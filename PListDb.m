//
//  PListDb.m
//
//  Licensed by ruralcoder.com under the
//  Creative Commons Attribution-ShareAlike 3.0 Unported License 

#import "PListDb.h"
#import "Application.h"
#import "NSDictionaryExtension.h"
#import "ApplicationLogging.h"


NSString *const NKPListDbDataUpdated = @"NKPListDbDataUpdated";
NSString *const NKPListDbDataUpdateFailed = @"NKPListDbDataUpdateFailed";

@implementation PListDb
@synthesize dbName = _dbName;
@synthesize absolutePath = _absolutePath;
@synthesize fields = _fields;
@synthesize notificationKey;


+ (id) instance
{
    NSAssert(NO, @"You are trying to instantiate the base class");
    return nil;
}


- (BOOL) save
{
    return [self saveAndNotify:YES];    
}


- (BOOL) saveAndNotify:(BOOL)notifyObservers
{
    BOOL saved = [self.fields writeToFile:_absolutePath atomically:YES];
    
    if (notifyObservers)
    {
        id notifKey = (self.notificationKey) ? self.notificationKey : NKPListDbDataUpdated;
        
        if (saved)
            [[NSNotificationCenter defaultCenter] postNotificationName:notifKey object:nil];
        else
            [[NSNotificationCenter defaultCenter] postNotificationName:NKPListDbDataUpdateFailed object:nil];
    }
    
#if TARGET_IPHONE_SIMULATOR
    if (saved)
        DLog(@"%@::saveAndNotify: OK '%@'.", [self class], _dbName);
    else
        ErrorLog(@"Error: Unable to save '%@'.", _dbName);
#endif
    
    return saved;
}


- (void) reloadData
{
    [self.fields removeAllObjects];
    [_fields release];
    
     _fields = [[NSMutableDictionary alloc] initWithContentsOfFile:self.absolutePath];
     
}


- (void) addObject:(id)object forKey:(id)key
{
    [self addObject:object forKey:key overwrite:NO];
}


- (void) addObject:(id)object forKey:(id)key overwrite:(BOOL)overwrite
{
    if (overwrite == NO && [self.fields containsKey:key] == YES)
        return;
    
    [self.fields setObject:object forKey:key];
    [self save];
}


- (void) removeObjectWithKey:(id)key
{
    if ([self.fields containsKey:key] == NO)
        return;
    
    [self.fields removeObjectForKey:key];
    [self save];
}


- (void) removeAllObjects
{
    [self.fields removeAllObjects];
    [self save];
}


#pragma mark Alloc & Dealloc


- (id) initWithDbName:(id)dbName
{
    id absolutePath = [Application fileInCache:dbName];
    
    self = [super init];
    
    if (self)
    {
        _fields = [[NSMutableDictionary alloc] initWithContentsOfFile:absolutePath];
        
        if (_fields == nil)
            _fields = [[NSMutableDictionary alloc] init];
        
        _dbName = [dbName retain];
        _absolutePath = [absolutePath retain];
    }
    
    return self;
}


- (void) dealloc
{
    [_fields release];
    [_dbName release];
    [_absolutePath release];
    self.notificationKey = nil;
    
    [super dealloc];
}


@end




