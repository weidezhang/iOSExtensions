//
//  NSErrorExtension.h
//
//  Licensed by ruralcoder.com under the
//  Creative Commons Attribution-ShareAlike 3.0 Unported License 

#import <Foundation/Foundation.h>

@interface NSError (Extension)

+ (id)errorWithDomain:(NSString *)domain 
                 code:(NSInteger)code
                title:(NSString*)title
          description:(NSString*)description;

@end
