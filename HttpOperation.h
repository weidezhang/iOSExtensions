//
//  HttpOperation.h
//
//  Licensed by ruralcoder.com under the
//  Creative Commons Attribution-ShareAlike 3.0 Unported License 

#import <Foundation/Foundation.h>
#import "HttpOperationDelegate.h"




typedef enum
{
    HttpOperationGet,
    HttpOperationPost
} HttpOperations;

@interface HttpOperation : NSOperation <NSURLConnectionDataDelegate>
@property (nonatomic, assign) BOOL executing;
@property (nonatomic, assign) BOOL finished;

@property (nonatomic, readonly) id delegate;
@property (nonatomic, readonly) id cookie;
@property (nonatomic, readonly) id resourceUrl;
@property (nonatomic, readonly) NSData *responseData;
@property (nonatomic, readonly) NSURLRequest *request;
@property (nonatomic, readonly) HttpOperations type;


- (id) initWithRequest:(NSURLRequest*)httpRequest 
                  type:(HttpOperations)httpType 
                cookie:(id)object 
                target:(id<HttpOperationDelegate>)target;



+ (void) startHttpGetOperationWithClient:(id)client 
                                resource:(NSString*)resource 
                             withPayload:(NSDictionary*)args ;


+ (void) startHttpPostOperationWithClient:(id)client 
                                 resource:(NSString*)resource 
                              withPayload:(NSDictionary*)args ;

@end





