//
//  OptionsViewController.m
//  Guitar Scales Interactive
//
//  Created by Elena Boyd on 4/28/15.
//
//

#import "OptionsViewController.h"
#import "UIColor+Guitar.h"
#import "UIFont+Guitar.h"

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
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor GuitarBlue];
    cell.textLabel.textColor = [UIColor GuitarCream];
    
    NSString *text;
    switch (indexPath.row) {
        case 0:
            text = @"Help";
            break;
        case 1:
            text = @"Rate Us";
            break;
        case 2:
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
        case 0:
            NSLog(@"Display tutorial");
            break;
        case 1: {
            NSString *iTunesLink = @"https://itunes.apple.com/us/app/apple-store/id971847390?mt=8";
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:iTunesLink]];
        }
            break;
        case 2: {
            NSString *email = @"mailto:elenaeboyd@gmail.com?subject=Feedback!";
            email = [email stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:email]];
        }
            break;
        default:
            break;
    }
}

@end
