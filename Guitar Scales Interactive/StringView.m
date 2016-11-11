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
    BOOL isLeftHand = [[GuitarStore sharedStore] isLeftHand];
    BOOL showDegrees = [[GuitarStore sharedStore] showDegrees];

    CGFloat horizontalSpacing = self.bounds.size.width / 6.42;  // original 6.42 trying 6.0
    CGFloat verticalSpacing   = self.bounds.size.height / 4.5;  // original 6.6 then 3.5
    CGFloat radiusVerticalSpacing = self.bounds.size.height / 6.6; // original 6.0 then 7.0 to be used to calculate radius
    CGFloat horizontalOffset = horizontalSpacing / 4.8;  // original 4.8 trying 3.4
    CGFloat verticalOffset   = verticalSpacing / 3.2; // original 2.0 then 4.4
    CGFloat radius = radiusVerticalSpacing / 2.4;  // original 2.4
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height - verticalSpacing;

    CGFloat lineWidth        = radius / 5.1;
    CGFloat strokeWidth      = radius / 4.0;
    CGFloat fontSize         = radius * 1.5;
    
    BOOL useShortScale = false;
    if ((self.position.identifier == 4) || (self.position.identifier == 5) || (self.position.identifier == 6))
    {
        useShortScale = true;            // only do 5 frets for some positions
    }
    
    if (useShortScale == true) {
        horizontalOffset += (horizontalSpacing / 2.0);
    }

    if (self.isMainView) {
        verticalSpacing = floorf(height / 5.44);
        height -= verticalSpacing;
        radius = radiusVerticalSpacing / 2.3;
    }

    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (self.position.baseFret || self.position.baseFret == 0) {
        CGFloat x = horizontalOffset + (self.position.baseFret * horizontalSpacing);
        if (isLeftHand) {
            x = width - x - horizontalSpacing;
        }
        NSInteger height = [self heightForPosition:self.position.identifier];
        CGFloat y = height * verticalSpacing + (verticalOffset * 2.0);
        CGRect fretFrame = CGRectMake(x, 0, horizontalSpacing, y);
        UIColor *color = [self colorForPosition:self.position.identifier];

        CGContextSetFillColorWithColor(context, color.CGColor);
        CGContextFillRect(context, fretFrame);
    }
    
    CGContextSetStrokeColorWithColor(context, [[UIColor blackColor] CGColor]);
    CGContextSetLineWidth(context, lineWidth);
    
    // draw vertical lines
    NSInteger numLines = 7;
    if (useShortScale == true) {
        numLines = 6;
    }
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
    if (useShortScale == true) {
        horizontalLineWidth -= horizontalSpacing / 2.0;
        horizontalLineX     += horizontalSpacing / 2.0;
   }
    
    for (int i = 0; i < 6; i++) {
        CGFloat y = i * verticalSpacing + verticalOffset;
        CGContextMoveToPoint(context, horizontalLineX, y);
        CGContextAddLineToPoint(context, horizontalLineWidth, y);
        CGContextDrawPath(context, kCGPathStroke);
    }
    
    NSArray *stringArray = @[@"(1)", @"1", @"2", @"3", @"4", @"(4)"];
    if (useShortScale == true) {
        stringArray = @[@"1", @"2", @"3", @"4", @"(4)"];
    }
    
    
    for (int i = 0; i < stringArray.count; i++) {
        CGFloat x      = horizontalOffset + (i * horizontalSpacing);
        
        if (isLeftHand) {
            x = width - x - horizontalSpacing;
        }
        
        CGFloat y      = 5.4 * verticalSpacing + verticalOffset;
        NSString *text = stringArray[i];
        CGRect rect    = CGRectMake(x, y, horizontalSpacing, verticalSpacing);
        NSMutableParagraphStyle *paragrapStyle = NSMutableParagraphStyle.new;
        paragrapStyle.alignment                = NSTextAlignmentCenter;
        [text drawInRect:rect withAttributes:@{NSFontAttributeName:[UIFont jrHandFontWithSize:fontSize], NSParagraphStyleAttributeName:paragrapStyle}];

    }
    
    
    
    NSMutableArray *degrees = [[GuitarStore sharedStore] degrees];
    for (Degree *degree in degrees) {
        if ([self containsId:degree.identifier]) {
            NSArray *degreePositions = degree.degreePositions;
            for (DegreePosition *degreePosition in degreePositions) {
                if (degreePosition.positionID == self.position.identifier) {
                    NSArray *coordinates = degreePosition.coordinates;
                    for (Coordinate *coord in coordinates) {
                        CGFloat x
                        = coord.x * horizontalSpacing + (horizontalSpacing / 2.0) + horizontalOffset;
                        
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
                            textColor   = [UIColor GuitarDarkGray];
                            fillColor   = [UIColor GuitarLightGray];
                            strokeColor = [UIColor lightGrayColor];
                            newStrokeWidth = strokeWidth - 1;
                        }
                        CGContextSetLineWidth(context, newStrokeWidth);

                        CGContextSetFillColorWithColor(context, [fillColor CGColor]);
                        CGContextSetStrokeColorWithColor(context, [strokeColor CGColor]);
  
                        CGContextDrawPath(context, kCGPathFillStroke);

                        // If the view is the center view, add degree text on top of notes
                        // if showDegrees is set on
                if (showDegrees == false)
                {
                
                        if (self.isMainView) {
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
        }
    }
}

- (UIColor *)colorForPosition:(NSInteger)identifier {
    switch (identifier) {
        case 0:
            return [UIColor GuitarRockBlue];
        case 1:
            return [UIColor GuitarRose];
        case 2:
            return [UIColor GuitarRockBlue];
        case 3:
            return [UIColor GuitarRose];
        case 4:
            return [UIColor GuitarRockBlue];
        case 5:
            return [UIColor GuitarRose];
        case 6:
            return [UIColor GuitarYellow];
            
        default:
            return 0;
    }
}

- (NSInteger)heightForPosition:(NSInteger)identifier {
    switch (identifier) {
        case 0:
            return 5;
        case 1:
            return 4;
        case 2:
            return 5;
        case 3:
            return 4;
        case 4:
            return 5;
        case 5:
            return 4;
        case 6:
            return 3;
            
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
