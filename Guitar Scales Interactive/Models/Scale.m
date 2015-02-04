//
//  Scale.m
//  Guitar Scales Interactive
//
//  Created by Elena Boyd on 1/22/15.
//
//

#import "Scale.h"
#import "Degree.h"


@implementation Scale

@dynamic id;
@dynamic title;
@dynamic menuTitle;
@dynamic degrees;

+ (NSDictionary*)mappingDictionary
{
    return @{
                                                       @"title": @"title",
                                                       @"menu_title": @"menuTitle"
                                                       };
}

+ (void)importScalesFromArray:(NSArray *)scales toScaleGroup:(ScaleGroup *)scaleGroup usingContext:(NSManagedObjectContext *)context
{
    for (NSDictionary *scaleDictionary in scales)
    {
        Scale *scale = [NSEntityDescription insertNewObjectForEntityForName:@"Scale"
                                                          inManagedObjectContext:context];
        [Scale performDataMappingForObject:scale
                          withMappingDictionary:[Scale mappingDictionary]
                             withDataDictionary:scaleDictionary];
        NSArray *degreeArray = scaleDictionary[@"degrees"];
    }
    NSError *error = nil;
    [context save:&error];
}

@end
