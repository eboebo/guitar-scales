//
//  buttonView.m
//  Guitar Scales Interactive
//
//  Created by Elena Boyd on 8/16/14.
//
//

#import "GuitarStore.h"
#import "ButtonView.h"
#import "Degree.h"

@interface ButtonView ()


@property (nonatomic, strong) UIButton *clearAllButton;
@property (nonatomic, strong) UIButton *showAllButton;

@end

@implementation ButtonView

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
        
        NSString *degreeString = [NSString stringWithFormat:@"%ld", (long)degree.number];
        
        UIView *degreeView = [[UIView alloc] initWithFrame:CGRectZero];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.text = degreeString;
        label.textAlignment = NSTextAlignmentCenter;
        
        CGFloat x = textButtonWidth + (degree.identifier * smallButtonWidth);
        CGRect buttonFrame = CGRectMake(x, 0, smallButtonWidth, bounds.size.height);
        degreeView.frame = buttonFrame;
        
        CGRect labelFrame = CGRectMake(0, 0, smallButtonWidth, bounds.size.height);
        label.frame = labelFrame;
        
        [degreeView addSubview:label];
        degreeView.tag = degree.identifier;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(degreeTapped:)];
        [degreeView addGestureRecognizer:tap];
        
        [self addSubview:degreeView];
        
        
        if ([self containsId:degree.identifier]) {
            degreeView.backgroundColor = [UIColor blueColor];
            label.textColor = [UIColor whiteColor];
        }
    }
}

- (void)setNeedsDisplay
{
    [super setNeedsDisplay];
    [self layoutSubviews];
}


- (void)clearAllTap:(id)sender
{
    NSLog(@"Clear All Tapped");
}

- (void)showAllTap:(id)sender
{
    NSLog(@"Show All Tapped");
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
    
    NSLog(@"degree button tapped");
}

@end
