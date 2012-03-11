//
//  NSObjectIntercept.m
//
//  Licensed by ruralcoder.com under the
//  Creative Commons Attribution-ShareAlike 3.0 Unported License 

#import "NSObjectIntercept.h"

@implementation NSObjectIntercept


- (Class)class
{
    NSLog(@"%@::class", [super class]);
    return [super class];
}

- (BOOL)isKindOfClass:(Class)aClass
{
    NSLog(@"%@::isKindOfClass", [super class]);
    return [super isKindOfClass:aClass];
}

- (BOOL)isMemberOfClass:(Class)aClass
{
    NSLog(@"%@::isMemberOfClass", [super class]);
    return [super isMemberOfClass:aClass];
}

- (BOOL)conformsToProtocol:(Protocol *)aProtocol
{
    NSLog(@"%@::conformsToProtocol", [super class]);
    return [super conformsToProtocol:aProtocol];
}

- (id)performSelector:(SEL)aSelector
{
    NSLog(@"%@::performSelector", [super class]);
    return [super performSelector:aSelector];
}

- (id)performSelector:(SEL)aSelector withObject:(id)anObject
{
    NSLog(@"%@::performSelector: withObject:", [super class]);
    return [super performSelector:aSelector withObject:anObject];
}

- (oneway void)release
{
    NSLog(@"%@::release", [super class]);
    [super release];
}

- (BOOL)respondsToSelector:(SEL)aSelector
{
    NSLog(@"%@::respondsToSelector", [super class]);
    return [super respondsToSelector:aSelector];
}

- (Class)superclass
{
    NSLog(@"%@::superclass", [super class]);
    return [super superclass];
}

- (NSZone *)zone 
{ 
    NSLog(@"%@::zone", [super class]);
    return [super zone]; 
}

- (BOOL)isEqual:(id)anObject
{
    NSLog(@"%@::isEqual", [super class]);
    return [super isEqual:anObject];
}

- (NSUInteger)hash
{
    NSLog(@"%@::hash", [super class]);
    return [super hash];
}

+ (NSInteger)version 
{ 
    NSLog(@"%@::version", [super class]);
    return [super version]; 
}

+ (void)setVersion:(NSInteger)aVersion 
{ 
    NSLog(@"%@::setVersion:%d", [super class], aVersion);
}


- (Class)classForCoder 
{
    NSLog(@"%@::classForCoder", [super class]);
    return [super classForCoder];
}

- (id)replacementObjectForCoder:(NSCoder *)aCoder
{
    NSLog(@"%@::replacementObjectForCoder", [super class]);
    return [super replacementObjectForCoder:aCoder];
}

- (id)awakeAfterUsingCoder:(NSCoder *)aDecoder 
{
    NSLog(@"%@::awakeAfterUsingCoder", [super class]);
    return [super awakeAfterUsingCoder:aDecoder];
}



@end
