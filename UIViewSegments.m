//
//  UIViewSegments.m
//
//  Licensed by ruralcoder.com under the
//  Creative Commons Attribution-ShareAlike 3.0 Unported License 

#import "UIViewSegments.h"

@implementation UIViewSegments
@synthesize segments = _segments;

- (id) init
{
    self = [super init];
    
    if (self)
        _segments = [[NSMutableArray alloc] init];
    
    return self;
}


- (void) dealloc
{
    [_segments release];
    [super dealloc];
}


- (NSString*) description
{
    return [self.segments description];
}

+ (UILabel*) labelWithText:(id)text font:(UIFont*)font color:(UIColor*)color width:(float)width
{
    return [UIViewSegments labelWithMultilineText:text font:font color:color width:width ];
}


+ (UILabel*) labelWithOneLineText:(id)text fontSize:(CGFloat)fontSize color:(UIColor*)color width:(float)width 
{
    CGFloat height = fontSize;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    
    label.text = text;
    label.numberOfLines = 1;
    label.textColor = color;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:fontSize];
    label.lineBreakMode = UILineBreakModeTailTruncation;
    label.textAlignment = UITextAlignmentLeft;
    return [label autorelease];
}


+ (UILabel*) labelWithMultilineText:(id)text font:(UIFont*)font color:(UIColor*)color width:(float)width 
{
    CGSize maxSize = CGSizeMake(width, 9999);
    
    CGSize size = [text sizeWithFont:font
                   constrainedToSize:maxSize
                       lineBreakMode:UILineBreakModeWordWrap]; 
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];

    label.text = text;
    label.numberOfLines = 0;
    label.textColor = color;
    label.backgroundColor = [UIColor clearColor];
    label.font = font;
    label.lineBreakMode = UILineBreakModeWordWrap;
    label.textAlignment = UITextAlignmentLeft;
    return [label autorelease];
}


- (UIView*) containerWithMarginBetweetSegments:(NSUInteger)margin frame:(CGRect)frame
{
    NSUInteger calculatedHeight = 0;
    CGRect updatedFrame;
    
    UIView *container = [[UIView alloc] initWithFrame:frame];
    
    for (UIView *segment in self.segments)
    {
        updatedFrame = segment.frame;
        updatedFrame.origin.y = calculatedHeight;
        segment.frame = updatedFrame;

        [container addSubview:segment];
        
        calculatedHeight += updatedFrame.size.height + margin;
    }
    
    frame.size.height = calculatedHeight;
    container.frame = frame;
    
    return [container autorelease];
}


@end
