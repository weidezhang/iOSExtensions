//
//  ImageCacheDelegate.h
//
//  Licensed by ruralcoder.com under the
//  Creative Commons Attribution-ShareAlike 3.0 Unported License 

#import <Foundation/Foundation.h>

@protocol ImageCacheDelegate <NSObject>

- (void) newImageAvailable:(UIImage*)image cookie:(id)object;

@end
