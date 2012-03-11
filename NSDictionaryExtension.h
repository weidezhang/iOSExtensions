//
//  NSDictionaryExtension.h
//
//  Licensed by ruralcoder.com under the
//  Creative Commons Attribution-ShareAlike 3.0 Unported License 

#import <Foundation/Foundation.h>

@interface NSDictionary (Extension)

- (BOOL) containsKey:(id)key;
- (BOOL) containsDictionaryForKey:(id)key;

- (NSString*) stringWithDelimeter:(NSString*)delimiter andKeyValueSeperator:(NSString*)seperator; 
- (NSString*) stringWithDelimeter:(NSString*)delimiter andKeyValueSeperator:(NSString*)seperator urlEncode:(BOOL)encode;

- (NSDictionary*) dictionaryForKey:(id)key;
- (NSArray*) arrayForKey:(id)key;
- (BOOL) boolForKey:(id)key;
- (NSInteger) integerForKey:(id)key;
- (NSUInteger) unsignedIntegerForKey:(id)key;

- (float) floatForKey:(id)key;
- (double) doubleForKey:(id)key;
- (NSString*) stringForKey:(id)key;
- (NSURL*) urlForKey:(id)key;

- (id) utcDateForKey:(id)key;


@end
