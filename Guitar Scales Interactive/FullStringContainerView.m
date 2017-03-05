//
//  FullStringContainerView.m
//  Guitar Scales Interactive
//
//  Created by Elena Stransky on 11/11/16.
//
//

#import "FullStringContainerView.h"
#import "GuitarStore.h"
#import "StringView.h"


@interface FullStringContainerView()
@property (nonatomic, strong) Position       *position;
@property (nonatomic, strong) Key            *key;
@property (nonatomic, strong) NSArray        *selectedDegrees;
@property (nonatomic, assign) NSInteger       currentPosition;
@property (strong, nonatomic) StringView     *mainStringView;

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
    
    // the very first time you click full string view
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tappedView:)];
    [self addGestureRecognizer:singleTap];
    
//    UISwipeGestureRecognizer *right = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleRightSwipeFrom:)];
//    [right setDirection:(UISwipeGestureRecognizerDirectionRight )];
//    [self addGestureRecognizer:right];
//    
//    UISwipeGestureRecognizer *left = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleLeftSwipeFrom:)];
//    [left setDirection:(UISwipeGestureRecognizerDirectionLeft)];
//    [self addGestureRecognizer:left];
}

- (void)layoutFretView {
    // effects the touching on either side of the box
    BOOL isLeftHand = [[GuitarStore sharedStore] isLeftHand];
    BOOL isiPad = [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad;
    
    CGFloat horizontalSpacing = self.bounds.size.width / 18.5;   // copied new numbers from FullStringView.m
    CGFloat verticalSpacing   = self.bounds.size.height / 7.4;
    CGFloat horizontalOffset = 0; // horizontalSpacing / 3.8;
    CGFloat verticalOffset   = verticalSpacing / 2.0;
    CGFloat width = self.bounds.size.width;
    CGFloat iPadExtraSpace = horizontalSpacing;
    
    if (!isiPad) {                                              // iPhone
        horizontalSpacing = self.bounds.size.width / 16.5;
        iPadExtraSpace = 0.0;
    }
    
    BOOL useShortScale = false;
    if ((self.position.identifier == 4) || (self.position.identifier == 5) || (self.position.identifier == 6))
    {
        useShortScale = true;            // only do 5 frets for some positions
    }
    
//     draw background
    NSInteger selectedOffset = [self offsetForPosition:self.position.identifier];
    CGFloat fretWidth;
    fretWidth = horizontalSpacing * 6.0;
//    if (useShortScale) {
//        fretWidth = horizontalSpacing * 5.0;
//    }
    
    CGFloat x = iPadExtraSpace + horizontalOffset + (selectedOffset * horizontalSpacing);
            // scoot the box over overhang, then add more depending on position

    if (isLeftHand) {
        x = width - x - fretWidth - iPadExtraSpace;
    }
    
    CGFloat y = 5 * verticalSpacing;
    
    self.fretView.frame = CGRectMake(x, verticalOffset, fretWidth, y);
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
    
    [UIView animateWithDuration:0.2 animations:^{
        [self layoutFretView];
    }];
}

- (void)setKey:(Key *)key {
    self.fullStringView.key = key;
    _key = key;
    
    [UIView animateWithDuration:0.2 animations:^{
        [self layoutFretView];
    }];
}

- (void)tappedView:(id)sender {
    CGPoint touchPoint = [sender locationInView:self];
    
    BOOL isLeftHand = [[GuitarStore sharedStore] isLeftHand];
    BOOL isiPad = [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad;
    
    if (!isiPad) {
        CGFloat horizontalSpacing = self.bounds.size.width / 17.25; // / 16.5;
        CGFloat horizontalOffset = horizontalSpacing * 0.7;
        
        CGFloat x = touchPoint.x - horizontalOffset;
        NSInteger newPosition = 0;
        NSInteger keyOffset = self.key.identifier - 3; // starting in the key of C
        if (keyOffset < 0) {
            keyOffset += 12;
        }
        
        CGFloat width = self.bounds.size.width;
        if (isLeftHand) {
            x = width - x - horizontalSpacing - (horizontalOffset * 0.5);
        }
        if (keyOffset == 0) {
            if      (x < horizontalSpacing * 1)  newPosition = 4;
            else if (x < horizontalSpacing * 3)  newPosition = 5;
            else if (x < horizontalSpacing * 5)  newPosition = 6;
            else if (x < horizontalSpacing * 6)  newPosition = 0;
            else if (x < horizontalSpacing * 8)  newPosition = 1;
            else if (x < horizontalSpacing * 9)  newPosition = 2;
            else if (x < horizontalSpacing * 12) newPosition = 3;
            else                                 newPosition = 4;
        }
        else if (keyOffset == 1) {
            if (x < horizontalSpacing * 2) newPosition = 4;
            else if (x < horizontalSpacing * 4) newPosition = 5;
            else if (x < horizontalSpacing * 6) newPosition = 6;
            else if (x < horizontalSpacing * 7) newPosition = 0;
            else if (x < horizontalSpacing * 9) newPosition = 1;
            else if (x < horizontalSpacing * 10) newPosition = 2;
            else if (x < horizontalSpacing * 13) newPosition = 3;
            else                                 newPosition = 4;
        }
        else if (keyOffset == 2) {
            if (x < horizontalSpacing * 3) newPosition = 4;
            else if (x < horizontalSpacing * 5) newPosition = 5;
            else if (x < horizontalSpacing * 7) newPosition = 6;
            else if (x < horizontalSpacing * 8) newPosition = 0;
            else if (x < horizontalSpacing * 10) newPosition = 1;
            else if (x < horizontalSpacing * 11) newPosition = 2;
            else                                 newPosition = 3;
        }
        else if (keyOffset == 3) {
            if (x < horizontalSpacing * 2) newPosition = 3;
            else if (x < horizontalSpacing * 4) newPosition = 4;
            else if (x < horizontalSpacing * 6) newPosition = 5;
            else if (x < horizontalSpacing * 8) newPosition = 6;
            else if (x < horizontalSpacing * 9) newPosition = 0;
            else if (x < horizontalSpacing * 11) newPosition = 1;
            else if (x < horizontalSpacing * 12) newPosition = 2;
            else                                 newPosition = 3;
        }
        else if (keyOffset == 4) {
            if (x < horizontalSpacing * 3) newPosition = 3;
            else if (x < horizontalSpacing * 5) newPosition = 4;
            else if (x < horizontalSpacing * 7) newPosition = 5;
            else if (x < horizontalSpacing * 9) newPosition = 6;
            else if (x < horizontalSpacing * 10) newPosition = 0;
            else if (x < horizontalSpacing * 12) newPosition = 1;
            else if (x < horizontalSpacing * 13) newPosition = 2;
            else                                 newPosition = 3;
        }
        else if (keyOffset == 5) {
            if (x < horizontalSpacing * 2) newPosition = 2;
            else if (x < horizontalSpacing * 4) newPosition = 3;
            else if (x < horizontalSpacing * 6) newPosition = 4;
            else if (x < horizontalSpacing * 8) newPosition = 5;
            else if (x < horizontalSpacing * 10) newPosition = 6;
            else if (x < horizontalSpacing * 11) newPosition = 0;
            else if (x < horizontalSpacing * 13) newPosition = 1;
            else if (x < horizontalSpacing * 14) newPosition = 2;
            else                                 newPosition = 3;
        }
        else if (keyOffset == 6) {
            if (x < horizontalSpacing * 2) newPosition = 1;
            else if (x < horizontalSpacing * 3) newPosition = 2;
            else if (x < horizontalSpacing * 5) newPosition = 3;
            else if (x < horizontalSpacing * 7) newPosition = 4;
            else if (x < horizontalSpacing * 9) newPosition = 5;
            else if (x < horizontalSpacing * 11) newPosition = 6;
            else if (x < horizontalSpacing * 12) newPosition = 0;
            else if (x < horizontalSpacing * 14) newPosition = 1;
            else if (x < horizontalSpacing * 15) newPosition = 2;
            else                                 newPosition = 3;
        }
        else if (keyOffset == 7) {
            if (x < horizontalSpacing * 1) newPosition = 0;
            else if (x < horizontalSpacing * 3) newPosition = 1;
            else if (x < horizontalSpacing * 4) newPosition = 2;
            else if (x < horizontalSpacing * 6) newPosition = 3;
            else if (x < horizontalSpacing * 8) newPosition = 4;
            else if (x < horizontalSpacing * 10) newPosition = 5;
            else if (x < horizontalSpacing * 12) newPosition = 6;
            else if (x < horizontalSpacing * 13) newPosition = 0;
            else                                 newPosition = 1;
        }
        else if (keyOffset == 8) {
            if (x < horizontalSpacing * 2) newPosition = 0;
            else if (x < horizontalSpacing * 4) newPosition = 1;
            else if (x < horizontalSpacing * 5) newPosition = 2;
            else if (x < horizontalSpacing * 7) newPosition = 3;
            else if (x < horizontalSpacing * 9) newPosition = 4;
            else if (x < horizontalSpacing * 11) newPosition = 5;
            else if (x < horizontalSpacing * 13) newPosition = 6;
            else                                 newPosition = 0;
        }
        else if (keyOffset == 9) {
            if (x < horizontalSpacing * 3) newPosition = 0;
            else if (x < horizontalSpacing * 5) newPosition = 1;
            else if (x < horizontalSpacing * 6) newPosition = 2;
            else if (x < horizontalSpacing * 8) newPosition = 3;
            else if (x < horizontalSpacing * 10) newPosition = 4;
            else if (x < horizontalSpacing * 12) newPosition = 5;
            else                                 newPosition = 6;
        }
        else if (keyOffset == 10) {
            if (x < horizontalSpacing * 3) newPosition = 6;
            else if (x < horizontalSpacing * 4) newPosition = 0;
            else if (x < horizontalSpacing * 6) newPosition = 1;
            else if (x < horizontalSpacing * 7) newPosition = 2;
            else if (x < horizontalSpacing * 9) newPosition = 3;
            else if (x < horizontalSpacing * 11) newPosition = 4;
            else if (x < horizontalSpacing * 13) newPosition = 5;
            else                                 newPosition = 6;
        }
        else if (keyOffset == 11) {
            if (x < horizontalSpacing * 2) newPosition = 5;
            else if (x < horizontalSpacing * 4) newPosition = 6;
            else if (x < horizontalSpacing * 5) newPosition = 0;
            else if (x < horizontalSpacing * 7) newPosition = 1;
            else if (x < horizontalSpacing * 8) newPosition = 2;
            else if (x < horizontalSpacing * 10) newPosition = 3;
            else if (x < horizontalSpacing * 12) newPosition = 4;
            else                                 newPosition = 5;
        }

        [self.delegate updateMainStringView:newPosition];
        [self.delegate toggleView];
    }
}

// COMMENTING OUT THIS SECTION FOR NEW KEY-BASED VERSION
- (void)handleLeftSwipeFrom:(UISwipeGestureRecognizer *)recognizer {
//    CGPoint point = [recognizer locationInView:[recognizer view]];
//
//    if (point.x < (self.fretView.frame.origin.x + self.fretView.frame.size.width)) {
//        [self.delegate decreasePosition];
//    }
}

- (void)handleRightSwipeFrom:(UISwipeGestureRecognizer *)recognizer {
//    CGPoint point = [recognizer locationInView:[recognizer view]];
//    
//    if (point.x > self.fretView.frame.origin.x) {
//        [self.delegate increasePosition];
//
//    }
}

@end
