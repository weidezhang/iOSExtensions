//
//  SqlObject.h
//
// Sqlite Objective C wrapper by Stephen Anderson is licensed under 
// a Creative Commons Attribution-ShareAlike 3.0 Unported License.
// Permissions beyond the scope of this license may be available at 
// ruralcoder.com.

#import <Foundation/Foundation.h>
#import "SqliteQuery.h"


@interface SqlObject : NSObject
@property (nonatomic, retain) SqliteQuery *sqliteQuery;

- (id) initWithData:(SqliteQuery*)query;

- (BOOL) nextRecord;

@end
