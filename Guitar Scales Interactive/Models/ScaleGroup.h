//
//  ScaleGroup.h
//  Guitar Scales Interactive
//
//  Created by Elena Boyd on 1/22/15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ScaleGroup : NSManagedObject

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSOrderedSet *scales;

+ (NSDictionary*)mappingDictionary;

@end

@interface ScaleGroup (CoreDataGeneratedAccessors)

- (void)insertObject:(NSManagedObject *)value inScalesAtIndex:(NSUInteger)idx;
- (void)removeObjectFromScalesAtIndex:(NSUInteger)idx;
- (void)insertScales:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeScalesAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInScalesAtIndex:(NSUInteger)idx withObject:(NSManagedObject *)value;
- (void)replaceScalesAtIndexes:(NSIndexSet *)indexes withScales:(NSArray *)values;
- (void)addScalesObject:(NSManagedObject *)value;
- (void)removeScalesObject:(NSManagedObject *)value;
- (void)addScales:(NSOrderedSet *)values;
- (void)removeScales:(NSOrderedSet *)values;

@end
