//
//  Coordinate.h
//  Guitar Scales Interactive
//
//  Created by Elena Boyd on 8/17/14.
//
//

#import "JSONModel.h"

@protocol Coordinate
@end

@interface Coordinate : JSONModel


@property (nonatomic, assign) NSInteger x;
@property (nonatomic, assign) NSInteger y;
@property (nonatomic, strong) NSString *color;



@end
