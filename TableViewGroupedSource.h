//
//  TableViewGroupedSource.h
//
//  Licensed by ruralcoder.com under the
//  Creative Commons Attribution-ShareAlike 3.0 Unported License 


#import <Foundation/Foundation.h>

@interface TableViewGroupedSource : NSObject 

- (void) setDataSourceForGroup:(id)groupName data:(NSArray*)dataSource;
- (void) reset;

- (NSUInteger) numberOfSections;
- (NSUInteger) numberOfRowsInSection:(NSUInteger)section;

- (id) groupNameForSection:(NSUInteger)section;
- (id) dataSourceForSection:(NSUInteger)section;
- (id) objectForIndexPath:(NSIndexPath*) indexPath;

- (BOOL) isEmpty;

@end
