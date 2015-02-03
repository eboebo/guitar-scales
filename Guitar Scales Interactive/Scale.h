//
//  Scale.h
//  Guitar Scales Interactive
//
//  Created by Elena Boyd on 8/12/14.
//
//

#import <UIKit/UIKit.h>
#import "JSONModel.h"
#import "Position.h"

@interface Scale : JSONModel

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *menuTitle;
//@property (nonatomic, assign) double *kern;
@property (nonatomic, strong) NSArray *selectedDegrees;

@end
