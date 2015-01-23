//
//  Position.h
//  Guitar Scales Interactive
//
//  Created by Elena Boyd on 1/22/15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Position : NSManagedObject

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSNumber * baseFret;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber * string;
@property (nonatomic, retain) NSString * finger;

+ (NSDictionary*)mappingDictionary;

@end
