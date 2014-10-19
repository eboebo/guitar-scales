//
//  MenuTableViewCell.m
//  Guitar Scales Interactive
//
//  Created by Elena Boyd on 10/19/14.
//
//

#import "MenuTableViewCell.h"

@implementation MenuTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor GuitarCream];
        
        self.leftTitle = [UILabel new];
        self.leftTitle.font = [UIFont proletarskFontWithSize:15.0f];
        self.leftTitle.textColor = [UIColor blackColor];
        self.leftTitle.backgroundColor = [UIColor GuitarCream];
        [self.leftTitle setTextAlignment:NSTextAlignmentCenter];
        [self.leftTitle setUserInteractionEnabled:YES];
        
        UITapGestureRecognizer *leftTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleLeftTitleTap:)];
        [self.leftTitle addGestureRecognizer:leftTap];

        self.middleTitle = [UILabel new];
        self.middleTitle.textColor = [UIColor blackColor];
        self.middleTitle.font = [UIFont proletarskFontWithSize:15.0f];
        self.middleTitle.backgroundColor = [UIColor GuitarCream];
        [self.middleTitle setUserInteractionEnabled:YES];

        [self.middleTitle setTextAlignment:NSTextAlignmentCenter];
        
        UITapGestureRecognizer *middleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleMiddleTitleTap:)];
        [self.middleTitle addGestureRecognizer:middleTap];
        
        self.rightTitle = [UILabel new];
        self.rightTitle.textColor = [UIColor blackColor];
        self.rightTitle.backgroundColor = [UIColor GuitarCream];
        [self.rightTitle setUserInteractionEnabled:YES];
        self.rightTitle.font = [UIFont proletarskFontWithSize:15.0f];
        [self.rightTitle setTextAlignment:NSTextAlignmentCenter];
        
        UITapGestureRecognizer *rightTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleRightTitleTap:)];
        [self.rightTitle addGestureRecognizer:rightTap];
        
        [self.contentView addSubview:self.leftTitle];
        [self.contentView addSubview:self.middleTitle];
        [self.contentView addSubview:self.rightTitle];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect bounds = self.contentView.bounds;
    
    CGFloat width = bounds.size.width / 3.0;
    CGRect labelFrame = CGRectZero;
    labelFrame.size = CGSizeMake(width, bounds.size.height);
    
    self.leftTitle.frame = CGRectIntegral(labelFrame);
    labelFrame.origin.x += width;
    self.middleTitle.frame = CGRectIntegral(labelFrame);
    labelFrame.origin.x += width;
    self.rightTitle.frame = CGRectIntegral(labelFrame);
    
}

- (void)handleLeftTitleTap:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(scaleTapped:)] && self.leftTitle.tag) {
        [self.delegate scaleTapped:self.leftTitle.tag];
    }
}

- (void)handleMiddleTitleTap:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(scaleTapped:)] && self.middleTitle.tag) {
        [self.delegate scaleTapped:self.middleTitle.tag];
    }
}

- (void)handleRightTitleTap:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(scaleTapped:)] && self.rightTitle.tag) {
        [self.delegate scaleTapped:self.rightTitle.tag];
    }
}

@end
