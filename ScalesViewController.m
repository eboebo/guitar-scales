//
//  ScalesViewController.m
//  Guitar Scales Interactive
//
//  Created by Elena Boyd on 8/12/14.
//
//

#import "ScalesViewController.h"
#import "StringView.h"
#import "GradientLineView.h"
#import "FullStringContainerView.h"

#import "FullStringView.h"
#import "Scale.h"
#import "DegreeView.h"
#import "GuitarStore.h"
#import "MenuTableViewController.h"
#import "ArrowButton.h"
#import "ArrowButtonZoom.h"
//#import "MetButton.h"
#import "TutorialViewController.h"

#import "QuartzCore/QuartzCore.h"

@interface ScalesViewController ()
<DegreeViewDelegate,
 MenuDelegate,
 UIAlertViewDelegate,
 FullStringContainerViewDelegate
>

@property (nonatomic, strong) StringView *selectedStringView;
@property (nonatomic, assign) NSInteger currentPosition;
@property (nonatomic, assign) NSInteger currentKey;
//@property (nonatomic, assign) BOOL metIsOn;

@property (nonatomic, strong) MenuTableViewController *menuController;

@property (strong, nonatomic) DegreeView *degreeView;
@property (strong, nonatomic) StringView *mainStringView;
@property (strong, nonatomic) GradientLineView *leftGradientLines;
@property (strong, nonatomic) GradientLineView *rightGradientLines;

@property (strong, nonatomic) ArrowButton *leftArrowButton;
@property (strong, nonatomic) ArrowButton *rightArrowButton;

@property (strong, nonatomic) ArrowButtonZoom *leftArrowButtonZoom;
@property (strong, nonatomic) ArrowButtonZoom *rightArrowButtonZoom;

//@property (strong, nonatomic) MetButton *metButton;

@property (strong, nonatomic) FullStringContainerView *fullStringView;

@property (strong, nonatomic ) UILabel    *positionLabel;
@property (strong, nonatomic ) UILabel    *keyLabel;

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
    
    self.currentPosition = 2;
    self.currentKey = 0;
//    self.metIsOn = false;
    
    [self setUpNavigationBar];
    [self setUpLabels];
    [self setUpStringViews];
    
    self.degreeView = [[DegreeView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.degreeView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didChangeDisplay:) name:@"DisplayChange" object:nil];
                                
                                
}

- (void)setUpNavigationBar
{    
    self.navigationController.navigationBar.barTintColor = [UIColor GuitarMain];
    [self.navigationController.navigationBar setTranslucent:NO];
    
    CGRect bounds = [[UIScreen mainScreen] bounds];

    CGFloat titleSize = bounds.size.width / 13.0; // sets the title size (refreshTitle below works)
    
    self.navigationController.navigationBar.tintColor    = [UIColor GuitarCream];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor GuitarCream], NSForegroundColorAttributeName,[UIFont blackoutFontWithSize:titleSize], NSFontAttributeName, nil]];
    
    CGFloat fontSize = bounds.size.width / 37.0;  // MENU button size
    
    UIBarButtonItem *leftBarButtonItem                      // ** try to move MENU button down slightly
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
    = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"dots"]       // ** try to make dots slightly bigger
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
    
    self.keyLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.keyLabel setText:@"KEY OF"];
    [self.view addSubview:self.keyLabel];
    
}

