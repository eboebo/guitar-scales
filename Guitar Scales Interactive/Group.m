//
//  Group.m
//  Guitar Scales Interactive
//
//  Created by Elena Boyd on 8/12/14.
//
//

#import "Group.h"

@implementation Group

+ (JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"group_id" : @"identifier",
                                                       @"string"   : @"string",
                                                       @"finger"   : @"finger",
                                                       @"base_fret": @"baseFret",
                                                       @"title"    : @"title"}];
}

@end
