//
//  TutorialViewController.m
//  Guitar Scales Interactive
//
//  Created by Elena Boyd on 10/19/14.
//
//

#import "TutorialViewController.h"
#import "GuitarStore.h"

@interface TutorialViewController ()

@property (nonatomic) NSInteger currentImageIndex;

@property (nonatomic, strong) UIImageView *backgroundImageView;

@property (nonatomic, strong) UIButton *skipButton;
@end

@implementation TutorialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.backgroundImageView = [[UIImageView alloc] init];
    [self.backgroundImageView setContentMode:UIViewContentModeScaleToFill];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewTapped:)];
    [self.backgroundImageView addGestureRecognizer:tap];
    self.backgroundImageView.userInteractionEnabled = YES;
    [self.view addSubview:self.backgroundImageView];
    
    CGFloat width = self.view.bounds.size.width;
    CGFloat skipSize = 16;
    if (width > 667) skipSize = 20; // iPhone 6 & 7 Plus, iPad ?
    
    self.skipButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.skipButton setTitle:@"EXIT" forState:UIControlStateNormal];
    [self.skipButton setTitleColor:[UIColor GuitarMainAlpha] forState:UIControlStateNormal];
    [self.skipButton.titleLabel setFont:[UIFont blackoutFontWithSize:skipSize]];
    [self.skipButton addTarget:self action:@selector(skip:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.skipButton];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.skipButton.hidden = NO;
    self.currentImageIndex = 1;
    [self layoutImageWithAnimation:NO];
}

- (void)viewWillLayoutSubviews
{
    CGRect bounds = self.view.bounds;
    self.backgroundImageView.frame = bounds;
    CGFloat x = bounds.size.width * 0.9;
    CGFloat y = 0;
    CGFloat skipWidth = bounds.size.width * 0.1;
    CGFloat skipHeight = bounds.size.height * 0.1;
    self.skipButton.frame = CGRectMake(x, y, skipWidth, skipHeight);

}

- (void)layoutImageWithAnimation:(BOOL)animation
{
    NSString *baseString = @"tutorial_";
    if ([[GuitarStore sharedStore] isLeftHand]) {
        baseString = @"tutorial_left_";
    }
    
    NSString *imageString = [NSString stringWithFormat:@"%@%ld", baseString, (long)self.currentImageIndex];
    
    if (!animation) {
        [self.backgroundImageView setImage:[UIImage imageNamed:imageString]];
    } else {
        [UIView transitionWithView:self.backgroundImageView
                          duration:0.1f // animation duration
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:^{
                            [self.backgroundImageView setImage:[UIImage imageNamed:imageString]];
                        } completion:nil];
    }
}

-(void)imageViewTapped:(id)sender
{
    if (self.currentImageIndex < 23) {
        self.currentImageIndex++;
        
        if (self.currentImageIndex > 22) {
            self.skipButton.hidden = YES;
        }
        
        [self layoutImageWithAnimation:YES];
    } else {
        [self skip:nil];
    }
}

- (void)skip:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        if (self.currentImageIndex > 1) {
            self.currentImageIndex = 1;
            [self layoutImageWithAnimation:NO];
        }
    }];

}
@end
