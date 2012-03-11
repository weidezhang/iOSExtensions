//
//  NSDataExtension.h
//
//  Licensed by ruralcoder.com under the
//  Creative Commons Attribution-ShareAlike 3.0 Unported License 

#import <Foundation/Foundation.h>

@interface NSData (Extension)

- (NSString*) toString;


- (NSData *) gzipInflate;
- (NSData *) gzipDeflate;


@end
