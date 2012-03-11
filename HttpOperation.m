//
//  HttpOperation.m
//
//  Licensed by ruralcoder.com under the
//  Creative Commons Attribution-ShareAlike 3.0 Unported License 

#import "HttpOperation.h"
#import "NSErrorExtension.h"
#import "NSDictionaryExtension.h"
#import "HttpOperationDelegate.h"

        
  


@interface HttpOperation()
@property (nonatomic, retain) NSURLConnection *connection;
@property (nonatomic, retain) NSMutableData *data;
@end


@implementation HttpOperation
@synthesize connection;
@synthesize data;
@synthesize type = _type;
@synthesize delegate = _delegate;
@synthesize cookie = _cookie;

@synthesize resourceUrl = _resourceUrl;
@synthesize request = _request;
@synthesize executing = _executing;
@synthesize finished = _finished;


- (NSData*) responseData
{
    return self.data;
}

- (id) initWithRequest:(NSURLRequest*)httpRequest type:(HttpOperations)httpType cookie:(id)object target:(id<HttpOperationDelegate>)target
{
    NSParameterAssert(httpRequest != nil);
    NSParameterAssert(target != nil);
    
    self = [super init];
    
    if (self)
    {
        self.executing = NO;
        self.finished = NO;
        
        _type = httpType;
        _request = [httpRequest retain];
        _delegate = [target retain];
        _cookie = [object retain];
    }
    
    return self;
}




+ (void) startHttpGetOperationWithClient:(id<HttpOperationDelegate>)client 
                                resource:(NSString*)resource 
                             withPayload:(NSDictionary*)args 
{
    NetLog(@"HttpPostOperation - startOperationWithClient");
    NSMutableDictionary *updatedArgs = [NSMutableDictionary dictionaryWithDictionary:args];
    
    id cookie = [args objectForKey:ObjectKeyCookie];
    [updatedArgs removeObjectForKey:ObjectKeyCookie];    
    [updatedArgs removeObjectForKey:ObjectKeyObjectId];    
    
    NSString *payload = [updatedArgs stringWithDelimeter:@"&" andKeyValueSeperator:@"=" urlEncode:YES];
    
    NSString *link = [NSString stringWithFormat:@"%@?%@", resource, payload];
    
    NSURL *resourceUrl = [NSURL URLWithString:link];
    
    HttpLog(@"HTTP GET: %@", [resourceUrl absoluteString]);
    
    NSMutableURLRequest *httpRequest = [[NSMutableURLRequest alloc] initWithURL:resourceUrl];
    [httpRequest setTimeoutInterval:[ServiceSettings instance].connectionTimeout];
    
    HttpOperation *operation = [[HttpOperation alloc] initWithRequest:httpRequest 
                                                                 type:HttpOperationGet
                                                               cookie:cookie 
                                                               target:(id<HttpOperationDelegate>)client];
    [httpRequest release];
    
    [ApplicationController addOperationToQueue:operation];
    [operation release];
}


