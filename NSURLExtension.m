//
//  NSURLExtension.m
//
//  Licensed by ruralcoder.com under the
//  Creative Commons Attribution-ShareAlike 3.0 Unported License 

#import "NSURLExtension.h"

@implementation NSURL (Extension)

- (NSDictionary*) queryKeyValues
{
    NSMutableDictionary *keyValueParm = [NSMutableDictionary dictionary];

    if ([self query] == nil)
        return keyValueParm;
    
    NSCharacterSet *delimeters = [NSCharacterSet characterSetWithCharactersInString:@"=&"];
    NSArray *parameters = [[self query] componentsSeparatedByCharactersInSet:delimeters];

    for (int i = 0; i < [parameters count]; i=i+2) {
        [keyValueParm setObject:[parameters objectAtIndex:i+1] forKey:[parameters objectAtIndex:i]];
    }
    
    return keyValueParm;
}

@end