- (void)setUpStringViews        // only runs once
{
    
    self.rightArrowButton = [[ArrowButton alloc] initWithFrame:CGRectZero andType:ArrowButtonTypeRight];
    [self.rightArrowButton addTarget:self action:@selector(handlePositionRightKey:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.rightArrowButton];
    
    self.leftArrowButton = [[ArrowButton alloc] initWithFrame:CGRectZero andType:ArrowButtonTypeLeft];
    [self.leftArrowButton addTarget:self action:@selector(handlePositionLeftKey:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.leftArrowButton];
    
    self.rightArrowButtonZoom = [[ArrowButtonZoom alloc] initWithFrame:CGRectZero andType:ArrowButtonTypeRightZoom];
    [self.rightArrowButtonZoom addTarget:self action:@selector(handlePositionRight:) forControlEvents:UIControlEventTouchUpInside];
    self.rightArrowButtonZoom.layer.zPosition = 0;
    [self.view addSubview:self.rightArrowButtonZoom];
    
    self.leftArrowButtonZoom = [[ArrowButtonZoom alloc] initWithFrame:CGRectZero andType:ArrowButtonTypeLeftZoom];
    [self.leftArrowButtonZoom addTarget:self action:@selector(handlePositionLeft:) forControlEvents:UIControlEventTouchUpInside];
    self.leftArrowButtonZoom.layer.zPosition = 0;
    [self.view addSubview:self.leftArrowButtonZoom];
    
//    self.metButton = [[MetButton alloc] initWithFrame:CGRectZero];
//    [self.metButton addTarget:self action:@selector(toggleMet:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:self.metButton];
    
    self.mainStringView = [[StringView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.mainStringView];
    
    self.leftGradientLines = [[GradientLineView alloc] initWithFrame:CGRectZero andType:GradientLinesLeft];
    [self.leftGradientLines addTarget:self action:@selector(handlePositionLeft:) forControlEvents:UIControlEventTouchUpInside];
    self.leftGradientLines.layer.zPosition = -1;
    [self.view addSubview:self.leftGradientLines];
    
    self.rightGradientLines = [[GradientLineView alloc] initWithFrame:CGRectZero andType:GradientLinesRight];
    [self.rightGradientLines addTarget:self action:@selector(handlePositionRight:) forControlEvents:UIControlEventTouchUpInside];
    self.rightGradientLines.layer.zPosition = -1;
    [self.view addSubview:self.rightGradientLines];
    
    self.fullStringView = [[FullStringContainerView alloc] initWithFrame:CGRectZero];
    self.fullStringView.delegate = self;
    [self.view addSubview:self.fullStringView];
    
    if( [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone ) {
        self.fullStringView.hidden = true;
        self.fullStringView.alpha = 0;
        self.leftArrowButton.hidden = true;
        self.leftArrowButton.alpha = 0;
        self.rightArrowButton.hidden = true;
        self.rightArrowButton.alpha = 0;
        self.keyLabel.hidden = true;
        self.keyLabel.alpha = 0;
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(toggleViews:)]; // this adds the tap gesture to the zoomed in view
        [self.mainStringView addGestureRecognizer:singleTap];
//        
//        UITapGestureRecognizer *singleTap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(toggleViews:)];
//        [self.fullStringView addGestureRecognizer:singleTap2];
    }

}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    [self layoutDegreeView];
    [self layoutMainStringView];
    [self layoutFullStringView];
    
    CGRect bounds = [[UIScreen mainScreen] bounds];
    CGFloat positionLabelHeight = bounds.size.height / 23.0; // sets the height of the Position Label
    CGFloat keyLabelHeight = bounds.size.height / 23.0; // sets the height of the Key Label
    
    if([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) { // iPad
        positionLabelHeight = bounds.size.height / 19.0;
        keyLabelHeight = bounds.size.height / 19.0;
    }

    self.positionLabel.frame = CGRectMake(0, positionLabelHeight, self.view.frame.size.width, 48);
    self.keyLabel.frame = CGRectMake(0, keyLabelHeight, self.view.frame.size.width, 48);

}

- (void)layoutDegreeView
{
    CGFloat height           = self.view.frame.size.height;
    
    
    CGFloat y;                      // sets the degree button height
    CGFloat degreeViewHeight;
    if([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        y                = height * 0.89;   // smaller is taller, small changes make big difference
        degreeViewHeight = height - y;
    } else {
        y                = height * 0.85;
        degreeViewHeight = height - y;
    }
    
    self.degreeView.frame    = CGRectMake(0, y, self.view.frame.size.width, degreeViewHeight);

}


- (void)layoutMainStringView
{
    
    CGFloat width             = self.view.frame.size.width;
    CGFloat height            = self.view.frame.size.height;
    
    CGFloat stringViewWidth;
    CGFloat stringViewHeight;
    CGFloat buttonOffset;
    CGFloat y;
    
    if([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {     // top part of iPad
        stringViewWidth     = width * 0.5;
        stringViewHeight    = height * 0.45;
        buttonOffset        = width * 0.1;
        y                   = height * 0.13;
    } else {

        stringViewWidth     = width * 0.53;                  // iPhone zoom in
        stringViewHeight    = height * 0.594;
        buttonOffset        = width * 0.155;
        y                   = height * 0.217;
    }
    CGFloat x = (width - stringViewWidth ) / 2.0;
    CGRect frame = CGRectMake(x, y, stringViewWidth, stringViewHeight);
    self.mainStringView.frame = frame;
    
    CGFloat gradientHeight = stringViewHeight * 0.8;
    CGFloat horizontalSpacing = stringViewWidth / 6.42;
    CGFloat gradientWidth = x + (horizontalSpacing / 2.0);
    frame = CGRectMake(0, y, gradientWidth, gradientHeight);          // Gradient lines
    self.leftGradientLines.frame = frame;
    
    x = width - x - (horizontalSpacing / 2.0);
    frame = CGRectMake(x, y, gradientWidth, gradientHeight);
    self.rightGradientLines.frame = frame;
    
    CGRect bounds = [[UIScreen mainScreen] bounds];
    
//    // METRONOME BUTTON POSITION
//    width = bounds.size.width;
//    height = bounds.size.height;
//    CGFloat metX = width * 0.85;
//    CGFloat metY = height * 0.7;
//    CGFloat metWidth = width * 0.1;
//    CGFloat metHeight = height * 0.1;
//    self.metButton.frame = CGRectMake(metX, metY, metWidth, metHeight);
    
    // ARROW BUTTON POSITION
    BOOL isiPad = [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad;
    
    if (isiPad) {
        CGFloat buttonHeight = stringViewHeight * 0.5;
        CGFloat buttonWidth  = buttonHeight / 2.0;
        
        CGFloat leftButtonX = buttonOffset;
        CGFloat buttonY = y + (stringViewHeight * 0.17);
        self.leftArrowButton.frame = CGRectMake(leftButtonX, buttonY, buttonWidth, buttonHeight);
        
        CGFloat rightButtonX = width - buttonOffset - buttonWidth;
        self.rightArrowButton.frame = CGRectMake(rightButtonX, buttonY, buttonWidth, buttonHeight);
    }
    else
    {                                   // initial setup, program doesn't return here
        // top arrow buttons
        width = bounds.size.width;
        height = bounds.size.height;
        
        CGFloat buttonHeight = height * 0.2;
        CGFloat buttonWidth  = width * 0.16;
        buttonOffset = width * 0.02;
        CGFloat leftButtonX = buttonOffset;
        CGFloat buttonY = height * 0.01;
        self.leftArrowButton.frame = CGRectMake(leftButtonX, buttonY, buttonWidth, buttonHeight);
    
        CGFloat rightButtonX = width - buttonOffset - buttonWidth;
        self.rightArrowButton.frame = CGRectMake(rightButtonX, buttonY, buttonWidth, buttonHeight);
        
        // zoom arrow buttons
        buttonOffset = width * 0.08;
        buttonHeight = height * 0.28;
        buttonWidth  = buttonHeight / 2.0;
        leftButtonX = buttonOffset;
        buttonY = height * 0.28;
        self.leftArrowButtonZoom.frame = CGRectMake(leftButtonX, buttonY, buttonWidth, buttonHeight);
        
        rightButtonX = width - buttonOffset - buttonWidth;
        self.rightArrowButtonZoom.frame = CGRectMake(rightButtonX, buttonY, buttonWidth, buttonHeight);

    }
}

- (void)layoutFullStringView
{
    CGFloat width             = self.view.frame.size.width;
    CGFloat height            = self.view.frame.size.height;
    CGFloat stringViewHeight;
    CGFloat stringViewWidth;
    CGFloat x;
    CGFloat y;
                                                                                 // bottom part of iPad
    if([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        stringViewWidth         = width;
        stringViewHeight        = height * 0.3;
        x                       = 0;
        y                       = height * .59;                              // lower number raises
    }
    else {
        stringViewWidth         = width * 0.97;                      // iPhone zoom out
        stringViewHeight        = height * 0.625;
        x                       = (width - stringViewWidth ) / 2.0;
        y                       = height * 0.215;
    }
    
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
        self.menuController.view.backgroundColor = [UIColor GuitarMain];
        
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
    self.keys = [[GuitarStore sharedStore] keys];

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
    BOOL isiPad = [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad;
    
    if (scale) {
        if (isiPad) {
            titleText = scale.longTitle;
        }
        else {
            titleText = scale.title;
        }
    } else {
        titleText = @"";
    }
    
    CGRect bounds = [[UIScreen mainScreen] bounds];
    CGFloat titleSize = bounds.size.width / 13.0; // sets the title size  // iPhone 6 & 7
    if (bounds.size.width < 667) {                                        // iPhone 5
        titleSize = bounds.size.width / 11.0;
    }
    if (bounds.size.width < 568.0) {                                        // iPhone 4
    
    }
    if (bounds.size.width > 667) {                                        // iPhone 6 & 7 Plus
        titleSize = bounds.size.width / 10.8;
    }    
    if (isiPad) {                                 // iPad
        titleSize = bounds.size.width / 14.0;
    }
    
    
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:titleText];
    [title addAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor GuitarCream], NSForegroundColorAttributeName,[UIFont blackoutFontWithSize:titleSize], NSFontAttributeName, nil] range:NSMakeRange(0, title.length)];
    NSMutableParagraphStyle *paragraphStyle = NSMutableParagraphStyle.new;
    paragraphStyle.alignment                = NSTextAlignmentCenter;
    [title addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, title.length)];
    if (!isiPad) {
        [title addAttribute:NSKernAttributeName value:@-2.0 range:NSMakeRange(0, title.length)];
    }    // add kerning for iPhone
 
    CGRect titleFrame;
    if (isiPad) {
        titleFrame = CGRectMake(2.0, 1.0, 0.0, 0.0);
    }
    else {
        titleFrame = CGRectMake(5.0, 1.0, 0.0, 0.0);
    }
    
    UIView * customTitleView = [[UIView alloc] initWithFrame:titleFrame];

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

//- (void)toggleMet:(id)sender
//{
////    NSURL *metSound = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"click" ofType:@"mp3"]];
////    
////    AudioServicesPlaySystemSound(metSound);
//    
//    if (self.metIsOn) {
//        self.metIsOn = false;
//    }
//    else {
//        self.metIsOn = true;
//    }
//    
//}
//

- (void)handlePositionLeft:(id)sender            // arrow button function
{
    BOOL isLeftHand = [[GuitarStore sharedStore] isLeftHand];               // conditional statements to flip arrow direction in LeftHand mode
    if (isLeftHand){
        if (self.currentPosition < self.positions.count - 1) {
            self.currentPosition++;
            [self updateStringViewPositions];
        }
        else if (self.currentPosition == self.positions.count - 1) {
            self.currentPosition = 0;
            [self updateStringViewPositions];
        }
    }
    else {
        if (self.currentPosition > 0) {
            self.currentPosition--;
            [self updateStringViewPositions];
        }
        else if (self.currentPosition == 0) {
            self.currentPosition = self.positions.count - 1;
            [self updateStringViewPositions];
        }
    }
}

- (void)handlePositionRight:(id)sender
{
    BOOL isLeftHand = [[GuitarStore sharedStore] isLeftHand];
    if (isLeftHand){
        if (self.currentPosition > 0) {
            self.currentPosition--;
            [self updateStringViewPositions];
        }
        else if (self.currentPosition == 0) {
            self.currentPosition = self.positions.count - 1;
            [self updateStringViewPositions];
        }
    }
    else {
        if (self.currentPosition < self.positions.count - 1) {
            self.currentPosition++;
            [self updateStringViewPositions];
        }
        else if (self.currentPosition == self.positions.count - 1) {
            self.currentPosition = 0;
            [self updateStringViewPositions];
        }
    }
}

//

- (void)handlePositionLeftKey:(id)sender            // arrow button function
{
    BOOL isLeftHand = [[GuitarStore sharedStore] isLeftHand];               // conditional statements to flip arrow direction in LeftHand mode
    if (isLeftHand){
        if (self.currentKey < self.keys.count - 1) {
            self.currentKey++;
            [self updateStringViewPositions];
        }
        else if (self.currentKey == self.keys.count - 1) {
            self.currentKey = 0;
            [self updateStringViewPositions];
        }
    }
    else {
        if (self.currentKey > 0) {
            self.currentKey--;
            [self updateStringViewPositions];
        }
        else if (self.currentKey == 0) {
            self.currentKey = self.keys.count - 1;
            [self updateStringViewPositions];
        }
    }
}

- (void)handlePositionRightKey:(id)sender
{
    BOOL isLeftHand = [[GuitarStore sharedStore] isLeftHand];
    if (isLeftHand){
        if (self.currentKey > 0) {
            self.currentKey--;
            [self updateStringViewPositions];
        }
        else if (self.currentKey == 0) {
            self.currentKey = self.keys.count - 1;
            [self updateStringViewPositions];
        }
    }
    else {
        if (self.currentKey < self.keys.count - 1) {
            self.currentKey++;
            [self updateStringViewPositions];
        }
        else if (self.currentKey == self.keys.count - 1) {
            self.currentKey = 0;
            [self updateStringViewPositions];
        }
    }
}

//

- (void)updateStringViewPositions
{
    BOOL isBassMode = [[GuitarStore sharedStore] isBassMode];
    if (self.positions.count > 0) {
        self.mainStringView.position = self.positions[self.currentPosition];
        self.leftGradientLines.position = self.positions[self.currentPosition];
        self.rightGradientLines.position = self.positions[self.currentPosition];
        self.fullStringView.position = self.positions[self.currentPosition];
        
        if (isBassMode) {
            [self setSubHeaderText:self.mainStringView.position.altTitle];
        }
        else {
            [self setSubHeaderText:self.mainStringView.position.title];
        }
    }
    
    self.mainStringView.key = self.keys[self.currentKey];
    
    [self setSubHeaderKeyText:self.mainStringView.key.title];
    
    [self.mainStringView setNeedsDisplay];
    [self.leftGradientLines setNeedsDisplay];
    [self.rightGradientLines setNeedsDisplay];
    [self.fullStringView updateStringViewPosition];
}

- (void)toggleViews:(id)sender {                      // toggle views for iPhone
    if ([self.mainStringView isHidden]) {
        [UIView animateWithDuration:0.2 animations:^{
            self.mainStringView.hidden = false;
            self.mainStringView.alpha = 1;
            self.fullStringView.alpha = 0;
        } completion: ^(BOOL finished) {
            self.fullStringView.hidden = true;
        }];
            } else {
        [UIView animateWithDuration:0.2 animations:^{
            self.fullStringView.hidden = false;
            self.fullStringView.alpha = 1;
            self.mainStringView.alpha = 0;
        } completion: ^(BOOL finished) {
            self.mainStringView.hidden = true;
        }];
    }
    if ([self.leftArrowButtonZoom isHidden]) {
        [UIView animateWithDuration:0.2 animations:^{
            self.leftArrowButtonZoom.hidden = false;
            self.leftArrowButtonZoom.alpha = 1;
            self.leftArrowButton.alpha = 0;
        } completion: ^(BOOL finished) {
            self.leftArrowButton.hidden = true;
        }];
    } else {
        [UIView animateWithDuration:0.2 animations:^{
            self.leftArrowButton.hidden = false;
            self.leftArrowButton.alpha = 1;
            self.leftArrowButtonZoom.alpha = 0;
        } completion: ^(BOOL finished) {
            self.leftArrowButtonZoom.hidden = true;
        }];
    }
    if ([self.rightArrowButtonZoom isHidden]) {
        [UIView animateWithDuration:0.2 animations:^{
            self.rightArrowButtonZoom.hidden = false;
            self.rightArrowButtonZoom.alpha = 1;
            self.rightArrowButton.alpha = 0;
        } completion: ^(BOOL finished) {
            self.rightArrowButton.hidden = true;
        }];
    } else {
        [UIView animateWithDuration:0.2 animations:^{
            self.rightArrowButton.hidden = false;
            self.rightArrowButton.alpha = 1;
            self.rightArrowButtonZoom.alpha = 0;
        } completion: ^(BOOL finished) {
            self.rightArrowButtonZoom.hidden = true;
        }];
    }
    if ([self.keyLabel isHidden]) {
        [UIView animateWithDuration:0.2 animations:^{
            self.keyLabel.hidden = false;
            self.keyLabel.alpha = 1;
            self.positionLabel.alpha = 0;
        } completion: ^(BOOL finished) {
            self.positionLabel.hidden = true;
        }];
    } else {
        [UIView animateWithDuration:0.2 animations:^{
            self.positionLabel.hidden = false;
            self.positionLabel.alpha = 1;
            self.keyLabel.alpha = 0;
        } completion: ^(BOOL finished) {
            self.keyLabel.hidden = true;
        }];
    }


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
    CGRect bounds = [[UIScreen mainScreen] bounds];
    CGFloat fontSize = bounds.size.width / 25.6538;
    
    NSMutableAttributedString *attributedString;
    attributedString = [[NSMutableAttributedString alloc] initWithString:text];     // iPhone 6 & 7
    [attributedString addAttribute:NSKernAttributeName
                             value:@5.3
                             range:NSMakeRange(0, text.length)];
        if (bounds.size.width < 667) {                                        // iPhone 5
            [attributedString addAttribute:NSKernAttributeName
                                     value:@4.8
                                     range:NSMakeRange(0, text.length)];
        }
        if (bounds.size.width < 568.0) {                                        // iPhone 4
            [attributedString addAttribute:NSKernAttributeName
                                     value:@3.81
                                     range:NSMakeRange(0, text.length)];
        }
        if (bounds.size.width > 667) {                                        // iPhone 6 & 7 Plus
            [attributedString addAttribute:NSKernAttributeName
                                     value:@6.3    //7.63
                                     range:NSMakeRange(0, text.length)];
        }
        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) { // iPad
            [attributedString addAttribute:NSKernAttributeName
                                     value:@7.0
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

- (void)setSubHeaderKeyText:(NSString *)text
{
    CGRect bounds = [[UIScreen mainScreen] bounds];
    CGFloat fontSize = bounds.size.width / 25.6538;
    
    NSMutableAttributedString *attributedString;
    attributedString = [[NSMutableAttributedString alloc] initWithString:text];     // iPhone 6 & 7
    
//    [attributedString addAttribute:NSKernAttributeName
//                             value:@5.3
//                             range:NSMakeRange(0, text.length)];
//    if (bounds.size.width < 667) {                                        // iPhone 5
//        [attributedString addAttribute:NSKernAttributeName
//                                 value:@4.8
//                                 range:NSMakeRange(0, text.length)];
//    }
//    if (bounds.size.width < 568.0) {                                        // iPhone 4
//        [attributedString addAttribute:NSKernAttributeName
//                                 value:@3.81
//                                 range:NSMakeRange(0, text.length)];
//    }
//    if (bounds.size.width > 667) {                                        // iPhone 6 & 7 Plus
//        [attributedString addAttribute:NSKernAttributeName
//                                 value:@6.3    //7.63
//                                 range:NSMakeRange(0, text.length)];
//    }
//    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) { // iPad
//        [attributedString addAttribute:NSKernAttributeName
//                                 value:@7.0
//                                 range:NSMakeRange(0, text.length)];
//    }
//    
    [attributedString addAttribute:NSFontAttributeName
                             value:[UIFont newOpusFontWithSize:fontSize]
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
    
    [self.keyLabel setAttributedText:attributedString];
}

#pragma mark Notifications

- (void)didChangeDisplay:(id)sender
{
    [self refreshData];
}

#pragma mark FullStringContainerViewDelegate

- (void)toggleView {
    [self toggleViews:self];
}

- (void)increasePosition {
    [self handlePositionRight:self];
}
- (void)decreasePosition {
    [self handlePositionLeft:self];
}

@end
