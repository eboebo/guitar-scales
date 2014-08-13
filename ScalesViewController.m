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

@interface ScalesViewController ()

@property (weak, nonatomic) IBOutlet StringView *mainStringView;

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
    Group *group = scale.groups[0];
    self.mainStringView.notes = group.notes;
    [self.mainStringView setNeedsDisplay];
    
}

@end
