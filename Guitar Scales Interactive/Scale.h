//
//  Scale.h
//  Guitar Scales Interactive
//
//  Created by Elena Boyd on 8/12/14.
//
//

#import <UIKit/UIKit.h>
#import "JSONModel.h"
#import "Group.h"

@interface Scale : JSONModel

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *modeTitle;
@property (nonatomic, strong) NSArray *selectedButtons;
@property (nonatomic, strong) NSArray<Group> *groups;

@end
