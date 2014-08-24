//
//  noteGroup.h
//  Guitar Scales Interactive
//
//  Created by Elena Boyd on 8/17/14.
//
//

#import "JSONModel.h"
#import "Coordinate.h"

@protocol DegreePosition <NSObject>


@end

@interface DegreePosition : JSONModel

@property (nonatomic, assign) NSInteger positionID;
@property (nonatomic, strong) NSArray<Coordinate> *coordinates;

@end
