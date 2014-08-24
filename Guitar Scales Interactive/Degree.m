//
//  Note.m
//  Guitar Scales Interactive
//
//  Created by Elena Boyd on 8/12/14.
//
//

#import "Degree.h"

@implementation Degree

+ (JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"degree_id" : @"identifier",
                                                       @"degree_number"   : @"number",
                                                       @"flat"   : @"flat",
                                                       @"sharp": @"sharp",
                                                       @"degree_positions"    : @"degreePositions"}];
}

@end
