//
//  HttpOperationDelegate.h
//
//  Licensed by ruralcoder.com under the
//  Creative Commons Attribution-ShareAlike 3.0 Unported License 

#import <Foundation/Foundation.h>

@class HttpOperation;

@protocol HttpOperationDelegate <NSObject>

- (void) operationException:(NSException*)exception;
- (void) operationError:(NSNumber*)error;
- (void) operationCompleted:(HttpOperation*)operation;
- (void) operationCancelled;



@end
