//
//  NSScannerExtension.m
//  DurationScanner
//
//  Created by Stephen Anderson on 1/11/11.
//  Copyright 2011 KaDonk Inc. All rights reserved.
//

#import "NSScannerExtension.h"


@implementation NSScanner (NSScannerExtension)

- (char) scanNextCharacter
{
	NSUInteger location = [self scanLocation];
	NSString *target = [self string];
	
	if (location > [target length] - 1)
		return 0;
	
	char value = [target characterAtIndex:location];
	
	[self setScanLocation:location+1];
	
	return value;
}


@end
