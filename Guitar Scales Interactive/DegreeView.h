//
//  buttonView.h
//  Guitar Scales Interactive
//
//  Created by Elena Boyd on 8/16/14.
//
//

#import <UIKit/UIKit.h>

@protocol DegreeViewDelegate <NSObject>

- (void)selectedDegreesModified:(NSMutableArray *)degrees;

@end

@interface DegreeView : UIView

@property (nonatomic, weak) id<DegreeViewDelegate> delegate;
@property (nonatomic, strong) NSMutableArray *selectedDegrees;
@property (strong, nonatomic) NSMutableArray *tempDegrees;
@property (strong, nonatomic) NSMutableArray *tempShowDegrees;
- (void)resetClearButton;
- (void)resetShowAllButton;

@end
