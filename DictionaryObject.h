//
//  DictionaryObject.h
//
//  Licensed by ruralcoder.com under the
//  Creative Commons Attribution-ShareAlike 3.0 Unported License 

#import <Foundation/Foundation.h>

@interface DictionaryObject : NSObject
@property (nonatomic, retain) NSDictionary *fields;

- (id) initWithDictionary:(NSDictionary *)dictionary;

@end
