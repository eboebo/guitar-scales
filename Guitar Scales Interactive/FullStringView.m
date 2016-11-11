//
//  StringView.m
//  Guitar Scales Interactive
//
//  Created by Elena Boyd on 8/12/14.
//
//

#import "FullStringView.h"
#import "Degree.h"
#import <CoreText/CoreText.h>
#import "Coordinate.h"
#import "GuitarStore.h"


@implementation FullStringView

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.backgroundColor = [UIColor clearColor];
}

- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [super drawRect:rect];
    BOOL isLeftHand = [[GuitarStore sharedStore] isLeftHand];
    
    CGFloat horizontalSpacing = self.bounds.size.width / 17;
    CGFloat verticalSpacing   = self.bounds.size.height / 6;
    CGFloat radiusVerticalSpacing = self.bounds.size.height / 6.0; // to be used to calculate radius
    CGFloat horizontalOffset = horizontalSpacing / 4.8;
    horizontalOffset = 0;
    CGFloat verticalOffset   = verticalSpacing / 2.0;
    CGFloat radius = radiusVerticalSpacing / 2.4;
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height - verticalSpacing;
    
    CGFloat lineWidth        = radius / 5.1;
    CGFloat strokeWidth      = radius / 4.0;
    CGFloat fontSize         = radius * 1.5;
    
    horizontalOffset += (horizontalSpacing / 2.0);

    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // draw background
