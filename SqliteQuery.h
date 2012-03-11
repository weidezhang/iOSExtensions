//
//  SqliteQuery.h
//
// Sqlite Objective C wrapper by Stephen Anderson is licensed under 
// a Creative Commons Attribution-ShareAlike 3.0 Unported License.
// Permissions beyond the scope of this license may be available at 
// ruralcoder.com.

#import <Foundation/Foundation.h>
#import <sqlite3.h>

#import "Sqlite.h"

typedef enum
{
    SqliteDataTypeUnknown = 0,
    SqliteDataTypeInteger = 1,
    SqliteDataTypeFloat = 2,
    SqliteDataTypeText = 3,
    SqliteDataTypeBlob = 4,
    SqliteDataTypeNull = 5
} SqliteDataTypes;


@interface SqliteQuery : NSObject 

- (id) initWithStatement:(NSString*)sqlStatement database:(sqlite3*)db;

- (NSString*) sqlQuery;

- (void) bindDouble:(NSInteger)columnIndex value:(double)value;
- (void) bindInt:(NSInteger)columnIndex value:(int)value;
- (void) bindInt64:(NSInteger)columnIndex value:(sqlite3_int64)value;
- (void) bindNull:(NSInteger)columnIndex;
- (void) bindText:(NSInteger)columnIndex value:(NSString*)value;
- (void) bindText16:(NSInteger)columnIndex value:(NSString*)value;
- (void) bindValue:(NSInteger)columnIndex value:(const sqlite3_value*)value;
- (void) bindZeroBlob:(NSInteger)columnIndex length:(int)length;
- (void) bindBlob:(NSInteger)columnIndex data:(NSData*)data;

- (NSInteger) parameterCount;
- (NSString*) parameterName:(NSInteger)index;
- (NSInteger) findParameterByName:(NSString*)name;

- (void) clearBindings;

- (NSInteger) columnCount;
- (NSString*) columnName:(NSInteger)index;
- (NSInteger) findColumnByName:(NSString*)name;

- (NSData*) columnBlob:(NSInteger)columnIndex;
- (NSInteger) columnBytes:(NSInteger)columnIndex;
- (NSInteger) columnBytes16:(NSInteger)columnIndex;
- (double) columnDouble:(NSInteger)columnIndex;
- (NSInteger) columnInt:(NSInteger)columnIndex;
- (sqlite3_int64) columnInt64:(NSInteger)columnIndex;
- (NSString*) columnText:(NSInteger)columnIndex;
- (NSString*) columnText16:(NSInteger)columnIndex;
- (id) columnObject:(NSInteger)columnIndex;

- (NSInteger) columnType:(NSInteger)columnIndex;
- (sqlite3_value*) columnValue:(NSInteger)columnIndex;

- (SqliteCodes) step;
- (void) next;
- (void) reset;



@end
