//
//  ScalesViewController.m
//  Guitar Scales Interactive
//
//  Created by Elena Boyd on 8/12/14.
//
//

#import "ScalesViewController.h"
#import "StringView.h"
#import "FullStringView.h"
#import "Scale.h"
#import "DegreeView.h"
#import "GuitarStore.h"
#import "MenuTableViewController.h"
#import "ArrowButton.h"
#import "TutorialViewController.h"

@interface ScalesViewController ()
<DegreeViewDelegate,
 MenuDelegate,
 UIAlertViewDelegate
>

@property (nonatomic, strong) StringView *selectedStringView;
@property (nonatomic, assign) NSInteger currentPosition;

@property (nonatomic, strong) MenuTableViewController *menuController;


@property (strong, nonatomic) DegreeView *degreeView;
@property (strong, nonatomic) StringView *mainStringView;

@property (strong, nonatomic) ArrowButton *leftArrowButton;
@property (strong, nonatomic) ArrowButton *rightArrowButton;


@property (strong, nonatomic) FullStringView *fullStringView;



@property (strong, nonatomic ) UILabel    *positionLabel;







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
    
    self.degreeView = [[DegreeView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.degreeView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didChangeDisplay:) name:@"DisplayChange" object:nil];
                                
                                
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
        fontSize = 22.0; // original 19.0
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
    = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"dots"]
                                       style:UIBarButtonItemStylePlain
                                      target:self
                                      action:@selector(handleRightBarButtonTap:)];

    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

- (void)setUpLabels
{
    
    self.positionLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.positionLabel setText:@"POSITION"];
    [self.view addSubview:self.positionLabel];
    
}

