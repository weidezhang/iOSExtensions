//
//  SqlObject.m
//
// Sqlite Objective C wrapper by Stephen Anderson is licensed under 
// a Creative Commons Attribution-ShareAlike 3.0 Unported License.
// Permissions beyond the scope of this license may be available at 
// ruralcoder.com.

#import "SqlObject.h"
#import "SqliteQuery.h"

@implementation SqlObject
@synthesize sqliteQuery;

- (id) initWithData:(SqliteQuery*)query
{
    if (query == nil)
        return nil;
    
    NSParameterAssert(query);
    
    if ([query step] != SQLITE_ROW)
        return nil;
    
    self = [super init];
    
    if (self)
    {
        self.sqliteQuery = query;
    }
    
    return self;
}


- (BOOL) nextRecord
{
    return ([self.sqliteQuery step] == SQLITE_ROW);
}


- (void) dealloc
{
    self.sqliteQuery = nil;
    [super dealloc];
}

@end
