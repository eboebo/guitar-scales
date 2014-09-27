//
//  DoubleDegreeButtonView.h
//  Guitar Scales Interactive
//
//  Created by Elena Boyd on 9/25/14.
//
//

#import "DegreeButtonView.h"

typedef enum {
    DoubleDegreeButtonStateNone = 0,
    DoubleDegreeButtonStateTop = 1,
    DoubleDegreeButtonStateBottom = 2
} DoubleDegreeButtonState;

@protocol DoubleDegreeButtonDelegate <NSObject>

- (void)doubleDegreeButtonTapped:(id)sender;

@end

@interface DoubleDegreeButtonView : DegreeButtonView

@property (nonatomic, weak) id<DoubleDegreeButtonDelegate> delegate;
@property (nonatomic, strong) UILabel *secondTitleLabel;
@property (nonatomic, assign) DoubleDegreeButtonState currentState;
@property (nonatomic, strong) NSArray *buttonTags;



@end
