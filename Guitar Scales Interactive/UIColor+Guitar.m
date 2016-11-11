//
//  UIColor+Guitar.m
//  Guitar Scales Interactive
//
//  Created by Elena Boyd on 8/24/14.
//
//

#import "UIColor+Guitar.h"

@implementation UIColor (Guitar)

+ (UIColor *)GuitarBlue  // main
{
//   return [UIColor colorWithRed:(62.0 / 255.0) green:(105.0 / 255.0) blue:(175.0 / 255.0) alpha:1];  // original
  //  return [UIColor colorWithRed:(224.0 / 255.0) green:(216.0 / 255.0) blue:(163.0 / 255.0) alpha:1];  // new
      return [UIColor colorWithRed:(75.0 / 255.0) green:(60.0 / 225.0) blue:(95.0 / 255.0) alpha:1];  // new
}

+ (UIColor *)GuitarLightBlue  // not used ?
{
    return [UIColor colorWithRed:0.796 green:0.839 blue:0.929 alpha:1];  // original
 //   return [UIColor colorWithRed:(232.0 / 255.0) green:(202.0 / 255.0) blue:(130.0 / 255.0) alpha:1];  // new
  //      return [UIColor colorWithRed:(220.0 / 255.0) green:(220.0 / 255.0) blue:(220.0 / 255.0) alpha:1];  // new
}

+ (UIColor *)GuitarMediumBlue  // light
{
 //   return [UIColor colorWithRed:(113.0 / 255.0) green:(139.0 / 255.0) blue:(188.0 / 255.0) alpha:1];  // original
 //   return [UIColor colorWithRed:(243.0 / 255.0) green:(235.0 / 255.0) blue:(178.0 / 255.0) alpha:1];  // new
 //   return [UIColor colorWithRed:(146.0 / 255.0) green:(130.0 / 255.0) blue:(168.0 / 255.0) alpha:1];  // new
    return [UIColor colorWithRed:(166.0 / 255.0) green:(158.0 / 255.0) blue:(178.0 / 255.0) alpha:1];  // new
}


+ (UIColor *)GuitarCream
{
    return [UIColor colorWithRed:(252.0 / 255.0) green:(251.0 / 255.0) blue:(236.0 / 255.0) alpha:1];
}

+ (UIColor *)GuitarDarkGray
{
    return [UIColor colorWithRed:(152.0 / 255.0) green:(152.0 / 255.0) blue:(152.0 / 255.0) alpha:1];
}

+ (UIColor *)GuitarGray
{
    return [UIColor colorWithRed:0.71 green:0.71 blue:0.69 alpha:1];
}

+ (UIColor *)GuitarLightGray
{
    return [UIColor colorWithRed:0.882 green:0.878 blue:0.878 alpha:1];
}

+ (UIColor *)GuitarRockBlue
{
    return [UIColor colorWithRed:0.58 green:0.68 blue:0.84 alpha:1.00];
}

+ (UIColor *)GuitarRose
{
    return [UIColor colorWithRed:0.85 green:0.64 blue:0.59 alpha:1.00];
}

+ (UIColor *)GuitarYellow
{
    return [UIColor colorWithRed:0.93 green:0.87 blue:0.55 alpha:1.00];
}

// new transparent colors

+ (UIColor *)blackColorAlpha
{
    return [UIColor colorWithRed:(150 / 255.0) green:(150 / 255.0) blue:(150 / 255.0) alpha:1];
}

+ (UIColor *)GuitarDarkGrayAlpha
{
    return [UIColor colorWithRed:(100.0 / 255.0) green:(100.0 / 255.0) blue:(100.0 / 255.0) alpha:0.25];
}

+ (UIColor *)GuitarRockBlueAlpha
{
    return [UIColor colorWithRed:0.58 green:0.68 blue:0.84 alpha:0.36];
}

+ (UIColor *)GuitarRoseAlpha
{
    return [UIColor colorWithRed:0.85 green:0.64 blue:0.59 alpha:0.36];
}

+ (UIColor *)GuitarYellowAlpha
{
    return [UIColor colorWithRed:0.93 green:0.87 blue:0.55 alpha:0.40];
}


@end
