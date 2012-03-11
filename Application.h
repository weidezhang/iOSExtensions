//
//  Application.h
//
//  Licensed by ruralcoder.com under the
//  Creative Commons Attribution-ShareAlike 3.0 Unported License 

#import <Foundation/Foundation.h>

@interface Application  

+ (NSOperationQueue*)operationQueue;
+ (NSNotificationCenter*) notificationCenter;

+ (NSString*) documentsFolder;
+ (NSString*) cacheFolder;

+ (id) fileInCache:(id)filename;
+ (id) fileInDocuments:(id)filename;
+ (id) fileInBundle:(id)filename;

+ (NSURL*) urlInCache:(NSString*)filename;
+ (NSURL*) urlInDocuments:(NSString*)filename;

+ (NSString*) version;
+ (NSString*) versionClean;

+ (void) registerDefaultValues;

@end
