//
//  NSObjectExtension.h
//
//  Licensed by ruralcoder.com under the
//  Creative Commons Attribution-ShareAlike 3.0 Unported License 

#import <Foundation/Foundation.h>

typedef enum
{
	DataTypeNil,
	DataTypeObject,
	DataTypeBoolean,
	DataTypeNumeric,
	DataTypeString,
	DataTypeDate,
	DataTypeData,
	DataTypeArray,
	DataTypeDictionary
	
} DataType;


@interface NSObject (Extension) 

- (NSString*) toString;
- (DataType) dataType;

@end
