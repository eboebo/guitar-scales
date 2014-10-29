//
//  UIFont+Guitar.m
//  Guitar Scales Interactive
//
//  Created by Elena Boyd on 8/24/14.
//
//

#import "UIFont+Guitar.h"

@implementation UIFont (Guitar)

+ (UIFont *)oratorFontWithSize:(CGFloat)size
{
    return [UIFont fontWithName:@"OratorStd" size:size];
}

+ (UIFont *)proletarskFontWithSize:(CGFloat)size
{
    return [UIFont fontWithName:@"Proletarsk" size:size];
}

+ (UIFont *)markerFontWithSize:(CGFloat)size
{
    return [UIFont fontWithName:@"JasonSharpie" size:size];
}

@end
