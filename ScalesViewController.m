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
 MenuDelegate,
 UIAlertViewDelegate
>

@property (nonatomic, strong) StringView *selectedStringView;
@property (nonatomic, assign) Position   *currentPosition;

@property (nonatomic, strong) MenuTableViewController *menuController;
@property (nonatomic, strong) TutorialViewController  *tutorialController;

@property (nonatomic) BOOL fadeTutorial;

@property (strong, nonatomic) DegreeView *degreeView;
@property (strong, nonatomic) StringView *mainStringView;
@property (strong, nonatomic) StringView *topLeftStringView;
@property (strong, nonatomic) StringView *middleLeftStringView;
@property (strong, nonatomic) StringView *bottomLeftStringView;
@property (strong, nonatomic) StringView *topRightStringView;
@property (strong, nonatomic) StringView *middleRightStringView;
@property (strong, nonatomic) StringView *bottomRightStringView;

@property (strong, nonatomic ) UILabel    *positionLabel;

@property (strong, nonatomic) UILabel *leftStringLabel;
@property (strong, nonatomic) UILabel *leftIndexLabel;
@property (strong, nonatomic) UILabel *leftMiddleLabel;
@property (strong, nonatomic) UILabel *leftBottomLabel;

@property (strong, nonatomic) UILabel *rightStringLabel;
@property (strong, nonatomic) UILabel *rightIndexLabel;
@property (strong, nonatomic) UILabel *rightMiddleLabel;
@property (strong, nonatomic) UILabel *rightBottonLabel;

@end

@implementation ScalesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Parse Data
    [[GuitarStore sharedStore] setCallback:^(BOOL success) {
        if (success) {
            [self refreshData];
            [self resetButtonView];
        }
    }];
    
    [[GuitarStore sharedStore] parseData];
    
    self.view.backgroundColor = [UIColor GuitarCream];
    
    self.currentPosition = 0;
    
    [self setUpNavigationBar];
    [self setUpLabels];
    [self setUpStringViews];
    [self setUpTutorial];
    
    self.degreeView = [[DegreeView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.degreeView];
}

- (void)setUpNavigationBar
{
    
    self.navigationController.navigationBar.barTintColor = [UIColor GuitarBlue];
    [self.navigationController.navigationBar setTranslucent:NO];
    
    CGFloat titleAdjust = 5.0f;                                     // iPhone 6, 5, 4
    CGFloat titleSize = 30.0f;
    CGRect bounds = [[UIScreen mainScreen] bounds];
    if (bounds.size.width > 667.0) {                                // iPhone 6 Plus
        titleAdjust = 1.0;
        titleSize = 40.0f;
    }
    
    self.navigationController.navigationBar.tintColor    = [UIColor GuitarCream];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor GuitarCream], NSForegroundColorAttributeName,[UIFont blackoutFontWithSize:titleSize], NSFontAttributeName, nil]];
    [self.navigationController.navigationBar setTitleVerticalPositionAdjustment:(titleAdjust) forBarMetrics:UIBarMetricsDefault];
    
    CGFloat fontSize = 18.0f;                                                   // iPhone 6
    if (bounds.size.width < 568.0) {                                            // iPhone 4
        fontSize = 16.0;
    }
    else if (bounds.size.width > 667.0) {                                       // iPhone 6 Plus
        fontSize = 19.0;
    }
    else if (bounds.size.width < 667.0) {                                       // iPhone 5
        fontSize = 16.0;
    }
    
    UIBarButtonItem *leftBarButtonItem
    = [[UIBarButtonItem alloc] initWithTitle:@"Menu"
                                       style:UIBarButtonItemStylePlain
                                      target:self
                                      action:@selector(handleLeftBarButtonTap:)];
    [leftBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                               [UIFont blackoutFontWithSize:fontSize], NSFontAttributeName,
                                               nil]
                                     forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
    UIBarButtonItem *rightBarButtonItem
    = [[UIBarButtonItem alloc] initWithTitle:@"Help"
                                       style:UIBarButtonItemStylePlain
                                      target:self
                                      action:@selector(handleRightBarButtonTap:)];
    [rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                [UIFont blackoutFontWithSize:fontSize], NSFontAttributeName,
                                                nil]
                                      forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

