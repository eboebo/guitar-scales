//
//  GuitarModel.m
//  Guitar Scales Interactive
//
//  Created by Elena Boyd on 2/3/15.
//
//

#import "GuitarManagedObject.h"

@implementation GuitarManagedObject

+ (id)performDataMappingForObject:(id)mappableObject withMappingDictionary:(NSDictionary *)mappingDictionary withDataDictionary:(NSDictionary *)dataDictionary
{
    if (mappableObject == nil ||dataDictionary == nil || dataDictionary.count == 0) {
        return nil;
    }
    
    for (NSString *localAttributeName in mappingDictionary) {
        
        NSString *sagePropertyName = [mappingDictionary objectForKey:localAttributeName];
        
        if (![WFMUtility isBlankOrNull:[dataDictionary objectForKey:sagePropertyName]]){  //Checking if value is empty
            id valueFromSage = [dataDictionary objectForKey:sagePropertyName]; //Value of object from remote API
            
            objc_property_t property = class_getProperty([mappableObject class], [localAttributeName UTF8String]); //Determining local property type
            char *property_type_attribute = property_copyAttributeValue(property, "T");
            NSString *propertyString = [NSString stringWithFormat:@"%s" , property_type_attribute];
            free(property_type_attribute);
            if ([propertyString isEqualToString: @"@\"NSDate\""]){ //Handling Date saving
                if ([self isValidISO8601DateTimeStamp:valueFromSage]) {
                    NSDate *dateTimeStamp = [[WFMCoreCoreDataManager sharedManager].dateFormatter dateFromString:valueFromSage];
                    [mappableObject setValue:dateTimeStamp forKey:localAttributeName];
                } else {
                    NSNumber* timestamp = [[WFMCoreCoreDataManager sharedManager].numberFormatter numberFromString:valueFromSage];
                    [mappableObject setValue:[WFMUtility getDateFromTimeStamp:[timestamp integerValue]] forKey:localAttributeName];
                }
            } else if ([propertyString isEqualToString: @"@\"NSString\""] && ![valueFromSage isKindOfClass:[NSString class]]){ //Handling saving of Number into NSString
                [mappableObject setValue:[NSString stringWithFormat:@"%@", valueFromSage] forKey:localAttributeName];
            }else if([propertyString isEqualToString: @"@\"NSNumber\""] && ![valueFromSage isKindOfClass:[NSNumber class]]){ //Handling saving NSString into NSNumber
                [mappableObject setValue:[NSNumber numberWithInteger:[valueFromSage intValue]] forKey:localAttributeName];
            }else{//Any other saves with matching data types.
                [mappableObject setValue:valueFromSage forKey:localAttributeName];
            }
        }
    }
    return mappableObject;
}

@end
