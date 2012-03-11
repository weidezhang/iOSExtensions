//
//  Observer.m
//
//  Licensed by ruralcoder.com under the
//  Creative Commons Attribution-ShareAlike 3.0 Unported License 

#import "Observer.h"

@implementation Observer

+ (id) createObserverWithTarget:(id)target andCookie:(id)cookie
{
    NSParameterAssert(target);
    NSParameterAssert(cookie);
    
    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:target, @"target", cookie, @"cookie", nil];
    
    Observer *object = [[[Observer alloc] initWithDictionary:fields] autorelease];
    return object;
}



- (id) target
{
    return [self.fields objectForKey:@"target"];
}

- (id) cookie
{
    return [self.fields objectForKey:@"cookie"];
}



@end
