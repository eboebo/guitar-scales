//
//  FretView.m
//  Guitar Scales Interactive
//
//  Created by Elena Stransky on 11/11/16.
//
//

#import "FretView.h"
#import "GuitarStore.h"


@implementation FretView


- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    [self layoutFretView];

}


- (void)layoutFretView {
    BOOL isLeftHand = [[GuitarStore sharedStore] isLeftHand];
    
    CGFloat horizontalSpacing = self.bounds.size.width / 17;
    CGFloat verticalSpacing   = self.bounds.size.height / 6;
    CGFloat radiusVerticalSpacing = self.bounds.size.height / 6.0; // to be used to calculate radius
    CGFloat horizontalOffset = horizontalSpacing / 4.8;
    horizontalOffset = 0;
    CGFloat verticalOffset   = verticalSpacing / 2.0;
    CGFloat width = self.bounds.size.width;
    
    horizontalOffset += (horizontalSpacing / 2.0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // draw background
    NSInteger selectedOffset = [self offsetForPosition:self.position.identifier];
    for (int i = 0; i < 6; i++) {
        NSInteger selectedIndex = i + selectedOffset;
        CGFloat x = horizontalOffset + (selectedIndex * horizontalSpacing);
        
        if (isLeftHand) {
            x = width - x - horizontalSpacing;
        }
        CGFloat y = 5 * verticalSpacing + (verticalOffset * 2.0);
        CGRect fretFrame = CGRectMake(x, 0, horizontalSpacing, y);
        CGContextSetFillColorWithColor(context, [UIColor GuitarGray].CGColor);
        CGContextFillRect(context, fretFrame);
    }
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
@end
