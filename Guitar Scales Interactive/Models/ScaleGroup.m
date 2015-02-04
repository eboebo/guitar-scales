//
//  ScaleGroup.m
//  Guitar Scales Interactive
//
//  Created by Elena Boyd on 1/22/15.
//
//

#import "ScaleGroup.h"
#import "Scale.h"


@implementation ScaleGroup

@dynamic id;
@dynamic title;
@dynamic scales;

+ (NSDictionary*)mappingDictionary
{
    return @{@"id":@"id",
             @"title":@"title"};
}

+ (void)importScaleGroupsFromArray:(NSArray *)scaleGroups usingContext:(NSManagedObjectContext *)context
{
    for (NSDictionary *scaleGroup in scaleGroups)
    {
        ScaleGroup *group = [NSEntityDescription insertNewObjectForEntityForName:@"ScaleGroup"
                                                       inManagedObjectContext:context];
        [ScaleGroup performDataMappingForObject:group
                      withMappingDictionary:[ScaleGroup mappingDictionary]
                         withDataDictionary:scaleGroup];
        [Scale importScalesFromArray:scaleGroup[@"scales"] toScaleGroup:group usingContext:context];
    }
    NSError *error = nil;
    [context save:&error];
}


@end
