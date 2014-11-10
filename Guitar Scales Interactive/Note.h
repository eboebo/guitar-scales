//
//  Note.h
//  Guitar Scales Interactive
//
//  Created by Elena Boyd on 8/12/14.
//
//

#import <UIKit/UIKit.h>
#import "JSONModel.h"
#import "NoteGroup.h"

@protocol Note
@end

@interface Note : JSONModel

//@property (nonatomic, assign) NSInteger degree;
//@property (nonatomic, strong) NSString *type;
//@property (nonatomic, assign) NSInteger x;
//@property (nonatomic, assign) NSInteger y;

// other
@property (nonatomic, assign) NSInteger identifier;
@property (nonatomic, assign) NSInteger number;
@property (nonatomic, assign) BOOL flat;
@property (nonatomic, assign) BOOL sharp;
@property (nonatomic, strong) NSArray<NoteGroup> *noteGroups;

@end
