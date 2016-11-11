//
//  FullStringContainerView.m
//  Guitar Scales Interactive
//
//  Created by Elena Stransky on 11/11/16.
//
//

#import "FullStringContainerView.h"
#import "GuitarStore.h"


@interface FullStringContainerView()
@property (nonatomic, strong) Position       *position;
@property (nonatomic, strong) NSArray        *selectedDegrees;

@property (assign,nonatomic) BOOL didStartInFretView;
@end

@implementation FullStringContainerView

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.backgroundColor = [UIColor clearColor];
    
    self.didStartInFretView = false;
    
    self.fretView = [[UIView alloc] initWithFrame:self.bounds];
    [self addSubview:self.fretView];
    [self layoutFretView];
    
    
    self.fullStringView = [[FullStringView alloc] initWithFrame:self.bounds];
    [self addSubview:self.fullStringView];
    self.fullStringView.selectedDegrees = self.selectedDegrees;
    self.fullStringView.position = self.position;
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tappedView:)];
    [self addGestureRecognizer:singleTap];
    
    UISwipeGestureRecognizer *right = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleRightSwipeFrom:)];
    [right setDirection:(UISwipeGestureRecognizerDirectionRight )];
    [self addGestureRecognizer:right];
    
    UISwipeGestureRecognizer *left = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleLeftSwipeFrom:)];
    [left setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [self addGestureRecognizer:left];
}

- (void)layoutFretView {
    BOOL isLeftHand = [[GuitarStore sharedStore] isLeftHand];
    
    CGFloat horizontalSpacing = self.bounds.size.width / 17;
    CGFloat verticalSpacing   = self.bounds.size.height / 6;
    CGFloat horizontalOffset = horizontalSpacing / 4.8;
    horizontalOffset = 0;
    CGFloat verticalOffset   = verticalSpacing / 2.0;
    CGFloat width = self.bounds.size.width;
    
    horizontalOffset += (horizontalSpacing / 2.0);
    
    // draw background
    NSInteger selectedOffset = [self offsetForPosition:self.position.identifier];
    CGFloat fretWidth = horizontalSpacing * 6.0;
    
    CGFloat x = horizontalOffset + (selectedOffset * horizontalSpacing);

    if (isLeftHand) {
        x = width - x - horizontalSpacing;
    }
    
    CGFloat y = 5 * verticalSpacing + (verticalOffset * 2.0);
    self.fretView.backgroundColor = [UIColor GuitarGray];
    self.fretView.frame = CGRectMake(x, 0, fretWidth, y);
}

- (NSInteger)offsetForPosition:(NSInteger)identifier {
    switch (identifier) {
        case 0:
            return 0;
        case 1:
            return 7;
        case 2:
            return 2;
        case 3:
            return 9;
        case 4:
            return 4;
        case 5:
            return 11;
        case 6:
            return 6;
        default:
            return 0;
    }
}


- (void)updateStringViewPosition {
    [self.fullStringView setNeedsDisplay];
}

- (void)setSelectedDegrees:(NSArray *)selectedDegrees {
    self.fullStringView.selectedDegrees = selectedDegrees;

}

- (void)setPosition:(Position *)position {
    self.fullStringView.position = position;
    _position = position;
    
    [UIView animateWithDuration:0.5 animations:^{
        [self layoutFretView];
    }];
}

- (void)tappedView:(id)sender {
    CGPoint touchPoint = [sender locationInView:self];
    
    BOOL isLeft = touchPoint.x < self.fretView.frame.origin.x;
    BOOL isRight = touchPoint.x > (self.fretView.frame.origin.x + self.fretView.frame.size.width);
    BOOL isPointInsideView = !isLeft && !isRight;
    
    if (isPointInsideView) {
        [self.delegate toggleView];
    } else if (isLeft) {
        [self.delegate decreasePosition];
    } else if (isRight){
        [self.delegate increasePosition];
    }
}

- (void)handleLeftSwipeFrom:(UISwipeGestureRecognizer *)recognizer {
    CGPoint point = [recognizer locationInView:[recognizer view]];

    if (point.x < (self.fretView.frame.origin.x + self.fretView.frame.size.width)) {
        [self.delegate decreasePosition];
    }
}

- (void)handleRightSwipeFrom:(UISwipeGestureRecognizer *)recognizer {
    CGPoint point = [recognizer locationInView:[recognizer view]];
    
    if (point.x > self.fretView.frame.origin.x) {
        [self.delegate increasePosition];

    }
}

@end
