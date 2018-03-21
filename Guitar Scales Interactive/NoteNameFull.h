//
//  DegreeFull.h
//  Guitar Scales Interactive
//
//  Created by Chris McQueen on 2/4/17.
//
//

#import <UIKit/UIKit.h>
#import "JSONModel.h"
#import "Coordinate.h"

@protocol NoteNameFull
@end

@interface NoteNameFull : JSONModel


// other
@property (nonatomic, assign) NSInteger identifier;
@property (nonatomic, assign) NSString* name;
@property (nonatomic, assign) NSString* enharm;

@property (nonatomic, strong) NSArray<Coordinate> *coordinates;

- (NSAttributedString *)toAttributedString;
- (NSAttributedString *)toAttributedStringCircleWithFontSize:(CGFloat)fontSize;
//- (NSAttributedString *)toAttributedStringEnharmonic;


@end

