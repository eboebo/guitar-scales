//
//  FretView.h
//  Guitar Scales Interactive
//
//  Created by Elena Stransky on 11/11/16.
//
//

#import <UIKit/UIKit.h>
#import "Position.h"

@interface FretView : UIView

@property (nonatomic, strong) Position       *position;
@property (nonatomic, strong) NSArray        *selectedDegrees;

@end
