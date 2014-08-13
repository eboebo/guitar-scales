//
//  Note.h
//  Guitar Scales Interactive
//
//  Created by Elena Boyd on 8/12/14.
//
//

#import <UIKit/UIKit.h>
#import "JSONModel.h"

@protocol Note
@end

@interface Note : JSONModel

@property (nonatomic, assign) NSInteger degree;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, assign) NSInteger x;
@property (nonatomic, assign) NSInteger y;

@end
