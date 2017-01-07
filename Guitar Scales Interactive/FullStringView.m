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

- (void)drawRect:(CGRect)rect               // iPad & iPhone, full string version
{
    // Drawing code
    [super drawRect:rect];
    BOOL isLeftHand = [[GuitarStore sharedStore] isLeftHand];
    BOOL isFlipped = [[GuitarStore sharedStore] isFlipped];
    BOOL showDegrees = [[GuitarStore sharedStore] showDegrees];
    
    BOOL isiPad = [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad;
    
    CGFloat horizontalSpacing = self.bounds.size.width / 18.5;
    CGFloat verticalSpacing   = self.bounds.size.height / 7.4;
    CGFloat radiusVerticalSpacing = self.bounds.size.height / 7.6;
    CGFloat horizontalOffset = horizontalSpacing / 3.8;
    CGFloat verticalOffset   = verticalSpacing / 2.0;
    CGFloat radius = radiusVerticalSpacing / 2.1;
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height - verticalSpacing;
    CGFloat lineWidth        = radius / 5.1;
    CGFloat strokeWidth      = radius / 4.0;
    CGFloat fontSize         = radius * 1.42;
    
    if (!isiPad) {                                              // iPhone
        horizontalSpacing = self.bounds.size.width / 16.5;
        verticalSpacing   = self.bounds.size.height / 7.4;
        radiusVerticalSpacing = self.bounds.size.height / 7.6;
        horizontalOffset = horizontalSpacing / 3.8;
        verticalOffset   = verticalSpacing / 2.0;
        radius = radiusVerticalSpacing / 2.3;
        width = self.bounds.size.width;
        height = self.bounds.size.height - verticalSpacing;
        lineWidth        = radius / 5.2;
        strokeWidth      = radius / 4.0;
        fontSize         = radius * 1.42;
    }

    CGContextRef context = UIGraphicsGetCurrentContext();
    
    
  //   draw gray background
    // throughout this section int diff is used to differientate the layouts between iPhone and iPad
    
    int diff = horizontalSpacing;
        CGFloat y = 5 * verticalSpacing;
        CGRect fretFrame = CGRectMake(0, verticalOffset, width, y);
    if (isiPad) {
        CGContextSetFillColorWithColor(context, [UIColor GuitarLightGray].CGColor);
    }
    else {
        CGContextSetFillColorWithColor(context, [UIColor GuitarCream].CGColor);
        diff = 0;
    }
        CGContextFillRect(context, fretFrame);
    NSInteger selectedOffset = [self offsetForPosition:self.position.identifier];
    int positionCheck = 6;
    if ((self.position.identifier == 4) || (self.position.identifier == 5) || (self.position.identifier == 6))
    {
        positionCheck = 5;
    }
    for (int i = 0; i < positionCheck; i++) {
        NSInteger selectedIndex = i + selectedOffset;
        CGFloat x = diff + horizontalOffset + (selectedIndex * horizontalSpacing);
        if (isLeftHand) {
            x = width - x - horizontalSpacing;
        }
        CGRect fretFrame = CGRectMake(x, verticalOffset, horizontalSpacing, y);
        if (isiPad) {
            CGContextSetFillColorWithColor(context, [UIColor GuitarCream].CGColor);
        }
        else {
            if ((self.position.identifier == 0) || (self.position.identifier == 4) || (self.position.identifier == 2))
            {
                CGContextSetFillColorWithColor(context, [UIColor Guitar6thStringAlpha].CGColor);
            }
            else if (self.position.identifier == 6)
            {
                CGContextSetFillColorWithColor(context, [UIColor Guitar4thStringAlpha].CGColor);
            }
            else
            {
                CGContextSetFillColorWithColor(context, [UIColor Guitar5thStringAlpha].CGColor);
            }
        }
        CGContextFillRect(context, fretFrame);
    }
    
    // Draw 6th string base fret - blue
    diff = 4; if (isiPad) diff = 5;
    CGFloat x = horizontalOffset + (diff * horizontalSpacing);
    if (isLeftHand) {
        x = width - x - horizontalSpacing;
    }
    y = 5 * verticalSpacing + (verticalOffset * 2.0);
    fretFrame = CGRectMake(x, 0, horizontalSpacing, y);
    if (isiPad) {
        CGContextSetFillColorWithColor(context, [UIColor Guitar6thStringAlpha].CGColor);
    }
    else {
        CGContextSetFillColorWithColor(context, [UIColor Guitar6thString].CGColor);
    }
    CGContextFillRect(context, fretFrame);
    
    // Draw 4th string base fret - yellow
    diff = 6; if (isiPad) diff = 7;
    CGFloat originY = 0;
    if (isFlipped) {
        originY = (verticalSpacing * 2.0);
    }
    y = 3 * verticalSpacing + (verticalOffset * 2.0);
    x = horizontalOffset + (diff * horizontalSpacing);
    if (isLeftHand) {
        x = width - x - horizontalSpacing;
    }
    fretFrame = CGRectMake(x, originY, horizontalSpacing, y);
    if (isiPad) {
        CGContextSetFillColorWithColor(context, [UIColor Guitar4thStringAlpha].CGColor);
    }
    else {
        CGContextSetFillColorWithColor(context, [UIColor Guitar4thString].CGColor);
    }
    CGContextFillRect(context, fretFrame);
    
    // Draw 5th string base from - red
    diff = 11; if (isiPad) diff = 12;
    originY = 0;
    if (isFlipped) {
        originY = verticalSpacing;
    }
    y = 4 * verticalSpacing + (verticalOffset * 2.0);
    x = horizontalOffset + (diff * horizontalSpacing);
    if (isLeftHand) {
        x = width - x - horizontalSpacing;
    }
    fretFrame = CGRectMake(x, originY, horizontalSpacing, y);
    if (isiPad) {
        CGContextSetFillColorWithColor(context, [UIColor Guitar5thStringAlpha].CGColor);
    }
    else {
        CGContextSetFillColorWithColor(context, [UIColor Guitar5thString].CGColor);
    }
    CGContextFillRect(context, fretFrame);
    
    if (isiPad) {
        CGContextSetStrokeColorWithColor(context, [[UIColor blackColorAlpha] CGColor]);
    }
    else {
        CGContextSetStrokeColorWithColor(context, [[UIColor blackColor] CGColor]);
    }
    CGContextSetLineWidth(context, lineWidth);
    
    // draw vertical lines
    diff = 17; if (isiPad) diff = 19;
    NSInteger numLines = diff;
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
    
    diff = 0; if (isiPad) diff = 1;
    NSMutableArray *degrees = [[GuitarStore sharedStore] degrees];
    for (Degree *degree in degrees) {
        if ([self containsId:degree.identifier]) {
            NSArray *degreePositions = degree.degreePositions;
            for (DegreePosition *degreePosition in degreePositions) {
                NSArray *coordinates = degreePosition.coordinates;
                for (Coordinate *coord in coordinates) {
                    NSInteger xOffset = [self offsetForPosition:degreePosition.positionID] + diff;
                    NSInteger xCoordinate = coord.x + xOffset;
                    CGFloat x
                    = xCoordinate * horizontalSpacing + (horizontalSpacing / 2.0) + horizontalOffset;
                    
                    if (isLeftHand) {
                        x = width - x;
                    }
                    
                    CGFloat y
                    = coord.y * verticalSpacing + verticalOffset;
                    if (isFlipped) {
                        y = height - y - (verticalOffset * 0.8);
                    }
                    CGContextAddArc(context, x, y, radius - strokeWidth, 0.0, M_PI*2, YES);
                    UIColor *textColor;
                    UIColor *fillColor;
                    UIColor *strokeColor;
                    CGFloat newStrokeWidth;
                    if ([coord.color isEqual:@"black"]) {
<<<<<<< Updated upstream
                        textColor   = [UIColor GuitarCream];
                        if (isiPad) {
                            fillColor   = [UIColor blackColorAlpha];
                            strokeColor = [UIColor blackColorAlpha];
                        }
                        else {
                            fillColor   = [UIColor blackColor];
                            strokeColor = [UIColor blackColor];
                        }
                        newStrokeWidth = strokeWidth;
                    } else if ([coord.color isEqualToString:@"white"]) {
                        fillColor   = [UIColor GuitarCream];
                        if (isiPad) {
                            textColor   = [UIColor blackColorAlpha];
                            strokeColor = [UIColor blackColorAlpha];
                        }
                        else {
                            textColor   = [UIColor blackColor];
                            strokeColor = [UIColor blackColor];
                        }
=======
                        textColor   = [UIColor whiteColor];
                        fillColor   = [UIColor blackColorAlpha];
                        strokeColor = [UIColor blackColorAlpha];
                        newStrokeWidth = strokeWidth;
                    } else if ([coord.color isEqualToString:@"white"]) {
                        textColor   = [UIColor blackColorAlpha];
                        fillColor   = [UIColor whiteColor];
                        strokeColor = [UIColor blackColorAlpha];
>>>>>>> Stashed changes
                        newStrokeWidth = strokeWidth;
                    } else if ([coord.color isEqualToString:@"gray"]) {
                        textColor   = [UIColor GuitarCream];
                        if (isiPad) {
                            fillColor   = [UIColor blackColorAlpha];
                            strokeColor = [UIColor blackColorAlpha];
                        }
                        else {
                            fillColor   = [UIColor blackColor];
                            strokeColor = [UIColor blackColor];
                        }
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
