//
//  buttonView.m
//  Guitar Scales Interactive
//
//  Created by Elena Boyd on 8/16/14.
//
//

#import "ButtonView.h"

@interface ButtonView ()


@property (nonatomic, strong) NSArray *buttons;
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
    self.buttons = @[@"1", @"b2", @"2", @"#2", @"3", @"4", @"#4", @"5",@"#5", @"6",@"b7",@"7"];
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
    
    
    CGFloat buttonBoardWidth = bounds.size.width - textButtonWidth * 2.0;
    CGFloat smallButtonWidth = buttonBoardWidth / self.buttons.count;
    
    for (int i = 0; i < self.buttons.count; i++) {
        NSString *buttonString = self.buttons[i];
        
        
        UIView *buttonView = [[UIView alloc] initWithFrame:CGRectZero];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.text = buttonString;
        label.textAlignment = NSTextAlignmentCenter;
        
        CGFloat x = textButtonWidth + (i * smallButtonWidth);
        CGRect buttonFrame = CGRectMake(x, 0, smallButtonWidth, bounds.size.height);
        buttonView.frame = buttonFrame;
        
        CGRect labelFrame = CGRectMake(0, 0, smallButtonWidth, bounds.size.height);
        label.frame = labelFrame;
        
        [buttonView addSubview:label];
        [self addSubview:buttonView];
        

        if (self.selectedButtons) {
            for (NSNumber *string in self.selectedButtons) {
                if ([buttonString isEqualToString:[string stringValue]]) {
                    buttonView.backgroundColor = [UIColor blueColor];
                    label.textColor = [UIColor whiteColor];
                    break;
                }
            }
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

@end
