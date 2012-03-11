//
//  NSObjectExtension.m
//
//  Licensed by ruralcoder.com under the
//  Creative Commons Attribution-ShareAlike 3.0 Unported License 

#import "NSObjectExtension.h"
#import "NSDateExtension.h"


@implementation NSObject (Extension)


- (DataType) dataType
{
	if (self == nil) return DataTypeNil;

	// STRING - just return it back
	if ([self isKindOfClass:[NSString class]])
		return DataTypeString;

	if ([self isKindOfClass:[NSData class]])
		return DataTypeData;

	if ([self isKindOfClass:[NSDate class]])
		return DataTypeDate;

	if ([self isKindOfClass:[NSArray class]])
		return DataTypeArray;

	if ([self isKindOfClass:[NSDictionary class]])
		return DataTypeDictionary;

	if ([self isKindOfClass:[NSNumber class]])
	{
		NSNumber *number = (NSNumber*) self;
	
		const char *type = [number objCType];
		if (*type == 'c' && [number respondsToSelector:@selector(boolValue)])
			return DataTypeBoolean;
		else
			return DataTypeNumeric;
	}
	
	return DataTypeObject;
}


- (NSString*) toString
{
	if (self == nil)
		return @"n/a";
	
	// STRING - just return it back
	if ([self isKindOfClass:[NSString class]])
		return (NSString*) self;
	
	// DATE - format it first
	if ([self isKindOfClass:[NSDate class]])
	{
		NSDate *date = (NSDate*) self;
		return [date toString];
	}
	
	// NUMBER - might be a BOOL, INT or FLOAT
	if ([self isKindOfClass:[NSNumber class]])
	{
		NSNumber *number = (NSNumber*) self;
		
		const char *type = [number objCType];
		if (*type == 'c')
		{
			if ([number respondsToSelector:@selector(boolValue)])
				return ([number boolValue] == YES) ? @"Yes" : @"No";
		}
		
		if (*type == 'f')
		{
			if ([number respondsToSelector:@selector(floatValue)])
				return [NSString stringWithFormat:@"%1.1f", [number floatValue]];
		}
		
		
		if ([number respondsToSelector:@selector(integerValue)])
			return [NSString stringWithFormat:@"%d", [number integerValue]];
		
	}
	
	return [self description];
}


@end

