//
//  Coordinate.h
//  Guitar Scales Interactive
//
//  Created by Elena Boyd on 1/22/15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Degree.h"
#import "GuitarManagedObject.h"

@interface Coordinate : GuitarManagedObject

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSNumber * x;
@property (nonatomic, retain) NSNumber * y;
@property (nonatomic, retain) NSString * color;
@property (nonatomic, retain) NSString * positionID;

+ (NSDictionary*)mappingDictionary;
+ (void)importCoordinatesFromArray:(NSArray *)coordinates toDegree:(Degree *)degree usingContext:(NSManagedObjectContext *)context;

@end
