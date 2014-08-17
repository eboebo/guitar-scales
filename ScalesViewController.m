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
#import "ButtonView.h"

@interface ScalesViewController ()

@property (weak, nonatomic) IBOutlet StringView *mainStringView;
@property (weak, nonatomic) IBOutlet StringView *topLeftStringView;
@property (weak, nonatomic) IBOutlet StringView *middleLeftStringView;
@property (weak, nonatomic) IBOutlet StringView *bottomLeftStringView;
@property (weak, nonatomic) IBOutlet StringView *topRightStringView;
@property (weak, nonatomic) IBOutlet StringView *middleRightStringView;
@property (weak, nonatomic) IBOutlet StringView *bottomRightStringView;
@property (weak, nonatomic) IBOutlet ButtonView *buttonView;


@property (weak, nonatomic) IBOutlet UILabel *groupLabel;

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
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"scales" ofType:@"json"];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSData* data = [NSData dataWithContentsOfFile:
                        filePath];
        [self performSelectorOnMainThread:@selector(fetchedData:)
                               withObject:data waitUntilDone:YES];
    });
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
}

- (void)handleLeftBarButtonTap:(id)sender
{
    NSLog(@"Open menu");
}

- (void)fetchedData:(NSData *)responseData
{
    NSError* error;
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:responseData //1
                          options:kNilOptions
                          error:&error];
    
    NSArray* scales = [json objectForKey:@"scales"];
    
    // Block values to return
    NSMutableArray *scalesArray = [NSMutableArray array];
    
    [(NSArray *)scales enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        Scale *scale = [[Scale alloc] initWithDictionary:obj error:nil];
        [scalesArray addObject:scale];
    }];
    
    Scale *scale = scalesArray[0];
    self.title = scale.title;
    Group *group = scale.groups[0];
    self.mainStringView.notes = group.notes;
    self.mainStringView.isMainView = YES;
    
    NSString *groupString = [NSString stringWithFormat:@"%@th String // %@", group.string, group.finger];
    self.groupLabel.text = groupString;
    self.mainStringView.fret = group.baseFret;
    [self.mainStringView setNeedsDisplay];
    
    for (Group *group in scale.groups) {
        if ([group.string isEqualToString:@"6"]) {
            if ([group.finger isEqualToString:@"index"]) {
                self.topLeftStringView.notes = group.notes;
                self.topLeftStringView.string = group.string;
                self.topLeftStringView.finger = group.finger;
                self.topLeftStringView.fret = group.baseFret;
                [self.topLeftStringView setNeedsDisplay];
            } else if ([group.finger isEqualToString:@"middle"]) {
                self.middleLeftStringView.notes = group.notes;
                self.middleLeftStringView.string = group.string;
                self.middleLeftStringView.finger = group.finger;
                self.middleLeftStringView.fret = group.baseFret;
                [self.middleLeftStringView setNeedsDisplay];
            } else {
                self.bottomLeftStringView.notes = group.notes;
                self.bottomLeftStringView.string = group.string;
                self.bottomLeftStringView.finger = group.finger;
                self.bottomLeftStringView.fret = group.baseFret;
                [self.bottomLeftStringView setNeedsDisplay];
            }
        } else {
            if ([group.finger isEqualToString:@"index"]) {
                self.topRightStringView.notes = group.notes;
                self.topRightStringView.string = group.string;
                self.topRightStringView.finger = group.finger;
                self.topRightStringView.fret = group.baseFret;
                [self.topRightStringView setNeedsDisplay];
            } else if ([group.finger isEqualToString:@"middle"]) {
                self.middleRightStringView.notes = group.notes;
                self.middleRightStringView.string = group.string;
                self.middleRightStringView.finger = group.finger;
                self.middleRightStringView.fret = group.baseFret;
                [self.middleRightStringView setNeedsDisplay];
            } else {
                self.bottomRightStringView.notes = group.notes;
                self.bottomRightStringView.string = group.string;
                self.bottomRightStringView.finger = group.finger;
                self.bottomRightStringView.fret = group.baseFret;
                [self.bottomRightStringView setNeedsDisplay];
            }
        }
    }
    
    self.buttonView.selectedButtons = scale.selectedButtons;
    [self.buttonView setNeedsDisplay];
}

- (void)viewTapped:(id)sender
{
    UITapGestureRecognizer *tapRec = (UITapGestureRecognizer *) sender;
    StringView *stringView = (StringView *) tapRec.view;
    self.mainStringView.notes = stringView.notes;
    self.mainStringView.fret
    = stringView.fret;
    [self.mainStringView setNeedsDisplay];
    
     NSString *groupString = [NSString stringWithFormat:@"%@th String // %@", stringView.string, stringView.finger];
    self.groupLabel.text = groupString;

}

@end
