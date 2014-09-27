//
//  DegreeButtonView.h
//  Guitar Scales Interactive
//
//  Created by Elena Boyd on 8/26/14.
//
//

#import <UIKit/UIKit.h>

typedef enum {
    DegreeButtonViewTypeSingle = 0,
    DegreeButtonViewTypeDouble = 0
} DegreeButtonViewType;

@protocol DegreeButtonViewDelegate <NSObject>

- (void)degreeTapped:(id)sender;

@end

@interface DegreeButtonView : UIView

@property (nonatomic, weak) id<DegreeButtonViewDelegate> delegate;
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, assign) BOOL selected;

@property (nonatomic, assign) DegreeButtonViewType degreeButtonType;

@end
