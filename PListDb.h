//
//  PListDb.h
//
//  Licensed by ruralcoder.com under the
//  Creative Commons Attribution-ShareAlike 3.0 Unported License 

#import <Foundation/Foundation.h>

UIKIT_EXTERN NSString *const NKPListDbDataUpdated;
UIKIT_EXTERN NSString *const NKPListDbDataUpdateFailed;


@interface PListDb : NSObject

@property (nonatomic, readonly) NSMutableDictionary *fields;
@property (nonatomic, readonly) NSString *dbName;
@property (nonatomic, readonly) NSString *absolutePath;

@property (nonatomic, retain) id notificationKey;

- (id) initWithDbName:(id)dbName;

- (void) addObject:(id)object forKey:(id)key;
- (void) addObject:(id)object forKey:(id)key overwrite:(BOOL)overwrite;

- (void) removeObjectWithKey:(id)key;
- (void) removeAllObjects;

- (BOOL) save;
- (BOOL) saveAndNotify:(BOOL)notifyObservers;

- (void) reloadData;

@end

