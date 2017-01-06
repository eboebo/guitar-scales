//
//  DegreeButtonView.m
//  Guitar Scales Interactive
//
//  Created by Elena Boyd on 8/26/14.
//
//

#import "DegreeButtonView.h"

@implementation DegreeButtonView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.titleLabel                 = [[UILabel alloc] init];
        self.titleLabel.textAlignment   = NSTextAlignmentCenter;
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.selected                   = NO;
        [self addSubview:self.titleLabel];
        
        UITapGestureRecognizer *buttonTap
        = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonTapped:)];
        [self addGestureRecognizer:buttonTap];
    }
    return self;
}

- (void)layoutSubviews
{
    self.titleLabel.frame = self.bounds;
}

- (void)drawRect:(CGRect)rect
{
    // size of bottom border (middle, under degree buttons)
    CGRect bounds = [[UIScreen mainScreen] bounds];
    BOOL isiPad = [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad;
    CGFloat borderSize = bounds.size.width / 74.0;   // for iPhone
    if (isiPad) {
        borderSize = bounds.size.width / 77.5;       // for iPad
    }

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor GuitarMain].CGColor);
    CGContextFillRect(context, CGRectMake(0.0f, self.frame.size.height - borderSize, self.frame.size.width, borderSize));
}

- (void)buttonTapped:(id)sender
{
    self.selected = !self.selected;
    
    if ([self.delegate respondsToSelector:@selector(degreeTapped:)]) {
        [self.delegate degreeTapped:self];
    }
}

- (void)setSelected:(BOOL)selected
{
    _selected = selected;
    
    [UIView animateWithDuration:0.8 animations:^{
        if (_selected) {
            self.titleLabel.textColor = [UIColor GuitarCream];
            self.backgroundColor = [UIColor GuitarMain];
        } else {
            self.titleLabel.textColor = [UIColor GuitarMainAlpha];
            self.backgroundColor = [UIColor GuitarCream];
            
        }
    }];
}

@end
