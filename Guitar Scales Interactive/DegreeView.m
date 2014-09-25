//
//  buttonView.m
//  Guitar Scales Interactive
//
//  Created by Elena Boyd on 8/16/14.
//
//

#import "GuitarStore.h"
#import "DegreeView.h"
#import "Degree.h"
#import "DegreeButtonView.h"

@interface DegreeView () < DegreeButtonViewDelegate>


@property (nonatomic, strong) UIButton *clearAllButton;
@property (nonatomic, strong) UIButton *showAllButton;

@end

@implementation DegreeView

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews
{
    self.backgroundColor = [UIColor clearColor];
    self.clearAllButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.clearAllButton setTitle:@"CLEAR ALL" forState:UIControlStateNormal];
    [self.clearAllButton setTintColor:[UIColor GuitarBlue]];
    self.clearAllButton.titleLabel.font = [UIFont proletarskFontWithSize:17.0f];
    [self.clearAllButton addTarget:self action:@selector(clearAllTap:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.clearAllButton];
    
    self.showAllButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.showAllButton setTitle:@"SHOW ALL" forState:UIControlStateNormal];
    [self.showAllButton setTintColor:[UIColor GuitarBlue]];
    self.showAllButton.titleLabel.font = [UIFont proletarskFontWithSize:17.0f];

    [self.showAllButton addTarget:self action:@selector(showAllTap:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.showAllButton];

}

- (void)drawRect:(CGRect)rect
{
    //draw the bottom border
    float borderSize = 8.0f;
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor GuitarBlue].CGColor);
    CGContextFillRect(context, CGRectMake(0.0f, self.frame.size.height - borderSize, self.frame.size.width, borderSize));
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat textButtonWidth = 120.0f;
    
    CGRect bounds = self.bounds;
    
    CGRect clearFrame = CGRectMake(0, 0, textButtonWidth, bounds.size.height);
    self.clearAllButton.frame = clearFrame;
    
    CGRect showFrame = CGRectMake(bounds.size.width - textButtonWidth, 0, textButtonWidth, bounds.size.height);
    self.showAllButton.frame = showFrame;
    
    NSArray *degrees = [[GuitarStore sharedStore] degrees];
    
    CGFloat buttonBoardWidth = bounds.size.width - textButtonWidth * 2.0;
    CGFloat smallButtonWidth = buttonBoardWidth / degrees.count;
    
    for (Degree *degree in degrees) {
        DegreeButtonView *degreeButton = [[DegreeButtonView alloc] initWithFrame:CGRectZero];
        CGFloat x = textButtonWidth + (degree.identifier * smallButtonWidth);
        CGRect buttonFrame = CGRectMake(x, 0, smallButtonWidth, bounds.size.height);
        degreeButton.frame = buttonFrame;

        [degreeButton.titleLabel setAttributedText:[degree toAttributedString]];
        degreeButton.delegate = self;
        degreeButton.tag = degree.identifier;
        
        if ([self containsId:degree.identifier]) {
            [degreeButton setSelected:YES];
        } else {
            [degreeButton setSelected:NO];
        }
        [self addSubview:degreeButton];
    }
}

- (void)layoutSingleButton
{
    
}


- (void)layoutDoubleButton
{
    
}


- (void)setNeedsDisplay
{
    [super setNeedsDisplay];
    [self layoutSubviews];
}


- (void)clearAllTap:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(selectedDegreesModified:)]) {
        [self.delegate selectedDegreesModified:[NSMutableArray new]];
    }
    self.selectedDegrees = [NSMutableArray new];
    [self setNeedsDisplay];
}

- (void)showAllTap:(id)sender
{
    NSArray *degrees = [[GuitarStore sharedStore] degrees];
    NSMutableArray *degreeArray = [NSMutableArray new];
    for (Degree *degree in degrees) {
        NSString *identifier = [NSString stringWithFormat:@"%ld", (long) degree.identifier];
        [degreeArray addObject:identifier];
    }
    if ([self.delegate respondsToSelector:@selector(selectedDegreesModified:)]) {
        [self.delegate selectedDegreesModified:degreeArray];
    }
    
    self.selectedDegrees = degreeArray;
    
    [self setNeedsDisplay];
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

- (void)degreeTapped:(id)sender
{
    
    DegreeButtonView *degreeButton = (DegreeButtonView *)sender;
    if (degreeButton.selected) {
        NSNumber *number = [NSNumber numberWithInt:degreeButton.tag];
        [self.selectedDegrees insertObject:number atIndex:0];
    } else {
        for (NSNumber *degree in self.selectedDegrees) {
            if ([degree integerValue]  == degreeButton.tag) {
                [self.selectedDegrees removeObject:degree];
                break;
            }
        }
    }

    if ([self.delegate respondsToSelector:@selector(selectedDegreesModified:)]) {
        [self.delegate selectedDegreesModified:self.selectedDegrees];
    }
}

//- (UIImage *)imageWithColor:(UIColor *)color {
//    CGRect rect = CGRectMake(0, 0, 1, 1);
//    // Create a 1 by 1 pixel context
//    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
//    [color setFill];
//    UIRectFill(rect);   // Fill it with your color
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    
//    return image;
//}

@end
