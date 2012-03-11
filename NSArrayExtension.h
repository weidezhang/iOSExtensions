//
//  NSArrayExtension.h
//
//  Licensed by ruralcoder.com under the
//  Creative Commons Attribution-ShareAlike 3.0 Unported License 

#import <Foundation/Foundation.h>

@interface NSArray (Extension)

- (NSUInteger)indexOfCaseInsensitiveString:(NSString *)aString;
- (BOOL) containsInsensitiveString:(NSString *)aString;


@end
