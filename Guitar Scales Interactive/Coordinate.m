//
//  Coordinate.m
//  Guitar Scales Interactive
//
//  Created by Elena Boyd on 8/17/14.
//
//

#import "Coordinate.h"

@implementation Coordinate

+ (JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                            
                                                       @"x"   : @"x",
                                                       @"y"   : @"y",
                                                       @"color": @"color"}
                                                    ];
}

@end