- (void)setUpStringViews
{
    
    self.rightArrowButton = [[ArrowButton alloc] initWithFrame:CGRectZero andType:ArrowButtonTypeRight];
    [self.rightArrowButton addTarget:self action:@selector(handlePositionRight:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.rightArrowButton];
    
    self.leftArrowButton = [[ArrowButton alloc] initWithFrame:CGRectZero andType:ArrowButtonTypeLeft];
    [self.leftArrowButton addTarget:self action:@selector(handlePositionLeft:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.leftArrowButton];
    
    self.mainStringView = [[StringView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.mainStringView];
    
    self.fullStringView = [[FullStringView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.fullStringView];

}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    [self layoutDegreeView];
    [self layoutMainStringView];
    [self layoutFullStringView];

}

- (void)layoutDegreeView
{
    CGFloat height           = self.view.frame.size.height;
//    CGFloat y                = height * 0.85;
//    CGFloat degreeViewHeight = height - y;
    
    CGFloat y                = height * 0.895;  // original 0.92
    CGFloat degreeViewHeight = height - y;
    self.degreeView.frame    = CGRectMake(0, y, self.view.frame.size.width, degreeViewHeight);

}

- (void)layoutMainStringView
{
    CGRect bounds = [[UIScreen mainScreen] bounds];
    
    CGFloat width             = self.view.frame.size.width;
    CGFloat height            = self.view.frame.size.height;

    CGFloat stringViewWidth   = width * 0.5;
    CGFloat stringViewHeight  = height * 0.45;

    CGFloat x                 = (width - stringViewWidth ) / 2.0;
    CGFloat y                 = 96.0;  // original 58.0
    
//    if (bounds.size.width > 667.0) {
//        stringViewHeight += 4.0;                           // iPhone 6 Plus
//        
//    }
//
    CGRect frame              = CGRectMake(x, y, stringViewWidth, stringViewHeight);
    self.mainStringView.frame = frame;
//
//    if (bounds.size.width > 667.0) {
//         x -= 7; y -= 40; stringViewWidth += 20;                           // iPhone 6 Plus
//
//    }
//    else if (bounds.size.width < 667.0) {                                    // iPhone 5, 4
//        x -= 7; y -= 35; stringViewWidth += 20;
//    }
//    
//    else {
//         x -= 7; y -= 38; stringViewWidth += 20;                             // iPhone 6
//    }
    
    self.positionLabel.frame = CGRectMake(x, 30.0, stringViewWidth, 38);
    
    
    CGFloat buttonHeight = stringViewHeight * 0.6;  // original (2.0/3.0)
    CGFloat buttonWidth  = width * 0.09;  // original 0.1
    
    CGFloat oneEight = width * (1.0 / 8.0);
    CGFloat buttonOffset = oneEight - (buttonWidth / 2.0);
    
    CGFloat buttonY = y + stringViewHeight * 0.09;   // original (1.0/8.0)
    self.leftArrowButton.frame = CGRectMake(buttonOffset, buttonY, buttonWidth, buttonHeight);
    
    CGFloat rightButtonX = x + stringViewWidth + buttonOffset;
    self.rightArrowButton.frame = CGRectMake(rightButtonX, buttonY, buttonWidth, buttonHeight);

    

}

- (void)layoutFullStringView
{
    
    CGFloat width             = self.view.frame.size.width;
    CGFloat height            = self.view.frame.size.height;
    
    CGFloat stringViewWidth   = width * 0.875; // original .75
    CGFloat stringViewHeight  = height * 0.3;
    
    CGFloat x                 = width * (1.0/16.0); // original 1.0/8.0
    CGFloat y                 = height * .25;
    y = 78.0 + self.mainStringView.frame.size.height;  // original 90.0
    
    CGRect frame              = CGRectMake(x, y, stringViewWidth, stringViewHeight);
    self.fullStringView.frame = frame;
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
    [self.delegate didSelectRightButton];
}

- (void)refreshData
{
    Scale *scale = [[GuitarStore sharedStore] selectedScale];
    
    [self refreshTitle];
    
    if (!self.selectedDegrees) {
        self.selectedDegrees = [scale.selectedDegrees mutableCopy];
    }

    self.positions = [[GuitarStore sharedStore] positions];
//    for (Position *pos in positions) {
//        
//        NSInteger positionID = pos.identifier;
////        StringView *stringView = [self stringViewForPositionID:positionID];
////        UILabel *positionabel = [self positionLabelForPositionID:positionID];
////        stringView.position = pos;
////        stringView.selectedDegrees = self.selectedDegrees;
//        if (!self.selectedStringView && stringView.position.identifier == 4) {
//            self.selectedStringView = stringView;
//            stringView.alpha = .8;
//            positionabel.alpha = .8;
//        } else if (stringView == self.selectedStringView) {
//            stringView.alpha = .8;
//            positionabel.alpha = .8;
//        }else {
//            stringView.alpha = 0.3;
//            positionabel.alpha = 0.3;
//        }
//        [positionabel setNeedsDisplay];
//        [stringView setNeedsDisplay];
//    }
//    

    self.mainStringView.isMainView = YES;
   
    // TODO // HANDLE THIS
//    self.mainStringView.stringViewType = self.selectedStringView.stringViewType;
    self.mainStringView.selectedDegrees = self.selectedDegrees;
    self.fullStringView.selectedDegrees = self.selectedDegrees;
    
    [self updateStringViewPositions];
    

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
    
    CGFloat titleSize = 30.0f; // original 30.0f
    CGRect bounds = [[UIScreen mainScreen] bounds];
    if (bounds.size.width > 700.0) {
        titleSize = 44.0f;  // original 40.0f
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
    [self.degreeView resetClearButton];
    [self.degreeView setNeedsDisplay];
}

- (void)viewTapped:(id)sender
{
//    UITapGestureRecognizer *tapRec = (UITapGestureRecognizer *) sender;
//    
//    self.selectedStringView.backgroundColor = [UIColor clearColor];
//    self.selectedStringView.alpha = 0.3;
//    UILabel *positionLabel = [self positionLabelForPositionID:self.selectedStringView.position.identifier];
//    positionLabel.alpha = 0.3;
//    
//    StringView *stringView = (StringView *) tapRec.view;
//    self.selectedStringView = stringView;
//    stringView.alpha = .8;
//    
//    positionLabel = [self positionLabelForPositionID:stringView.position.identifier];
//    positionLabel.alpha = .8;
//    
//    self.mainStringView.stringViewType = stringView.stringViewType;
//    self.mainStringView.position = stringView.position;
//    self.mainStringView.selectedDegrees = stringView.selectedDegrees;
//    [self.mainStringView setNeedsDisplay];
//    [self setSubHeaderText:stringView.position.title];
}


- (void)handlePositionLeft:(id)sender
{
    if (self.currentPosition > 0) {
        self.currentPosition--;
    }
    else {
        self.currentPosition = 6;
    }
    [self updateStringViewPositions];
}

- (void)handlePositionRight:(id)sender
{
    if (self.currentPosition < self.positions.count - 1) {
        self.currentPosition++;
    }
    else {
        self.currentPosition = 0;
    }
    [self updateStringViewPositions];
}

- (void)updateStringViewPositions
{
    if (self.positions.count > 0) {
        self.mainStringView.position = self.positions[self.currentPosition];
        self.fullStringView.position = self.positions[self.currentPosition];
        
        [self setSubHeaderText:self.mainStringView.position.title];

        
    }
    [self.mainStringView setNeedsDisplay];
    [self.fullStringView setNeedsDisplay];
}

- (void)updateArrowColor
{
    
}

#pragma mark DegreeViewDelegate

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
    
    CGFloat fontSize = 32.0f;   // original 26.0f                                // iPhone 6
    CGRect bounds = [[UIScreen mainScreen] bounds];
    if (bounds.size.width < 568.0) {                                            // iPhone 4
        fontSize = 25.0f;   // original 20.0f
    }
    else if (bounds.size.width > 667.0) {                                       // iPhone 6 Plus
        fontSize = 33.0f; // original 27.0f
    }
    else if (bounds.size.width < 667.0) {                                       // iPhone 5
        fontSize = 26.0f;  // original 21.0f
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
                                     value:@9.0 // original 6.7
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

#pragma mark Notifications

- (void)didChangeDisplay:(id)sender
{
    [self refreshData];
}

@end
