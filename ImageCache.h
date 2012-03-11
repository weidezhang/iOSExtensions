//
//  ImageCache.h
//
//  Licensed by ruralcoder.com under the
//  Creative Commons Attribution-ShareAlike 3.0 Unported License 

#import "ImageCacheDelegate.h"


@interface ImageCache : NSObject

/*
 Uses the URL as a key to find the cached image.
 If none is found the NIL is returned.
 */
+ (UIImage*) imageFromCacheWithUrl:(NSURL*)url;

/*
 Uses the URL as a key to find the cached image.
 If none is found the NIL is returned but initiates a 
 image request which upon completion it call the client
 passing along the indexPath as a cookie along with the
 data
 */
+ (UIImage*) imageFromCacheWithUrl:(NSURL*)url cookie:(id)object target:(id<ImageCacheDelegate>)client;




@end
