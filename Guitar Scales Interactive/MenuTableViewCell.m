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
        self.backgroundColor = [UIColor GuitarBlue];
        
        self.leftTitle = [UILabel new];
        self.leftTitle.font = [UIFont ProletarskFontWithSize:17.0f];
        self.leftTitle.textColor = [UIColor GuitarCream];
        self.leftTitle.backgroundColor = [UIColor GuitarBlue];
        [self.leftTitle setTextAlignment:NSTextAlignmentLeft];
        [self.leftTitle setUserInteractionEnabled:YES];
        
        UITapGestureRecognizer *leftTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleLeftTitleTap:)];
        [self.leftTitle addGestureRecognizer:leftTap];
        
        self.rightTitle = [UILabel new];
        self.rightTitle.textColor = [UIColor GuitarCream];
        self.rightTitle.backgroundColor = [UIColor GuitarBlue];
        [self.rightTitle setUserInteractionEnabled:YES];
        self.rightTitle.font = [UIFont ProletarskFontWithSize:17.0f];
        [self.rightTitle setTextAlignment:NSTextAlignmentRight];
        
        UITapGestureRecognizer *rightTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleRightTitleTap:)];
        [self.rightTitle addGestureRecognizer:rightTap];
        
        [self.contentView addSubview:self.leftTitle];
        [self.contentView addSubview:self.rightTitle];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat offset = 80.0f;
    CGFloat padding = 30.0f;
    
    CGRect bounds = self.contentView.bounds;
    
    CGFloat width = bounds.size.width / 2.0 - offset;
    CGRect labelFrame = CGRectZero;
    labelFrame.origin.x += offset - padding / 2.0;
    labelFrame.size = CGSizeMake(width, bounds.size.height);
    
    self.leftTitle.frame = CGRectIntegral(labelFrame);
    labelFrame.origin.x += width + padding;
    self.rightTitle.frame = CGRectIntegral(labelFrame);
    
}

- (void)handleLeftTitleTap:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(scaleTapped:)] && self.leftTitle.tag) {


        [self.delegate scaleTapped:self.leftTitle];
    }
}

- (void)handleRightTitleTap:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(scaleTapped:)] && self.rightTitle.tag) {

        [self.delegate scaleTapped:self.rightTitle];
    }
}

@end