//    NSInteger selectedOffset = [self offsetForPosition:self.position.identifier];
//    for (int i = 0; i < 6; i++) {
//        NSInteger selectedIndex = i + selectedOffset;
//        CGFloat x = horizontalOffset + (selectedIndex * horizontalSpacing);
//        
//        if (isLeftHand) {
//            x = width - x - horizontalSpacing;
//        }
//        CGFloat y = 5 * verticalSpacing + (verticalOffset * 2.0);
//        CGRect fretFrame = CGRectMake(x, 0, horizontalSpacing, y);
//        CGContextSetFillColorWithColor(context, [UIColor GuitarGray].CGColor);
//        CGContextFillRect(context, fretFrame);
//    }
//    
    // Draw 6th string base fret - blue
    
    CGFloat x = horizontalOffset + (4 * horizontalSpacing);;
    
    if (isLeftHand) {
        x = width - x - horizontalSpacing;
    }
    CGFloat y = 5 * verticalSpacing + (verticalOffset * 2.0);
    CGRect fretFrame = CGRectMake(x, 0, horizontalSpacing, y);
    CGContextSetFillColorWithColor(context, [UIColor GuitarRockBlue].CGColor);
    CGContextFillRect(context, fretFrame);
    
    // Draw 4th string base fret - yellow
    y = 3 * verticalSpacing + (verticalOffset * 2.0);
    x = horizontalOffset + (6 * horizontalSpacing);
    if (isLeftHand) {
        x = width - x - horizontalSpacing;
    }
    fretFrame = CGRectMake(x, 0, horizontalSpacing, y);
    CGContextSetFillColorWithColor(context, [UIColor GuitarYellow].CGColor);
    CGContextFillRect(context, fretFrame);
    
    // Draw 5th string base from - red
    y = 4 * verticalSpacing + (verticalOffset * 2.0);

    x = horizontalOffset + (11 * horizontalSpacing);
    if (isLeftHand) {
        x = width - x - horizontalSpacing;
    }
    fretFrame = CGRectMake(x, 0, horizontalSpacing, y);
    CGContextSetFillColorWithColor(context, [UIColor GuitarRose].CGColor);
    CGContextFillRect(context, fretFrame);
    
    CGContextSetStrokeColorWithColor(context, [[UIColor blackColor] CGColor]);
    CGContextSetLineWidth(context, lineWidth);
    
    // draw vertical lines
    NSInteger numLines = 17;
    for (int i = 0; i < numLines; i++) {
        CGFloat x = horizontalOffset + (i * horizontalSpacing);
        CGFloat y = 5 * verticalSpacing + verticalOffset;
        CGContextMoveToPoint(context, x, verticalOffset);
        CGContextAddLineToPoint(context, x, y);
        CGContextDrawPath(context, kCGPathStroke);
    }
    
    // draw horizontal lines
    // adjust depending on string view type
    CGFloat horizontalLineWidth = width;
    CGFloat horizontalLineX     = 0.0;
    horizontalLineX     += horizontalSpacing / 2.0;
    horizontalLineX = 0;

    for (int i = 0; i < 6; i++) {
        CGFloat y = i * verticalSpacing + verticalOffset;
        CGContextMoveToPoint(context, 0, y);
        CGContextAddLineToPoint(context, horizontalLineWidth, y);
        CGContextDrawPath(context, kCGPathStroke);
    }
    
    NSMutableArray *degrees = [[GuitarStore sharedStore] degrees];
    for (Degree *degree in degrees) {
        if ([self containsId:degree.identifier]) {
            NSArray *degreePositions = degree.degreePositions;
            for (DegreePosition *degreePosition in degreePositions) {
                NSArray *coordinates = degreePosition.coordinates;
                for (Coordinate *coord in coordinates) {
                    NSInteger xOffset = [self offsetForPosition:degreePosition.positionID];
                    NSInteger xCoordinate = coord.x + xOffset;
                    CGFloat x
                    = xCoordinate * horizontalSpacing + (horizontalSpacing / 2.0) + horizontalOffset;
                    
                    if (isLeftHand) {
                        x = width - x;
                    }
                    
                    CGFloat y
                    = coord.y * verticalSpacing + verticalOffset;
                    CGContextAddArc(context, x, y, radius - strokeWidth, 0.0, M_PI*2, YES);
                    UIColor *textColor;
                    UIColor *fillColor;
                    UIColor *strokeColor;
                    CGFloat newStrokeWidth;
                    if ([coord.color isEqual:@"black"]) {
                        textColor   = [UIColor GuitarCream];
                        fillColor   = [UIColor blackColor];
                        strokeColor = [UIColor blackColor];
                        newStrokeWidth = strokeWidth;
                    } else if ([coord.color isEqualToString:@"white"]) {
                        textColor   = [UIColor blackColor];
                        fillColor   = [UIColor GuitarCream];
                        strokeColor = [UIColor blackColor];
                        newStrokeWidth = strokeWidth;
                    } else if ([coord.color isEqualToString:@"gray"]) {
//                        textColor   = [UIColor GuitarDarkGray];
//                        fillColor   = [UIColor GuitarLightGray];
//                        strokeColor = [UIColor lightGrayColor];
                        textColor   = [UIColor GuitarCream];
                        fillColor   = [UIColor blackColor];
                        strokeColor = [UIColor blackColor];
                        newStrokeWidth = strokeWidth - 1;
                    }
                    CGContextSetLineWidth(context, newStrokeWidth);
                    
                    CGContextSetFillColorWithColor(context, [fillColor CGColor]);
                    CGContextSetStrokeColorWithColor(context, [strokeColor CGColor]);
                    
                    CGContextDrawPath(context, kCGPathFillStroke);
                    
                    // If the view is the center view, add degree text on top of notes
                    NSMutableAttributedString *degreeString
                    = [[degree toAttributedStringCircleWithFontSize:fontSize] mutableCopy];
                    CGFloat width    = (radius - lineWidth) * 2;
                    CGRect rect;
                    if (degreeString.length == 1) {
                        rect = CGRectMake(x - width / 2.2, y - width / 2, width, width);
                    } else {
                        rect = CGRectMake(x - width / 2.2, y - width / 1.7, width, width);
                        
                    }
                    CGSize size      = [degreeString size];
                    CGFloat offset   = (width - size.height) / 2;
                    rect.size.height -= offset * 2.0;
                    rect.origin.y    += offset;
                    
                    NSNumber *offNum = [NSNumber numberWithFloat:offset];
                    
                    NSMutableParagraphStyle *paragrapStyle = NSMutableParagraphStyle.new;
                    paragrapStyle.alignment                = NSTextAlignmentCenter;
                    
                    [paragrapStyle setLineBreakMode:NSLineBreakByWordWrapping];
                    [degreeString addAttributes:@{NSForegroundColorAttributeName:textColor,
                                                  NSParagraphStyleAttributeName:paragrapStyle,
                                                  NSBaselineOffsetAttributeName:offNum}
                                          range:NSMakeRange(0, degreeString.length)];
                    
                    NSShadow *shadowDic=[[NSShadow alloc] init];
                    [shadowDic setShadowColor:textColor];
                    [shadowDic setShadowOffset:CGSizeMake(0, 0.7)];
                    [degreeString addAttribute:NSShadowAttributeName
                                         value:shadowDic
                                         range:NSMakeRange(0, degreeString.length)];
                    
                    
                    
                    [degreeString drawInRect:rect];
                        
                    
                }
                
            }
        }
    }
}

- (NSInteger)offsetForPosition:(NSInteger)identifier {
    switch (identifier) {
        case 0:
            return 0;
        case 1:
            return 7;
        case 2:
            return 2;
        case 3:
            return 9;
        case 4:
            return 4;
        case 5:
            return 11;
        case 6:
            return 6;
        default:
            return 0;
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

-(BOOL)iPhone6PlusDevice{
    if ([UIScreen mainScreen].scale > 2.9) {
        return YES;
    } else {
        return NO;
    }
}

@end
