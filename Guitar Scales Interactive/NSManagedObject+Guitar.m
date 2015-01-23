//
//  NSManagedObject+Guitar.m
//  Guitar Scales Interactive
//
//  Created by Elena Boyd on 1/22/15.
//
//

#import "NSManagedObject+Guitar.h"
#import <objc/runtime.h>

@implementation NSManagedObject (Guitar)

+ (id)performDataMappingForObject:(id)mappableObject withMappingDictionary:(NSDictionary *)mappingDictionary withDataDictionary:(NSDictionary *)dataDictionary
{
    if (mappableObject == nil ||dataDictionary == nil || dataDictionary.count == 0) {
        return nil;
    }
    
    for (NSString *localAttributeName in mappingDictionary) {
        
        NSString *jsonPropertyName = [mappingDictionary objectForKey:localAttributeName];
        
        if ([dataDictionary objectForKey:jsonPropertyName]){  //Checking if value is empty
            id jsonValue = [dataDictionary objectForKey:jsonPropertyName]; //Value of object from remote API
            
            objc_property_t property = class_getProperty([mappableObject class], [localAttributeName UTF8String]); //Determining local property type
            char *property_type_attribute = property_copyAttributeValue(property, "T");
            NSString *propertyString = [NSString stringWithFormat:@"%s" , property_type_attribute];
            free(property_type_attribute);
            if ([propertyString isEqualToString: @"@\"NSString\""] && ![jsonValue isKindOfClass:[NSString class]]){ //Handling saving of Number into NSString
                [mappableObject setValue:[NSString stringWithFormat:@"%@", jsonValue] forKey:localAttributeName];
            }else if([propertyString isEqualToString: @"@\"NSNumber\""] && ![jsonValue isKindOfClass:[NSNumber class]]){ //Handling saving NSString into NSNumber
                [mappableObject setValue:[NSNumber numberWithInteger:[jsonValue intValue]] forKey:localAttributeName];
            }else{//Any other saves with matching data types.
                [mappableObject setValue:jsonValue forKey:localAttributeName];
            }
        }
    }
    
    return mappableObject;
}

@end
