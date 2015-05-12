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
    
    self.skipButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.skipButton setTitle:@"SKIP" forState:UIControlStateNormal];
    [self.skipButton setTitleColor:[UIColor GuitarMediumBlue] forState:UIControlStateNormal];
    [self.skipButton.titleLabel setFont:[UIFont blackoutFontWithSize:16.0]];
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
    self.backgroundImageView.frame = self.view.bounds;
    self.skipButton.frame = CGRectMake(self.view.bounds.size.width - 75, 1, 80, 30);

}

- (void)layoutImageWithAnimation:(BOOL)animation
{
    NSString *baseString = @"tutorial_";
    if ([[GuitarStore sharedStore] isLeftHand]) {
        baseString = @"tutorial_"; // Change once we have the image files
    }
    
    NSString *imageString = [NSString stringWithFormat:@"%@%ld", baseString, (long)self.currentImageIndex];
    
    if (!animation) {
        [self.backgroundImageView setImage:[UIImage imageNamed:imageString]];
    } else {
        [UIView transitionWithView:self.backgroundImageView
                          duration:0.3f // animation duration
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:^{
                            [self.backgroundImageView setImage:[UIImage imageNamed:imageString]];
                        } completion:nil];
    }
}

-(void)imageViewTapped:(id)sender
{
    if (self.currentImageIndex < 20) {
        self.currentImageIndex++;
        
        if (self.currentImageIndex > 18) {
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
