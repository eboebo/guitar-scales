//
//  StringView.h
//  Guitar Scales Interactive
//
//  Created by Elena Boyd on 8/12/14.
//
//

#import <UIKit/UIKit.h>

@interface StringView : UIView

@property (nonatomic, strong) NSString *string;
@property (nonatomic, strong) NSString *finger;
@property (nonatomic, strong) NSArray *notes;
@property (nonatomic, assign) NSInteger fret;
@property (nonatomic, assign) BOOL isMainView;

@end
