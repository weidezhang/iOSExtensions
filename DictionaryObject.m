//
//  DictionaryObject.m
//
//  Licensed by ruralcoder.com under the
//  Creative Commons Attribution-ShareAlike 3.0 Unported License 

#import "DictionaryObject.h"

@implementation DictionaryObject
@synthesize fields;

- (id) init
{
    NSAssert(NO, @"Unsupported: Use initWithFields instead");
    return nil;
}

- (id) initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    
    if (self)
    {
        self.fields = dictionary;
    }
    
    return self;
}


- (void) dealloc
{
    self.fields = nil;
    [super dealloc];
}

- (NSString*)description
{
    return [self.fields description];
}

@end
