//
//  JsonObject.h
//
//  Licensed by ruralcoder.com under the
//  Creative Commons Attribution-ShareAlike 3.0 Unported License 

#import "DictionaryObject.h"

@interface JsonObject : DictionaryObject

- (id) initWithData:(NSData*)jsonData;

@end
