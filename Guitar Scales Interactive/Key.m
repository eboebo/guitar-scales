//
//  Key.m
//  Guitar Scales Interactive
//
//  Created by Chris McQueen on 1/15/17.
//
//

#import "Key.h"

@implementation Key

+ (JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"key_id" : @"identifier",
                                                       @"title"    : @"title"}];
}

@end
