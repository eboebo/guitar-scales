//
//  Key.h
//  Guitar Scales Interactive
//
//  Created by Chris McQueen on 1/15/17.
//
//

#import <UIKit/UIKit.h>
#import "Degree.h"
#import "JSONModel.h"

@protocol Key
@end

@interface Key : JSONModel

@property (nonatomic, assign) NSInteger identifier;
@property (nonatomic, strong) NSString *title;

@end
