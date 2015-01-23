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

const CGFloat maxHeight = 175.0;

@implementation StringView

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.backgroundColor = [UIColor clearColor];
}

- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [super drawRect:rect];

    CGFloat horizontalOffset = self.isMainView ? 10 : 5;
    CGFloat verticalOffset   = self.isMainView ? 12 : 3;
    CGFloat lineWidth        = self.isMainView ? 2.0 : 0.5;
    CGFloat width            = self.bounds.size.width - (horizontalOffset * 2.0);
    
    CGFloat height = self.bounds.size.height - (verticalOffset * 2.0);
    
    CGFloat horizontalSpacing = floorf(width / 6.0);
    CGFloat verticalSpacing   = floorf(height / 5.0);
    
    if (self.stringViewType == StringViewTypeIndex) {
        horizontalOffset += (horizontalSpacing / 2.0);
    }
    

    if (self.isMainView) {
        verticalSpacing = floorf(height / 6.0);
        height -= verticalSpacing;
    }

    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (self.position.baseFret || self.position.baseFret == 0) {
        CGFloat x = horizontalOffset + (self.position.baseFret.integerValue * horizontalSpacing);
        CGFloat y = 5 * verticalSpacing + (verticalOffset * 2.0);
        CGRect fretFrame = CGRectMake(x, 0, horizontalSpacing, y);
        CGContextSetFillColorWithColor(context, [UIColor GuitarGray].CGColor);
        CGContextFillRect(context, fretFrame);
    }
    
    CGContextSetStrokeColorWithColor(context, [[UIColor blackColor] CGColor]);
    CGContextSetLineWidth(context, lineWidth);
    
    // draw vertical lines
    NSInteger numLines = self.stringViewType == StringViewTypeIndex ? 6 : 7;
    for (int i = 0; i < numLines; i++) {
        CGFloat x = horizontalOffset + (i * horizontalSpacing);
        CGFloat y = 5 * verticalSpacing + verticalOffset;
        CGContextMoveToPoint(context, x, verticalOffset);
        CGContextAddLineToPoint(context, x, y);
        CGContextDrawPath(context, kCGPathStroke);
    }
    
    // draw horizontal lines
    // adjust depending on string view type
    CGFloat horizontalLineWidth = self.bounds.size.width;
    CGFloat horizontalLineX     = 0.0;
    if (self.stringViewType == StringViewTypeIndex) {
        horizontalLineWidth -= horizontalSpacing / 2;
        horizontalLineX     += horizontalSpacing / 2;
    }
    
    for (int i = 0; i < 6; i++) {
        CGFloat y = i * verticalSpacing + verticalOffset;
        CGContextMoveToPoint(context, horizontalLineX, y);
        CGContextAddLineToPoint(context, horizontalLineWidth, y);
        CGContextDrawPath(context, kCGPathStroke);
    }
    
    NSArray *stringArray = @[@"(1)", @"1", @"2", @"3", @"4", @"(4)"];
    if (self.stringViewType == StringViewTypeIndex) {
        stringArray = @[@"1", @"2", @"3", @"4", @"(4)"];
    }
    
    if (self.isMainView) {
        for (int i = 0; i < stringArray.count; i++) {
            CGFloat x      = horizontalOffset + (i * horizontalSpacing);
            CGFloat y      = 5.35 * verticalSpacing + verticalOffset;
            NSString *text = stringArray[i];
            CGRect rect    = CGRectMake(x, y, horizontalSpacing, verticalSpacing);
            NSMutableParagraphStyle *paragrapStyle = NSMutableParagraphStyle.new;
            paragrapStyle.alignment                = NSTextAlignmentCenter;
            [text drawInRect:rect withAttributes:@{NSFontAttributeName:[UIFont jrHandFontWithSize:21.0f], NSParagraphStyleAttributeName:paragrapStyle}];

        }
    }
    
    
    NSMutableArray *degrees = [[GuitarStore sharedStore] degrees];
    for (Degree *degree in degrees) {
//        if ([self containsId:degree.identifier]) {
//            NSArray *degreePositions = degree.coordinates;
//            for (DegreePosition *degreePosition in degreePositions) {
//                if (degreePosition.positionID == self.position.identifier) {
//                    NSArray *coordinates = degreePosition.coordinates;
//                    for (Coordinate *coord in coordinates) {
//                        CGFloat x
//                        = coord.x * horizontalSpacing + (horizontalSpacing / 2.0) + horizontalOffset;
//                        CGFloat y
//                        = coord.y * verticalSpacing + verticalOffset;
//                        CGContextAddArc(context, x, y, verticalOffset - lineWidth, 0.0, M_PI*2, YES);
//                        
//                        UIColor *textColor;
//                        UIColor *fillColor;
//                        UIColor *strokeColor;
//                        if ([coord.color isEqual:@"black"]) {
//                            textColor   = [UIColor whiteColor];
//                            fillColor   = [UIColor blackColor];
//                            strokeColor = [UIColor blackColor];
//                        } else if ([coord.color isEqualToString:@"white"]) {
//                            textColor   = [UIColor blackColor];
//                            fillColor   = [UIColor whiteColor];
//                            strokeColor = [UIColor blackColor];
//                            
//                        } else if ([coord.color isEqualToString:@"gray"]) {
//                            textColor   = [UIColor grayColor];
//                            fillColor   = [UIColor GuitarLightGray];
//                            strokeColor = [UIColor lightGrayColor];
//                        }
//                        CGContextSetFillColorWithColor(context, [fillColor CGColor]);
//                        CGContextSetStrokeColorWithColor(context, [strokeColor CGColor]);
//                        CGContextDrawPath(context, kCGPathFillStroke);
//
//                        // If the view is the center view, add degree text on top of notes
//                        if (self.isMainView) {
//                            NSMutableAttributedString *degreeString
//                            = [[degree toAttributedStringCircle] mutableCopy];
//                            CGFloat width    = (verticalOffset - lineWidth) * 2;
//                            CGRect rect      = CGRectMake(x - width / 2, y - width / 2, width, width);
//                            CGSize size      = [degreeString size];
//                            CGFloat offset   = (width - size.height) / 2;
//                            rect.size.height -= offset * 2.0;
//                            rect.origin.y    += offset;
//
//                            NSNumber *offNum = [NSNumber numberWithFloat:offset];
//                            
//                            NSMutableParagraphStyle *paragrapStyle = NSMutableParagraphStyle.new;
//                            paragrapStyle.alignment                = NSTextAlignmentCenter;
//                            
//                           [paragrapStyle setLineBreakMode:NSLineBreakByWordWrapping];
//                           [degreeString addAttributes:@{NSForegroundColorAttributeName:textColor,
//                                                        NSParagraphStyleAttributeName:paragrapStyle,
//                                                        NSBaselineOffsetAttributeName:offNum}
//                                                 range:NSMakeRange(0, degreeString.length)];
//                            [degreeString drawInRect:rect];
//                            
//                        }
//                    }
//                }
//            }
//        }
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
