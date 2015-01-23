//
//  Position.m
//  Guitar Scales Interactive
//
//  Created by Elena Boyd on 1/22/15.
//
//

#import "Position.h"


@implementation Position

@dynamic id;
@dynamic baseFret;
@dynamic title;
@dynamic string;
@dynamic finger;

+ (NSDictionary*)mappingDictionary
{
    return @{
                                                       @"position_id" : @"identifier",
                                                       @"string"   : @"string",
                                                       @"finger"   : @"finger",
                                                       @"base_fret": @"baseFret",
                                                       @"title"    : @"title"};
}

@end
