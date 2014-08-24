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

@interface DegreeView ()


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
    self.backgroundColor = [UIColor whiteColor];
    self.clearAllButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.clearAllButton setTitle:@"CLEAR ALL" forState:UIControlStateNormal];
    [self.clearAllButton setTintColor:[UIColor blueColor]];
    [self.clearAllButton addTarget:self action:@selector(clearAllTap:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.clearAllButton];
    
    self.showAllButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.showAllButton setTitle:@"SHOW ALL" forState:UIControlStateNormal];
    [self.showAllButton setTintColor:[UIColor blueColor]];
    [self.showAllButton addTarget:self action:@selector(showAllTap:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.showAllButton];

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
        
        
        UIButton *degreeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        CGFloat x = textButtonWidth + (degree.identifier * smallButtonWidth);
        CGRect buttonFrame = CGRectMake(x, 0, smallButtonWidth, bounds.size.height);
        degreeButton.frame = buttonFrame;
        
        NSString *degreeString;
        if (degree.flat) {
            degreeString = [NSString stringWithFormat:@"b%d", degree.number];
        } else if (degree.sharp) {
            degreeString = [NSString stringWithFormat:@"#%d", degree.number];
        } else {
            degreeString = [NSString stringWithFormat:@"%d", degree.number];
        }
        
        
        [degreeButton setTitle:degreeString forState:UIControlStateNormal];

        degreeButton.tag = degree.identifier;
        
        if ([self containsId:degree.identifier]) {
            [degreeButton setSelected:YES];
        }
        
        [degreeButton addTarget:self action:@selector(degreeTapped:) forControlEvents:UIControlEventTouchDown];

        [self addSubview:degreeButton];

        [degreeButton setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
        [degreeButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];

        
        
    }
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
        NSString *identifier = [NSString stringWithFormat:@"%d", degree.identifier];
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
    
    UIButton *degreeButton = (UIButton *)sender;
    degreeButton.selected = !degreeButton.selected;
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
    
    [self setNeedsDisplay];
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
