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
    if (self.currentImageIndex < 20) {
        self.currentImageIndex++;
        [self layoutImage];
    } else {
        if ([self.delegate respondsToSelector:@selector(didCompleteTutorial)]) {
            [self.delegate didCompleteTutorial];
        }
    }
}
@end
