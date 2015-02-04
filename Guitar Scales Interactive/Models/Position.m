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
                                                       @"position_id" : @"id",
                                                       @"string"   : @"string",
                                                       @"finger"   : @"finger",
                                                       @"base_fret": @"baseFret",
                                                       @"title"    : @"title"};
}

+ (void)importPositionsFromArray:(NSArray *)positions usingContext:(NSManagedObjectContext *)context
{

    for (NSDictionary *positionDictionary in positions)
    {
        Position *position = [NSEntityDescription insertNewObjectForEntityForName:@"Position"
                                                           inManagedObjectContext:context];
        [Position performDataMappingForObject:position
                      withMappingDictionary:[Position mappingDictionary]
                         withDataDictionary:positionDictionary];
    }
    NSError *error = nil;
    [context save:&error];
};

@end
