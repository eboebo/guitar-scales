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
#import "TutorialViewController.h"

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
@property (nonatomic, assign) Position   *currentPosition;
@property (weak, nonatomic  ) IBOutlet UILabel    *positionLabel;

@property (weak, nonatomic) IBOutlet UILabel *leftStringLabel;
@property (weak, nonatomic) IBOutlet UILabel *leftIndexLabel;
@property (weak, nonatomic) IBOutlet UILabel *leftMiddleLabel;
@property (weak, nonatomic) IBOutlet UILabel *leftBottomLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightStringLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightIndexLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightMiddleLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightBottonLabel;

@property (nonatomic, strong) MenuTableViewController *menuController;
@property (nonatomic, strong) TutorialViewController  *tutorialController;

@property (nonatomic) BOOL fadeTutorial;


@end

@implementation ScalesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    self.view.backgroundColor                            = [UIColor GuitarCream];
    self.navigationController.navigationBar.barTintColor = [UIColor GuitarBlue];
    

    self.navigationController.navigationBar.tintColor    = [UIColor GuitarCream];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor GuitarCream], NSForegroundColorAttributeName,[UIFont blackoutFontWithSize:22.0f], NSFontAttributeName, nil]];
    [self.navigationController.navigationBar setTitleVerticalPositionAdjustment:(5.0) forBarMetrics:UIBarMetricsDefault];



    self.currentPosition = 0;
    
    self.title = @"Scales";

    self.leftStringLabel.font  = [UIFont ProletarskFontWithSize:14.0f];
    self.leftIndexLabel.font   = [UIFont ProletarskFontWithSize:10.0f];
    self.leftMiddleLabel.font  = [UIFont ProletarskFontWithSize:10.0f];
    self.leftBottomLabel.font  = [UIFont ProletarskFontWithSize:10.0f];
    self.rightStringLabel.font = [UIFont ProletarskFontWithSize:14.0f];
    self.rightIndexLabel.font  = [UIFont ProletarskFontWithSize:10.0f];
    self.rightMiddleLabel.font = [UIFont ProletarskFontWithSize:10.0f];
    self.rightBottonLabel.font = [UIFont ProletarskFontWithSize:10.0f];

    
    UIBarButtonItem *leftBarButtonItem
    = [[UIBarButtonItem alloc] initWithTitle:@"Menu"
                                       style:UIBarButtonItemStylePlain
                                      target:self
                                      action:@selector(handleLeftBarButtonTap:)];
    [leftBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                           [UIFont blackoutFontWithSize:16.0], NSFontAttributeName,
                                           nil]
                                 forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
    UIBarButtonItem *rightBarButtonItem
    = [[UIBarButtonItem alloc] initWithTitle:@"Help"
                                       style:UIBarButtonItemStylePlain
                                      target:self
                                      action:@selector(handleRightBarButtonTap:)];
    [rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                           [UIFont blackoutFontWithSize:16.0], NSFontAttributeName,
                                           nil]
                                 forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
    UITapGestureRecognizer *topRightviewTapped
    = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    [self.topRightStringView addGestureRecognizer:topRightviewTapped];
    self.topRightStringView.stringViewType = StringViewTypeIndex;
    
    UITapGestureRecognizer *topLeftviewTapped
    = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    [self.topLeftStringView addGestureRecognizer:topLeftviewTapped];
    self.topLeftStringView.stringViewType = StringViewTypeIndex;

    
    UITapGestureRecognizer *middleRightViewTapped
    = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    [self.middleRightStringView addGestureRecognizer:middleRightViewTapped];
    self.middleRightStringView.stringViewType = StringViewTypeMiddle;

    
    UITapGestureRecognizer *middleLeftViewTapped
    = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    [self.middleLeftStringView addGestureRecognizer:middleLeftViewTapped];
    self.middleLeftStringView.stringViewType = StringViewTypeMiddle;

    
    UITapGestureRecognizer *bottomLeftViewTapped
    = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    [self.bottomLeftStringView addGestureRecognizer:bottomLeftViewTapped];
    self.bottomLeftStringView.stringViewType = StringViewTypePinky;

    
     UITapGestureRecognizer *bottomRightViewTapped
    = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    [self.bottomRightStringView addGestureRecognizer:bottomRightViewTapped];
    self.bottomRightStringView.stringViewType = StringViewTypePinky;
    
    if (![[GuitarStore sharedStore] displayedTutorial]) {
        self.fadeTutorial = YES;
        [self handleRightBarButtonTap:nil];
        [[GuitarStore sharedStore] setDisplayedTutorial];
    }
    
    [[GuitarStore sharedStore] setCallback:^(BOOL success) {
        if (success) {
            [self refreshData];
            [self resetButtonView];
        }
    }];
    
    [[GuitarStore sharedStore] parseData];
    

}

