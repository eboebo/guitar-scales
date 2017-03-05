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
    
    CGRect bounds = [[UIScreen mainScreen] bounds];
    CGFloat rowHeight = bounds.size.width / 22.0;
    if (bounds.size.width > 667) {
        rowHeight = bounds.size.width / 27.0;
    }
    self.tableView.rowHeight = rowHeight;
    
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
    int rows = numScales / 2;
    if (numScales % 2 == 1) {
        return rows + 1;
    } else {
        return rows;
    }
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
    
    Scale *leftScale    = sectionScales[indexPath.row];
    Scale *selectedScale = [[GuitarStore sharedStore] selectedScale];
  
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:leftScale.menuTitle];
    [attributedString addAttribute:NSKernAttributeName value:@(1.0) range:NSMakeRange(0, leftScale.menuTitle.length)]; // original .3
    
    
    cell.leftTitle.attributedText = attributedString;
    NSInteger tag = ([indexPath section] * 1000 + indexPath.row) + SCALE_TAG_OFFSET;
    cell.leftTitle.tag  = tag;
    cell.delegate       = self;
    
    // seems to have to do with unselecting old selection
    if ([leftScale.title isEqualToString:selectedScale.title] ) {
        cell.leftTitle.backgroundColor = [UIColor GuitarMenuSelection]; //
        cell.leftTitle.textColor = [UIColor GuitarMenuSelectionText];
        self.selectedLabel = cell.leftTitle;
    } else {
        cell.leftTitle.textColor = [UIColor GuitarCream];
        cell.leftTitle.backgroundColor = [UIColor GuitarMain]; //
        
    }
    
    NSInteger scaleIndex = (sectionScales.count / 2.0) + indexPath.row;
    if (sectionScales.count % 2) {
        scaleIndex++;
    }
    
    if (scaleIndex< sectionScales.count) {
        Scale *rightScale = sectionScales[scaleIndex];
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:rightScale.menuTitle];
        [attributedString addAttribute:NSKernAttributeName value:@(1.0) range:NSMakeRange(0, rightScale.menuTitle.length)]; // original .3

        cell.rightTitle.attributedText = attributedString;
        tag = ([indexPath section] * 1000 + (scaleIndex)) + SCALE_TAG_OFFSET;
        cell.rightTitle.tag = tag;
        if ([rightScale.title isEqualToString:selectedScale.title]) {
            cell.rightTitle.backgroundColor = [UIColor GuitarMenuSelection]; //
            cell.rightTitle.textColor = [UIColor GuitarMenuSelectionText];
            self.selectedLabel = cell.rightTitle;
        }
        else {
            cell.rightTitle.textColor = [UIColor GuitarCream];
            cell.rightTitle.backgroundColor = [UIColor GuitarMain]; //
        }        
    }
    else {  // doesn't seem to ever go to this code
        cell.rightTitle.text = @"";
    }

    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CGRect bounds = [[UIScreen mainScreen] bounds];
    UIView *headerView         = [UIView new];
    CGFloat headerHeight       = bounds.size.width / 22.0;
    headerView.frame           = CGRectMake(0, 0, self.view.bounds.size.width, headerHeight);
    headerView.backgroundColor = [UIColor GuitarMenuHeader];        

    UILabel *titleLabel        = [UILabel new];
    CGFloat headerFontSize     = bounds.size.width / 36.0;
    titleLabel.backgroundColor = [UIColor GuitarMenuHeader];
    [titleLabel setFont:[UIFont ProletarskFontWithSize:headerFontSize]];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    
    NSString *titleText = @"SCALES";
    if (section < self.scaleGroups.count) {
        titleText = self.scaleGroups[section];
    }
    [titleLabel setText:titleText];

    CGRect labelFrame  = CGRectMake(0, 0, self.view.bounds.size.width , headerView.frame.size.height);
    titleLabel.frame   = labelFrame;
    
    [headerView addSubview:titleLabel];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    CGRect bounds = [[UIScreen mainScreen] bounds];
    return bounds.size.width / 20.84;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (void)scaleTapped:(UILabel *)scaleLabel
{
    // unselect last selection
    if (self.selectedLabel) {
        [self.selectedLabel setTextColor:[UIColor GuitarCream]];
        [self.selectedLabel setBackgroundColor: [UIColor GuitarMain]];
        self.selectedLabel = scaleLabel;
        self.selectedLabel.textColor = [UIColor GuitarCream];
        self.selectedLabel.backgroundColor = [UIColor GuitarMain];
        [self.selectedLabel setBackgroundColor: [UIColor GuitarMenuSelection]];
        [self.selectedLabel setTextColor: [UIColor GuitarMenuSelectionText]]; //
    }
    
    // has to do with keeping selection while scrolling
    self.selectedLabel = scaleLabel;
    [self.selectedLabel setBackgroundColor: [UIColor GuitarMenuSelection]];
    [self.selectedLabel setTextColor: [UIColor GuitarMenuSelectionText]]; //
    
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
