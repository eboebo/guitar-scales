//
//  ArrowButton.m
//  Guitar Scales Interactive
//
//  Created by Elena Boyd on 9/26/16.
//
//

#import "ArrowButton.h"
#import "UIColor+Guitar.h"



@implementation ArrowButton

- (id)initWithFrame:(CGRect)frame andType:(ArrowButtonType)buttonType {
    if (self = [super initWithFrame:frame]) {
        self.type = buttonType;
    }
    return(self);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.backgroundColor = [UIColor clearColor];
}


- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGSize size = self.frame.size;
    
    if (self.type == ArrowButtonTypeRight) {
        CGContextMoveToPoint(context, 0, 0);
        CGContextAddLineToPoint(context, 0, size.height);
        CGContextAddLineToPoint(context, size.width, size.height / 2.0);
        CGContextAddLineToPoint(context, 0.0, 0.0);
        
        CGContextSetFillColorWithColor(context, [UIColor GuitarBlue].CGColor);
    } else {
        CGContextMoveToPoint(context, size.width, 0);
        CGContextAddLineToPoint(context, size.width, size.height);
        CGContextAddLineToPoint(context, 0, size.height / 2.0);
        CGContextAddLineToPoint(context, size.width, 0.0);
        
        CGContextSetFillColorWithColor(context, [UIColor GuitarBlue].CGColor);
        
    }
    
    


    CGContextClosePath(context);
    
    
    CGContextFillPath(context);
}


@end
