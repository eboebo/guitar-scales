//
//  FullStringView.h
//  Guitar Scales Interactive
//
//  Created by Elena Boyd on 9/26/16.
//
//

#import <UIKit/UIKit.h>
#import "Position.h"
#import "Key.h"


@interface FullStringView : UIView

@property (nonatomic, assign) BOOL           isMainView;
@property (nonatomic, strong) Position       *position;
@property (nonatomic, strong) Key            *key;
@property (nonatomic, strong) NSArray        *selectedDegrees;

@end
