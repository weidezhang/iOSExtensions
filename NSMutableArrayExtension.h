//
//  NSMutableArrayExtension.h
//
//  Licensed by ruralcoder.com under the
//  Creative Commons Attribution-ShareAlike 3.0 Unported License 

#import <Foundation/Foundation.h>

@interface NSMutableArray (Extension)

- (void)moveObjectAtIndexPath:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex;
- (NSUInteger)indexOfCaseInsensitiveString:(NSString *)aString;
- (BOOL) containsInsensitiveString:(NSString *)aString;


@end
