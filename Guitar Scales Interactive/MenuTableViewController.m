//
//  MenuTableViewController.m
//  Guitar Scales Interactive
//
//  Created by Elena Boyd on 8/25/14.
//
//

#import "MenuTableViewController.h"
#import "GuitarStore.h"
#import "Scale.h"
#import "MenuTableViewCell.h"

@interface MenuTableViewController ()

@property (nonatomic, strong) NSArray *scales;
@end

@implementation MenuTableViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.scales = [[GuitarStore sharedStore] scales2DArray];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return self.scales.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.scales[section] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Cell
    NSString *MenuCellIdentifier = @"MenuCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MenuCellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MenuCellIdentifier];
    }
    
    Scale *scale = self.scales[indexPath.section][indexPath.row];
    cell.textLabel.text = scale.title;
    cell.textLabel.font = [UIFont proletarskFontWithSize:17.0f];

    
    cell.backgroundColor = [UIColor clearColor];
    
    if (scale == [[GuitarStore sharedStore] selectedScale]) {
        cell.textLabel.textColor = [UIColor GuitarBlue];
    } else {
        cell.textLabel.textColor = [UIColor blackColor];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Scale *scale = self.scales[indexPath.section][indexPath.row];
    [[GuitarStore sharedStore] setSelectedScale:scale];
    if ([self.delegate respondsToSelector:@selector(didSelectScale:)]) {
        [self.delegate didSelectScale:scale];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30.0f;
}

@end
