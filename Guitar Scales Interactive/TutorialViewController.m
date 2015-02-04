//
//  TutorialViewController.m
//  Guitar Scales Interactive
//
//  Created by Elena Boyd on 10/19/14.
//
//

#import "TutorialViewController.h"

@interface TutorialViewController ()

@property (nonatomic) NSInteger currentImageIndex;

@property (nonatomic, strong) UIImageView *backgroundImageView;

@property (nonatomic, strong) UIButton *skipButton;
@end

@implementation TutorialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentImageIndex = 1;
    
    self.backgroundImageView = [[UIImageView alloc] init];
    [self.backgroundImageView setContentMode:UIViewContentModeScaleToFill];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewTapped:)];
    [self.backgroundImageView addGestureRecognizer:tap];
    self.backgroundImageView.userInteractionEnabled = YES;
    [self.view addSubview:self.backgroundImageView];
    
    self.skipButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.skipButton.frame = CGRectMake(self.view.bounds.size.width - 80, 15, 80, 30);
    [self.skipButton setTitle:@"SKIP" forState:UIControlStateNormal];
    [self.skipButton setTitleColor:[UIColor GuitarBlue] forState:UIControlStateNormal];
    [self.skipButton.titleLabel setFont:[UIFont ProletarskFontWithSize:24.0]];
    [self.skipButton addTarget:self action:@selector(skip:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.skipButton];
    
    [self layoutImage];
}

- (void)viewWillLayoutSubviews
{
    self.backgroundImageView.frame = self.view.bounds;
}

- (void)layoutImage
{
    NSString *imageString = [NSString stringWithFormat:@"tutorial_%ld", self.currentImageIndex];
    
    [UIView transitionWithView:self.backgroundImageView
                      duration:0.3f // animation duration
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                         [self.backgroundImageView setImage:[UIImage imageNamed:imageString]];
                    } completion:nil];
}

-(void)imageViewTapped:(id)sender
{
    if (self.currentImageIndex < 16) {
        self.currentImageIndex++;
        [self layoutImage];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)skip:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
