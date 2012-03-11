//
//  NSStack.m
//
//  Licensed by ruralcoder.com under the
//  Creative Commons Attribution-ShareAlike 3.0 Unported License 

#import "NSStack.h"


@implementation NSStack
@synthesize objects = _objects;

#pragma mark - Lifecycle

- (id)init 
{
    self = [super init];
    
    if (self) 
        _objects = [[NSMutableArray alloc] init];    
     
    return self;
}


- (void) dealloc
{
    [_objects release];
    [super dealloc];
}


#pragma mark - Stack Methods


- (NSArray*) toArray
{
	return [NSArray arrayWithArray:_objects];
}


- (void)push:(id)object 
{
    [_objects insertObject:object atIndex:0];
}


- (id)top
{
    if ([_objects count] == 0) return nil;

    id object = [[[_objects objectAtIndex:0] retain] autorelease];
    
    return object;
}


- (id)pop
{
    if ([_objects count] == 0) return nil;
    
    id object = [[[_objects objectAtIndex:0] retain] autorelease];
    [_objects removeObjectAtIndex:0];
    
    return object;
}


- (void) popAll
{
    [_objects removeAllObjects];
}


- (NSInteger) count
{
    return [_objects count];
}





@end
