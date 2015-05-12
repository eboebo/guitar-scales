//
//  OptionsViewController.h
//  Guitar Scales Interactive
//
//  Created by Elena Boyd on 4/28/15.
//
//

#import <UIKit/UIKit.h>

@protocol OptionsViewDelegate <NSObject>

- (void)didSelectOptionRow:(NSInteger)row;

@end

@interface OptionsViewController : UITableViewController
<UITableViewDataSource,
UITableViewDelegate>

@property (nonatomic, weak) id<OptionsViewDelegate> delegate;

@end
