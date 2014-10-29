//
//  MenuTableViewCell.h
//  Guitar Scales Interactive
//
//  Created by Elena Boyd on 10/19/14.
//
//

#import <UIKit/UIKit.h>

@protocol MenuTableViewCellDelegate <NSObject>

- (void)scaleTapped:(UILabel *)scaleLabel;

@end

@interface MenuTableViewCell : UITableViewCell

@property (weak, nonatomic) id<MenuTableViewCellDelegate> delegate;
@property (strong, nonatomic) UILabel *leftTitle;
@property (strong, nonatomic) UILabel *middleTitle;
@property (strong, nonatomic) UILabel *rightTitle;

@end
