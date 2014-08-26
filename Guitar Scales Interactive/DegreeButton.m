//
//  DegreeButton.m
//  Guitar Scales Interactive
//
//  Created by Elena Boyd on 8/24/14.
//
//

#import "DegreeButton.h"

@implementation DegreeButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor GuitarBlue] forState:UIControlStateSelected];
        //[self setColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        //[self setColor:[UIColor GuitarBlue] forState:UIControlStateSelected];

        self.titleEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 8);

    }
    return self;
}


//// Only override drawRect: if you perform custom drawing.
//// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect
//{
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    
//    CGColorRef strokeColor;
//    CGColorRef fillColor;
//    
//    switch (self.state) {
//        case UIControlStateSelected:
//            self.backgroundColor = [UIColor GuitarBlue];
//            strokeColor = [self titleColorForState:UIControlStateNormal] ? [self titleColorForState:UIControlStateNormal].CGColor : [UIColor blackColor].CGColor;
//            fillColor = [UIColor purpleColor].CGColor;
//            break;
//        case UIControlStateDisabled:
//            strokeColor = [self titleColorForState:UIControlStateDisabled] ? [self titleColorForState:UIControlStateDisabled].CGColor : [UIColor blackColor].CGColor;
//            fillColor = [self titleColorForState:UIControlStateDisabled] ? [self titleColorForState:UIControlStateDisabled].CGColor : [UIColor blackColor].CGColor;
//            break;
//        default:
//            strokeColor = [self titleColorForState:UIControlStateNormal] ? [self titleColorForState:UIControlStateNormal].CGColor : [UIColor blackColor].CGColor;
//            fillColor = [UIColor GuitarBlue].CGColor;
//            self.backgroundColor = [UIColor whiteColor];
//            break;
//    }
//    
//    CGContextSetFillColorWithColor(ctx, fillColor);
//    CGContextSetStrokeColorWithColor(ctx, strokeColor);
//    
//    CGContextSaveGState(ctx);
//    
//    CGFloat lineWidth = 2.0;
//    
//    CGContextSetLineWidth(ctx, lineWidth);
//    
//    UIBezierPath *outlinePath = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(self.bounds, lineWidth, lineWidth) cornerRadius:self.bounds.size.height/2];
//    
//    //CGContextAddPath(ctx, outlinePath.CGPath);
//    //CGContextStrokePath(ctx);
//}

//- (void)setSelected:(BOOL)selected
//{
//    [super setSelected:selected];
//    
//    if (selected) {
//        self.backgroundColor = [UIColor GuitarBlue];
//        self.titleLabel.textColor = [UIColor whiteColor];
//
//    } else {
//        self.backgroundColor = [UIColor whiteColor];
//        self.titleLabel.textColor = [UIColor GuitarBlue];
//
//    }
//    
//}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    [self setNeedsDisplay];
}

//- (void)setColor:(UIColor *)color forState:(UIControlState)state
//{
//    UIView *colorView = [[UIView alloc] initWithFrame:self.frame];
//    colorView.backgroundColor = color;
//    
//    UIGraphicsBeginImageContext(colorView.bounds.size);
//    [colorView.layer renderInContext:UIGraphicsGetCurrentContext()];
//    
//    UIImage *colorImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    
//    [self setBackgroundImage:colorImage forState:state];
//}



@end