- (void)handleLeftBarButtonTap:(id)sender
{
    if (!self.menuController) {
        [self.navigationItem.rightBarButtonItem setEnabled:NO];
        
        self.menuController = [[MenuTableViewController alloc] initWithStyle:UITableViewStylePlain];
        self.menuController.delegate = self;
        // Initialize the view controller and set any properties
        
        // Set the frame of playslistViewController view
        CGRect scalesViewControllerViewFrame      = self.view.bounds;
        scalesViewControllerViewFrame.origin.y    -= scalesViewControllerViewFrame.size.height;
        scalesViewControllerViewFrame.size.height -= self.degreeView.frame.size.height;
        
        self.menuController.view.frame           = scalesViewControllerViewFrame;
        self.menuController.view.backgroundColor = [UIColor GuitarBlue];
        
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
        [self.navigationItem.rightBarButtonItem setEnabled:YES];

        // Create the frame for playslistViewController view
        CGRect scalesViewControllerViewFrame   = self.view.bounds;
        scalesViewControllerViewFrame.origin.y = -scalesViewControllerViewFrame.size.height;
        
        // Animate playslistViewController view changes
        [UIView animateWithDuration:.20
                         animations:^
         {
             
             // Set the frame
             self.menuController.view.frame = scalesViewControllerViewFrame;
             
         } completion:^(BOOL finished) {
             
             // Remove the subview
             [self.menuController.view removeFromSuperview];
             
             self.menuController = nil;
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
    menuViewControllerViewFrame.size   = CGSizeMake(viewBounds.size.width, (viewBounds.size.height - navBarHeight - self.degreeView.frame.size.height));
    menuViewControllerViewFrame.origin = CGPointMake(0.0, navBarHeight);
    
    // Set playslistViewControllerView frame
    self.menuController.view.frame = menuViewControllerViewFrame;
}

- (void)handleRightBarButtonTap:(id)sender
{
    if (!self.tutorialController) {

        self.tutorialController = [[TutorialViewController alloc] init];
        // Initialize the view controller and set any properties

        //self.tutorialController.view.frame = scalesViewControllerViewFrame;
        self.tutorialController.view.backgroundColor = [UIColor GuitarCream];
    }
    
    
    [self presentViewController:self.tutorialController animated:[[GuitarStore sharedStore] displayedTutorial] completion:nil];
}

- (void)layoutTutorialViewController
{
    // View layout setup
    CGRect viewBounds = self.view.bounds;
    
    // playslistViewController view layout
    CGRect tutorialViewControllerViewFrame;
    CGFloat navBarHeight = self.navigationController.navigationBar.frame.size.height;
    tutorialViewControllerViewFrame.size   = CGSizeMake(viewBounds.size.width, (viewBounds.size.height - navBarHeight));
    tutorialViewControllerViewFrame.origin = CGPointMake(0.0, navBarHeight);
    
    // Set playslistViewControllerView frame
    self.tutorialController.view.frame = tutorialViewControllerViewFrame;
}

- (void)refreshData
{
    Scale *scale = [[GuitarStore sharedStore] selectedScale];
    
    [self refreshTitle];
    
    if (!self.selectedDegrees) {
        self.selectedDegrees = [scale.selectedDegrees mutableCopy];
    }

    NSMutableArray *positions = [[GuitarStore sharedStore] positions];
    for (Position *pos in positions) {
        
        NSInteger positionID = pos.identifier;
        StringView *stringView = [self stringViewForPositionID:positionID];
        UILabel *positionabel = [self positionLabelForPositionID:positionID];
        stringView.position = pos;
        stringView.selectedDegrees = self.selectedDegrees;
        if (!self.selectedStringView && stringView.position.identifier == 4) {
            self.selectedStringView = stringView;
            stringView.alpha = 1;
            positionabel.alpha = 1;
        } else if (stringView == self.selectedStringView) {
            stringView.alpha = 1;
            positionabel.alpha = 1;
        }else {
            stringView.alpha = 0.3;
            positionabel.alpha = 0.3;
        }
        [positionabel setNeedsDisplay];
        [stringView setNeedsDisplay];
    }
    
    [self setSubHeaderText:self.selectedStringView.position.title];

    self.mainStringView.isMainView = YES;
    self.mainStringView.position = self.selectedStringView.position;
    self.mainStringView.stringViewType = self.selectedStringView.stringViewType;
    self.mainStringView.selectedDegrees = self.selectedDegrees;
    [self.mainStringView setNeedsDisplay];

}

- (void)refreshTitle
{
    Scale *scale = [[GuitarStore sharedStore] selectedScale];
    NSString *titleText;
    if (scale) {
        titleText = scale.title;
    } else {
        titleText = @"";
    }
    

    
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:titleText];
    [title addAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor GuitarCream], NSForegroundColorAttributeName,[UIFont blackoutFontWithSize:24.0f], NSFontAttributeName, nil] range:NSMakeRange(0, title.length)];
    NSMutableParagraphStyle *paragraphStyle = NSMutableParagraphStyle.new;
    paragraphStyle.alignment                = NSTextAlignmentCenter;
    [title addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, title.length)];
 
    UIView * customTitleView = [[UIView alloc] initWithFrame:CGRectZero];

    UILabel *label = [[UILabel alloc] initWithFrame:customTitleView.frame];
    label.attributedText = title;
    [label sizeToFit];
    [customTitleView addSubview:label];
    customTitleView.frame = label.frame;
    
    [self.navigationItem setTitleView:customTitleView];
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
    self.selectedStringView.alpha = 0.3;
    UILabel *positionLabel = [self positionLabelForPositionID:self.selectedStringView.position.identifier];
    positionLabel.alpha = 0.3;
    
    StringView *stringView = (StringView *) tapRec.view;
    self.selectedStringView = stringView;
    stringView.alpha = 1;
    
    positionLabel = [self positionLabelForPositionID:stringView.position.identifier];
    positionLabel.alpha = 1;
    
    self.mainStringView.stringViewType = stringView.stringViewType;
    self.mainStringView.position = stringView.position;
    self.mainStringView.selectedDegrees = stringView.selectedDegrees;
    [self.mainStringView setNeedsDisplay];
    [self setSubHeaderText:stringView.position.title];
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

