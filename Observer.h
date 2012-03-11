//
//  Observer.h
//
//  Licensed by ruralcoder.com under the
//  Creative Commons Attribution-ShareAlike 3.0 Unported License 

#import <Foundation/Foundation.h>

@interface Observer : DictionaryObject

+ (id) createObserverWithTarget:(id)target andCookie:(id)cookie;

@property (nonatomic, readonly) id target;
@property (nonatomic, readonly) id cookie;


@end
