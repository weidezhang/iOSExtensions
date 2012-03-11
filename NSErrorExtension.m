//
//  NSErrorExtension.m
//
//  Licensed by ruralcoder.com under the
//  Creative Commons Attribution-ShareAlike 3.0 Unported License 

#import "NSErrorExtension.h"

@implementation NSError (Extension)


+ (id)errorWithDomain:(NSString *)domain 
                 code:(NSInteger)code
                title:(NSString*)title
          description:(NSString*)description
{
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:NSLocalizedString(title, description)
                                                         forKey:NSLocalizedDescriptionKey];
    
    return [NSError errorWithDomain:domain code:code userInfo:userInfo];
}

@end

