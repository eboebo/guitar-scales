//
//  GuitarModel.h
//  Guitar Scales Interactive
//
//  Created by Elena Boyd on 2/3/15.
//
//

#import <CoreData/CoreData.h>

@interface GuitarManagedObject : NSManagedObject

+ (id)performDataMappingForObject:(id)mappableObject withMappingDictionary:(NSDictionary *)mappingDictionary withDataDictionary:(NSDictionary *)dataDictionary;

@end
