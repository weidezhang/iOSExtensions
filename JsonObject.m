//
//  JsonObject.m
//
//  Licensed by ruralcoder.com under the
//  Creative Commons Attribution-ShareAlike 3.0 Unported License 

#import "JsonObject.h"
#import "ApplicationLogging.h"

@implementation JsonObject

- (id) init
{
    NSAssert(NO, @"Unsupported: Use initWithData instead");
    return nil;
}


- (id) initWithData:(NSData*)jsonData
{
    NSAssert(jsonData != nil, @"Invalid argument for initWithJsonData jsonData == nil");
    NSAssert([jsonData length] > 0, @"Invalid argument for initWithJsonData jsonData has 0 bytes");
    

//    NSString *debugThis = [jsonData toString];
//    DLog(@"%@", debugThis);

 
    NSError *jsonParsingError = nil;
    NSDictionary *fields = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&jsonParsingError];

    if (fields == nil || jsonParsingError != nil)
    {
        if (jsonParsingError)
            ErrorLog(@"Error: %@", [jsonParsingError localizedDescription]);
        else
            ErrorLog(@"Error: failed to parse json data for unknown reason");
        
        return nil;
    }

    self = [super initWithDictionary:fields]; // fields retained by base class
    
    return self;
}




@end
