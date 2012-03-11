//
//  NSDateExtension.h
//
//  Licensed by ruralcoder.com under the
//  Creative Commons Attribution-ShareAlike 3.0 Unported License 

#import <Foundation/Foundation.h>

@interface NSDate (Extension)

+ (NSDateFormatter*) getDateFormatter:(NSString*)format;

+ (NSDate*) dateFromString:(NSString*)formattedDate format:(NSString*)format isUTC:(BOOL)utcDate;
+ (NSDate*) dateFromString:(NSString*)formattedDate format:(NSString*)format ;
+ (NSDate*) dateFromUtcString:(NSString*)utcDate;


- (BOOL) isInFutureComparedTo:(NSDate*)other;
- (BOOL) isPast;
- (BOOL) isFuture;
- (BOOL) isThisDay;
- (BOOL) isThisWeek;
- (BOOL) isThisMonth;
- (BOOL) isThisYear;

- (NSString*) toFileTimestamp;
- (NSString*) toString;
- (NSString*) toTimeStamp;
- (NSString*) toStringWithLocale:(NSLocale*)locale;
- (NSString*) toTimeStampWithLocale:(NSLocale*)locale;
- (NSString*) toStringWithStyle:(NSDateFormatterStyle)style;
- (NSString*) toTimeStampWithStyle:(NSDateFormatterStyle)style;



@end
