//
//  Sqlite.m
//
// Sqlite Objective C wrapper by Stephen Anderson is licensed under 
// a Creative Commons Attribution-ShareAlike 3.0 Unported License.
// Permissions beyond the scope of this license may be available at 
// ruralcoder.com.

#import "Sqlite.h"

#import "SqliteQuery.h"

@implementation Sqlite



- (id) initWithFilename:(NSString*) databaseFilename
{
	if (self = [super init])
	{
		int status = sqlite3_open_v2([databaseFilename UTF8String], &database, SQLITE_OPEN_READONLY, NULL);
        
		if (status != SQLITE_OK)
			return nil;
	}
	
	return self;
}


- (id) initWithFilename:(NSString*) databaseFilename readOnly:(BOOL)readOnly
{
	if (self = [super init])
	{
        int mode = (readOnly) ? SQLITE_OPEN_READONLY : SQLITE_OPEN_READWRITE;
		int status = sqlite3_open_v2([databaseFilename UTF8String], &database, mode, NULL);
	
		if (status != SQLITE_OK)
			return nil;
	}
	
	return self;
}


- (SqliteCodes) close
{
	return sqlite3_close(database);
}


- (SqliteCodes) threadSafe
{
	return sqlite3_threadsafe();
}

- (SqliteCodes) extendedResultCodes:(BOOL)enable
{
	return sqlite3_extended_result_codes(database, enable);
}

- (sqlite3_int64) lastInsertRowId
{
	return sqlite3_last_insert_rowid(database);
}

- (SqliteCodes) changes
{
	return sqlite3_changes(database);
}

- (SqliteCodes) totalChanges
{
	return sqlite3_total_changes(database);
}

- (void) interrupt
{
	sqlite3_interrupt(database);
}

- (SqliteCodes) complete:(NSString*)sql
{
	return sqlite3_complete([sql UTF8String]);
}

- (SqliteCodes) busyTimeout:(NSInteger)milliseconds
{
	return sqlite3_busy_timeout(database, milliseconds);
}

//- (SqliteCodes) getTable;
//- (SqliteCodes) freeTable;


- (NSInteger) errorCode
{
	return sqlite3_errcode(database);
}


- (NSInteger) extendedErrorCode
{
	return sqlite3_extended_errcode(database);
}

- (NSString*) errorMessage
{
	return [NSString stringWithUTF8String:sqlite3_errmsg(database)];
}


- (SqliteCodes) limit:(NSInteger)identifier value:(NSInteger)value
{
	return sqlite3_limit(database, identifier, value);
}

- (SqliteQuery*) queryWithStatement:(NSString*)sqlQuery
{
	SqliteQuery *query = [[[SqliteQuery alloc] initWithStatement:sqlQuery database:database] autorelease];
	
	return query;
}


- (void) dealloc
{
	[self close];
	database = nil;
	
	[super dealloc];
}

@end