- (void)setUpLabels
{
    
    self.positionLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.positionLabel setText:@"POSITION"];
    [self.view addSubview:self.positionLabel];
    
    CGRect bounds = self.view.bounds;
    CGFloat stringFont = 16.0f;                                                 // iPhone 6
    CGFloat fingerFont = 12.0f;
    if (bounds.size.width < 568.0) {                                            // iPhone 4
        stringFont = 14.0;
        fingerFont = 11.0;
    }
    else if (bounds.size.width > 667.0) {                                       // iPhone 6 Plus
        stringFont = 18.0;
        fingerFont = 13.0;
    }
    else if (bounds.size.width < 667.0) {                                       // iPhone 5
        stringFont = 14.0;
        fingerFont = 11.0;
    }
    
    self.leftStringLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.leftStringLabel setText:@"6TH STRING"];
    self.leftStringLabel.font  = [UIFont ProletarskFontWithSize:stringFont];
    self.leftStringLabel.textAlignment = NSTextAlignmentCenter;
    self.leftStringLabel.alpha = .5;
    [self.view addSubview:self.leftStringLabel];
    
    self.leftIndexLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.leftIndexLabel setText:@"INDEX"];
    self.leftIndexLabel.textAlignment = NSTextAlignmentCenter;
    self.leftIndexLabel.font   = [UIFont ProletarskFontWithSize:fingerFont];
    [self.view addSubview:self.leftIndexLabel];
    
    self.leftMiddleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.leftMiddleLabel setText:@"MIDDLE"];
    self.leftMiddleLabel.textAlignment = NSTextAlignmentCenter;
    self.leftMiddleLabel.font   = [UIFont ProletarskFontWithSize:fingerFont];
    [self.view addSubview:self.leftMiddleLabel];
    
    self.leftBottomLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.leftBottomLabel setText:@"PINKY"];
    self.leftBottomLabel.textAlignment = NSTextAlignmentCenter;
    self.leftBottomLabel.font   = [UIFont ProletarskFontWithSize:fingerFont];
    [self.view addSubview:self.leftBottomLabel];
    
    self.rightStringLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.rightStringLabel setText:@"5TH STRING"];
    self.rightStringLabel.font  = [UIFont ProletarskFontWithSize:stringFont];
    self.rightStringLabel.textAlignment = NSTextAlignmentCenter;
    self.rightStringLabel.alpha = .5;
    [self.view addSubview:self.rightStringLabel];
    
    self.rightIndexLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.rightIndexLabel setText:@"INDEX"];
    self.rightIndexLabel.textAlignment = NSTextAlignmentCenter;
    self.rightIndexLabel.font   = [UIFont ProletarskFontWithSize:fingerFont];
    [self.view addSubview:self.rightIndexLabel];
    
    self.rightMiddleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.rightMiddleLabel setText:@"MIDDLE"];
    self.rightMiddleLabel.textAlignment = NSTextAlignmentCenter;
    self.rightMiddleLabel.font   = [UIFont ProletarskFontWithSize:fingerFont];
    [self.view addSubview:self.rightMiddleLabel];
    
    self.rightBottonLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.rightBottonLabel setText:@"PINKY"];
    self.rightBottonLabel.textAlignment = NSTextAlignmentCenter;
    self.rightBottonLabel.font   = [UIFont ProletarskFontWithSize:fingerFont];
    [self.view addSubview:self.rightBottonLabel];
}

