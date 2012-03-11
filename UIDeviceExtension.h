//
//  UIDeviceExtension.h
//
//  Licensed by ruralcoder.com under the
//  Creative Commons Attribution-ShareAlike 3.0 Unported License 

#import <Foundation/Foundation.h>

@interface UIDevice (Extension)


+ (BOOL) isRetinaDisplay;
+ (CGSize) imageSizeForCell;

+ (NSString *) newUniqueIdentifier;

@end
