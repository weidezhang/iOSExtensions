//
//  UIImageExtension.h
//
//  Licensed by ruralcoder.com under the
//  Creative Commons Attribution-ShareAlike 3.0 Unported License 

#import <Foundation/Foundation.h>

@interface UIImage (Extension)

- (UIImage *) toGrayscale;
- (UIImage *) toThumbnail:(CGSize)size;

@end
