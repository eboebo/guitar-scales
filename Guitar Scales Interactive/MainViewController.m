//
//  MainViewController.m
//  Guitar Scales Interactive
//
//  Created by Elena Boyd on 4/28/15.
//
//

#import "GuitarStore.h"
#import "MainViewController.h"
#import "ScalesViewController.h"
#import "OptionsViewController.h"
#import "TutorialViewController.h"

@interface MainViewController ()
<ScalesViewDelegate,
OptionsViewDelegate>

@property (nonatomic, strong) UINavigationController *scaleNavigationController;
@property (nonatomic, strong) OptionsViewController *optionsViewController;
@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;
@property (nonatomic, strong) UIView *optionsViewContainer;
@property (nonatomic, strong) TutorialViewController  *tutorialController;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (![[GuitarStore sharedStore] displayedTutorial]) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Welcome!"
                                                        message:@"Would you like to see the tutorial to get started?"
                                                       delegate:self
                                              cancelButtonTitle:@"No Thanks"
                                              otherButtonTitles:@"OK", nil];
        
        [alert show];
    }
    
    // layout scales
    [self layoutScalesViewController];
}

- (void)layoutScalesViewController
{
    ScalesViewController *scalesViewController = [[ScalesViewController alloc] initWithNibName:@"ScalesViewController" bundle:nil];
    scalesViewController.delegate = self;
    self.scaleNavigationController = [[UINavigationController alloc] initWithRootViewController:scalesViewController];
    [self addChildViewController:self.scaleNavigationController];
    self.scaleNavigationController.view.frame = self.view.bounds;
    [self.view addSubview:self.scaleNavigationController.view];
}

- (void)displayOptionsViewController:(BOOL)display withCompletion:(void (^)(void))completion
{
    CGRect viewBounds = self.view.bounds;
    
    if (display) {
        
        self.optionsViewContainer = [UIView new];
        self.optionsViewContainer.frame = viewBounds;
        
        self.optionsViewController = [[OptionsViewController alloc] init];
        self.optionsViewController.delegate = self;
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
            
            if (completion) {
                completion();
            }
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
            
            if (completion) {
                completion();
            }
            
        }];
    }
}

- (void)displayTutorial:(BOOL)display
{
    if (!self.tutorialController) {
        
        self.tutorialController = [[TutorialViewController alloc] init];
        // Initialize the view controller and set any properties
        
        //self.tutorialController.view.frame = scalesViewControllerViewFrame;
        self.tutorialController.view.backgroundColor = [UIColor GuitarCream];
    }
    
    [self presentViewController:self.tutorialController animated:YES completion:nil];
}


#pragma ScalesViewDelegate methods

- (void)didSelectRightButton
{
    [self displayOptionsViewController:YES withCompletion:nil];
}

#pragma mark OptionsViewDelegate methods

- (void)didSelectOptionRow:(NSInteger)row
{
    if (row == 0) {
        [self displayOptionsViewController:NO withCompletion:^{
            [self displayTutorial:YES];
        }];
    }
}

#pragma mark gesture recognizers

- (void)handleTap:(UITapGestureRecognizer *)tapGesture
{
    if(!CGRectContainsPoint(self.optionsViewController.view.frame, [tapGesture locationInView:self.view])) {
        [self displayOptionsViewController:NO withCompletion:nil];
    }
}

#pragma mark UIAlertView delegate

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [[GuitarStore sharedStore] setDisplayedTutorial];
    } else if (buttonIndex == 1) {
        [self displayTutorial:YES];
        [[GuitarStore sharedStore] setDisplayedTutorial];
    }
}

@end
