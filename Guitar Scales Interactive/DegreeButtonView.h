//
//  DegreeButtonView.h
//  Guitar Scales Interactive
//
//  Created by Elena Boyd on 8/26/14.
//
//

#import <UIKit/UIKit.h>

@protocol DegreeButtonViewDelegate <NSObject>

- (void)degreeTapped:(id)sender;

@end

@interface DegreeButtonView : UIView

@property (nonatomic, weak) id<DegreeButtonViewDelegate> delegate;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, assign) BOOL selected;

@end
