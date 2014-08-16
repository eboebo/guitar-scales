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


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    CGRect bounds = self.bounds;
    CGFloat verticalOffset = 10;
    CGFloat width = self.bounds.size.width - 20;
    CGFloat height = self.bounds.size.height - 20;
    CGFloat horizontalSpacing = floorf(width / 6.0);
    CGFloat verticalSpacing = floorf(height / 5.0);
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [[UIColor blackColor] CGColor]);
    CGContextSetLineWidth(context, 3.0);
    
    for (int i = 0; i < 7; i++) {
        
        CGFloat x = 10.0 + (i * horizontalSpacing);
        CGContextMoveToPoint(context, x, verticalOffset);
        CGContextAddLineToPoint(context, x, height + verticalOffset);
        CGContextDrawPath(context, kCGPathStroke);
    }
    
    for (int i = 0; i < 6; i++) {
        CGFloat y = i * verticalSpacing + 1.5 + verticalOffset;
        CGContextMoveToPoint(context, 0.0, y);
        CGContextAddLineToPoint(context, bounds.size.width, y);
        CGContextDrawPath(context, kCGPathStroke);
    }
    
    for (Note *note in self.notes) {
        CGFloat x = (note.x + 1) * horizontalSpacing;
        CGFloat y = note.y * verticalSpacing;
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
            textColor = [UIColor grayColor];
            fillColor = [UIColor lightGrayColor];
            strokeColor = [UIColor lightGrayColor];
        }
        CGContextSetFillColorWithColor(context, [fillColor CGColor]);
        CGContextSetStrokeColorWithColor(context, [strokeColor CGColor]);
        CGContextDrawPath(context, kCGPathFillStroke);
        
        CGPoint degreePoint = CGPointMake(x - horizontalSpacing / 8 , y - horizontalSpacing / 8);
        NSString *degreeString = [NSString stringWithFormat:@"%ld", (long)note.degree ];
        [degreeString drawAtPoint:degreePoint withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16.0],
                                                               NSForegroundColorAttributeName:textColor
                                                               }];
    
        
    }
}

- (void)drawSubtractedText:(NSString *)text
                   atPoint:(CGPoint)point
                  withSize:(CGFloat)size
                 inContext:(CGContextRef)context
{
    
    

    
//    CGContextSaveGState(context);
//    
//    // Magic blend mode
//    CGContextSetBlendMode(context, kCGBlendModeDestinationOut);
//    
//    
//    UIFont *font = [UIFont boldSystemFontOfSize:10.0f];
//    
//    // Move drawing start point for centering label.
//    CGContextTranslateCTM(context, 0,
//                          (size / 2 - (font.lineHeight/2)));
//    
//    CGRect frame = CGRectMake(point.x, point.y, size, font.lineHeight);
//    UILabel *label = [[UILabel alloc] initWithFrame:frame];
//    label.font = font;
//    label.textColor = [UIColor whiteColor];
//    label.text = text;
//    label.textAlignment = NSTextAlignmentCenter;
//    label.backgroundColor = [UIColor clearColor];
//    [label.layer drawInContext:context];
//    
//    // Restore the state of other drawing operations
//    CGContextRestoreGState(context);
}

@end
