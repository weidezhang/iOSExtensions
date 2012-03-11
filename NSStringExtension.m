//
//  NSStringExtension.m
//
//  Licensed by ruralcoder.com under the
//  Creative Commons Attribution-ShareAlike 3.0 Unported License 

#import "NSStringExtension.h"
#include <CommonCrypto/CommonDigest.h>

@implementation NSString (Extension)

+ (BOOL) isNullOrEmpty:(NSString*)string
{
	if (string == nil) return YES;
	
	return ([string length] == 0);
}


- (BOOL) isEmpty
{
	return ([self length] == 0);
}


- (NSString*) trim
{
	return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}


+ (NSString*) urlEncode:(NSString *)value charactersToEscape:(NSString*)charactersToEscape
{
	NSString * encodedString = (NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
																				   (CFStringRef)value,
																				   NULL,
																				   (CFStringRef)charactersToEscape,
																				   kCFStringEncodingUTF8 );
	
	return [encodedString autorelease];
}


// Helper function 
- (NSString*) urlEncode 
{ 
    return [NSString urlEncode:self charactersToEscape:@"!*'();:@&=+$,/?%#[]"]; 
} 

- (NSString*) urlEncodeSafer
{ 
    return [NSString urlEncode:self charactersToEscape:@"!*'();:@&=+$,?%#[]"]; 
} 


- (BOOL) contains:(NSString*)value
{
	NSRange range = [self rangeOfString:value options:NSCaseInsensitiveSearch];
	
	return (range.location != NSNotFound);
}

                                                                                   

                                                                                   

- (id) digestSHA512
{
    const char *s = [self cStringUsingEncoding:NSASCIIStringEncoding];
	
    NSData *keyData = [NSData dataWithBytes:s length:strlen(s)];
	
    uint8_t digest[CC_SHA512_DIGEST_LENGTH] = {0};
	
    CC_SHA512(keyData.bytes, keyData.length, digest);
	
    NSData *out = [NSData dataWithBytes:digest length:CC_SHA512_DIGEST_LENGTH];
	
    return [out description];
}




- (id) digestMD5 
{
    const char* str = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, strlen(str), result);
    
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02x",result[i]];
    }
    return ret;
}





- (NSString *) stringByStrippingHTML 
{
    NSRange range;
    NSString *object = [[self copy] autorelease];
    
    while ((range = [object rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
    {
        object = [object stringByReplacingCharactersInRange:range withString:@""];
    }
    
    return object; 
}


- (NSString*) clean
{
    NSCharacterSet *badChars = [NSCharacterSet characterSetWithCharactersInString:@"\t ,.'~`!@#$%^&*()_-+=;:|{}[]?<>"];
    return [[self componentsSeparatedByCharactersInSet: badChars] componentsJoinedByString: @""];
}




@end
