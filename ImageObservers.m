//
//  ImageObservers.m
//
//  Licensed by ruralcoder.com under the
//  Creative Commons Attribution-ShareAlike 3.0 Unported License 

#import "ImageObservers.h"
#import "Observer.h"
#import "Application.h"
#import "ImageCacheDelegate.h"

@implementation ImageObservers
@synthesize isRunning;


+ (id) createObserverWithFilename:(id)filename andUrl:(id)url
{
    NSParameterAssert(url);
    NSParameterAssert(filename);

    NSMutableArray *observers = [NSMutableArray array];
    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:filename, @"filename", url, @"url", observers, @"observers",  nil];
    
    ImageObservers *object = [[[ImageObservers alloc] initWithDictionary:fields] autorelease];
    
    return object;
}


- (id)filename
{
    return [self.fields objectForKey:@"filename"];
}


- (id)url
{
    return [self.fields objectForKey:@"url"];
}


- (void) addObserver:(Observer*)observer
{
    @synchronized(self)
    {
        NSLog(@"    + Observer for %@", self.url);
        NSMutableArray *observers = [self.fields objectForKey:@"observers"];
        
        [observers addObject:observer];
    }
}


- (NSMutableArray *)observers
{
    return [self.fields objectForKey:@"observers"];
}


- (void) invokeDelegate:(id<ImageCacheDelegate>)delegate image:(UIImage*)image cookie:(id)cookie
{
    AppLog(@"INFO: newImageAvailable: delegate:%@  cookie:%@", [delegate class], [cookie class]);
    
    if (delegate == nil)
    {
        ErrorLog(@"ERROR: delegate is nil");
        return;
    }
    
    if (image == nil)
    {
        ErrorLog(@"ERROR: image is nil");
        return;
    }
    
    if (cookie == nil)
        ErrorLog(@"WARNING: cookie is nil");
    
    [delegate newImageAvailable:image cookie:cookie];
}


- (void) handleAsynchronousRequestCompletion:(NSURLResponse *)response
                                        data:(NSData*)imageData 
                                       error:(NSError*)error
{
    if ([response isKindOfClass:[NSHTTPURLResponse class]] == NO)
    {
        ErrorLog(@"ERROR: Response was not a HTTP response.");
        return;
    }
    
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
    NSLog(@"HTTP Status Code: %d - %@", httpResponse.statusCode, [response.URL absoluteString]);

    if (imageData == nil || [imageData length] == 0)
    {
        ErrorLog(@"ERROR: Image response data was nil or empty.");
        return;
    }
    
    if ([imageData writeToFile:self.filename atomically:YES] == NO)
    {
        ErrorLog(@"ERROR: Unable to write  '%@'", imageRequest.filename);
        return;
    }
    
    UIImage *image = [UIImage imageWithData:imageData];

    @synchronized(self)
    {
        for (Observer *observer in self.observers)
        {
            NSLog(@"Notifying %@ about '%@'", observer.target, self.url); 
            [self invokeDelegate:observer.target image:image cookie:observer.cookie];
        }
        
        [self.observers removeAllObjects];
    }
}





- (void) start
{
    if (self.isRunning == YES)
    {
        NSLog(@"Operation in progress for '%@'", [self.url absoluteString]);
        return;
    }
    
    self.isRunning = YES;
    NSURLRequest *request = [NSURLRequest requestWithURL:self.url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[Application operationQueue]  
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               self.isRunning = NO;
                               dispatch_async(dispatch_get_main_queue(), ^{
                                   [self handleAsynchronousRequestCompletion:response data:data error:error];
                               });
                           } ];
}



@end
