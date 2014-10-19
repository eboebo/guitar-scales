//
//  NSMutableArray+Guitar.m
//  Guitar Scales Interactive
//
//  Created by Elena Boyd on 8/27/14.
//
//

#import "NSMutableArray+Guitar.h"

@implementation NSMutableArray (Guitar)

- (BOOL)equalDegrees:(NSArray *)array
{
    if (self.count != array.count) {
        return NO;
    }
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"intValue" ascending:YES];
    NSArray *sortedSelf = [self sortedArrayUsingDescriptors:@[sortDescriptor]];
    NSArray *sortedArray = [array sortedArrayUsingDescriptors:@[sortDescriptor]];

    for (int i = 0; i < sortedSelf.count; i++) {
        if ([sortedSelf[i] integerValue] != [sortedArray[i] integerValue]) {
            return NO;
            break;
        }
    }
    //minor pentatonic
    return YES;
}

@end
