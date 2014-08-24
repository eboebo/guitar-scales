//
//  StringView.h
//  Guitar Scales Interactive
//
//  Created by Elena Boyd on 8/12/14.
//
//

#import <UIKit/UIKit.h>
#import "Position.h"

@interface StringView : UIView

@property (nonatomic, assign) BOOL isMainView;

@property (nonatomic, strong) Position *position;
@property (nonatomic, strong) NSArray *selectedDegrees;

@end
