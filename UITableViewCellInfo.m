//
//  UITableViewCellInfo.m
//
//  Licensed by ruralcoder.com under the
//  Creative Commons Attribution-ShareAlike 3.0 Unported License 

#import "UITableViewCellInfo.h"

@implementation UITableViewCellInfo
@synthesize title;
@synthesize subtitle;
@synthesize image;
@synthesize key;



- (void) dealloc
{
    self.title = nil;
    self.subtitle = nil;
    self.image = nil;
    self.key = nil;
    
    [super dealloc];
}


@end
