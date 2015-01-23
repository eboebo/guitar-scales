//
//  Coordinate.m
//  Guitar Scales Interactive
//
//  Created by Elena Boyd on 1/22/15.
//
//

#import "Coordinate.h"


@implementation Coordinate

@dynamic id;
@dynamic x;
@dynamic y;
@dynamic color;
@dynamic position;

+ (NSDictionary*)mappingDictionary
{
    return @{
             
             @"x"   : @"x",
             @"y"   : @"y",
             @"color": @"color"};
}

@end
