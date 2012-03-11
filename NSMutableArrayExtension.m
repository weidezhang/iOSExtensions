//
//  NSMutableArrayExtension.m
//
//  Licensed by ruralcoder.com under the
//  Creative Commons Attribution-ShareAlike 3.0 Unported License 

#import "NSMutableArrayExtension.h"

@implementation NSMutableArray (Extension)

- (void)moveObjectAtIndexPath:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex
{
    if (toIndex == fromIndex)
        return;
    
    id object = [[self objectAtIndex:fromIndex] retain];
    [self removeObjectAtIndex:fromIndex];
    
    if (toIndex >= [self count]) 
        [self addObject:object];
    else 
        [self insertObject:object atIndex:toIndex];

    [object release];
}


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
