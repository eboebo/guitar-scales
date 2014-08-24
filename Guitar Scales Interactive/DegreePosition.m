//
//  noteGroup.m
//  Guitar Scales Interactive
//
//  Created by Elena Boyd on 8/17/14.
//
//

#import "DegreePosition.h"

@implementation DegreePosition

+ (JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"position_id" : @"positionID",
                                                       @"coordinates": @"coordinates"}
            ];
}

@end
