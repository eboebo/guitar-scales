//
//  Group.m
//  Guitar Scales Interactive
//
//  Created by Elena Boyd on 8/12/14.
//
//

#import "Position.h"

@implementation Position

+ (JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"position_id" : @"identifier",
                                                       @"string"   : @"string",
                                                       @"finger"   : @"finger",
                                                       @"base_fret": @"baseFret",
                                                       @"title"    : @"title"}];
}

@end
