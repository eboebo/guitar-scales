//
//  DoubleDegreeButtonView.m
//  Guitar Scales Interactive
//
//  Created by Elena Boyd on 9/25/14.
//
//

#import "DoubleDegreeButtonView.h"

@interface DoubleDegreeButtonView ()

@end

@implementation DoubleDegreeButtonView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        
        self.secondTitleLabel = [[UILabel alloc] init];
        self.secondTitleLabel.textAlignment = NSTextAlignmentCenter;
        self.secondTitleLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:self.secondTitleLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    if (self.currentState == DoubleDegreeButtonStateTop) {
        self.secondTitleLabel.hidden = YES;
        self.titleLabel.hidden = NO;
        self.titleLabel.frame = self.bounds;
        self.titleLabel.textColor = [UIColor GuitarCream];
        self.titleLabel.attributedText = self.firstDegree.toAttributedString;
        self.backgroundColor = [UIColor GuitarBlue];

    } else if (self.currentState == DoubleDegreeButtonStateBottom) {
        self.secondTitleLabel.hidden = NO;
        self.titleLabel.hidden = YES;
        self.secondTitleLabel.frame = self.bounds;
        self.secondTitleLabel.textColor = [UIColor GuitarCream];
        self.secondTitleLabel.attributedText = self.secondDegree.toAttributedString;
        self.backgroundColor = [UIColor GuitarBlue];

    } else {
        self.secondTitleLabel.hidden = NO;
        self.titleLabel.hidden = NO;
        CGRect topFrame = self.bounds;
        CGFloat height = self.bounds.size.height / 2.5;
        topFrame.size.height = height;
        self.titleLabel.frame = topFrame;
        
        CGRect bottomFrame = topFrame;
        bottomFrame.origin.y = height;
        self.secondTitleLabel.frame = bottomFrame;
        
        
        self.titleLabel.attributedText = self.firstDegree.toAttributedStringEnharmonic;
        self.titleLabel.textColor = [UIColor GuitarMediumBlue];
        
        
        self.secondTitleLabel.attributedText = self.secondDegree.toAttributedStringEnharmonic;

        self.secondTitleLabel.textColor = [UIColor GuitarMediumBlue];
        
        self.backgroundColor = [UIColor GuitarCream];
    }
}

- (void)buttonTapped:(id)sender
{
    if (self.currentState == DoubleDegreeButtonStateTop) {
        self.currentState = DoubleDegreeButtonStateNone;
    } else {
        self.currentState++;
    }

    [self layoutSubviews];
    
    if ([self.delegate respondsToSelector:@selector(doubleDegreeButtonTapped:)]) {
        
        [self.delegate doubleDegreeButtonTapped:self];
    }
}

@end
