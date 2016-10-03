//
//  ArrowButton.h
//  Guitar Scales Interactive
//
//  Created by Elena Boyd on 9/26/16.
//
//

#import <UIKit/UIKit.h>

typedef enum {
    ArrowButtonTypeRight = 0,
    ArrowButtonTypeLeft = 1,
} ArrowButtonType;

@interface ArrowButton : UIButton

@property (nonatomic, assign) ArrowButtonType type;

- (id)initWithFrame:(CGRect)frame andType:(ArrowButtonType)buttonType;



@end
