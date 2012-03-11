//
//  KeyChainWrapper.h
//
//  Licensed by ruralcoder.com under the
//  Creative Commons Attribution-ShareAlike 3.0 Unported License 

#import <Foundation/Foundation.h>

//
// !REQUIREMENT: Security.framework!
//

@interface KeyChainWrapper : NSObject



+ (NSString*) retrieveEntryForUser:(NSString*)userEmail forService:(NSString*)service;

+ (BOOL) createEntryForUser:(NSString*)userEmail entryValue:(NSString*)entryValue forService:(NSString*)service;
+ (BOOL) isEntryStoredForUserEmail:(NSString*)userEmail forService:(NSString*)service;
+ (BOOL) removeEntryForUserEmail:(NSString*)userEmail forService:(NSString*)service;

+ (NSString *) keyChainErrorToString:(OSStatus)status;
+ (void) printAttributes:(NSDictionary *)attributes;


@end
