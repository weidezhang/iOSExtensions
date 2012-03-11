//
//  Application.m
//
//  Licensed by ruralcoder.com under the
//  Creative Commons Attribution-ShareAlike 3.0 Unported License 


#import "Application.h"

@implementation Application


+ (NSOperationQueue*)operationQueue
{
    static NSOperationQueue* sOperationQueue = nil;
    
    @synchronized(self)
    {
        if (sOperationQueue)
            return sOperationQueue;
        
        sOperationQueue = [[NSOperationQueue alloc] init];
        
        return sOperationQueue;
    }
}


+ (NSNotificationCenter*) notificationCenter
{
    static NSNotificationCenter* sCenter = nil;
    
    @synchronized(self)
    {
        if (sCenter)
            return sCenter;
        
        sCenter = [[NSNotificationCenter alloc] init];
        
        return sCenter;
    }
}


+ (NSString*) documentsFolder
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
}


+ (NSString*) cacheFolder
{
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
}


+ (id) fileInCache:(id)filename
{
    NSString *cachesPath = [Application cacheFolder];
    return [cachesPath stringByAppendingPathComponent:filename];
}


+ (id) fileInBundle:(id)filename
{
    return [[NSBundle mainBundle] pathForResource:filename ofType:nil];
}


+ (NSURL*) urlInCache:(NSString*)filename
{
    return [NSURL fileURLWithPath:[Application fileInCache:filename]]; 
}


+ (id) fileInDocuments:(id)filename
{
    NSString *documentsPath = [Application documentsFolder];
    return [documentsPath stringByAppendingPathComponent:filename];
}


+ (NSURL*) urlInDocuments:(NSString*)filename
{
    return [NSURL fileURLWithPath:[Application fileInDocuments:filename]]; 
}


+ (NSString*)version
{
    id versionValue = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    
    return [NSString stringWithFormat:@"version: %@", versionValue];
}


+ (NSString*)versionClean
{
    id buildValue = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
    
    return [NSString stringWithFormat:@"%@", buildValue];
}

@end
