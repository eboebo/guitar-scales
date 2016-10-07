//
//  OptionsViewController.m
//  Guitar Scales Interactive
//
//  Created by Elena Boyd on 4/28/15.
//
//

#import "OptionsViewController.h"
#import "GuitarStore.h"
#import "UIColor+Guitar.h"
#import "UIFont+Guitar.h"
#import "UITableViewCell+Guitar.h"

typedef NS_ENUM(NSInteger, OptionsRow) {
    OptionsRowTutorial,
    OptionsRowShowDegrees,
    OptionsRowLeftHand,
    OptionsRowRate,
    OptionsRowFeedback,
    OptionsRowNumRows
    
};

@interface OptionsViewController ()

@end

@implementation OptionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor GuitarBlue];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return OptionsRowNumRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor GuitarBlue];
    cell.tintColor = [UIColor GuitarCream];
    cell.textLabel.textColor = [UIColor GuitarCream];
    
    NSString *text;
    switch (indexPath.row) {
        case OptionsRowTutorial:
            text = @"View Tutorial";
            break;
        case OptionsRowShowDegrees: {
            text = @"Show Scale Degrees";
            BOOL showDegrees = [[GuitarStore sharedStore] showDegrees];
            cell.accessoryType = showDegrees ? UITableViewCellAccessoryNone : UITableViewCellAccessoryCheckmark;
        }
            break;
        case OptionsRowLeftHand: {
            text = @"Enable Left Hand";
            BOOL isLeftHand = [[GuitarStore sharedStore] isLeftHand];
            cell.accessoryType = isLeftHand ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
        }
            break;
        case OptionsRowRate: {
            text = @"Rate Us";
            [cell addStars];
        }
            break;
        case OptionsRowFeedback:
            text = @"Give Us Feedback";
            break;
        default:
            break;
    }
    
    [cell.textLabel setText:text];
    [cell.textLabel setFont:[UIFont ProletarskFontWithSize:16.0f]];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case OptionsRowTutorial:
            [self.delegate didSelectOptionRow:OptionsRowTutorial];
            break;
        case OptionsRowShowDegrees: {
            BOOL showDegrees = [[GuitarStore sharedStore] showDegrees];
            [[GuitarStore sharedStore] setShowDegrees:!showDegrees];
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"DisplayChange" object:self];
        }
            break;
        case OptionsRowLeftHand: {
            BOOL isLeftHand = [[GuitarStore sharedStore] isLeftHand];
            [[GuitarStore sharedStore] setLeftHand:!isLeftHand];
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"DisplayChange" object:self];
        }
            break;
        case OptionsRowRate: {
            NSString *iTunesLink = @"https://itunes.apple.com/us/app/apple-store/id971847390?mt=8";
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:iTunesLink]];
        }
            break;
        case OptionsRowFeedback: {
            NSString *email = @"mailto:guitarnoteatlas@gmail.com?subject=Feedback!";
            email = [email stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:email]];
        }
            break;
        default:
            break;
    }
}

@end
