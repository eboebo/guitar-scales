//
//  UITableViewCell+Guitar.m
//  Guitar Scales Interactive
//
//  Created by Elena Boyd on 5/14/15.
//
//

#import "UITableViewCell+Guitar.h"

@implementation UITableViewCell (Guitar)

- (void)addStars
{
    for (int i = 1; i < 6; i++) {
        UIImageView *star = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"star"]];
        CGRect bounds = self.bounds;
        CGRect starFrame = star.frame;
        starFrame.origin.x = bounds.size.width - ((starFrame.size.width + 5) * i) - 30;
        starFrame.origin.y = (bounds.size.height - starFrame.size.height ) / 2;
        star.frame = starFrame;
        [self addSubview:star];
    }
}

@end
