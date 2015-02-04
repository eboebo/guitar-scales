//
//  Scale.h
//  Guitar Scales Interactive
//
//  Created by Elena Boyd on 1/22/15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "GuitarManagedObject.h"
#import "ScaleGroup.h"

@class Degree;

@interface Scale : GuitarManagedObject

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * menuTitle;
@property (nonatomic, retain) NSSet *degrees;
@end

@interface Scale (CoreDataGeneratedAccessors)

- (void)addDegreesObject:(Degree *)value;
- (void)removeDegreesObject:(Degree *)value;
- (void)addDegrees:(NSSet *)values;
- (void)removeDegrees:(NSSet *)values;

+ (NSDictionary*)mappingDictionary;
+ (void)importScalesFromArray:(NSArray *)scales toScaleGroup:(ScaleGroup *)scaleGroup usingContext:(NSManagedObjectContext *)context;

@end
