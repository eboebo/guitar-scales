//
//  DegreeFull.m
//  Guitar Scales Interactive
//
//  Created by Chris McQueen on 2/4/17.
//
//

#import "NoteNameFull.h"

@implementation NoteNameFull

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

+ (JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"degree_id" : @"identifier",
                                                       @"note_name"   : @"name",
                                                       @"enharm"   : @"enharm",
                                                       @"coordinates": @"coordinates"}];
}

- (NSAttributedString *)toAttributedString
{
    CGRect bounds = [[UIScreen mainScreen] bounds];
    CGFloat regFontSize = bounds.size.width / 18.53;
    CGFloat specialFontSize = bounds.size.width / 19.62;
    
    NSString *degreeString = [[NSString alloc] initWithString:self.name];
    NSMutableAttributedString *degreeAttributedString = [[NSMutableAttributedString alloc] initWithString:degreeString];
    if (self.name.length > 1) {
        [degreeAttributedString addAttribute:NSFontAttributeName
                                       value:[UIFont svBasicManualFontWithSize:regFontSize]
                                       range:NSMakeRange(0, 1)];
        [degreeAttributedString addAttribute:NSFontAttributeName
                                       value:[UIFont bravuraFontWithSize:specialFontSize]
                                       range:NSMakeRange(1, 1)];
    } else {
        [degreeAttributedString addAttribute:NSFontAttributeName
                                       value:[UIFont svBasicManualFontWithSize:regFontSize]
                                       range:NSMakeRange(0, 1)];
    }
    return degreeAttributedString;
}

//- (NSAttributedString *)toAttributedStringEnharmonic
//{
//    NSString *rightChar = @"";
//    if (self.flat) {
//        rightChar = @"b";
//    } else if (self.sharp) {
//        rightChar = @"#";
//    }
//    
//    CGRect bounds = [[UIScreen mainScreen] bounds];
//    CGFloat fontSize = bounds.size.width / 22.23;
//    
//    
//    NSString *degreeString = [NSString stringWithFormat:@"%@%ld", rightChar, (long)self.number];
//    NSMutableAttributedString *degreeAttributedString = [[NSMutableAttributedString alloc] initWithString:degreeString];
//    if (self.flat || self.sharp) {
//        [degreeAttributedString addAttribute:NSFontAttributeName
//                                       value:[UIFont bravuraFontWithSize:fontSize]
//                                       range:NSMakeRange(0, 1)];
//        [degreeAttributedString addAttribute:NSFontAttributeName
//                                       value:[UIFont svBasicManualFontWithSize:fontSize]
//                                       range:NSMakeRange(1, 1)];
//    } else {
//        [degreeAttributedString addAttribute:NSFontAttributeName
//                                       value:[UIFont svBasicManualFontWithSize:fontSize]
//                                       range:NSMakeRange(0, 1)];
//    }
//    return degreeAttributedString;
//}

- (NSAttributedString *)toAttributedStringCircleWithFontSize:(CGFloat)fontSize
{
   NSString *degreeString = [[NSString alloc] initWithString:self.name];
    NSMutableAttributedString *degreeAttributedString = [[NSMutableAttributedString alloc] initWithString:degreeString];
    if (self.name.length > 1) {
        [degreeAttributedString addAttribute:NSFontAttributeName
                                       value:[UIFont svBasicManualFontWithSize:fontSize]
                                       range:NSMakeRange(0, 1)];
        [degreeAttributedString addAttribute:NSFontAttributeName
                                       value:[UIFont bravuraFontWithSize:fontSize]
                                       range:NSMakeRange(1, 1)];
    } else {
        [degreeAttributedString addAttribute:NSFontAttributeName
                                       value:[UIFont svBasicManualFontWithSize:fontSize]
                                       range:NSMakeRange(0, 1)];
    }
   
    return degreeAttributedString;
}



@end
