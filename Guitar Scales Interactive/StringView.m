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
    CGFloat verticalOffset = self.isMainView ? 10 : 3;
    CGFloat width = self.bounds.size.width - (verticalOffset * 2.0);
    CGFloat height = self.bounds.size.height - (verticalOffset * 2.0);
    CGFloat horizontalSpacing = floorf(width / 6.0);
    CGFloat verticalSpacing = floorf(height / 5.0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();

    
    if (self.position.baseFret || self.position.baseFret == 0) {
        CGFloat x = 10.0 + (self.position.baseFret * horizontalSpacing);
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
                        CGContextAddArc(context, x, y, verticalOffset, 0.0, M_PI*2, YES );
                        
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
                            textColor = [UIColor whiteColor];
                            fillColor = [UIColor lightGrayColor];
                            strokeColor = [UIColor lightGrayColor];
                        }
                        CGContextSetFillColorWithColor(context, [fillColor CGColor]);
                        CGContextSetStrokeColorWithColor(context, [strokeColor CGColor]);
                        CGContextDrawPath(context, kCGPathFillStroke);
                        
                        if (self.isMainView) {
                            x = coord.x * horizontalSpacing + (horizontalSpacing / 2.0) + 10.0 - verticalOffset / 2;
                            y = coord.y * verticalSpacing ;
                            CGPoint degreePoint = CGPointMake(x, y);
                            
                            NSString *degreeString;
                            if (degree.flat) {
                                degreeString = [NSString stringWithFormat:@"b%d", degree.number];
                            } else if (degree.sharp) {
                                degreeString = [NSString stringWithFormat:@"#%d", degree.number];
                            } else {
                                degreeString = [NSString stringWithFormat:@"%d", degree.number];
                            }
                            
                            [degreeString drawAtPoint:degreePoint withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16.0],
                                                                                   NSForegroundColorAttributeName:textColor
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
