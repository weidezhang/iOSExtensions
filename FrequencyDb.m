//
//  FrequencyDb.m
//
//  Licensed by ruralcoder.com under the
//  Creative Commons Attribution-ShareAlike 3.0 Unported License 


#import "FrequencyDb.h"
#import "NSDictionaryExtension.h"


@implementation FrequencyDb


- (void) increaseUse:(id)key
{
    NSUInteger freqValue = 1;
    
    NSNumber *frequency = [self.fields objectForKey:key];
    
    if (frequency)
        freqValue = [frequency unsignedIntegerValue] + 1;
    
    frequency = [NSNumber numberWithUnsignedInteger:freqValue];
    
    [self addObject:frequency forKey:key overwrite:YES];
}


- (NSUInteger) frequencyForKey:(id)key
{
    if ([self.fields containsKey:key] == NO)
        return 0;
    
    return [[self.fields objectForKey:key] unsignedIntegerValue];
}


@end