- (UILabel *)positionLabelForPositionID:(NSInteger)positionID
{
    switch (positionID) {
        case 0:
            return self.leftBottomLabel;
            break;
        case 1:
            return self.rightBottonLabel;
            break;
        case 2:
            return self.leftMiddleLabel;
            break;
        case 3:
            return self.rightMiddleLabel;
            break;
        case 4:
            return self.leftIndexLabel;
            break;
        case 5:
            return self.rightIndexLabel;
            break;
        default:
            return nil;
            break;
    }
}

- (void)selectedDegreesModified:(NSMutableArray *)degrees
{
    self.selectedDegrees = degrees;
    [[GuitarStore sharedStore] setSelectedScale:nil];
    [self refreshData];
    
    // test if new selection matches other scale
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSArray *scaleArray = [[GuitarStore sharedStore] scales2DArray];
        for (NSArray *scales in scaleArray) {
            for (Scale *scale in scales) {
                if ([self.selectedDegrees equalDegrees:scale.selectedDegrees]) {
                    [[GuitarStore sharedStore] setSelectedScale:scale];
                    [self refreshTitle];
                    break;
                }
            }
        }
    });
}

- (void)didSelectScale:(Scale *)scale
{
    self.selectedDegrees = [scale.selectedDegrees mutableCopy];
    
    [self refreshData];
    [self resetButtonView];
}

- (void)setSubHeaderText:(NSString *)text
{
    
    CGFloat fontSize = 21.0f;
    CGRect bounds = [[UIScreen mainScreen] bounds];
    if (bounds.size.width < 568.0) {
        fontSize = 12.0f;
    }
    NSMutableAttributedString *attributedString;
    attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    [attributedString addAttribute:NSKernAttributeName
                             value:@4.5
                             range:NSMakeRange(0, text.length)];
    [attributedString addAttribute:NSFontAttributeName
                             value:[UIFont ProletarskFontWithSize:fontSize]
                             range:NSMakeRange(0, text.length)];
    NSMutableParagraphStyle *paragraphStyle = NSMutableParagraphStyle.new;
    paragraphStyle.alignment                = NSTextAlignmentCenter;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, text.length)];
    
    
    NSShadow *shadowDic=[[NSShadow alloc] init];
  [shadowDic setShadowColor: [UIColor blackColor]];
    [shadowDic setShadowOffset:CGSizeMake(.4, .5)];
    [attributedString addAttribute:NSShadowAttributeName
                         value:shadowDic
                         range:NSMakeRange(0, attributedString.length)];
    
    NSShadow *shadowDic2=[[NSShadow alloc] init];
    [shadowDic2 setShadowColor: [UIColor darkGrayColor]];
    [shadowDic2 setShadowOffset:CGSizeMake(.6, .6)];
    [attributedString addAttribute:NSShadowAttributeName
                             value:shadowDic2
                             range:NSMakeRange(0, attributedString.length)];
    
    [self.positionLabel setAttributedText:attributedString];
}



@end
