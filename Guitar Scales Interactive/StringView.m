//
//  StringView.m
//  Guitar Scales Interactive
//
//  Created by Elena Boyd on 8/12/14.
//
//

#import "StringView.h"
#import "Degree.h"
#import <CoreText/CoreText.h>
#import "Coordinate.h"
#import "GuitarStore.h"

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
    CGFloat verticalOffset = self.isMainView ? 12 : 3;
    CGFloat lineWidth = self.isMainView ? 2.0 : 0.5;

    CGFloat width = self.bounds.size.width - (verticalOffset * 2.0);
    CGFloat height = self.bounds.size.height - (verticalOffset * 2.0);
    
    CGFloat horizontalSpacing = floorf(width / 6.0);
    CGFloat verticalSpacing = floorf(height / 5.0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();

    
    if (self.position.baseFret || self.position.baseFret == 0) {
        CGFloat x = 10.0 + (self.position.baseFret * horizontalSpacing);
        CGRect fretFrame = CGRectMake(x, verticalOffset, horizontalSpacing, height);
        CGContextSetFillColorWithColor(context, [UIColor GuitarGray].CGColor);
        CGContextFillRect(context, fretFrame);
    }
    
    CGContextSetStrokeColorWithColor(context, [[UIColor blackColor] CGColor]);
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
    
    
    NSMutableArray *degrees = [[GuitarStore sharedStore] degrees];
    for (Degree *degree in degrees) {
        if ([self containsId:degree.identifier]) {
            NSArray *degreePositions = degree.degreePositions;
            for (DegreePosition *degreePosition in degreePositions) {
                if (degreePosition.positionID == self.position.identifier) {
                    NSArray *coordinates = degreePosition.coordinates;
                    for (Coordinate *coord in coordinates) {
                        CGFloat x = coord.x * horizontalSpacing + (horizontalSpacing / 2.0) + 10.0;
                        CGFloat y = coord.y * verticalSpacing + verticalOffset;
                        CGContextAddArc(context, x, y, verticalOffset - lineWidth, 0.0, M_PI*2, YES );
                        
                        UIColor *textColor;
                        UIColor *fillColor;
                        UIColor *strokeColor;
                        if ([coord.color isEqual:@"black"]) {
                            textColor = [UIColor whiteColor];
                            fillColor = [UIColor blackColor];
                            strokeColor = [UIColor blackColor];
                            
                        } else if ([coord.color isEqualToString:@"white"]) {
                            textColor = [UIColor blackColor];
                            fillColor = [UIColor whiteColor];
                            strokeColor = [UIColor blackColor];
                            
                        } else if ([coord.color isEqualToString:@"gray"]) {
                            textColor = [UIColor grayColor];
                            fillColor = [UIColor GuitarLightGray];
                            strokeColor = [UIColor lightGrayColor];
                        }
                        CGContextSetFillColorWithColor(context, [fillColor CGColor]);
                        CGContextSetStrokeColorWithColor(context, [strokeColor CGColor]);
                        CGContextDrawPath(context, kCGPathFillStroke);
                        
                        if (self.isMainView) {
                            
                            NSString *degreeString;
                            if (degree.flat) {
                                degreeString = [NSString stringWithFormat:@"b%ld", degree.number];
                            } else if (degree.sharp) {
                                degreeString = [NSString stringWithFormat:@"#%ld", degree.number];
                            } else {
                                degreeString = [NSString stringWithFormat:@"%ld", degree.number];
                            }
                            
                            CGFloat width =(verticalOffset - lineWidth) * 2;
                            CGRect rect = CGRectMake(x - width / 2, y - width / 2, width, width);

                            NSMutableParagraphStyle *paragrapStyle = NSMutableParagraphStyle.new;
                            paragrapStyle.alignment                = NSTextAlignmentCenter;
                            [paragrapStyle setLineBreakMode:NSLineBreakByWordWrapping];
                            [degreeString drawInRect:rect withAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"MarkerFelt-Thin" size:14.0],
                                                                          NSForegroundColorAttributeName:textColor,
                                                                           NSParagraphStyleAttributeName:paragrapStyle
                                                                           }];
                            
                        }
                    }
                }
            }
        }
    }
}

- (BOOL)containsId:(NSInteger)identifier
{
    for (int i = 0; i < self.selectedDegrees.count; i++) {
        NSInteger buttonID = [self.selectedDegrees[i] integerValue];
        if (buttonID == identifier) {
            return YES;
            break;
        }
    }
    return NO;
}
@end
