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
        self.backgroundColor = [UIColor GuitarBlue];

    } else if (self.currentState == DoubleDegreeButtonStateBottom) {
        self.secondTitleLabel.hidden = NO;
        self.titleLabel.hidden = YES;
        self.secondTitleLabel.frame = self.bounds;
        self.secondTitleLabel.textColor = [UIColor GuitarCream];
        self.backgroundColor = [UIColor GuitarBlue];

    } else {
        self.secondTitleLabel.hidden = NO;
        self.titleLabel.hidden = NO;
        CGRect topFrame = self.bounds;
        topFrame.size.height = self.bounds.size.height / 2.0;
        self.titleLabel.frame = topFrame;
        
        CGRect bottomFrame = topFrame;
        bottomFrame.origin.y = topFrame.size.height;
        self.secondTitleLabel.frame = bottomFrame;
        
        self.titleLabel.textColor = [UIColor GuitarMediumBlue];
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
