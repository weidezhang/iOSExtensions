//
//  FrequencyDb.h
//
//  Licensed by ruralcoder.com under the
//  Creative Commons Attribution-ShareAlike 3.0 Unported License 


#import "PListDb.h"

@interface FrequencyDb : PListDb

- (void) increaseUse:(id)key;
- (NSUInteger) frequencyForKey:(id)key;

@end
