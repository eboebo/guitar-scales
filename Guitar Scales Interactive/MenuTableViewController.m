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
    [attributedString addAttribute:NSKernAttributeName value:@(.3) range:NSMakeRange(0, leftScale.menuTitle.length)];
    
    
    cell.leftTitle.attributedText = attributedString;
    NSInteger tag = ([indexPath section] * 1000 + indexPath.row) + SCALE_TAG_OFFSET;
    cell.leftTitle.tag  = tag;
    cell.delegate       = self;
    

    if ([leftScale.title isEqualToString:selectedScale.title] ) {
        cell.leftTitle.backgroundColor = [UIColor GuitarMediumBlue]; //
        self.selectedLabel = cell.leftTitle;
    } else {
        cell.leftTitle.textColor = [UIColor GuitarCream];
        cell.leftTitle.backgroundColor = [UIColor GuitarBlue]; //
        
    }
    
    NSInteger scaleIndex = (sectionScales.count / 2.0) + indexPath.row;
    if (sectionScales.count % 2) {
        scaleIndex++;
    }
    
    if (scaleIndex< sectionScales.count) {
        Scale *rightScale = sectionScales[scaleIndex];
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:rightScale.menuTitle];
        [attributedString addAttribute:NSKernAttributeName value:@(.3) range:NSMakeRange(0, rightScale.menuTitle.length)];

        cell.rightTitle.attributedText = attributedString;
        tag = ([indexPath section] * 1000 + (scaleIndex)) + SCALE_TAG_OFFSET;
        cell.rightTitle.tag = tag;
        if ([rightScale.title isEqualToString:selectedScale.title]) {
            cell.rightTitle.backgroundColor = [UIColor GuitarMediumBlue]; //
            self.selectedLabel = cell.rightTitle;
        } else {
            cell.rightTitle.textColor = [UIColor GuitarCream];
            cell.rightTitle.backgroundColor = [UIColor GuitarBlue]; //
        }
    } else {
        cell.rightTitle.text = @"";
    }

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 28.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView         = [UIView new];
    headerView.frame           = CGRectMake(0, 0, self.view.bounds.size.width, 24.0f);
    headerView.backgroundColor = [UIColor GuitarLightBlue];

    UILabel *titleLabel        = [UILabel new];
    titleLabel.backgroundColor = [UIColor GuitarLightBlue];
    [titleLabel setFont:[UIFont ProletarskFontWithSize:16.0f]];
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
    return 24.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (void)scaleTapped:(UILabel *)scaleLabel
{
    if (self.selectedLabel) {
        [self.selectedLabel setTextColor:[UIColor GuitarCream]];
        [self.selectedLabel setBackgroundColor: [UIColor GuitarBlue]];
        self.selectedLabel = scaleLabel;
        self.selectedLabel.textColor = [UIColor GuitarCream];
        self.selectedLabel.backgroundColor = [UIColor GuitarBlue];
        [self.selectedLabel setBackgroundColor: [UIColor GuitarMediumBlue]];
    }
    
    self.selectedLabel = scaleLabel;
    [self.selectedLabel setBackgroundColor: [UIColor GuitarMediumBlue]];
    
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