+ (void) startHttpPostOperationWithClient:(id)client 
                                 resource:(NSString*)resource 
                              withPayload:(NSDictionary*)args 
{
    NetLog(@"HttpPostOperation - startOperationWithClient");
    NSMutableDictionary *updatedArgs = [NSMutableDictionary dictionaryWithDictionary:args];
    
    id cookie = [args objectForKey:ObjectKeyCookie];
    [updatedArgs removeObjectForKey:ObjectKeyCookie];    
    [updatedArgs removeObjectForKey:ObjectKeyObjectId];    
    
    NSURL *resourceUrl = [NSURL URLWithString:resource];
    NSString *payload = [updatedArgs stringWithDelimeter:@"&" andKeyValueSeperator:@"="];
    
    HttpLog(@"HTTP POST: %@", [resourceUrl absoluteString]);
    
    NSMutableURLRequest *httpRequest = [[[NSMutableURLRequest alloc] initWithURL:resourceUrl] autorelease];
    [httpRequest setTimeoutInterval:[ServiceSettings instance].connectionTimeout];
    
    [httpRequest setHTTPMethod:@"POST"];
    [httpRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    [httpRequest setValue:[NSString stringWithFormat:@"%d", [payload length]] forHTTPHeaderField:@"Content-length"];
    [httpRequest setHTTPBody:[payload dataUsingEncoding:NSUTF8StringEncoding]];
    
    HttpOperation *operation = [[HttpOperation alloc] initWithRequest:httpRequest 
                                                                 type:HttpOperationPost
                                                               cookie:cookie 
                                                               target:(id<HttpOperationDelegate>)client];
    
    [ApplicationController addOperationToQueue:operation];
    [operation release];
}


- (void) dealloc
{
    AllocLog(@"HttpOperation - dealloc");
    self.connection = nil;
    self.data = nil;
    [_cookie release];
    [_delegate release];
    [_request release];
    
    [super dealloc];
}


- (void) start
{
    NetLog(@"HttpOperation - start");
    
    if ([self isCancelled])
    {
        // Must move the operation to the finished state if it is canceled.
        [self willChangeValueForKey:@"isFinished"];
        self.finished = YES;
        [self didChangeValueForKey:@"isFinished"];
        return;
    }
    
    // If the operation is not canceled, begin executing the task.
    [self willChangeValueForKey:@"isExecuting"];
    [NSThread detachNewThreadSelector:@selector(main) toTarget:self withObject:nil];
    self.executing = YES;
    [self didChangeValueForKey:@"isExecuting"];
}


- (void)completeOperation {
    NetLog(@"HttpOperation - completeOperation");
    self.connection = nil;
    
    [self willChangeValueForKey:@"isFinished"];
    [self willChangeValueForKey:@"isExecuting"];
    
    self.executing = NO;
    self.finished = YES;
    
    [self didChangeValueForKey:@"isExecuting"];
    [self didChangeValueForKey:@"isFinished"];
}


- (void) main
{
    NetLog(@"HttpOperation - main");
    @autoreleasepool {
        @try 
        {
            [self willChangeValueForKey:@"isExecuting"];
            self.executing = YES;
            [self didChangeValueForKey:@"isExecuting"];
            
            self.connection = [[NSURLConnection alloc] initWithRequest:self.request delegate:self];
  
            if (self.connection == nil)
                [self completeOperation];
            else
            {
                [self.connection scheduleInRunLoop:[NSRunLoop currentRunLoop] 
                                           forMode:NSDefaultRunLoopMode];
                [self.connection start];
                
                while (![self isFinished]) {
                    [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
                }
            }
        }
        @catch (NSException *exception) 
        {
            [self.delegate performSelectorOnMainThread:@selector(operationException:) 
                                            withObject:exception 
                                         waitUntilDone:YES];
        }
    }
}





- (void) cancel
{
    [self.connection cancel];
}


- (BOOL)isConcurrent
{
    return YES;
}

- (BOOL)isExecuting {
    return self.executing;
}

- (BOOL)isFinished {
    return self.finished;
}

#pragma mark NSURLConnection delegate methods

// Handle errors in the download by showing an alert to the user. This is a very
// simple way of handling the error, partly because this application does not have any offline
// functionality for the user. Most real applications should handle the error in a less obtrusive
// way and provide offline functionality to the user.
//
- (void)handleError:(NSError *)error 
{
    NetLog(@"HttpPostOperation - handleError: '%@'", [error description]);
    [self.delegate performSelectorOnMainThread:@selector(operationError:) 
                                    withObject:error 
                                 waitUntilDone:YES];

    [self completeOperation];
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection 
{
    NetLog(@"HttpPostOperation - connectionDidFinishLoading");
    
    [self.delegate performSelectorOnMainThread:@selector(operationCompleted:) 
                                    withObject:self 
                                 waitUntilDone:YES];

    [self completeOperation];
}


// The following are delegate methods for NSURLConnection. Similar to callback functions, this is
// how the connection object, which is working in the background, can asynchronously communicate back
// to its delegate on the thread from which it was started - in this case, the main thread.
//
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NetLog(@"HttpPostOperation - didReceiveResponse");
    // check for HTTP status code for proxy authentication failures
    // anything in the 200 to 299 range is considered successful,
    // also make sure the MIMEType is correct:
    //
    
    if ([response respondsToSelector:@selector(statusCode)] == NO)
    {
        NetLog(@"WARNING: Not an HTTP response");
        NetLog(@"%@", [response description]);
        return;
    }
    
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    
    NetLog(@"POST response code: %d", [httpResponse statusCode]);
    
    if (([httpResponse statusCode]/100) != 2) // HTTP 200 == OK
    {
        NSError *error = [NSError errorWithDomain:@"HTTP"
                                             code:[httpResponse statusCode]
                                            title:@"HTTP Error" 
                                      description:@"Error message displayed when receving a connection error."];
        
        [self handleError:error];
        [self completeOperation];
    } 
    
    if ([[response MIMEType] isEqual:@"application/json"] == NO)
        NetLog(@"WARNING: Server did not return JSON got '%@' instead.", [response MIMEType]);
    
    self.data = [NSMutableData data];
}


- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)dataPacket 
{
    NetLog(@"HttpPostOperation - didReceiveData");
    [self.data appendData:dataPacket];
}


- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error 
{
    NetLog(@"HttpPostOperation - didFailWithError");
    if ([error code] == kCFURLErrorNotConnectedToInternet) 
    {
        NSError *noConnectionError = [NSError errorWithDomain:NSCocoaErrorDomain
                                                         code:kCFURLErrorNotConnectedToInternet
                                                        title:@"No Connection Error" 
                                                  description:@"Error message displayed when not connected to the Internet."];
        [self handleError:noConnectionError];
    } 
    else 
    {
        // otherwise handle the error generically
        [self handleError:error];
    }
    
    [self completeOperation];
}









@end
