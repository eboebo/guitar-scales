//
//  StringView.m
//  Guitar Scales Interactive
//
//  Created by Elena Boyd on 8/12/14.
//
//

#import "StringView.h"
#import "Note.h"
#import <CoreText/CoreText.h>

@implementation StringView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)layoutSubviews
{
    self.backgroundColor = [UIColor clearColor];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    CGRect bounds = self.bounds;
    CGFloat verticalOffset = self.isMainView ? 10 : 3;
    CGFloat width = self.bounds.size.width - (verticalOffset * 2.0);
    CGFloat height = self.bounds.size.height - (verticalOffset * 2.0);
    CGFloat horizontalSpacing = floorf(width / 6.0);
    CGFloat verticalSpacing = floorf(height / 5.0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();

    
    if (self.fret || self.fret == 0) {
        CGFloat x = 10.0 + (self.fret * horizontalSpacing);
        CGRect fretFrame = CGRectMake(x, verticalOffset, horizontalSpacing, height);
        CGContextSetFillColorWithColor(context, [UIColor lightGrayColor].CGColor);
        CGContextFillRect(context, fretFrame);
    }
    
    CGContextSetStrokeColorWithColor(context, [[UIColor blackColor] CGColor]);
    CGFloat lineWidth = self.isMainView ? 2.0 : 0.5;
    CGContextSetLineWidth(context, lineWidth);
    
    for (int i = 0; i < 7; i++) {
        CGFloat x = 10.0 + (i * horizontalSpacing);
        CGContextMoveToPoint(context, x, verticalOffset);
        CGContextAddLineToPoint(context, x, height + verticalOffset );
        CGContextDrawPath(context, kCGPathStroke);
    }
    
    for (int i = 0; i < 6; i++) {
        CGFloat y = i * verticalSpacing  + verticalOffset;
        CGContextMoveToPoint(context, 0.0, y);
        CGContextAddLineToPoint(context, bounds.size.width, y);
        CGContextDrawPath(context, kCGPathStroke);
    }
    
    for (Note *note in self.notes) {
        CGFloat x = note.x * horizontalSpacing + (horizontalSpacing / 2.0) + 10.0;
        CGFloat y = note.y * verticalSpacing + verticalOffset;
        CGContextAddArc(context, x, y, verticalOffset, 0.0, M_PI*2, YES );

        UIColor *textColor;
        UIColor *fillColor;
        UIColor *strokeColor;
        if ([note.type isEqual:@"filled"]) {
            textColor = [UIColor whiteColor];
            fillColor = [UIColor blackColor];
            strokeColor = [UIColor blackColor];
            
        } else if ([note.type isEqualToString:@"unfilled"]) {
            textColor = [UIColor blackColor];
            fillColor = [UIColor whiteColor];
            strokeColor = [UIColor blackColor];
           
        } else if ([note.type isEqualToString:@"gray"]) {
            textColor = [UIColor whiteColor];
            fillColor = [UIColor lightGrayColor];
            strokeColor = [UIColor lightGrayColor];
        }
        CGContextSetFillColorWithColor(context, [fillColor CGColor]);
        CGContextSetStrokeColorWithColor(context, [strokeColor CGColor]);
        CGContextDrawPath(context, kCGPathFillStroke);
        
        if (self.isMainView) {
            x = note.x * horizontalSpacing + (horizontalSpacing / 2.0) + 10.0 - verticalOffset / 2;
            y = note.y * verticalSpacing ;
            CGPoint degreePoint = CGPointMake(x, y);
            NSString *degreeString = [NSString stringWithFormat:@"%ld", (long)note.degree ];
            [degreeString drawAtPoint:degreePoint withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16.0],
                                                                   NSForegroundColorAttributeName:textColor
                                                                   }];
        }
    }
}


@end
