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

@interface ScalesViewController ()

@property (weak, nonatomic) IBOutlet StringView *mainStringView;
@property (weak, nonatomic) IBOutlet StringView *topLeftStringView;
@property (weak, nonatomic) IBOutlet StringView *middleLeftStringView;
@property (weak, nonatomic) IBOutlet StringView *bottomLeftStringView;
@property (weak, nonatomic) IBOutlet StringView *topRightStringView;
@property (weak, nonatomic) IBOutlet StringView *middleRightStringView;
@property (weak, nonatomic) IBOutlet StringView *bottomRightStringView;
@property (weak, nonatomic) IBOutlet DegreeView *buttonView;


@property (weak, nonatomic) IBOutlet UILabel *positionLabel;

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
    self.title = @"Scales";
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStylePlain target:self action:@selector(handleLeftBarButtonTap:)];
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
    NSLog(@"Open menu");
}

- (void)refreshData
{
    if (!self.selectedDegrees) {
        NSMutableArray *scales = [[GuitarStore sharedStore] scales];
        Scale *scale = scales[0];
        self.selectedDegrees = [scale.selectedDegrees mutableCopy];
    }
    
    
    self.buttonView.selectedDegrees = self.selectedDegrees;
    self.buttonView.delegate = self;
    [self.buttonView setNeedsDisplay];


    
    NSMutableArray *positions = [[GuitarStore sharedStore] positions];
    for (Position *pos in positions) {
        NSInteger positionID = pos.identifier;
        StringView *stringView = [self stringViewForPositionID:positionID];
        stringView.position = pos;
        stringView.selectedDegrees = self.selectedDegrees;
        [stringView setNeedsDisplay];
    }

    self.mainStringView.isMainView = YES;
    [self.mainStringView setNeedsDisplay];
}

- (void)viewTapped:(id)sender
{
    UITapGestureRecognizer *tapRec = (UITapGestureRecognizer *) sender;
    StringView *stringView = (StringView *) tapRec.view;
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
}

@end
