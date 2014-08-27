//
//  MenuTableViewController.h
//  Guitar Scales Interactive
//
//  Created by Elena Boyd on 8/25/14.
//
//

#import <UIKit/UIKit.h>
#import "Scale.h"

@protocol MenuDelegate <NSObject>

- (void)didSelectScale:(Scale *)scale;

@end

@interface MenuTableViewController : UITableViewController

@property (nonatomic, weak) id<MenuDelegate> delegate;

@end
