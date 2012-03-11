//
//  NSDictionaryExtension.m
//
//  Licensed by ruralcoder.com under the
//  Creative Commons Attribution-ShareAlike 3.0 Unported License 

#import "NSDictionaryExtension.h"
#import "NSDateExtension.h"

@implementation NSDictionary (Extension)


- (BOOL) containsKey:(id)key
{
    id object = [self objectForKey:key];
    return (object != nil);
}


- (BOOL) containsDictionaryForKey:(id)key
{
    id object = [self objectForKey:key];
    
    if (object == nil)
        return NO;
    
    return ([object isKindOfClass:[NSDictionary class]]);
}


- (NSString*) stringWithDelimeter:(NSString*)delimiter andKeyValueSeperator:(NSString*)seperator
{
    return [self stringWithDelimeter:delimiter andKeyValueSeperator:seperator urlEncode:NO]; 
}


- (NSString*) stringWithDelimeter:(NSString*)delimiter andKeyValueSeperator:(NSString*)seperator urlEncode:(BOOL)encode
{
    NSMutableString *value = [NSMutableString string];
    
    NSUInteger index = [self count];
    for (id key in [self allKeys])
    {
        [value appendFormat:@"%@%@%@", key, seperator, [self objectForKey:key]];
        if (--index > 0)
            [value appendString:delimiter];
    }
    
    if (encode)
        return [value stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    else
        return value;
}


#pragma mark Type Strict Getters


- (NSDictionary*) dictionaryForKey:(id)key
{
    id object = [self objectForKey:key];
    
    if (object == nil)
        return nil;

    if ([object isKindOfClass:[NSDictionary class]] == NO)
    {
        ErrorLog(@"WARNING: Object '%@' was a '%@' but expected a dictionary.", key, [[object class] description]);
        return nil;
    }
    
    return object;
}


- (NSArray*) arrayForKey:(id)key
{
    id object = [self objectForKey:key];
    
    if ([object isKindOfClass:[NSArray class]] == NO)
    {
        ErrorLog(@"WARNING: Object '%@' expected to be an array.", key);
        return nil;
    }
    
    return object;
}


- (BOOL) boolForKey:(id)key
{
    id object = [self objectForKey:key];
    
    if (object == nil)
        return NO;
    
    if ([object isKindOfClass:[NSNumber class]] == NO)
    {
        ErrorLog(@"WARNING: Object '%@' expected to be an nsnumber.", key);
        return NO;
    }
    
    return [object boolValue];
}


- (NSUInteger) unsignedIntegerForKey:(id)key
{
    id object = [self objectForKey:key];
    
    if (object == nil)
        return 0;
    
    if ([object isKindOfClass:[NSNumber class]] == YES)
        return [object unsignedIntegerValue];
    
    if ([object isKindOfClass:[NSString class]] == YES)
    {
        NSInteger value = [object integerValue];
        
        if (value < 0)
        {
            ErrorLog(@"WARNING: Negative number cannot be passed to as UNSIGNED");
            return 0;
        }
        
        return value; // there is no unsignedIntegerValue under NSString
    }
    
    ErrorLog(@"WARNING: Object '%@' expected to be an nsnumber.", key);
    return 0;
}


- (NSInteger) integerForKey:(id)key
{
    id object = [self objectForKey:key];
    
    if (object == nil)
        return 0;
    
    if ([object isKindOfClass:[NSNumber class]] == YES)
        return [object integerValue];
    
    if ([object isKindOfClass:[NSString class]] == YES)
        return [object integerValue];
    
    ErrorLog(@"WARNING: Object '%@' expected to be an nsnumber.", key);
    return 0;
}


- (float) floatForKey:(id)key
{
    id object = [self objectForKey:key];
    
    if (object == nil)
        return 0.0f;
    
    if ([object isKindOfClass:[NSNumber class]] == NO)
    {
        ErrorLog(@"WARNING: Object '%@' expected to be an nsnumber.", key);
        return 0;
    }
    
    return [object floatValue];
}

- (double) doubleForKey:(id)key;
{
    id object = [self objectForKey:key];
    
    if (object == nil || [object isKindOfClass:[NSNumber class]] == NO)
    {
        ErrorLog(@"WARNING: Object '%@' expected to be an nsnumber.", key);
        return 0;
    }
    
    return [object doubleValue];
}


- (NSString*) stringForKey:(id)key
{
    id object = [self objectForKey:key];
    
    if (object == nil)
        return @"";

    if ([object isKindOfClass:[NSNumber class]] == YES)
        return [NSString stringWithFormat:@"%@", object];

    if ([object isKindOfClass:[NSString class]] == YES)
        return object;
    
    ErrorLog(@"WARNING: Object '%@' expected to be an string.", key);
    return @""; 
}


- (NSURL*) urlForKey:(id)key
{
    NSString *string = [self stringForKey:key];
    
    if (string == nil || [string length] == 0)
        return nil;
    
    NSURL *url = [NSURL URLWithString:string];
    
    if (url != nil)
        return url;

    ErrorLog(@"WARNING: Server returned URL value NOT URL ENCODED '%@'", string);
    
    NSString* urlEncoded = [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    url = [NSURL URLWithString:urlEncoded];
    
    if (url == nil)
        ErrorLog(@"WARNING: Server returned a NON-VALID URL '%@'", urlEncoded);
    
    return url;
}


 


- (id) utcDateForKey:(id)key 
{
    NSParameterAssert(key);
     
    id value = [self objectForKey:key];
    
    if (value == nil)
        return nil;
    
    if ([value isKindOfClass:[NSDate class]])
        return value;
    
    id date = [NSDate dateFromUtcString:value ];
    
    if (date == nil)
    {
        ErrorLog(@"WARNING: Unable to decode timestamp '%@' class:'%@'", value, [value class]);
        return nil;
    }
    
    return date;
}




@end