- (void)setUpStringViews
{
    
    self.mainStringView = [[StringView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.mainStringView];
    
    self.topLeftStringView = [[StringView alloc] initWithFrame:CGRectZero];
    UITapGestureRecognizer *topLeftviewTapped
    = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    [self.topLeftStringView addGestureRecognizer:topLeftviewTapped];
    self.topLeftStringView.stringViewType = StringViewTypeIndex;
    [self.view addSubview:self.topLeftStringView];
    
    self.middleLeftStringView = [[StringView alloc] initWithFrame:CGRectZero];
    UITapGestureRecognizer *middleLeftViewTapped
    = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    [self.middleLeftStringView addGestureRecognizer:middleLeftViewTapped];
    self.middleLeftStringView.stringViewType = StringViewTypeMiddle;
    [self.view addSubview:self.middleLeftStringView];
    
    self.bottomLeftStringView = [[StringView alloc] initWithFrame:CGRectZero];
    UITapGestureRecognizer *bottomLeftViewTapped
    = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    [self.bottomLeftStringView addGestureRecognizer:bottomLeftViewTapped];
    self.bottomLeftStringView.stringViewType = StringViewTypePinky;
    [self.view addSubview:self.bottomLeftStringView];
    
    
    self.topRightStringView = [[StringView alloc] initWithFrame:CGRectZero];
    UITapGestureRecognizer *topRightviewTapped
    = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    [self.topRightStringView addGestureRecognizer:topRightviewTapped];
    self.topRightStringView.stringViewType = StringViewTypeIndex;
    [self.view addSubview:self.topRightStringView];
    
    
    self.middleRightStringView = [[StringView alloc] initWithFrame:CGRectZero];
    UITapGestureRecognizer *middleRightViewTapped
    = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    [self.middleRightStringView addGestureRecognizer:middleRightViewTapped];
    self.middleRightStringView.stringViewType = StringViewTypeMiddle;
    [self.view addSubview:self.middleRightStringView];
    
    self.bottomRightStringView = [[StringView alloc] initWithFrame:CGRectZero];
    UITapGestureRecognizer *bottomRightViewTapped
    = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    [self.bottomRightStringView addGestureRecognizer:bottomRightViewTapped];
    self.bottomRightStringView.stringViewType = StringViewTypePinky;
    [self.view addSubview:self.bottomRightStringView];
}

- (void)setUpTutorial
{
    if (![[GuitarStore sharedStore] displayedTutorial]) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Welcome!" message:@"Would you like to see the tutorial to get started?" delegate:self cancelButtonTitle:@"No Thanks" otherButtonTitles:@"OK", nil];
        
        [alert show];
    }
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    [self layoutDegreeView];
    [self layoutMainStringView];
    [self layoutLeftStringViews];
    [self layoutRightStringViews];

}

- (void)layoutDegreeView
{
    CGFloat height           = self.view.frame.size.height;
    CGFloat y                = height * 0.85;
    CGFloat degreeViewHeight = height - y;
    self.degreeView.frame    = CGRectMake(0, y, self.view.frame.size.width, degreeViewHeight);

}

- (void)layoutMainStringView
{
    CGRect bounds = [[UIScreen mainScreen] bounds];
    
    CGFloat width             = self.view.frame.size.width;
    CGFloat height            = self.view.frame.size.height;

    CGFloat stringViewWidth   = width / 1.9;
    CGFloat stringViewHeight  = height / 1.8;

    CGFloat x                 = (width - stringViewWidth ) / 2.0;
    CGFloat y                 = height * .2;
    
    if (bounds.size.width > 667.0) {
        stringViewHeight += 4.0;                           // iPhone 6 Plus
        
    }

    CGRect frame              = CGRectMake(x, y, stringViewWidth, stringViewHeight);
    self.mainStringView.frame = frame;
    
    if (bounds.size.width > 667.0) {
         x -= 7; y -= 40; stringViewWidth += 20;                           // iPhone 6 Plus

    }
    else if (bounds.size.width < 667.0) {                                    // iPhone 5, 4
        x -= 7; y -= 35; stringViewWidth += 20;
    }
    
    else {
         x -= 7; y -= 38; stringViewWidth += 20;                             // iPhone 6
    }
    
    self.positionLabel.frame = CGRectMake(x, y, stringViewWidth, 38);

}

- (void)layoutLeftStringViews
{
    CGFloat width           = self.view.frame.size.width;
    CGFloat height           = self.view.frame.size.height;
    CGFloat stringViewWidth   = width * 0.16;
    CGFloat stringViewHeight  = height * 0.17;
    
    CGFloat labelHeight = height * 0.04;
    CGFloat gap = height * 0.1;
    
    CGFloat x = 15.0;
    
    self.leftStringLabel.frame = CGRectMake(x, gap, stringViewWidth, labelHeight);
    
    CGFloat y = (gap * 1.2) + labelHeight;
    self.leftIndexLabel.frame = CGRectMake(x, y, stringViewWidth, labelHeight);

    y += labelHeight;
    self.topLeftStringView.frame = CGRectMake(x, y, stringViewWidth, stringViewHeight);
    
    y += stringViewHeight;
    self.leftMiddleLabel.frame = CGRectMake(x, y, stringViewWidth, labelHeight);
    y += labelHeight;
    self.middleLeftStringView.frame = CGRectMake(x, y, stringViewWidth, stringViewHeight);
    
    y += stringViewHeight;
    self.leftBottomLabel.frame = CGRectMake(x, y, stringViewWidth, labelHeight);
    y += labelHeight;
    self.bottomLeftStringView.frame = CGRectMake(x, y, stringViewWidth, stringViewHeight);
}

