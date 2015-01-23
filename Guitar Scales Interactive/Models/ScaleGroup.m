//
//  ScaleGroup.m
//  Guitar Scales Interactive
//
//  Created by Elena Boyd on 1/22/15.
//
//

#import "ScaleGroup.h"


@implementation ScaleGroup

@dynamic id;
@dynamic title;
@dynamic scales;

+ (NSDictionary*)mappingDictionary
{
    return @{@"id":@"id",
             @"title":@"title",
             @"scales":@"scales"};
}

@end
