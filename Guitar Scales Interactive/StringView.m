//
//  StringView.m
//  Guitar Scales Interactive
//
//  Created by Elena Boyd on 8/12/14.
//
//

#import "StringView.h"
#import "Note.h"

@implementation StringView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    CGRect bounds = self.bounds;
    
    CGFloat width = self.bounds.size.width - 20;
    CGFloat height = self.bounds.size.height;
    CGFloat horizontalSpacing = floorf(width / 6.0);
    CGFloat verticalSpacing = floorf(height / 5.0);
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [[UIColor blackColor] CGColor]);
    CGContextSetLineWidth(context, 3.0);
    
    for (int i = 0; i < 7; i++) {
        
        CGFloat x = 10.0 + (i * horizontalSpacing);
        CGContextMoveToPoint(context, x, 0.0);
        CGContextAddLineToPoint(context, x, bounds.size.height);
        CGContextDrawPath(context, kCGPathStroke);
    }
    
    for (int i = 0; i < 6; i++) {
        CGFloat y = i * verticalSpacing + 1.5;
        CGContextMoveToPoint(context, 0.0, y);
        CGContextAddLineToPoint(context, bounds.size.width, y);
        CGContextDrawPath(context, kCGPathStroke);
    }
    
    for (Note *note in self.notes) {
        CGFloat x = note.x * horizontalSpacing;
        CGFloat y = note.y * verticalSpacing;
        CGContextAddArc(context, x, y, horizontalSpacing / 4, 0.0, M_PI*2, YES );
        CGContextDrawPath(context, kCGPathStroke);

    }
}


@end
