//
//  GradientLineView.m
//  Guitar Scales Interactive
//
//  Created by Chris McQueen on 12/15/16.
//
//

#import "GradientLineView.h"
#import "UIColor+Guitar.h"
#import "GuitarStore.h"
#import "QuartzCore/QuartzCore.h"

@implementation GradientLineView

- (id)initWithFrame:(CGRect)frame andType:(GradientLinesType)buttonType {
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

- (void)drawRect:(CGRect)rect               // Gradient Lines
{
    BOOL isiPad = [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad;
    
    if (!isiPad) {
        [super drawRect:rect];
        
        CGFloat width = self.bounds.size.width;
        CGFloat height = self.bounds.size.height;
        CGFloat horizontalSpacing = width / 3.1;
        CGFloat verticalSpacing   = height / 5.616;                 // iPhone 6 & 7
        CGFloat verticalOffset   = height / 11.7;
        CGFloat lineWidth = height / 60.0;
        CGFloat horizontalOffset;
        
        CGFloat startGradientX = 0.0f;
        CGFloat endGradientX = 1.0f;
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetStrokeColorWithColor(context, [[UIColor GuitarLightGray] CGColor]);
        CGContextSetLineWidth(context, lineWidth);
        
        CGRect bounds = [[UIScreen mainScreen] bounds];
        if (bounds.size.width < 667) {                              // iPhone 5
            verticalSpacing = height / 5.7;
        }
        if (bounds.size.width > 667) {                              // iPhone 6 & 7 Plus
            verticalOffset   = height / 11.5;
            verticalSpacing = height / 5.67;
        }
        
        BOOL useShortScale = false;
        if ((self.position.identifier == 4) || (self.position.identifier == 5) || (self.position.identifier == 6)) {
            useShortScale = true;
        }
        
        if (self.type == GradientLinesLeft) {                              // left gradient lines
            horizontalOffset = horizontalSpacing * 0.85;
            // draw vertical lines
            NSInteger numLines = 2;
            if (useShortScale) {
                numLines = 3;
                horizontalOffset = horizontalSpacing * 0.32;
            }
            for (int i = 0; i < numLines; i++) {
                CGFloat x = horizontalOffset + (i * horizontalSpacing);
                CGFloat y = 5 * verticalSpacing + verticalOffset;
                CGContextMoveToPoint(context, x, verticalOffset);
                CGContextAddLineToPoint(context, x, y);
                CGContextDrawPath(context, kCGPathStroke);
            }
            
            // draw horizontal lines
            CGFloat horizontalLineWidth = width;
            CGFloat horizontalLineX     = 0.0;
            if (!useShortScale) {
                horizontalLineWidth -= (horizontalSpacing * 0.46);
            }
            
            for (int i = 0; i < 6; i++) {
                CGFloat y = i * verticalSpacing + verticalOffset;
                CGContextMoveToPoint(context, horizontalLineX, y);
                CGContextAddLineToPoint(context, horizontalLineWidth, y);
                CGContextDrawPath(context, kCGPathStroke);
            }
            startGradientX = 1.0f;
            endGradientX = 0.0f;
        }
        else {                                                  // right gradient lines
            CGFloat originX        = (horizontalSpacing * 0.46);
            // draw vertical lines
            NSInteger numLines = 2;
            if (useShortScale) {
                numLines = 3;
                originX = 0;
            }
            horizontalOffset = originX + (horizontalSpacing * 0.8);
            CGFloat x = originX;
            for (int i = 0; i < numLines; i++) {
                x = horizontalOffset + (i * horizontalSpacing);
                CGFloat y = 5 * verticalSpacing + verticalOffset;
                CGContextMoveToPoint(context, x, verticalOffset);
                CGContextAddLineToPoint(context, x, y);
                CGContextDrawPath(context, kCGPathStroke);
            }
            
            // draw horizontal lines
            CGFloat horizontalLineWidth = width;
            CGFloat horizontalLineX     = originX;

            for (int i = 0; i < 6; i++) {
                CGFloat y = i * verticalSpacing + verticalOffset;
                CGContextMoveToPoint(context, horizontalLineX, y);
                CGContextAddLineToPoint(context, horizontalLineWidth, y);
                CGContextDrawPath(context, kCGPathStroke);
            }
        }
        
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.frame = self.bounds;
        gradientLayer.colors = [NSArray arrayWithObjects:(id)[UIColor blackColor].CGColor, (id)[UIColor clearColor].CGColor, nil];
        gradientLayer.startPoint = CGPointMake(startGradientX, 1.0f);
        gradientLayer.endPoint = CGPointMake(endGradientX, 1.0f);
        self.layer.mask = gradientLayer;

        
    }// !isiPad
}

@end
