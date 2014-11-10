//
//  noteGroup.h
//  Guitar Scales Interactive
//
//  Created by Elena Boyd on 8/17/14.
//
//

#import "JSONModel.h"
#import "Coordinate.h"

@protocol NoteGroup <NSObject>


@end

@interface NoteGroup : JSONModel

@property (nonatomic, assign) NSInteger positionID;
@property (nonatomic, strong) NSArray<Coordinate> *coordinates;

@end
