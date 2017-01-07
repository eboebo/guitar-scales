//
//  GuitarStore.h
//  Guitar Scales Interactive
//
//  Created by Elena Boyd on 8/16/14.
//
//

#import <Foundation/Foundation.h>
#import "Scale.h"

typedef void (^UpdateCallback)(BOOL success);

@interface GuitarStore : NSObject

@property (nonatomic, strong) NSArray *degreeButtonArray;
@property (nonatomic, strong) NSMutableArray *scales2DArray;
@property (nonatomic, strong) NSMutableArray *positions;
@property (nonatomic, strong) NSMutableArray *degrees;
@property (nonatomic, copy) UpdateCallback callback;
@property (nonatomic, strong) Scale *selectedScale;
@property (nonatomic, strong) Scale *chromaticScale;



+ (GuitarStore *)sharedStore;
- (void)parseData;
- (void)setDisplayedTutorial;
- (BOOL)displayedTutorial;
- (void)setShowDegrees:(BOOL)sDegrees;
- (BOOL)showDegrees;
- (void)setLeftHand:(BOOL)leftHand;
- (BOOL)isLeftHand;
- (void)setFlipped:(BOOL)flipped;
- (BOOL)isFlipped;




@end
