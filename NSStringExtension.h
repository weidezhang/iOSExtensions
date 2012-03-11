//
//  NSStringExtension.h
//
//  Licensed by ruralcoder.com under the
//  Creative Commons Attribution-ShareAlike 3.0 Unported License 

#import <Foundation/Foundation.h>


@interface NSString (Extension)

- (BOOL) contains:(id)substring;

- (id) digestMD5;
- (id) digestSHA512;


+ (BOOL) isNullOrEmpty:(NSString*)string;
- (BOOL) isEmpty;

- (NSString*) trim;


+ (NSString*) urlEncode:(NSString *)value charactersToEscape:(NSString*)charactersToEscape;
- (NSString*) urlEncode;
- (NSString*) urlEncodeSafer;


- (NSString *) stringByStrippingHTML;
- (NSString*) clean;

@end
