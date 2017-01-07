//
//  ArrowButtonZoom.h
//  Guitar Scales Interactive
//
//  Created by Chris McQueen on 12/15/16.
//
//

#import <UIKit/UIKit.h>

typedef enum {
    ArrowButtonTypeRightZoom = 0,
    ArrowButtonTypeLeftZoom = 1,
} ArrowButtonTypeZoom;

@interface ArrowButtonZoom : UIButton

@property (nonatomic, assign) ArrowButtonTypeZoom type;

- (id)initWithFrame:(CGRect)frame andType:(ArrowButtonTypeZoom)buttonTypeZoom;



@end
