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

    CGFloat horizontalOffset = self.isMainView ? 10 : 5;

    CGFloat verticalOffset = self.isMainView ? 12 : 3;
    CGFloat lineWidth = self.isMainView ? 2.0 : 0.5;

    
    CGFloat width = self.bounds.size.width - (horizontalOffset * 2.0);
    
    CGFloat height;
    if (self.bounds.size.height > maxHeight) {
        height = maxHeight - (verticalOffset * 2.0);
    } else {
        height = self.bounds.size.height - (verticalOffset * 2.0);
    }
    
    CGFloat horizontalSpacing = floorf(width / 6.0);
    CGFloat verticalSpacing = floorf(height / 5.0);
    
    if (self.stringViewType == StringViewTypeIndex) {
        horizontalOffset += (horizontalSpacing / 2.0);
    }
    

    if (self.isMainView) {
        verticalSpacing = floorf(height / 6.0);
        height -= verticalSpacing;
    }

    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (self.position.baseFret || self.position.baseFret == 0) {
        CGFloat x = horizontalOffset + (self.position.baseFret * horizontalSpacing);
        CGRect fretFrame = CGRectMake(x, verticalOffset, horizontalSpacing, height);
        CGContextSetFillColorWithColor(context, [UIColor GuitarGray].CGColor);
        CGContextFillRect(context, fretFrame);
    }
    
    CGContextSetStrokeColorWithColor(context, [[UIColor blackColor] CGColor]);
    CGContextSetLineWidth(context, lineWidth);
    
    // draw vertical lines
    
    NSInteger numLines = self.stringViewType == StringViewTypeIndex ? 6 : 7;
    for (int i = 0; i < numLines; i++) {
        CGFloat x = horizontalOffset + (i * horizontalSpacing);
        CGContextMoveToPoint(context, x, verticalOffset);
        CGContextAddLineToPoint(context, x, height + verticalOffset );
        CGContextDrawPath(context, kCGPathStroke);
    }
    
    // draw horizontal lines
    // adjust depending on string view type
    CGFloat horizontalLineWidth = self.bounds.size.width;
    CGFloat horizontalLineX = 0.0;
    if (self.stringViewType == StringViewTypeIndex) {
        horizontalLineWidth -= horizontalSpacing / 2;
        horizontalLineX += horizontalSpacing / 2;
    }
    
    for (int i = 0; i < 6; i++) {
        CGFloat y = i * verticalSpacing  + verticalOffset;
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
            CGFloat x = horizontalOffset + (i * horizontalSpacing);
            CGFloat y = 5.75 * verticalSpacing + verticalOffset;
            NSString *text = stringArray[i];
            CGRect rect = CGRectMake(x, y, horizontalSpacing, verticalSpacing);
            NSMutableParagraphStyle *paragrapStyle = NSMutableParagraphStyle.new;
            paragrapStyle.alignment                = NSTextAlignmentCenter;
            [text drawInRect:rect withAttributes:@{NSFontAttributeName:[UIFont markerFontWithSize:14.0f], NSParagraphStyleAttributeName:paragrapStyle}];

        }
        
        if (self.stringViewType == StringViewTypeIndex) {
            stringArray = @[@"(1)", @"1", @"2", @"3", @"4"];
            for (int i = 0; i < stringArray.count; i++) {
                CGFloat x = horizontalOffset + (i * horizontalSpacing);
                CGFloat y = 6.5 * verticalSpacing + verticalOffset;
                NSString *text = stringArray[i];
                CGRect rect = CGRectMake(x, y, horizontalSpacing, verticalSpacing);
                NSMutableParagraphStyle *paragrapStyle = NSMutableParagraphStyle.new;
                paragrapStyle.alignment                = NSTextAlignmentCenter;
                [text drawInRect:rect withAttributes:@{NSFontAttributeName:[UIFont markerFontWithSize:14.0f], NSParagraphStyleAttributeName:paragrapStyle}];
                
            }
        }
    }
    
    
    NSMutableArray *degrees = [[GuitarStore sharedStore] degrees];
    for (Degree *degree in degrees) {
        if ([self containsId:degree.identifier]) {
            NSArray *degreePositions = degree.degreePositions;
            for (DegreePosition *degreePosition in degreePositions) {
                if (degreePosition.positionID == self.position.identifier) {
                    NSArray *coordinates = degreePosition.coordinates;
                    for (Coordinate *coord in coordinates) {
                        
                        
                        
                        
                        //CGContextAddArc(context, x, y, verticalOffset - lineWidth, 0.0, M_PI*2, YES );
                        UIColor *textColor;
                        UIImage *circleImage;
                        if ([coord.color isEqual:@"black"]) {
                            textColor = [UIColor whiteColor];
                            circleImage = [UIImage imageNamed:@"blob_black"];

                        } else if ([coord.color isEqualToString:@"white"]) {
                            textColor = [UIColor blackColor];
                            circleImage = [UIImage imageNamed:@"blob_white"];
                            
                        } else if ([coord.color isEqualToString:@"gray"]) {
                            textColor = [UIColor GuitarGray];
                            circleImage = [UIImage imageNamed:@"blob_gray"];
                        }
                        
                        CGFloat x = coord.x * horizontalSpacing + (horizontalSpacing / 4.0) + horizontalOffset;
                        CGFloat y = coord.y * verticalSpacing - (verticalSpacing / 2.0) + verticalOffset;
                        CGFloat blah = (verticalOffset -lineWidth) *2;
                        CGRect frame = CGRectMake(x, y, blah, blah);
                        UIImageView *circleImageView = [[UIImageView alloc] initWithFrame:frame];
                        [circleImageView setImage:circleImage];

                        if (self.isMainView) {
                            
                            
                            UILabel *textLabel = [[UILabel alloc] initWithFrame:frame];
                            NSMutableAttributedString *string = [[degree toAttributedStringCircle] mutableCopy];
                            [string addAttribute:NSForegroundColorAttributeName value:textColor range:NSMakeRange(0, string.length)];
                            [textLabel setAttributedText:string];
                            [circleImageView addSubview:textLabel];
                            
//                            NSMutableAttributedString *degreeString = [[degree toAttributedStringCircle] mutableCopy];
//
//                            
//                            CGSize size = [degreeString size];
//                            
//                            CGFloat width = (verticalOffset - lineWidth) * 2;
//                            CGRect rect = CGRectMake(x - width / 2, y - width / 2, width, width);
//                            
//                            CGFloat offset = (width - size.height) / 2;
//                            
//                            rect.size.height -= offset * 2.0;
//                            rect.origin.y += offset;
//                            
//                            NSNumber *offNum = [NSNumber numberWithFloat:offset];
//
//                            NSMutableParagraphStyle *paragrapStyle = NSMutableParagraphStyle.new;
//                            paragrapStyle.alignment                = NSTextAlignmentCenter;
//                            
//                            [paragrapStyle setLineBreakMode:NSLineBreakByWordWrapping];
//                            [degreeString addAttributes:@{NSForegroundColorAttributeName:textColor,
//                                                          NSParagraphStyleAttributeName:paragrapStyle,
//                                                        NSBaselineOffsetAttributeName:offNum
//                                                          } range:NSMakeRange(0, degreeString.length)];
//                            //[degreeString drawInRect:frame];
//                            
// 
//                            
//                            
//                            UIGraphicsBeginImageContext(circleImage.size);
//                            [circleImage drawInRect:CGRectMake(0,0,circleImage.size.width,circleImage.size.height)];
//                            rect = CGRectMake(x, y, circleImage.size.width, circleImage.size.height);
//                            
//                            [degreeString drawInRect:CGRectIntegral(rect)];
//                            UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
//                            UIGraphicsEndImageContext();
//                            [circleImageView setImage:newImage];
//
//                            [self addSubview:circleImageView];

                            
                        }
                         [self addSubview:circleImageView];
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
