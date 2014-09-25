//
//  MenuTableViewCell.m
//  Guitar Scales Interactive
//
//  Created by Elena Boyd on 8/31/14.
//
//

#import "MenuTableViewCell.h"

@implementation MenuTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    
    CGRect bounds = self.bounds;
    CGRect frame = CGRectMake(0, 0, bounds.size.width / 2.0, bounds.size.height);
    UIView *leftView = [[UIView alloc] initWithFrame:frame];
    
    self.leftLabel = [[UILabel alloc] initWithFrame:frame];
    [leftView addSubview:self.leftLabel];
    [self addSubview:leftView];
    
    frame.origin.x += frame.size.width;
    
    UIView *rightView = [[UIView alloc] initWithFrame:frame];
    self.rightLabel = [[UILabel alloc] initWithFrame:frame];
    [rightView addSubview:self.rightLabel];
    [self addSubview:rightView];
}

@end
