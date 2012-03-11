//
//  TableViewGroupedSource.m
//
//  Licensed by ruralcoder.com under the
//  Creative Commons Attribution-ShareAlike 3.0 Unported License 


#import "TableViewGroupedSource.h"
#import "NSDictionaryExtension.h"

@interface TableViewGroupedSource ()
@property (nonatomic, retain) NSMutableDictionary *groups;
@property (nonatomic, retain) NSMutableArray *groupOrder;
@end


@implementation TableViewGroupedSource
@synthesize groups;
@synthesize groupOrder;

- (id) init
{
    self = [super init];
    
    if (self)
    {
        self.groups = [NSMutableDictionary dictionary];
        self.groupOrder = [NSMutableArray array];
    }
    
    return self;
}


- (void) dealloc
{
    self.groups = nil;
    self.groupOrder = nil;
    [super dealloc];
}


- (void) setDataSourceForGroup:(id)groupName data:(NSArray*)dataSource
{
    NSParameterAssert(groupName != nil);
    
    if (dataSource == nil)
        return;
    
    if ([dataSource count] == 0)
        return;
    
    if ([[dataSource objectAtIndex:0] isKindOfClass:[UITableViewCellInfo class]] == NO)
        NSAssert(NO, @"Error - Unsupported data type in group source. Add UITableViewCellInfo only.");
    
    [self.groupOrder addObject:groupName];
    [self.groups setObject:dataSource forKey:groupName];
}

- (NSString*)description
{
    return [self.groupOrder description];
}

- (BOOL) isEmpty
{
    if (self.groupOrder.count == 0)
        return YES;
    
    NSUInteger rows = 0;
    for (id key in groupOrder)
    {
        NSArray *groupRows = [self.groups arrayForKey:key];
        rows += groupRows.count;
    }
    
    return (rows == 0);
}


- (void) reset
{
    [self.groupOrder removeAllObjects];
    [self.groups removeAllObjects];
}


- (NSUInteger) numberOfSections
{
    return [self.groupOrder count];
}


- (id) groupNameForSection:(NSUInteger)section
{
    return [self.groupOrder objectAtIndex:section];
}


- (id) dataSourceForSection:(NSUInteger)section
{
    id key = [self groupNameForSection:section];
    return [self.groups arrayForKey:key];
}


- (NSUInteger) numberOfRowsInSection:(NSUInteger)section
{
    return [[self dataSourceForSection:section] count];
}


- (id) objectForIndexPath:(NSIndexPath*) indexPath
{
    NSArray *dataSource = [self dataSourceForSection:indexPath.section];
    return [dataSource objectAtIndex:indexPath.row];
}


@end


