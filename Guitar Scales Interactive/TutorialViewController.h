//
//  TutorialViewController.h
//  Guitar Scales Interactive
//
//  Created by Elena Boyd on 10/19/14.
//
//

#import <UIKit/UIKit.h>

@protocol TutorialViewControllerDelegate <NSObject>

- (void)didCompleteTutorial;

@end

@interface TutorialViewController : UIViewController

@property (nonatomic, weak) id<TutorialViewControllerDelegate> delegate;

@end
