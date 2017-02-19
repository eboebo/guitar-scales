//
//  StringView.m
//  Guitar Scales Interactive
//
//  Created by Elena Boyd on 8/12/14.
//
//

#import "FullStringView.h"
#import "DegreeFull.h"
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
    BOOL isBassMode = [[GuitarStore sharedStore] isBassMode];
    BOOL isFlipped = [[GuitarStore sharedStore] isFlipped];
    BOOL showDegrees = [[GuitarStore sharedStore] showDegrees];
    BOOL hideColors = [[GuitarStore sharedStore] isHideColors];
    
    BOOL isiPad = [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad;
    
    CGFloat horizontalSpacing = self.bounds.size.width / 18.5;
    CGFloat verticalSpacing   = self.bounds.size.height / 7.4;
    CGFloat radiusVerticalSpacing = self.bounds.size.height / 7.6;
    CGFloat horizontalOffset = horizontalSpacing * 0.7; //horizontalSpacing / 3.8;
    CGFloat verticalOffset   = verticalSpacing / 2.0;
    CGFloat radius = radiusVerticalSpacing / 2.1;
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height - verticalSpacing;
    CGFloat lineWidth        = radius / 5.1;
    CGFloat strokeWidth      = radius / 4.0;
    CGFloat fontSize         = radius * 1.42;
    
    if (!isiPad) {                                              // iPhone
        horizontalSpacing = self.bounds.size.width / 17.25; // / 16.5;
        verticalSpacing   = self.bounds.size.height / 7.4;
        radiusVerticalSpacing = self.bounds.size.height / 7.6;
        horizontalOffset = horizontalSpacing * 0.7;
        verticalOffset   = verticalSpacing / 2.0;
        radius = radiusVerticalSpacing / 2.3;
        width = self.bounds.size.width;
        height = self.bounds.size.height - verticalSpacing;
        lineWidth        = radius / 5.2;
        strokeWidth      = radius / 4.0;
        fontSize         = radius * 1.42;
    }
    
    CGFloat numStrings = 5;
    if (isBassMode) {
        numStrings = 3;
        verticalSpacing = verticalSpacing * 1.3;
        verticalOffset = verticalOffset * 2.1;
    }

    CGContextRef context = UIGraphicsGetCurrentContext();
    
    
    // draw gray background
    // throughout this section int diff is used to differientate the layouts between iPhone and iPad
    
    NSInteger diff = horizontalSpacing;

        CGFloat y = numStrings * verticalSpacing;
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
//        if (isiPad) { // COMMENTING OUT FOR NEW KEY VERSION
            CGContextSetFillColorWithColor(context, [UIColor GuitarCream].CGColor);
//        }
//        else {
//            if ((self.position.identifier == 0) || (self.position.identifier == 4) || (self.position.identifier == 2))
//            {
//                CGContextSetFillColorWithColor(context, [UIColor Guitar6thStringAlpha].CGColor);
//            }
//            else if (self.position.identifier == 6)
//            {
//                CGContextSetFillColorWithColor(context, [UIColor Guitar4thStringAlpha].CGColor);
//            }
//            else
//            {
//                CGContextSetFillColorWithColor(context, [UIColor Guitar5thStringAlpha].CGColor);
//            }
//        }
        CGContextFillRect(context, fretFrame);
    }
    
    NSInteger keyOffset = self.key.identifier;
    
    if (!hideColors) {
  
    // Draw 6th string base fret - green
    CGFloat originY = 0.0;
    diff = 4; if (isiPad) diff = 5;
    NSInteger greenOffset = diff + keyOffset;
    CGFloat x = horizontalOffset + (greenOffset * horizontalSpacing);
    if (isLeftHand) {
        x = width - x - horizontalSpacing;
    }
    numStrings = 5;
    y = numStrings * verticalSpacing + (verticalOffset * 2.0);
    if (isBassMode) {
        numStrings = 3;
        originY += (verticalSpacing * .43);
        y = numStrings * verticalSpacing + (verticalOffset * .95);
    }
    fretFrame = CGRectMake(x, originY, horizontalSpacing, y);
    if (isiPad) {
        CGContextSetFillColorWithColor(context, [UIColor Guitar6thStringAlpha].CGColor);
    }
    else {
        CGContextSetFillColorWithColor(context, [UIColor Guitar6thString].CGColor);
    }
    CGContextFillRect(context, fretFrame);
    
    if (keyOffset > 7) {        // second green
        greenOffset -= 12;
        CGFloat originY = 0.0;
        CGFloat x = horizontalOffset + (greenOffset * horizontalSpacing);
        if (isLeftHand) {
            x = width - x - horizontalSpacing;
        }
        numStrings = 5;
        y = numStrings * verticalSpacing + (verticalOffset * 2.0);
        if (isBassMode) {
            numStrings = 3;
            originY += (verticalSpacing * .43);
            y = numStrings * verticalSpacing + (verticalOffset * .95);
        }
        fretFrame = CGRectMake(x, originY, horizontalSpacing, y);
        if (isiPad) {
            CGContextSetFillColorWithColor(context, [UIColor Guitar6thStringAlpha].CGColor);
        }
        else {
            CGContextSetFillColorWithColor(context, [UIColor Guitar6thString].CGColor);
        }
        CGContextFillRect(context, fretFrame);

    }
    
    // Draw 4th string base fret - yellow
    diff = 6; if (isiPad) diff = 7;
    NSInteger yellowOffset = diff + keyOffset;
    if (yellowOffset > 15) {
        yellowOffset -= 12;
    }
    originY = 0;
    if (isFlipped) {
        originY = (verticalSpacing * 2.0);
    }
    x = horizontalOffset + (yellowOffset * horizontalSpacing);
    if (isLeftHand) {
        x = width - x - horizontalSpacing;
    }
    numStrings = 3;
    y = numStrings * verticalSpacing + (verticalOffset * 2.0);
    if (isBassMode) {
        numStrings = 1;
        originY += (verticalSpacing * .43);
        y = numStrings * verticalSpacing + (verticalOffset * .95);
    }
    fretFrame = CGRectMake(x, originY, horizontalSpacing, y);
    if (isiPad) {
        CGContextSetFillColorWithColor(context, [UIColor Guitar4thStringAlpha].CGColor);
    }
    else {
        CGContextSetFillColorWithColor(context, [UIColor Guitar4thString].CGColor);
    }
    CGContextFillRect(context, fretFrame);
    
    if (keyOffset > 5 && keyOffset < 10) {      // second yellow
        yellowOffset -= 12;
        originY = 0;
        if (isFlipped) {
            originY = (verticalSpacing * 2.0);
        }
        x = horizontalOffset + (yellowOffset * horizontalSpacing);
        if (isLeftHand) {
            x = width - x - horizontalSpacing;
        }
        numStrings = 3;
        y = numStrings * verticalSpacing + (verticalOffset * 2.0);
        if (isBassMode) {
            numStrings = 1;
            originY += (verticalSpacing * .43);
            y = numStrings * verticalSpacing + (verticalOffset * .95);
        }
        fretFrame = CGRectMake(x, originY, horizontalSpacing, y);
        if (isiPad) {
            CGContextSetFillColorWithColor(context, [UIColor Guitar4thStringAlpha].CGColor);
        }
        else {
            CGContextSetFillColorWithColor(context, [UIColor Guitar4thString].CGColor);
        }
        CGContextFillRect(context, fretFrame);

    }
    
    // Draw 5th string base from - purple
    diff = 11; if (isiPad) diff = 12;
    NSInteger purpleOffset = diff + keyOffset;
    if (purpleOffset > 15) {
        purpleOffset -= 12;
    }
    originY = 0;
    if (isFlipped) {
        originY = verticalSpacing;
    }
    x = horizontalOffset + (purpleOffset * horizontalSpacing);
    if (isLeftHand) {
        x = width - x - horizontalSpacing;
    }
    numStrings = 4;
    y = numStrings * verticalSpacing + (verticalOffset * 2.0);
    if (isBassMode) {
        numStrings = 2;
        originY += (verticalSpacing * .43);
        y = numStrings * verticalSpacing + (verticalOffset * .95);
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
    
    if (keyOffset > 0 && keyOffset < 5) {       // second purple
        purpleOffset -= 12;
        originY = 0;
        if (isFlipped) {
            originY = verticalSpacing;
        }
        x = horizontalOffset + (purpleOffset * horizontalSpacing);
        if (isLeftHand) {
            x = width - x - horizontalSpacing;
        }
        numStrings = 4;
        y = numStrings * verticalSpacing + (verticalOffset * 2.0);
        if (isBassMode) {
            numStrings = 2;
            originY += (verticalSpacing * .43);
            y = numStrings * verticalSpacing + (verticalOffset * .95);
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
    }
    }
    
    
    // draw vertical lines
    diff = 17; if (isiPad) diff = 19;
    NSInteger numLines = diff;
    numStrings = 5;
    if (isBassMode) {
        numStrings = 3;
    }
    for (int i = 0; i < numLines; i++) {
        if (i == 0) {
            CGFloat nutLineWidth = lineWidth * 2.0;
            CGContextSetLineWidth(context, nutLineWidth);
        }
        else {
            CGContextSetLineWidth(context, lineWidth);
        }
        CGFloat x = horizontalOffset + (i * horizontalSpacing);
        if (isLeftHand) {
            x = width - x;
        }
        CGFloat y = numStrings * verticalSpacing + verticalOffset;
        CGContextMoveToPoint(context, x, verticalOffset);
        CGContextAddLineToPoint(context, x, y);
        CGContextDrawPath(context, kCGPathStroke);
    }
    
    // draw horizontal lines
    // adjust depending on string view type
    CGFloat horizontalLineWidth = width * 0.98;
    CGFloat horizontalLineX     = horizontalOffset * 0.915;
    if (isLeftHand) {
        horizontalLineX = horizontalOffset * 0.5;
        horizontalLineWidth = width * 0.9628;
    }
    
    numLines = 6;
    if (isBassMode) {
        numLines = 4;
    }

    for (int i = 0; i < numLines; i++) {
        CGFloat y = i * verticalSpacing + verticalOffset;
        CGContextMoveToPoint(context, horizontalLineX, y);
        CGContextAddLineToPoint(context, horizontalLineWidth, y);
        CGContextDrawPath(context, kCGPathStroke);
    }
    
    // fret marker dots
    
    NSArray *stringArray = @[@" ", @" ", @"•", @" ", @"•", @" ", @"•", @" ", @"•", @" ", @" ", @"••", @" ", @" ", @"•"];
    
    for (int i = 0; i < stringArray.count; i++) {
        CGFloat x      = horizontalOffset + (i * horizontalSpacing);
        
        if (isLeftHand) {
            x = width - x - horizontalSpacing;
        }
        
        CGFloat fingerNumOffset = 5.4;
        if (isBassMode) {
            fingerNumOffset = 3.25;
        }
        
        CGFloat fretMarkerFontSize         = radius * 2.0;
        
        CGFloat y      = (fingerNumOffset * verticalSpacing) + verticalOffset;
        NSString *text = stringArray[i];
        CGRect rect    = CGRectMake(x, y, horizontalSpacing, verticalSpacing);
        NSMutableParagraphStyle *paragraphStyle = NSMutableParagraphStyle.new;
        paragraphStyle.alignment                = NSTextAlignmentCenter;
        [text drawInRect:rect withAttributes:@{NSFontAttributeName:[UIFont bravuraFontWithSize:fretMarkerFontSize], NSForegroundColorAttributeName:[UIColor blackColor], NSParagraphStyleAttributeName:paragraphStyle}];
    }
    
    // NEW NOTES for DegreeFull
    
    diff = 0; if (isiPad) diff = 1;
        NSMutableArray *degreesFull = [[GuitarStore sharedStore] degreesFull];
        for (DegreeFull *degreeFull in degreesFull) {
            if ([self containsId:degreeFull.identifier]) {
                NSArray *coordinates = degreeFull.coordinates;
                    for (Coordinate *coord in coordinates) {
//                        NSInteger xOffset = diff;
                        NSInteger xCoordinate = coord.x + keyOffset; // + xOffset
                        if (xCoordinate > 11) {
                            xCoordinate -= 12;
                        }
                        // slide over open notes
                        CGFloat noteShift = 0.0;
                        if (xCoordinate == 0) {
                            noteShift =  horizontalSpacing * 0.14;
                        }
                        CGFloat x  = xCoordinate * horizontalSpacing + (horizontalSpacing * 0.2) + noteShift;
                        CGFloat xx = x;
    
                        if (isLeftHand) {
                            xx = width - x;
                        }
    
                        CGFloat bassChanger = 0;
                        if (isBassMode) {
                            if (coord.y > 1) {      // in bass mode, move notes up 2 strings
                                bassChanger = 2;
                            }
                            if (coord.y == 6) {        // special case for special bass notes
                                bassChanger = 6;
                            }
                        }
                        CGFloat y
                        = (coord.y - bassChanger) * verticalSpacing + verticalOffset;
    
                        if (isFlipped) {
                            CGFloat flipOffset = 0.8;
                            if (isBassMode) {
                                flipOffset = 0.4;
                            }
                            y = height - y - (verticalOffset * flipOffset);
                        }
    
                        CGContextAddArc(context, xx, y, radius - strokeWidth, 0.0, M_PI*2, YES);
                        UIColor *textColor;
                        UIColor *fillColor;
                        UIColor *strokeColor;
                        UIColor *textColorUse;
                        UIColor *fillColorUse;
                        UIColor *strokeColorUse;
                        if ([coord.color isEqual:@"black"]) {
                            textColor   = [UIColor GuitarCream];
                            if (isiPad) {
                                fillColor   = [UIColor blackColorAlpha];
                                strokeColor = [UIColor blackColorAlpha];
                            }
                            else {
                                fillColor   = [UIColor blackColor];
                                strokeColor = [UIColor blackColor];
                            }
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
                        }
    
                        if (coord.y == 6) {         // hide special bass notes
                            textColor   = [UIColor clearColor];
                            fillColor   = [UIColor clearColor];
                            strokeColor = [UIColor clearColor];
                        }
                        
                        textColorUse   = textColor;
                        fillColorUse   = fillColor;
                        strokeColorUse = strokeColor;
                        strokeWidth      = radius / 4.0;
                        
                        if (xCoordinate == 0) {      //////// OPEN NOTES
                            textColorUse   = [UIColor GuitarDarkerGray];
                            strokeColorUse = [UIColor GuitarDarkerGray];
                            fillColorUse   = [UIColor clearColor];
                            strokeWidth      = radius / 12.0;
                        }
                        
                        if (isBassMode) {               // hides 1st 2 strings in bass mode
                            if (coord.y < 2) {
                                textColorUse   = [UIColor clearColor];
                                fillColorUse   = [UIColor clearColor];
                                strokeColorUse = [UIColor clearColor];
                            }
                        }
                        
                        CGContextSetLineWidth(context, strokeWidth);
                        CGContextSetFillColorWithColor(context, [fillColorUse CGColor]);
                        CGContextSetStrokeColorWithColor(context, [strokeColorUse CGColor]);
                        CGContextDrawPath(context, kCGPathFillStroke);
    
                        // If the view is the center view, add degree text on top of notes
                        // if showDegrees is set on
                if (showDegrees == false)
                {
    
                        NSMutableAttributedString *degreeString
                        = [[degreeFull toAttributedStringCircleWithFontSize:fontSize] mutableCopy];
                        CGFloat width    = (radius - lineWidth) * 2;
                        CGRect rect;
                        if (degreeString.length == 1) {
                            rect = CGRectMake(xx - width / 2.2, y - width / 2, width, width);
                        } else {
                            rect = CGRectMake(xx - width / 2.2, y - width / 1.7, width, width);
    
                        }
                        CGSize size      = [degreeString size];
                        CGFloat offset   = (width - size.height) / 2;
                        rect.size.height -= offset * 2.0;
                        rect.origin.y    += offset;
    
                        NSNumber *offNum = [NSNumber numberWithFloat:offset];
    
                        NSMutableParagraphStyle *paragrapStyle = NSMutableParagraphStyle.new;
                        paragrapStyle.alignment                = NSTextAlignmentCenter;
    
                        [paragrapStyle setLineBreakMode:NSLineBreakByWordWrapping];
                        [degreeString addAttributes:@{NSForegroundColorAttributeName:textColorUse,
                                                      NSParagraphStyleAttributeName:paragrapStyle,
                                                      NSBaselineOffsetAttributeName:offNum}
                                              range:NSMakeRange(0, degreeString.length)];
    
                        NSShadow *shadowDic=[[NSShadow alloc] init];
                        [shadowDic setShadowColor:textColorUse];
                        [shadowDic setShadowOffset:CGSizeMake(0, 0.7)];
                        [degreeString addAttribute:NSShadowAttributeName
                                             value:shadowDic
                                             range:NSMakeRange(0, degreeString.length)];
                   
                        [degreeString drawInRect:rect];
                            
                }
                        
                // draw 2nd dot, for the first 5 dots
                        
                if (xCoordinate < 5) {
               
                    if (isLeftHand) {
                        xx = xx - (horizontalSpacing * 12) + noteShift;
                    }
                    else {
                        xx = xx + (horizontalSpacing * 12) - noteShift;
                    }
                
                    strokeWidth      = radius / 4.0;   
                    CGContextAddArc(context, xx, y, radius - strokeWidth, 0.0, M_PI*2, YES);
                                
                    textColorUse   = textColor;
                    fillColorUse   = fillColor;
                    strokeColorUse = strokeColor;
                    
                    if (isBassMode) {               // hides 1st 2 strings in bass mode
                        if (coord.y < 2) {
                            textColorUse   = [UIColor clearColor];
                            fillColorUse   = [UIColor clearColor];
                            strokeColorUse = [UIColor clearColor];
                        }
                    }
                    
                    CGContextSetLineWidth(context, strokeWidth);
                    CGContextSetFillColorWithColor(context, [fillColorUse CGColor]);
                    CGContextSetStrokeColorWithColor(context, [strokeColorUse CGColor]);

                    CGContextDrawPath(context, kCGPathFillStroke);

                    // draw 2nd scale degree num
                    if (showDegrees == false)
                    {

                        NSMutableAttributedString *degreeString
                        = [[degreeFull toAttributedStringCircleWithFontSize:fontSize] mutableCopy];
                        CGFloat width    = (radius - lineWidth) * 2;
                        CGRect rect;
                        if (degreeString.length == 1) {
                            rect = CGRectMake(xx - width / 2.2, y - width / 2, width, width);
                        } else {
                            rect = CGRectMake(xx - width / 2.2, y - width / 1.7, width, width);
                        }
                        CGSize size      = [degreeString size];
                        CGFloat offset   = (width - size.height) / 2;
                        rect.size.height -= offset * 2.0;
                        rect.origin.y    += offset;

                        NSNumber *offNum = [NSNumber numberWithFloat:offset];

                        NSMutableParagraphStyle *paragrapStyle = NSMutableParagraphStyle.new;
                        paragrapStyle.alignment                = NSTextAlignmentCenter;

                        [paragrapStyle setLineBreakMode:NSLineBreakByWordWrapping];
                        [degreeString addAttributes:@{NSForegroundColorAttributeName:textColorUse,
                                                      NSParagraphStyleAttributeName:paragrapStyle,
                                                      NSBaselineOffsetAttributeName:offNum}
                                              range:NSMakeRange(0, degreeString.length)];
                        
                        NSShadow *shadowDic=[[NSShadow alloc] init];
                        [shadowDic setShadowColor:textColorUse];
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
