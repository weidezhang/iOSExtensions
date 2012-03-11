//
//  SqliteQuery.m
//
// Sqlite Objective C wrapper by Stephen Anderson is licensed under 
// a Creative Commons Attribution-ShareAlike 3.0 Unported License.
// Permissions beyond the scope of this license may be available at 
// ruralcoder.com.

#import "SqliteQuery.h"

@interface SqliteQuery () 
{
    sqlite3_stmt *compiledStatement;
    sqlite3 *database;
}

@end

@implementation SqliteQuery

- (NSString*)errorMessage
{
    return [NSString stringWithUTF8String:sqlite3_errmsg(database)];
}

- (id) initWithStatement:(NSString*)sqlStatement database:(sqlite3*)db
{
	NSLog(@"Info - Query '%@'", sqlStatement);
    
    self = [super init];
	if (self)
	{
		int status = sqlite3_prepare_v2(db, [sqlStatement UTF8String], -1, &compiledStatement, NULL);
		
		if (status != SQLITE_OK)
		{
			NSLog(@"Error %d: sqlite3_prepare_v2 '%@'", status, [self errorMessage]);
			return nil;
		}
	}	
	
	return self;
}





- (NSString*) sqlQuery
{
	return [NSString stringWithUTF8String:sqlite3_sql(compiledStatement)];
}


- (void) bindDouble:(NSInteger)columnIndex value:(double)value
{
	sqlite3_bind_double(compiledStatement, columnIndex, value);
}


- (void) bindInt:(NSInteger)columnIndex value:(int)value;
{
	sqlite3_bind_int(compiledStatement, columnIndex, value);
}


- (void) bindInt64:(NSInteger)columnIndex value:(sqlite3_int64)value;
{
	sqlite3_bind_int64(compiledStatement, columnIndex, value);
}


- (void) bindNull:(NSInteger)columnIndex;
{
	sqlite3_bind_null(compiledStatement, columnIndex);
}


- (void) bindText:(NSInteger)columnIndex value:(NSString*)value;
{
	sqlite3_bind_text(compiledStatement, columnIndex, [value UTF8String], -1, SQLITE_TRANSIENT);
}


- (void) bindText16:(NSInteger)columnIndex value:(NSString*)value;
{
	sqlite3_bind_text16(compiledStatement, columnIndex, value, -1, SQLITE_TRANSIENT);
}


- (void) bindValue:(NSInteger)columnIndex value:(const sqlite3_value*)value;
{
	sqlite3_bind_value(compiledStatement, columnIndex, value);
}


- (void) bindZeroBlob:(NSInteger)columnIndex length:(int)length;
{
	sqlite3_bind_zeroblob(compiledStatement, columnIndex, length);
}


- (void) bindBlob:(NSInteger)columnIndex data:(NSData*)data
{
	sqlite3_bind_blob(compiledStatement, columnIndex, [data bytes], [data length], SQLITE_TRANSIENT);
}


- (NSInteger) parameterCount
{
	return sqlite3_bind_parameter_count(compiledStatement);
}


- (NSString*) parameterName:(NSInteger)index
{
	return [NSString stringWithUTF8String:sqlite3_bind_parameter_name(compiledStatement, index)];
}


- (NSInteger) findParameterByName:(NSString*)name
{
	return 0;
}


- (void) clearBindings
{
	sqlite3_clear_bindings(compiledStatement);
}


- (NSInteger) columnCount
{
	return sqlite3_column_count(compiledStatement);
}


- (NSString*) columnName:(NSInteger)index
{
	return [NSString stringWithUTF8String:sqlite3_column_name(compiledStatement, index)];
}


- (NSInteger) findColumnByName:(NSString*)name
{
	return 0;
}


- (NSData*) columnBlob:(NSInteger)columnIndex
{
	NSData* blob = nil;
	NSInteger blobSize = sqlite3_column_bytes(compiledStatement, columnIndex);
	
	blob = [NSData dataWithBytes:sqlite3_column_blob(compiledStatement, columnIndex) 
						  length:blobSize];
	
	return blob;
}


- (NSInteger) columnBytes:(NSInteger)columnIndex;
{
	return sqlite3_column_bytes(compiledStatement, columnIndex);
}


- (NSInteger) columnBytes16:(NSInteger)columnIndex;
{
	return sqlite3_column_bytes16(compiledStatement, columnIndex);
}


- (double) columnDouble:(NSInteger)columnIndex;
{
	return sqlite3_column_double(compiledStatement, columnIndex);
}


- (NSInteger) columnInt:(NSInteger)columnIndex;
{
	return sqlite3_column_int(compiledStatement, columnIndex);
}


- (sqlite3_int64) columnInt64:(NSInteger)columnIndex;
{
	return sqlite3_column_int64(compiledStatement, columnIndex);
}


- (NSString*) columnText:(NSInteger)columnIndex;
{
	return [NSString stringWithUTF8String:(const char *)sqlite3_column_text(compiledStatement, columnIndex)];
}


- (NSString*) columnText16:(NSInteger)columnIndex;
{
	return nil;
}


- (NSInteger) columnType:(NSInteger)columnIndex;
{
	return sqlite3_column_type(compiledStatement, columnIndex);
}


- (sqlite3_value*) columnValue:(NSInteger)columnIndex
{
	return sqlite3_column_value(compiledStatement, columnIndex );
}


- (id) columnObject:(NSInteger)columnIndex
{
	SqliteDataTypes type = sqlite3_column_type(compiledStatement, columnIndex);
    
	switch (type) {
            
		case SqliteDataTypeInteger:
			return [NSNumber numberWithInteger:[self columnInt:columnIndex]];

		case SqliteDataTypeBlob:
			return [self columnBlob:columnIndex];
            
		case SqliteDataTypeText:
			return [self columnText:columnIndex];
            
		case SqliteDataTypeFloat:
			return [NSNumber numberWithDouble:[self columnDouble:columnIndex]];
			
		case SqliteDataTypeNull:
		default:
			return nil;
	}
}



- (SqliteCodes) step
{
	SqliteCodes status = sqlite3_step(compiledStatement);

    if (status != SQLITE_ROW && status != SQLITE_DONE)
        NSLog(@"Error %d: SqliteQuery::Step '%@'", status, [self errorMessage]);

    return status;
}

- (void) next
{
	sqlite3_next_stmt(database, compiledStatement);
}


- (void) reset
{
	sqlite3_reset(compiledStatement);
}


- (void) dealloc
{
	sqlite3_finalize(compiledStatement);
	
	compiledStatement = nil;
	database = nil;
	
	[super dealloc];
}




@end
