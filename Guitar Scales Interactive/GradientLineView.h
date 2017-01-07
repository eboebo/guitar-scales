//
//  GradientLineView.h
//  Guitar Scales Interactive
//
//  Created by Chris McQueen on 12/15/16.
//
//

#import <UIKit/UIKit.h>
#import "Position.h"

typedef enum {
    GradientLinesLeft = 0,
    GradientLinesRight = 1,
} GradientLinesType;


@interface GradientLineView : UIButton

@property (nonatomic, assign) GradientLinesType type;
@property (nonatomic, strong) Position       *position;

- (id)initWithFrame:(CGRect)frame andType:(GradientLinesType)buttonType;



@end
