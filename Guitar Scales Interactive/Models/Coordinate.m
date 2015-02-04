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
@dynamic positionID;

+ (NSDictionary*)mappingDictionary
{
    return @{@"x"   : @"x",
             @"y"   : @"y",
             @"color": @"color",
             @"position_id" : @"positionID"};
}

+ (void)importCoordinatesFromArray:(NSArray *)coordinates toDegree:(Degree *)degree usingContext:(NSManagedObjectContext *)context
{
    for (NSDictionary *coordDictionary in coordinates) {
        Coordinate *coordinate = [NSEntityDescription insertNewObjectForEntityForName:@"Coordinate" inManagedObjectContext:context];
        [Coordinate performDataMappingForObject:coordinate withMappingDictionary:[Coordinate mappingDictionary] withDataDictionary:coordDictionary];

        
        [degree addCoordinatesObject:coordinate];
    }
}

@end
