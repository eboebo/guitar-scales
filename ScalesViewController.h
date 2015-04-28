//
//  ScalesViewController.h
//  Guitar Scales Interactive
//
//  Created by Elena Boyd on 8/12/14.
//
//

#import <UIKit/UIKit.h>

@protocol ScalesViewDelegate <NSObject>

- (void)didSelectRightButton;

@end

@interface ScalesViewController : UIViewController

@property (nonatomic, strong) NSMutableArray *selectedDegrees;
@property (nonatomic, strong) id<ScalesViewDelegate> delegate;

@end
