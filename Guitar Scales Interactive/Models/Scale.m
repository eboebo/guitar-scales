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
                                                       @"menu_title": @"menuTitle",
                                                       @"degrees": @"selectedDegrees",
                                                       
                                                       };
}

@end
