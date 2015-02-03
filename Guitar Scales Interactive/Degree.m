//
//  Note.m
//  Guitar Scales Interactive
//
//  Created by Elena Boyd on 8/12/14.
//
//

#import "Degree.h"

@implementation Degree

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

+ (JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"degree_id" : @"identifier",
                                                       @"degree_number"   : @"number",
                                                       @"flat"   : @"flat",
                                                       @"sharp": @"sharp",
                                                       @"alt_degree_number"   : @"altNumber",
                                                       @"alt_flat"   : @"altFlat",
                                                       @"alt_sharp": @"altSharp",
                                                       @"degree_positions"    : @"degreePositions"}];
}

- (NSAttributedString *)toAttributedString
{
    NSString *leftChar = @"";
    if (self.flat) {
        leftChar = @"b";
    } else if (self.sharp) {
        leftChar = @"#";
    }
    
    NSString *degreeString = [NSString stringWithFormat:@"%@%ld", leftChar, (long)self.number];
    NSMutableAttributedString *degreeAttributedString = [[NSMutableAttributedString alloc] initWithString:degreeString];
    if (self.flat || self.sharp) {
        [degreeAttributedString addAttribute:NSFontAttributeName
                                       value:[UIFont bravuraFontWithSize:28.0]
                                       range:NSMakeRange(0, 1)];
        [degreeAttributedString addAttribute:NSFontAttributeName
                                       value:[UIFont svBasicManualFontWithSize:28.0f]
                                       range:NSMakeRange(1, 1)];
    } else {
        [degreeAttributedString addAttribute:NSFontAttributeName
                                       value:[UIFont svBasicManualFontWithSize:28.0f]
                                       range:NSMakeRange(0, 1)];
    }
    return degreeAttributedString;
}

- (NSAttributedString *)toAttributedStringCircle
{
    NSString *leftChar = @"";
    if (self.flat) {
        leftChar = @"b";
    } else if (self.sharp) {
        leftChar = @"#";
    }
    
    NSString *degreeString = [NSString stringWithFormat:@"%@%ld", leftChar, (long) self.number];
    NSMutableAttributedString *degreeAttributedString = [[NSMutableAttributedString alloc] initWithString:degreeString];
    if (self.flat || self.sharp) {
        [degreeAttributedString addAttribute:NSFontAttributeName
                                       value:[UIFont bravuraFontWithSize:18.0]
                                       range:NSMakeRange(0, 1)];
        [degreeAttributedString addAttribute:NSFontAttributeName
                                       value:[UIFont svBasicManualFontWithSize:19.5]
                                       range:NSMakeRange(1, 1)];
    } else {
        [degreeAttributedString addAttribute:NSFontAttributeName
                                       value:[UIFont svBasicManualFontWithSize:19.5]
                                       range:NSMakeRange(0, 1)];
    }
    


    return degreeAttributedString;
}



@end