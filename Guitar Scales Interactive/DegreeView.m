//
//  buttonView.m
//  Guitar Scales Interactive
//
//  Created by Elena Boyd on 8/16/14.
//
//

#import "GuitarStore.h"
#import "DegreeView.h"
#import "Degree.h"
#import "DegreeButtonView.h"
#import "DoubleDegreeButtonView.h"

@interface DegreeView ()
<DegreeButtonViewDelegate,
 DoubleDegreeButtonDelegate>


@property (nonatomic, strong) UIButton *clearAllButton;
@property (nonatomic, strong) UIButton *showAllButton;

@end

@implementation DegreeView

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews
{
    self.backgroundColor = [UIColor clearColor];
    self.clearAllButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.clearAllButton setTitle:@"CLEAR ALL" forState:UIControlStateNormal];
    [self.clearAllButton setTintColor:[UIColor GuitarBlue]];
    self.clearAllButton.titleLabel.font = [UIFont proletarskFontWithSize:17.0f];
    [self.clearAllButton addTarget:self action:@selector(clearAllTap:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.clearAllButton];
    
    self.showAllButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.showAllButton setTitle:@"SHOW ALL" forState:UIControlStateNormal];
    [self.showAllButton setTintColor:[UIColor GuitarBlue]];
    self.showAllButton.titleLabel.font = [UIFont proletarskFontWithSize:17.0f];

    [self.showAllButton addTarget:self action:@selector(showAllTap:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.showAllButton];

}

- (void)drawRect:(CGRect)rect
{
    //draw the bottom border
    float borderSize = 3.0f;
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor GuitarBlue].CGColor);
    CGContextFillRect(context, CGRectMake(0.0f, self.frame.size.height - borderSize, self.frame.size.width, borderSize));
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat textButtonWidth = 120.0f;
    
    CGRect bounds = self.bounds;
    
    CGRect clearFrame = CGRectMake(0, 0, textButtonWidth, bounds.size.height);
    self.clearAllButton.frame = clearFrame;
    
    CGRect showFrame = CGRectMake(bounds.size.width - textButtonWidth, 0, textButtonWidth, bounds.size.height);
    self.showAllButton.frame = showFrame;
    

    
    NSArray *degreeButtonArray = [[GuitarStore sharedStore] degreeButtonArray];
    NSArray *degrees = [[GuitarStore sharedStore] degrees];
    
    CGFloat buttonBoardWidth = bounds.size.width - textButtonWidth * 2.0;
    CGFloat smallButtonWidth = buttonBoardWidth / degreeButtonArray.count;

    for (int i = 0; i < degreeButtonArray.count; i++) {
        
        CGFloat x = textButtonWidth + (i * smallButtonWidth);
        CGRect buttonFrame = CGRectMake(x, 0, smallButtonWidth, bounds.size.height);
        
        NSArray *degreeArray = degreeButtonArray[i];
        
        if (degreeArray.count == 1) {
            DegreeButtonView *degreeButton = [[DegreeButtonView alloc] initWithFrame:CGRectZero];
            degreeButton.frame = buttonFrame;
            degreeButton.delegate = self;
            
            NSString *identifier = degreeArray[0];
            Degree *degree = degrees[[identifier integerValue]];
            [degreeButton.titleLabel setAttributedText:[degree toAttributedString]];
            degreeButton.tag = degree.identifier;
            
            if ([self containsId:degree.identifier]) {
                [degreeButton setSelected:YES];
            } else {
                [degreeButton setSelected:NO];
            }
            [self addSubview:degreeButton];

        } else if (degreeArray.count == 2) {
            DoubleDegreeButtonView *doubleButtonView = [[DoubleDegreeButtonView alloc] initWithFrame:CGRectZero];
            doubleButtonView.frame = buttonFrame;
            doubleButtonView.delegate = self;
            
            NSString *identifier = degreeArray[0];
            Degree *degree = degrees[[identifier integerValue]];
            [doubleButtonView.titleLabel setAttributedText:[degree toAttributedString]];
            doubleButtonView.buttonTags = degreeArray;
            
            if ([self containsId:degree.identifier]) {
                doubleButtonView.currentState = DoubleDegreeButtonStateTop;
            }
            
            identifier = degreeArray[1];
            degree = degrees[[identifier integerValue]];
            [doubleButtonView.secondTitleLabel setAttributedText:[degree toAttributedString]];
            
            if ([self containsId:degree.identifier]) {
                doubleButtonView.currentState = DoubleDegreeButtonStateBottom;

            }
            
            [self addSubview:doubleButtonView];

        }
    }
}

