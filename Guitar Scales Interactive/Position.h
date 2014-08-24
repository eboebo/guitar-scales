//
//  Group.h
//  Guitar Scales Interactive
//
//  Created by Elena Boyd on 8/12/14.
//
//

#import <UIKit/UIKit.h>
#import "Note.h"
#import "JSONModel.h"

@protocol Group
@end

@interface Group : JSONModel

@property (nonatomic, strong) NSString *string;
@property (nonatomic, strong) NSString *finger;
@property (nonatomic, assign) NSInteger baseFret;
@property (nonatomic, strong) NSArray<Note> *notes;

@end
