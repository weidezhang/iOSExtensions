//
//  ImageObservers.h
//
//  Licensed by ruralcoder.com under the
//  Creative Commons Attribution-ShareAlike 3.0 Unported License 

#import <Foundation/Foundation.h>

@class Observer;

@interface ImageObservers : DictionaryObject
@property (nonatomic, readonly) NSString *filename;
@property (nonatomic, readonly) NSURL *url;
@property (nonatomic, readonly) NSMutableArray *observers;
@property (nonatomic, assign) BOOL isRunning;


+ (id) createObserverWithFilename:(id)filename andUrl:(id)url;

- (void) addObserver:(Observer*)observer;

- (void) start;


@end
