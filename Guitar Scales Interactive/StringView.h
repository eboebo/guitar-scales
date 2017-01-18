//
//  StringView.h
//  Guitar Scales Interactive
//
//  Created by Elena Boyd on 8/12/14.
//
//

#import <UIKit/UIKit.h>
#import "Position.h"
#import "Key.h"

typedef enum {
    StringViewTypeIndex = 0,
    StringViewTypeMiddle = 1,
    StringViewTypePinky = 2
} StringViewType;

@interface StringView : UIView

@property (nonatomic, assign) BOOL           isMainView;
@property (nonatomic, strong) Position       *position;
@property (nonatomic, strong) Key            *key;
@property (nonatomic, strong) NSArray        *selectedDegrees;
@property (nonatomic, assign) StringViewType stringViewType;

@end
