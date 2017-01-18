//
//  UIFont+Guitar.m
//  Guitar Scales Interactive
//
//  Created by Elena Boyd on 8/24/14.
//
//

#import "UIFont+Guitar.h"

@implementation UIFont (Guitar)

+ (UIFont *)ProletarskFontWithSize:(CGFloat)size
{
    return [UIFont fontWithName:@"Proletarsk" size:size];
}

+ (UIFont *)blackoutFontWithSize:(CGFloat)size
{
    return [UIFont fontWithName:@"Blackout-Midnight" size:size];
}

+ (UIFont *)svBasicManualFontWithSize:(CGFloat)size
{
    return [UIFont fontWithName:@"SVBasicManual-Bold" size:size];
}

+ (UIFont *)bravuraFontWithSize:(CGFloat)size
{
    return [UIFont fontWithName:@"OpusTextStd" size:size];
}

+ (UIFont *)newOpusFontWithSize:(CGFloat)size
{
    return [UIFont fontWithName:@"OpusChordsSansStd" size:size];
}

+ (UIFont *)jrHandFontWithSize:(CGFloat)size
{
    return [UIFont fontWithName:@"Jrhand" size:size];
}



@end