- (void)layoutRightStringViews
{
    CGFloat width           = self.view.frame.size.width;
    CGFloat height           = self.view.frame.size.height;
    CGFloat stringViewWidth   = width * 0.16;
    CGFloat stringViewHeight  = height * 0.17;
    
    CGFloat x = width - 15.0 - stringViewWidth;
    
    CGFloat labelHeight = height * 0.04;
    CGFloat gap = height * 0.1;
    
    self.rightStringLabel.frame = CGRectMake(x, gap, stringViewWidth, labelHeight);
    
    CGFloat y = (gap * 1.2) + labelHeight;
    self.rightIndexLabel.frame = CGRectMake(x, y, stringViewWidth, labelHeight);
    
    y += labelHeight;
    self.topRightStringView.frame = CGRectMake(x, y, stringViewWidth, stringViewHeight);
    
    y += stringViewHeight;
    self.rightMiddleLabel.frame = CGRectMake(x, y, stringViewWidth, labelHeight);
    y += labelHeight;
    self.middleRightStringView.frame = CGRectMake(x, y, stringViewWidth, stringViewHeight);
    
    y += stringViewHeight;
    self.rightBottonLabel.frame = CGRectMake(x, y, stringViewWidth, labelHeight);
    y += labelHeight;
    self.bottomRightStringView.frame = CGRectMake(x, y, stringViewWidth, stringViewHeight);
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
    menuViewControllerViewFrame.size   = CGSizeMake(viewBounds.size.width, (viewBounds.size.height - self.degreeView.frame.size.height));
    menuViewControllerViewFrame.origin = CGPointMake(0.0, 0.0);
    
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
    
    
    [self presentViewController:self.tutorialController animated:YES completion:nil];
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
            stringView.alpha = .8;
            positionabel.alpha = .8;
        } else if (stringView == self.selectedStringView) {
            stringView.alpha = .8;
            positionabel.alpha = .8;
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
    
    CGFloat titleSize = 30.0f;
    CGRect bounds = [[UIScreen mainScreen] bounds];
    if (bounds.size.width > 700.0) {
        titleSize = 40.0f;
    }

    

    
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:titleText];
    [title addAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor GuitarCream], NSForegroundColorAttributeName,[UIFont blackoutFontWithSize:titleSize], NSFontAttributeName, nil] range:NSMakeRange(0, title.length)];
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
    stringView.alpha = .8;
    
    positionLabel = [self positionLabelForPositionID:stringView.position.identifier];
    positionLabel.alpha = .8;
    
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
    
    CGFloat fontSize = 26.0f;                                                   // iPhone 6
    CGRect bounds = [[UIScreen mainScreen] bounds];
    if (bounds.size.width < 568.0) {                                            // iPhone 4
        fontSize = 20.0f;
    }
    else if (bounds.size.width > 667.0) {                                       // iPhone 6 Plus
        fontSize = 27.0f;
    }
    else if (bounds.size.width < 667.0) {                                       // iPhone 5
        fontSize = 21.0f;
    }
    NSMutableAttributedString *attributedString;
    attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    [attributedString addAttribute:NSKernAttributeName                          // iPhone 6, 5
                             value:@5.3
                             range:NSMakeRange(0, text.length)];
        if (bounds.size.width < 568.0) {                                        // iPhone 4
            [attributedString addAttribute:NSKernAttributeName
                                     value:@2.7
                                     range:NSMakeRange(0, text.length)];
        }
        if (bounds.size.width > 667.0) {                                        // iPhone 6 Plus
            [attributedString addAttribute:NSKernAttributeName
                                     value:@6.7
                                     range:NSMakeRange(0, text.length)];
        }

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

#pragma mark UIAlertView delegate

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [[GuitarStore sharedStore] setDisplayedTutorial];
    } else if (buttonIndex == 1) {
        self.fadeTutorial = YES;
        [self handleRightBarButtonTap:nil];
        [[GuitarStore sharedStore] setDisplayedTutorial];
    }
}

@end
