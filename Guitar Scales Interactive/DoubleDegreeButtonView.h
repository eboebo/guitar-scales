//
//  DoubleDegreeButtonView.h
//  Guitar Scales Interactive
//
//  Created by Elena Boyd on 9/25/14.
//
//

#import "DegreeButtonView.h"
#import "Degree.h"

typedef enum {
    DoubleDegreeButtonStateNone = 0,
    DoubleDegreeButtonStateBottom = 1,
    DoubleDegreeButtonStateTop = 2
} DoubleDegreeButtonState;

@protocol DoubleDegreeButtonDelegate <NSObject>

- (void)doubleDegreeButtonTapped:(id)sender;

@end

@interface DoubleDegreeButtonView : UIButton

@property (nonatomic, weak) id<DoubleDegreeButtonDelegate> delegate;
@property (nonatomic, strong) UILabel *secondTitleLabel;
@property (nonatomic, assign) DoubleDegreeButtonState currentState;
@property (nonatomic, strong) NSArray *buttonTags;

@property (nonatomic, assign) Degree *firstDegree;
@property (nonatomic, assign) Degree *secondDegree;




@end
