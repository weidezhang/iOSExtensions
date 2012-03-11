//
//  UIDeviceExtension.m
//
//  Licensed by ruralcoder.com under the
//  Creative Commons Attribution-ShareAlike 3.0 Unported License 

#import "UIDeviceExtension.h"

static const CGSize KStandardListViewCellImageSize = {40, 40};
static const CGSize KRetinaListViewCellImageSize = {80, 80};

@implementation UIDevice (Extension)


+ (BOOL) isRetinaDisplay
{
    if ( [UIScreen instancesRespondToSelector:@selector(scale)] == NO)
        return NO;
    
    return ([[UIScreen mainScreen] scale] == 2.0);
}


+ (CGSize) imageSizeForCell
{
    if ([UIDevice isRetinaDisplay])
        return KRetinaListViewCellImageSize;
    else
        return KStandardListViewCellImageSize;
}


+ (NSString *) newUniqueIdentifier
{
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, theUUID);
    CFRelease(theUUID);
    
    return (NSString *)string;
}

@end
