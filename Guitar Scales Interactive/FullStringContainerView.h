//
//  FullStringContainerView.h
//  Guitar Scales Interactive
//
//  Created by Elena Stransky on 11/11/16.
//
//

#import <UIKit/UIKit.h>
#import "FullStringView.h"
#import "FretView.h"

@protocol FullStringContainerViewDelegate <NSObject>

- (void)toggleView;
- (void)updateMainStringView:(NSInteger)newPosition;
- (void)increasePosition;
- (void)decreasePosition;
- (void)increaseKey;
- (void)decreaseKey;


@end


@interface FullStringContainerView : UIView

@property (nonatomic, weak) id<FullStringContainerViewDelegate> delegate;
@property (strong, nonatomic) FullStringView *fullStringView;
@property (strong, nonatomic) UIView *fretView;
@property (nonatomic, strong) NSMutableArray *positions;


- (void)updateStringViewPosition;
- (void)setPosition:(Position *)position;
- (void)setKey:(Key *)key;
- (void)setSelectedDegrees:(NSArray *)selectedDegrees;


@end
