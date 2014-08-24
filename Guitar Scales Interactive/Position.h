//
//  Position.h
//  Guitar Scales Interactive
//
//  Created by Elena Boyd on 8/12/14.
//
//

#import <UIKit/UIKit.h>
#import "Degree.h"
#import "JSONModel.h"

@protocol Position
@end

@interface Position : JSONModel

@property (nonatomic, assign) NSInteger identifier;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *string;
@property (nonatomic, strong) NSString *finger;
@property (nonatomic, assign) NSInteger baseFret;

@end
