//
//  ScalesViewController.m
//  Guitar Scales Interactive
//
//  Created by Elena Boyd on 8/12/14.
//
//

#import "ScalesViewController.h"
#import "StringView.h"
#import "Scale.h"
#import "DegreeView.h"
#import "GuitarStore.h"
#import "MenuTableViewController.h"

@interface ScalesViewController ()
<DegreeViewDelegate,
 MenuDelegate
>

@property (weak, nonatomic) IBOutlet StringView *mainStringView;
@property (weak, nonatomic) IBOutlet StringView *topLeftStringView;
@property (weak, nonatomic) IBOutlet StringView *middleLeftStringView;
@property (weak, nonatomic) IBOutlet StringView *bottomLeftStringView;
@property (weak, nonatomic) IBOutlet StringView *topRightStringView;
@property (weak, nonatomic) IBOutlet StringView *middleRightStringView;
@property (weak, nonatomic) IBOutlet StringView *bottomRightStringView;
@property (weak, nonatomic) IBOutlet DegreeView *degreeView;

@property (nonatomic, strong) StringView *selectedStringView;


@property (nonatomic, assign) Position *currentPosition;
@property (weak, nonatomic) IBOutlet UILabel *positionLabel;

@property (weak, nonatomic) IBOutlet UILabel *leftStringLabel;
@property (weak, nonatomic) IBOutlet UILabel *leftIndexLabel;
@property (weak, nonatomic) IBOutlet UILabel *leftMiddleLabel;
@property (weak, nonatomic) IBOutlet UILabel *leftBottomLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightStringLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightIndexLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightMiddleLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightBottonLabel;

@property (nonatomic, strong) MenuTableViewController *menuController;


@end

@implementation ScalesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor GuitarCream];
    self.navigationController.navigationBar.barTintColor = [UIColor GuitarBlue];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,[UIFont proletarskFontWithSize:18.0f], NSFontAttributeName, nil]];


    self.currentPosition = 0;
    
    self.title = @"Scales";
    
    self.positionLabel.font = [UIFont proletarskFontWithSize:16.0f];
    self.leftStringLabel.font = [UIFont proletarskFontWithSize:14.0f];
    self.leftIndexLabel.font = [UIFont proletarskFontWithSize:10.0f];
    self.leftMiddleLabel.font = [UIFont proletarskFontWithSize:10.0f];
    self.leftBottomLabel.font = [UIFont proletarskFontWithSize:10.0f];
    self.rightStringLabel.font = [UIFont proletarskFontWithSize:14.0f];
    self.rightIndexLabel.font = [UIFont proletarskFontWithSize:10.0f];
    self.rightMiddleLabel.font = [UIFont proletarskFontWithSize:10.0f];
    self.rightBottonLabel.font = [UIFont proletarskFontWithSize:10.0f];

    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStylePlain target:self action:@selector(handleLeftBarButtonTap:)];
    [barButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                           [UIFont proletarskFontWithSize:14.0], NSFontAttributeName,
                                           nil]
                                 forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = barButtonItem;
    
    UITapGestureRecognizer *topRightviewTapped = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    [self.topRightStringView addGestureRecognizer:topRightviewTapped];
    
    UITapGestureRecognizer *topLeftviewTapped = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    [self.topLeftStringView addGestureRecognizer:topLeftviewTapped];
    
    UITapGestureRecognizer *middleRightViewTapped = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    [self.middleRightStringView addGestureRecognizer:middleRightViewTapped];
    
    UITapGestureRecognizer *middleLeftViewTapped = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    [self.middleLeftStringView addGestureRecognizer:middleLeftViewTapped];
    
    UITapGestureRecognizer *bottomLeftViewTapped = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    [self.bottomLeftStringView addGestureRecognizer:bottomLeftViewTapped];
    
     UITapGestureRecognizer *bottomRightViewTapped = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    [self.bottomRightStringView addGestureRecognizer:bottomRightViewTapped];
    
    [[GuitarStore sharedStore] setCallback:^(BOOL success) {
        if (success) {
            [self refreshData];
            [self resetButtonView];
        }
    }];
    
    [[GuitarStore sharedStore] parseData];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
}

