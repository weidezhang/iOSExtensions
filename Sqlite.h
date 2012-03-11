//
//  Sqlite.h
//
// Sqlite Objective C wrapper by Stephen Anderson is licensed under 
// a Creative Commons Attribution-ShareAlike 3.0 Unported License.
// Permissions beyond the scope of this license may be available at 
// ruralcoder.com.

#import <Foundation/Foundation.h>
#import <sqlite3.h>


@class SqliteQuery;

typedef enum
{
	SqliteCodeOK = 0,			/* Successful result */
	SqliteCodeERROR = 1,		/* SQL error or missing database */
	SqliteCodeINTERNAL = 2,		/* Internal logic error in SQLite */
	SqliteCodePERM = 3,			/* Access permission denied */
	SqliteCodeABORT = 4,		/* Callback routine requested an abort */
	SqliteCodeBUSY = 5,			/* The database file is locked */
	SqliteCodeLOCKED = 6,		/* A table in the database is locked */
	SqliteCodeNOMEM = 7,		/* A malloc() failed */
	SqliteCodeREADONLY = 8,		/* Attempt to write a readonly database */
	SqliteCodeINTERRUPT = 9,	/* Operation terminated by sqlite3_interrupt()*/
	SqliteCodeIOERR = 10,		/* Some kind of disk I/O error occurred */
	SqliteCodeCORRUPT = 11,		/* The database disk image is malformed */
	SqliteCodeNOTFOUND = 12,	/* NOT USED. Table or record not found */
	SqliteCodeFULL = 13,		/* Insertion failed because database is full */
	SqliteCodeCANTOPEN = 14,	/* Unable to open the database file */
	SqliteCodePROTOCOL = 15,	/* NOT USED. Database lock protocol error */
	SqliteCodeEMPTY = 16,		/* Database is empty */
	SqliteCodeSCHEMA = 17,		/* The database schema changed */
	SqliteCodeTOOBIG = 18,		/* String or BLOB exceeds size limit */
	SqliteCodeCONSTRAINT = 19,	/* Abort due to constraint violation */
	SqliteCodeMISMATCH = 20,	/* Data type mismatch */
	SqliteCodeMISUSE = 21,		/* Library used incorrectly */
	SqliteCodeNOLFS = 22,		/* Uses OS features not supported on host */
	SqliteCodeAUTH = 23,		/* Authorization denied */
	SqliteCodeFORMAT = 24,		/* Auxiliary database format error */
	SqliteCodeRANGE = 25,		/* 2nd parameter to sqlite3_bind out of range */
	SqliteCodeNOTADB = 26,		/* File opened that is not a database file */
	SqliteCodeROW = 100,		/* sqlite3_step() has another row ready */
	SqliteCodeDONE = 101		/* sqlite3_step() has finished executing */
	
} SqliteCodes;


typedef enum
{
	SqliteLimitLENGTH = 0,
	SqliteLimitSQL_LENGTH = 1,
	SqliteLimitCOLUMN = 2, 
	SqliteLimitEXPR_DEPTH = 3, 
	SqliteLimitCOMPOUND_SELECT = 4,
	SqliteLimitVDBE_OP = 5,
	SqliteLimitFUNCTION_ARG = 6,
	SqliteLimitATTACHED = 7,
	SqliteLimitLIKE_PATTERN_LENGTH = 8,
	SqliteLimitVARIABLE_NUMBER = 9,
	SqliteLimitTRIGGER_DEPTH = 10
} SqliteLimits;

@interface Sqlite : NSObject {
	sqlite3 *database;
}

- (id) initWithFilename:(NSString*) databaseFilename;
- (id) initWithFilename:(NSString*) databaseFilename readOnly:(BOOL)readOnly;

- (SqliteCodes) close;

- (SqliteCodes) threadSafe;
- (SqliteCodes) extendedResultCodes:(BOOL)enable;

- (sqlite3_int64) lastInsertRowId;

- (SqliteCodes) changes;
- (SqliteCodes) totalChanges;

- (void) interrupt;

- (SqliteCodes) complete:(NSString*)sql;

- (SqliteCodes) busyTimeout:(NSInteger)milliseconds;

//- (SqliteCodes) getTable;
//- (SqliteCodes) freeTable;


- (NSInteger) errorCode;
- (NSInteger) extendedErrorCode;

- (NSString*) errorMessage;


- (SqliteCodes) limit:(NSInteger)identifier value:(NSInteger)value;

- (SqliteQuery*) queryWithStatement:(NSString*)sqlQuery;


@end
