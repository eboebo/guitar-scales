//
//  NSManagedObject+Guitar.h
//  Guitar Scales Interactive
//
//  Created by Elena Boyd on 1/22/15.
//
//

#import <CoreData/CoreData.h>

@interface NSManagedObject (Guitar)

+ (id)performDataMappingForObject:(id)mappableObject withMappingDictionary:(NSDictionary *)mappingDictionary withDataDictionary:(NSDictionary *)dataDictionary;
@end
