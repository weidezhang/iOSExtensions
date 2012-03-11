//
//  NSArrayExtension.m
//
//  Licensed by ruralcoder.com under the
//  Creative Commons Attribution-ShareAlike 3.0 Unported License 

#import "NSArrayExtension.h"

@implementation NSArray (Extension)


- (NSUInteger)indexOfCaseInsensitiveString:(NSString *)aString {
    NSUInteger index = 0;
    for (NSString *object in self) {
        if ([object caseInsensitiveCompare:aString] == NSOrderedSame) {
            return index;
        }
        index++;
    }
    return NSNotFound;
}


- (BOOL) containsInsensitiveString:(NSString *)aString
{
    return ([self indexOfCaseInsensitiveString:aString] != NSNotFound);
}



@end
