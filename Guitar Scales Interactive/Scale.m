//
//  Scale.m
//  Guitar Scales Interactive
//
//  Created by Elena Boyd on 8/12/14.
//
//

#import "Scale.h"

@implementation Scale

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"title": @"title",
                                                       @"mode_title": @"modeTitle",
                                                       @"degrees": @"selectedDegrees",
                                                       
                                                       }];
}

@end
