//
//  MainViewController.m
//  Guitar Scales Interactive
//
//  Created by Elena Boyd on 4/28/15.
//
//

#import "MainViewController.h"
#import "ScalesViewController.h"
#import "OptionsViewController.h"

@interface MainViewController ()
<ScalesViewDelegate>

@property (nonatomic, strong) UINavigationController *scaleNavigationController;
@property (nonatomic, strong) OptionsViewController *optionsViewController;
@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;
@property (nonatomic, strong) UIView *optionsViewContainer;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ScalesViewController *scalesViewController = [[ScalesViewController alloc] initWithNibName:@"ScalesViewController" bundle:nil];
    scalesViewController.delegate = self;
    self.scaleNavigationController = [[UINavigationController alloc] initWithRootViewController:scalesViewController];
    [self addChildViewController:self.scaleNavigationController];
    self.scaleNavigationController.view.frame = self.view.bounds;
    [self.view addSubview:self.scaleNavigationController.view];
}


#pragma ScalesViewDelegate methods

- (void)didSelectRightButton
{
    [self displayOptionsViewController:YES];
}

- (void)displayOptionsViewController:(BOOL)display
{
    CGRect viewBounds = self.view.bounds;

    if (display) {
        
        self.optionsViewContainer = [UIView new];
        self.optionsViewContainer.frame = viewBounds;
        
        self.optionsViewController = [[OptionsViewController alloc] init];
        CGRect optionsViewControllerFrame     = viewBounds;
        optionsViewControllerFrame.size.width = 300;
        optionsViewControllerFrame.origin = CGPointMake(viewBounds.size.width, 0);
        self.optionsViewController.view.frame = optionsViewControllerFrame;
        
        [self.optionsViewContainer addSubview:self.optionsViewController.view];
        
        self.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        self.tapGesture.cancelsTouchesInView = NO;
        [self.optionsViewContainer addGestureRecognizer:self.tapGesture];
        
        [self.view addSubview:self.optionsViewContainer];
        
        [UIView animateWithDuration:0.15f animations:^{
            
            CGRect optionsViewControllerFrame = self.optionsViewController.view.frame;
            optionsViewControllerFrame.origin = CGPointMake(viewBounds.size.width - 300, 0);
            self.optionsViewController.view.frame = optionsViewControllerFrame;
            
            self.optionsViewContainer.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
            
            self.scaleNavigationController.view.transform = CGAffineTransformMakeScale(.85, .85);
            
        } completion:^(BOOL finished) {
            self.view.window.userInteractionEnabled = YES;
        }];
    } else {
        [UIView animateWithDuration:0.15 animations:^{
            self.optionsViewContainer.backgroundColor = [UIColor clearColor];
            
            CGRect optionsViewControllerFrame     = self.optionsViewController.view.frame;
            optionsViewControllerFrame.origin = CGPointMake(viewBounds.size.width, 0);
            self.optionsViewController.view.frame = optionsViewControllerFrame;
            
            self.scaleNavigationController.view.transform = CGAffineTransformIdentity;
            
        } completion:^(BOOL finished) {
            
            [self.optionsViewController.view removeFromSuperview];
            self.optionsViewController = nil;
            
            [self.optionsViewContainer removeGestureRecognizer:self.tapGesture];
            self.tapGesture = nil;
            
            [self.optionsViewContainer removeFromSuperview];
            self.optionsViewContainer = nil;
            
            self.view.window.userInteractionEnabled = YES;
            
        }];
    }

}

- (void)handleTap:(UITapGestureRecognizer *)tapGesture
{
    if(!CGRectContainsPoint(self.optionsViewController.view.frame, [tapGesture locationInView:self.view])) {
        [self displayOptionsViewController:NO];
    }
}

@end
