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
<MenuTableViewCellDelegate>

@property (nonatomic, strong) NSArray *scales;
@property (nonatomic, strong) NSArray *scaleGroups;
@property (nonatomic, strong) UILabel *selectedLabel;

@end

NSInteger const SCALE_TAG_OFFSET = 111;

@implementation MenuTableViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.scales = [[GuitarStore sharedStore] scales2DArray];
    self.scaleGroups = @[@"SCALES", @"ARPEGGIOS", @"INTERVALS", @"modes of MAJOR",
                         @"modes of MELODIC MINOR", @"modes of HARMONIC MINOR",
                         @"modes of HARMONIC MAJOR"];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.scales.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int numScales = (int)[self.scales[section] count];
    return (numScales+3-1)/3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *sectionScales = self.scales[indexPath.section];
    
    NSString *MenuCellIdentifier = @"MenuCellIdentifier";
    MenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MenuCellIdentifier];
    if (cell == nil) {
        cell
        = [[MenuTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MenuCellIdentifier];
    }
    
    NSInteger rowOffset = indexPath.row * 3;

    Scale *leftScale    = sectionScales[rowOffset];
    cell.leftTitle.text = leftScale.title;
    NSInteger tag = ([indexPath section] * 1000 + rowOffset) + SCALE_TAG_OFFSET;
    cell.leftTitle.tag  = tag;
    cell.delegate       = self;
    
    if (leftScale == [[GuitarStore sharedStore] selectedScale]) {
        cell.leftTitle.textColor = [UIColor GuitarBlue];
        self.selectedLabel = cell.leftTitle;
    } else {
        cell.leftTitle.textColor = [UIColor blackColor];
    }
    
    if (rowOffset + 1 < sectionScales.count) {
        Scale *middleScale = sectionScales[rowOffset + 1];
        cell.middleTitle.text = middleScale.title;
        tag = ([indexPath section] * 1000 + (rowOffset + 1)) + SCALE_TAG_OFFSET;
        cell.middleTitle.tag = tag;

        if (middleScale == [[GuitarStore sharedStore] selectedScale]) {
            cell.middleTitle.textColor = [UIColor GuitarBlue];
            self.selectedLabel = cell.middleTitle;

        } else {
            cell.middleTitle.textColor = [UIColor blackColor];
        }
    } else {
        cell.middleTitle.text = @"";
    }

    
    if (rowOffset + 2 < sectionScales.count) {
        Scale *rightScale = sectionScales[rowOffset + 2];
        cell.rightTitle.text = rightScale.title;
        tag = ([indexPath section] * 1000 + (rowOffset + 2)) + SCALE_TAG_OFFSET;
        cell.rightTitle.tag = tag;
        if (rightScale == [[GuitarStore sharedStore] selectedScale]) {
            cell.rightTitle.textColor = [UIColor GuitarBlue];
            self.selectedLabel = cell.rightTitle;
        } else {
            cell.rightTitle.textColor = [UIColor blackColor];
        }
    } else {
        cell.rightTitle.text = @"";
    }

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView         = [UIView new];
    headerView.frame           = CGRectMake(0, 0, self.view.bounds.size.width, 30.0f);
    headerView.backgroundColor = [UIColor GuitarLightBlue];

    UILabel *titleLabel        = [UILabel new];
    titleLabel.backgroundColor = [UIColor GuitarLightBlue];
    [titleLabel setFont:[UIFont proletarskFontWithSize:16.0f]];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    
    NSString *titleText = @"SCALES";
    if (section < self.scaleGroups.count) {
        titleText = self.scaleGroups[section];
    }
    [titleLabel setText:titleText];

    CGFloat inset      = 10.0;
    CGFloat labelWidth = self.view.bounds.size.width - inset * 2.0;
    CGRect labelFrame  = CGRectMake(inset, 0, labelWidth , headerView.frame.size.height);
    titleLabel.frame   = labelFrame;
    
    [headerView addSubview:titleLabel];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (void)scaleTapped:(UILabel *)scaleLabel
{
    if (self.selectedLabel) {
        [self.selectedLabel setTextColor:[UIColor blackColor]];
        self.selectedLabel = scaleLabel;
        [self.selectedLabel setTextColor:[UIColor GuitarBlue]];
    }
    
    if (scaleLabel.tag) {
        NSInteger tag = scaleLabel.tag - SCALE_TAG_OFFSET;
        NSInteger section = tag / 1000;
        NSInteger row     = tag % 1000;
        
        Scale *scale = self.scales[section][row];
        [[GuitarStore sharedStore] setSelectedScale:scale];
        if ([self.delegate respondsToSelector:@selector(didSelectScale:)]) {
            [self.delegate didSelectScale:scale];
        }
    }



}

@end