- (void)handleLeftBarButtonTap:(id)sender
{
    if (!self.menuController) {
        self.menuController = [[MenuTableViewController alloc] init];
        self.menuController.delegate = self;
        // Initialize the view controller and set any properties
        
        // Set the frame of playslistViewController view
        CGRect playslistViewControllerViewFrame   = self.view.bounds;
        playslistViewControllerViewFrame.origin.y = -playslistViewControllerViewFrame.size.height;
        
        self.menuController.view.frame = playslistViewControllerViewFrame;
        self.menuController.view.backgroundColor = [UIColor GuitarCream];
        self.menuController.view.alpha = 0.95;
        
        // Add as a child view controller
        [self addChildViewController:self.menuController];
        
        // Add as a subview
        [self.view addSubview:self.menuController.view];
        
        [UIView animateWithDuration:.20
                         animations:^
         {
             [self layoutMenuViewController];
         } completion:^(BOOL finished) {
             
             // Call didMoveToParentViewController to complete the
             // child view controller steps
             [self.menuController didMoveToParentViewController:self];
             
             // Reset user interaction
             self.view.window.userInteractionEnabled = YES;
             
         }];
    } else {
        // Create the frame for playslistViewController view
        CGRect playslistViewControllerViewFrame   = self.view.bounds;
        playslistViewControllerViewFrame.origin.y = -playslistViewControllerViewFrame.size.height;
        
        // Animate playslistViewController view changes
        [UIView animateWithDuration:.20
                         animations:^
         {
             
             // Set the frame
             self.menuController.view.frame = playslistViewControllerViewFrame;
             
         } completion:^(BOOL finished) {
             
             // Remove the subview
             [self.menuController.view removeFromSuperview];
             
             self.menuController = nil;
             
             // Reset user interaction
             self.view.window.userInteractionEnabled = YES;
             
         }];
    }

}

- (void)layoutMenuViewController
{
    // View layout setup
    CGRect viewBounds = self.view.bounds;
    
    // playslistViewController view layout
    CGRect menuViewControllerViewFrame;
    CGFloat navBarHeight = self.navigationController.navigationBar.frame.size.height;
    menuViewControllerViewFrame.size   = CGSizeMake(viewBounds.size.width, (viewBounds.size.height - navBarHeight));
    menuViewControllerViewFrame.origin = CGPointMake(0.0, navBarHeight);
    
    // Set playslistViewControllerView frame
    self.menuController.view.frame = menuViewControllerViewFrame;
}

- (void)refreshData
{
    Scale *scale = [[GuitarStore sharedStore] selectedScale];
    self.title = scale.title;
    if (!self.selectedDegrees) {
        self.selectedDegrees = [scale.selectedDegrees mutableCopy];
    }

    NSMutableArray *positions = [[GuitarStore sharedStore] positions];
    for (Position *pos in positions) {
        
        NSInteger positionID = pos.identifier;
        StringView *stringView = [self stringViewForPositionID:positionID];
        stringView.position = pos;
        stringView.selectedDegrees = self.selectedDegrees;
        if (!self.selectedStringView) {
            self.selectedStringView = stringView;
            stringView.backgroundColor = [UIColor GuitarLightBlue];
        }
        [stringView setNeedsDisplay];
    }
    
    self.positionLabel.text = self.selectedStringView.position.title;
    self.mainStringView.isMainView = YES;
    self.mainStringView.position = self.selectedStringView.position;
    self.mainStringView.selectedDegrees = self.selectedDegrees;
    [self.mainStringView setNeedsDisplay];


}

- (void)resetButtonView
{
    self.degreeView.selectedDegrees = self.selectedDegrees;
    self.degreeView.delegate = self;
    [self.degreeView setNeedsDisplay];
}

- (void)viewTapped:(id)sender
{
    UITapGestureRecognizer *tapRec = (UITapGestureRecognizer *) sender;
    self.selectedStringView.backgroundColor = [UIColor clearColor];
    
    StringView *stringView = (StringView *) tapRec.view;
    self.selectedStringView = stringView;

    stringView.backgroundColor = [UIColor GuitarLightBlue];
    self.mainStringView.position = stringView.position;
    self.mainStringView.selectedDegrees = stringView.selectedDegrees;
    [self.mainStringView setNeedsDisplay];
    
    self.positionLabel.text = stringView.position.title;

}

- (StringView *)stringViewForPositionID:(NSInteger)positionID
{
    switch (positionID) {
        case 0:
            return self.bottomLeftStringView;
            break;
        case 1:
            return self.bottomRightStringView;
            break;
        case 2:
            return self.middleLeftStringView;
            break;
        case 3:
            return self.middleRightStringView;
            break;
        case 4:
            return self.topLeftStringView;
            break;
        case 5:
            return self.topRightStringView;
            break;
        default:
            return nil;
            break;
    }
}

- (void)selectedDegreesModified:(NSMutableArray *)degrees
{
    self.selectedDegrees = degrees;
    [self refreshData];
    
    
    // test if new selection matches other scale
    dispatch_async(dispatch_get_main_queue(), ^{
        NSMutableArray *scales = [[GuitarStore sharedStore] scales];
        for (Scale *scale in scales) {
            self.title = @"";
            [[GuitarStore sharedStore] setSelectedScale:nil];

            if ([self.selectedDegrees equalDegrees:scale.selectedDegrees]) {
                self.title = scale.title;
                [[GuitarStore sharedStore] setSelectedScale:scale];
                break;
            }
        }
        
    });
}

- (void)didSelectScale:(Scale *)scale
{
    NSLog(@"selected scale");
    [self handleLeftBarButtonTap:nil];
    self.selectedDegrees = [scale.selectedDegrees mutableCopy];
    [self refreshData];
    [self resetButtonView];
}



@end
