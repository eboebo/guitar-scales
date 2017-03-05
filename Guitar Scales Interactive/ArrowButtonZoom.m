//
//  ArrowButtonZoom.m
//  Guitar Scales Interactive
//
//  Created by Chris McQueen on 12/15/16.
//
//

#import "ArrowButtonZoom.h"
#import "UIColor+Guitar.h"

@implementation ArrowButtonZoom

- (id)initWithFrame:(CGRect)frame andType:(ArrowButtonTypeZoom)buttonTypeZoom {
    if (self = [super initWithFrame:frame]) {
        self.type = buttonTypeZoom;
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
    
    if (self.type == ArrowButtonTypeRightZoom) {
        CGContextMoveToPoint(context, 0, 0);
        CGContextAddLineToPoint(context, 0, size.height);
        CGContextAddLineToPoint(context, size.width, size.height / 2.0);
        CGContextAddLineToPoint(context, 0.0, 0.0);
        
        CGContextSetFillColorWithColor(context, [UIColor GuitarMain].CGColor);
    } else if (self.type == ArrowButtonTypeLeftZoom){
        CGContextMoveToPoint(context, size.width, 0);
        CGContextAddLineToPoint(context, size.width, size.height);
        CGContextAddLineToPoint(context, 0, size.height / 2.0);
        CGContextAddLineToPoint(context, size.width, 0.0);
        
        CGContextSetFillColorWithColor(context, [UIColor GuitarMain].CGColor);
    }
    
    CGContextClosePath(context);
    CGContextFillPath(context);
}


@end

