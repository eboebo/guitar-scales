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
    
    CGFloat originY = 0.0;
    CGFloat height = size.height;
    CGFloat halfHeight = height / 2.0;
    CGFloat width = size.width;
    
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) // iPhone fullstring view
    {
        originY = size.height * 0.2;
        height = size.height * 0.8;
        width = size.width * 0.3;
        CGFloat leftSide = size.width - width;
    
        if (self.type == ArrowButtonTypeRight) {
            CGContextMoveToPoint(context, 0, originY);
            CGContextAddLineToPoint(context, 0, height);
            CGContextAddLineToPoint(context, width, halfHeight);
            CGContextAddLineToPoint(context, 0.0, originY);
            
            CGContextSetFillColorWithColor(context, [UIColor GuitarMain].CGColor);
        } else if (self.type == ArrowButtonTypeLeft){
            CGContextMoveToPoint(context, size.width, originY);
            CGContextAddLineToPoint(context, size.width, height);
            CGContextAddLineToPoint(context, leftSide, halfHeight);
            CGContextAddLineToPoint(context, size.width, originY);
            
            CGContextSetFillColorWithColor(context, [UIColor GuitarMain].CGColor);
        }
    }
    else {
        if (self.type == ArrowButtonTypeRight) { // up arrow
            CGContextMoveToPoint(context, size.width / 2.0, 0);
            CGContextAddLineToPoint(context, 0, size.height);
            CGContextAddLineToPoint(context, size.width, size.height);
            CGContextAddLineToPoint(context, size.width / 2.0, 0);
            
            CGContextSetFillColorWithColor(context, [UIColor blackColorAlpha].CGColor);
        } else if (self.type == ArrowButtonTypeLeft){ // down arrow
            CGContextMoveToPoint(context, 0, 0);
            CGContextAddLineToPoint(context, size.width / 2.0, size.height);
            CGContextAddLineToPoint(context, size.width, 0.0);
            CGContextAddLineToPoint(context, 0, 0);
            
            CGContextSetFillColorWithColor(context, [UIColor blackColorAlpha].CGColor);
        }
    }
    
    CGContextClosePath(context);
    CGContextFillPath(context);
}


@end
