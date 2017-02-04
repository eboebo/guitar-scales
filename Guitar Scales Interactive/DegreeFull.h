//
//  DegreeFull.h
//  Guitar Scales Interactive
//
//  Created by Chris McQueen on 2/4/17.
//
//

#import <UIKit/UIKit.h>
#import "JSONModel.h"

@protocol DegreeFull
@end

@interface DegreeFull : JSONModel


// other
@property (nonatomic, assign) NSInteger identifier;
@property (nonatomic, assign) NSInteger number;
@property (nonatomic, assign) BOOL flat;
@property (nonatomic, assign) BOOL sharp;

@property (nonatomic, assign) NSInteger altNumber;
@property (nonatomic, assign) BOOL altFlat;
@property (nonatomic, assign) BOOL altSharp;

- (NSAttributedString *)toAttributedString;
- (NSAttributedString *)toAttributedStringCircleWithFontSize:(CGFloat)fontSize;
- (NSAttributedString *)toAttributedStringEnharmonic;


@end