- (void)setNeedsDisplay
{
    [super setNeedsDisplay];
    [self layoutSubviews];
}


- (void)clearAllTap:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(selectedDegreesModified:)]) {
        [self.delegate selectedDegreesModified:[NSMutableArray new]];
    }
    self.selectedDegrees = [NSMutableArray new];
    [self setNeedsDisplay];
}

- (void)showAllTap:(id)sender
{
    NSArray *degrees = [[GuitarStore sharedStore] degreeButtonArray];
    NSMutableArray *degreeArray = [NSMutableArray new];
    for (NSArray *degreeButtonArray in degrees) {

        NSString *identifier =  degreeButtonArray[0];
        [degreeArray addObject:identifier];
    }
    if ([self.delegate respondsToSelector:@selector(selectedDegreesModified:)]) {
        [self.delegate selectedDegreesModified:degreeArray];
    }
    
    self.selectedDegrees = degreeArray;
    
    [self setNeedsDisplay];
}

- (BOOL)containsId:(NSInteger)identifier
{
    for (int i = 0; i < self.selectedDegrees.count; i++) {
        NSInteger buttonID = [self.selectedDegrees[i] integerValue];
        if (buttonID == identifier) {
            return YES;
            break;
        }
    }
    return NO;
}

- (void)degreeTapped:(id)sender
{
    DegreeButtonView *degreeButton = (DegreeButtonView *)sender;
    if (degreeButton.selected) {
        NSNumber *number = [NSNumber numberWithInteger:degreeButton.tag];
        [self.selectedDegrees insertObject:number atIndex:0];
    } else {
        for (NSNumber *degree in self.selectedDegrees) {
            if ([degree integerValue]  == degreeButton.tag) {
                [self.selectedDegrees removeObject:degree];
                break;
            }
        }
    }

    if ([self.delegate respondsToSelector:@selector(selectedDegreesModified:)]) {
        [self.delegate selectedDegreesModified:self.selectedDegrees];
    }
}

- (void)doubleDegreeButtonTapped:(id)sender
{
    DoubleDegreeButtonView *degreeButton = (DoubleDegreeButtonView *)sender;


    NSInteger insertIdentifier;
    NSInteger removeIdentifier;
    
    if (degreeButton.currentState == DoubleDegreeButtonStateBottom) {
        insertIdentifier = [degreeButton.buttonTags[1] integerValue];
        removeIdentifier = [degreeButton.buttonTags[0] integerValue];
    } else if (degreeButton.currentState == DoubleDegreeButtonStateTop) {
        insertIdentifier = [degreeButton.buttonTags[0] integerValue];
    } else {
        removeIdentifier = [degreeButton.buttonTags[1] integerValue];
    }
    
    if (insertIdentifier) {
        NSNumber *number = [NSNumber numberWithInteger:insertIdentifier];
        [self.selectedDegrees insertObject:number atIndex:0];
    }
    
    if (removeIdentifier) {
        for (NSNumber *degree in self.selectedDegrees) {
            if ([degree integerValue]  == removeIdentifier) {
                [self.selectedDegrees removeObject:degree];
                break;
            }
        }
    }
    
    if ([self.delegate respondsToSelector:@selector(selectedDegreesModified:)]) {
        [self.delegate selectedDegreesModified:self.selectedDegrees];
    }
}

@end
