//
//  NSDateExtension.m
//
//  Licensed by ruralcoder.com under the
//  Creative Commons Attribution-ShareAlike 3.0 Unported License 

#import "NSDateExtension.h"

static NSString *const utcDateFormat = @"MM/dd/yyyy hh:mm:ss a";

static NSMutableDictionary *gDateFormattersByFormat = nil;



@implementation NSDate (Extension)


+ (NSDate*) dateFromString:(NSString*)formattedDate format:(NSString*)format isUTC:(BOOL)utcDate
{
	NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
	
	if (utcDate)
		[dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
	
	dateFormatter.locale = [[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease];
	
	[dateFormatter setFormatterBehavior:NSDateFormatterBehaviorDefault];
	[dateFormatter setDateFormat:format];
	
	NSDate *date = [dateFormatter dateFromString:formattedDate];
	
	[dateFormatter release];
	
	return date;
}

+ (NSDate*) dateFromUtcString:(NSString*)utcDate
{
	return [NSDate dateFromString:utcDate format:utcDateFormat ];
}


+ (NSDate*) dateFromString:(NSString*)formattedDate format:(NSString*)format 
{
	NSDateFormatter *formatter = [NSDate getDateFormatter:format];
	return [formatter dateFromString:formattedDate];
}



- (BOOL) isPast
{
	return ([self timeIntervalSinceNow] < 0);
}


- (BOOL) isFuture
{
	return ([self timeIntervalSinceNow] > 0);
}

- (BOOL) isInFutureComparedTo:(NSDate*)other
{
	return ([self timeIntervalSinceDate:other] > 0);
}


- (BOOL) isThisToday
{
	NSDateComponents *now = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:[NSDate date]];
	NSDateComponents *thisDate = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit  fromDate:self];
	
	return ([now year] == [thisDate year] && [now month] == [thisDate day] && [now day] == [thisDate day]);
}

- (BOOL) isThisDay
{
	NSDateComponents *now = [[NSCalendar currentCalendar] components:NSDayCalendarUnit fromDate:[NSDate date]];
	NSDateComponents *thisDate = [[NSCalendar currentCalendar] components:NSDayCalendarUnit fromDate:self];
	
	return ([now day] == [thisDate day]);
}


- (BOOL) isThisWeek
{
	NSDateComponents *now = [[NSCalendar currentCalendar] components:NSWeekCalendarUnit fromDate:[NSDate date]];
	NSDateComponents *thisDate = [[NSCalendar currentCalendar] components:NSWeekCalendarUnit fromDate:self];
	
	if ([now week] != [thisDate week]) 
		return NO;
	
	return (abs([self timeIntervalSinceNow]) < 604800); // 7 * 24 * 3600
}


- (BOOL) isThisMonth
{
	NSDateComponents *now = [[NSCalendar currentCalendar] components:NSMonthCalendarUnit fromDate:[NSDate date]];
	NSDateComponents *thisDate = [[NSCalendar currentCalendar] components:NSMonthCalendarUnit fromDate:self];
	
	return ([now month] == [thisDate month]);
}


- (BOOL) isThisYear
{
	NSDateComponents *now = [[NSCalendar currentCalendar] components:NSYearCalendarUnit fromDate:[NSDate date]];
	NSDateComponents *thisDate = [[NSCalendar currentCalendar] components:NSYearCalendarUnit fromDate:self];
    
	return ([now year] == [thisDate year]);
}





+ (NSDateFormatter*) getDateFormatter:(NSString*)format
{
	if (gDateFormattersByFormat == nil)
		gDateFormattersByFormat = [[NSMutableDictionary alloc] init];
    
	id object = [gDateFormattersByFormat objectForKey:format];
    
	if (object != nil)
		return object;
	
	NSDateFormatter *newFormatter = [[NSDateFormatter alloc] init];
    
    newFormatter.timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
	newFormatter.locale = [NSLocale currentLocale]; //[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
	[newFormatter setFormatterBehavior:NSDateFormatterBehaviorDefault];
	[newFormatter setDateFormat:format];
	
	[gDateFormattersByFormat setObject:newFormatter forKey:format];
	[newFormatter release];
    
	return [gDateFormattersByFormat objectForKey:format];
}





- (NSString*) toFileTimestamp
{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"YYYYMMddHHmmss"];
	[dateFormatter setLocale:[NSLocale currentLocale]];
	NSString *timestamp = [dateFormatter stringFromDate:[NSDate date]];
	[dateFormatter release];
	
	return timestamp;
}


- (NSString*) toString
{
	NSLocale *curLocale = [NSLocale currentLocale];
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	
	[dateFormatter setTimeStyle:NSDateFormatterNoStyle];
	[dateFormatter setDateStyle:NSDateFormatterMediumStyle];
	[dateFormatter setLocale:curLocale];
	
	NSString *value = [dateFormatter stringFromDate:self];
	
	[dateFormatter release];
	
	return value;
}


- (NSString*) toTimeStamp
{
	NSLocale *curLocale = [NSLocale currentLocale];
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	
	[dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
	[dateFormatter setDateStyle:NSDateFormatterMediumStyle];
	[dateFormatter setLocale:curLocale];
	
	NSString *value = [dateFormatter stringFromDate:self];
	
	[dateFormatter release];
	
	return value;
}


- (NSString*) toStringWithLocale:(NSLocale*)locale
{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	
	[dateFormatter setTimeStyle:NSDateFormatterNoStyle];
	[dateFormatter setDateStyle:NSDateFormatterMediumStyle];
	[dateFormatter setLocale:locale];
	
	NSString *value = [dateFormatter stringFromDate:self];
	
	[dateFormatter release];
	
	return value;
}


- (NSString*) toTimeStampWithLocale:(NSLocale*)locale
{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	
	[dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
	[dateFormatter setDateStyle:NSDateFormatterMediumStyle];
	[dateFormatter setLocale:locale];
	
	NSString *value = [dateFormatter stringFromDate:self];
	
	[dateFormatter release];
	
	return value;
}


- (NSString*) toStringWithStyle:(NSDateFormatterStyle)style
{
	NSLocale *curLocale = [NSLocale currentLocale];
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	
	[dateFormatter setTimeStyle:NSDateFormatterNoStyle];
	[dateFormatter setDateStyle:style];
	[dateFormatter setLocale:curLocale];
	
	NSString *value = [dateFormatter stringFromDate:self];
	
	[dateFormatter release];
	
	return value;
}


- (NSString*) toTimeStampWithStyle:(NSDateFormatterStyle)style
{
	NSLocale *curLocale = [NSLocale currentLocale];
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	
	[dateFormatter setTimeStyle:style];
	[dateFormatter setDateStyle:style];
	[dateFormatter setLocale:curLocale];
	
	NSString *value = [dateFormatter stringFromDate:self];
	
	[dateFormatter release];
	
	return value;
}



@end
