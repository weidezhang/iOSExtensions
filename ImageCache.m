//
//  ImageCache.m
//
//  Licensed by ruralcoder.com under the
//  Creative Commons Attribution-ShareAlike 3.0 Unported License 

#import "ImageCache.h"
#import "ImageCacheDelegate.h"
#import "Application.h"
#import "NSStringExtension.h"
#import "ImageObservers.h"
#import "Observer.h"


#define MAX_AGE_OF_CACHED_FILE 15   // days
#define SECONDS_IN_A_DAY 86400      // seconds

static NSString *cachePath = nil;

@interface ImageCache ()

@property (nonatomic, readonly) NSFileManager *fs;
@property (nonatomic, retain) NSMutableDictionary *observers;

@end


@implementation ImageCache
@synthesize observers;

+ (ImageCache*) instance
{
    @synchronized(self)
    {
        static ImageCache *singleton = nil;

        if (singleton)
            return singleton;
    
        singleton = [[ImageCache alloc] init];
        
        return singleton;
    }
}


- (NSFileManager *)fs
{
    return [NSFileManager defaultManager];
}


+ (id) fileInImagesCache:(id)filename withExtension:(id)extension
{
    if (cachePath == nil)
        cachePath = [[Application fileInCache:@"images"] retain];

    NSString *absolutePath = [cachePath stringByAppendingPathComponent:filename];
    
    if (extension && [extension length] > 0)
        absolutePath = [absolutePath stringByAppendingPathExtension:extension];
    
    return absolutePath;
}


- (id) init
{
    self = [super init];
    self.observers = [NSMutableDictionary dictionary];
    
    NSString *imagesPath = [Application fileInCache:@"images"];
   
    if ([self.fs fileExistsAtPath:imagesPath] == NO)
    {
        [self.fs createDirectoryAtPath:imagesPath 
                          withIntermediateDirectories:YES 
                                           attributes:nil 
                                                error:nil];

    }
    
    return self;
}


+ (UIImage*) imageFromCacheWithUrl:(NSURL*)url cookie:(id)object target:(id)target
{
    if (url == nil)
        return nil;

    // Client can be null is the case where no events are needed (e.g. building caches of categories)
    // IndexPath can be null in the case of the business details image in the header.
    
    NSString *digest = [[url absoluteString] digest];
    
    NSString *absolutePath = [ImageCache fileInImagesCache:digest withExtension:[url pathExtension]];

    NSFileManager *fs = [NSFileManager defaultManager];
    NSData *cachedData = nil;
    BOOL needsFetching = YES;
    
    if ([fs fileExistsAtPath:absolutePath])
    {
        cachedData = [NSData dataWithContentsOfFile:absolutePath];

        NSDictionary *attributes = [fs attributesOfItemAtPath:absolutePath error:nil];
        NSDate *timestamp = [attributes objectForKey:NSFileCreationDate];
        NSTimeInterval ageInSecs = [[NSDate date] timeIntervalSinceDate:timestamp ];
        double ageInDays = (ageInSecs / SECONDS_IN_A_DAY);
        
        needsFetching = (ageInDays > MAX_AGE_OF_CACHED_FILE);
        AppLog(@"INFO: File '%@' age %.1f days", digest, ageInDays);
        
        if (cachedData == nil)
            return nil;
        
        return [UIImage imageWithData:cachedData];

    }
    
    if (needsFetching)
    {
        ImageCache *cacher = [ImageCache instance];
        
        ImageObservers *imageObservers = [cacher.observers objectForKey:url];
        
        if (imageObservers == nil)
        {
            imageObservers = [ImageObservers createObserverWithFilename:absolutePath andUrl:url];
            [cacher.observers setObject:imageObservers forKey:url];
        }
        
        Observer *observer = [Observer createObserverWithTarget:target andCookie:object];
        [imageObservers addObserver:observer];

        [imageObservers start];
    }
    
    return nil;
}


+ (UIImage*) imageFromCacheWithUrl:(NSURL*)url 
{
    if (url == nil)
        return nil;

    NSString *digest = [[url absoluteString] digest];
    
    NSString *absolutePath = [ImageCache fileInImagesCache:digest withExtension:[url pathExtension]];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:absolutePath] == NO)
        return nil;

    NSData *data = [NSData dataWithContentsOfFile:absolutePath];
    return [UIImage imageWithData:data];
}






@end


