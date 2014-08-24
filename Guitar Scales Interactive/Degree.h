//
//  Note.h
//  Guitar Scales Interactive
//
//  Created by Elena Boyd on 8/12/14.
//
//

#import <UIKit/UIKit.h>
#import "JSONModel.h"
#import "DegreePosition.h"

@protocol Degree
@end

@interface Degree : JSONModel


// other
@property (nonatomic, assign) NSInteger identifier;
@property (nonatomic, assign) NSInteger number;
@property (nonatomic, assign) BOOL flat;
@property (nonatomic, assign) BOOL sharp;
@property (nonatomic, strong) NSArray<DegreePosition> *degreePositions;

@end
