//
//  Degree.h
//  Guitar Scales Interactive
//
//  Created by Elena Boyd on 1/22/15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "GuitarManagedObject.h"


@interface Degree : GuitarManagedObject

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSNumber * number;
@property (nonatomic, retain) NSNumber * flat;
@property (nonatomic, retain) NSNumber * sharp;
@property (nonatomic, retain) NSSet *coordinates;

@end

@interface Degree (CoreDataGeneratedAccessors)

+ (NSDictionary*)mappingDictionary;;
+ (void)importDegreesFromArray:(NSArray *)degrees usingContext:(NSManagedObjectContext *)context;

- (void)addCoordinatesObject:(NSManagedObject *)value;
- (void)removeCoordinatesObject:(NSManagedObject *)value;
- (void)addCoordinates:(NSSet *)values;
- (void)removeCoordinates:(NSSet *)values;

- (NSAttributedString *)toAttributedString;
- (NSAttributedString *)toAttributedStringCircle;
- (NSAttributedString *)toAttributedStringEnharmonic;

@end
