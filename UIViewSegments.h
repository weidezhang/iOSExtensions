//
//  UIViewSegments.h
//
//  Licensed by ruralcoder.com under the
//  Creative Commons Attribution-ShareAlike 3.0 Unported License 


#import <Foundation/Foundation.h>

@interface UIViewSegments : NSObject
@property (nonatomic, readonly) NSMutableArray *segments;



+ (UILabel*) labelWithText:(id)text font:(UIFont*)font color:(UIColor*)color width:(float)width ;
+ (UILabel*) labelWithOneLineText:(id)text fontSize:(CGFloat)fontSize color:(UIColor*)color width:(float)width; 
+ (UILabel*) labelWithMultilineText:(id)text font:(UIFont*)font color:(UIColor*)color width:(float)width;

- (UIView*) containerWithMarginBetweetSegments:(NSUInteger)margin frame:(CGRect)frame;

@end
