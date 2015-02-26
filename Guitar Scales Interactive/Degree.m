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
    
    CGFloat regFontSize = 36.0f;
    CGFloat specialFontSize = 34.0f;                                            // iPhone 6
    CGRect bounds = [[UIScreen mainScreen] bounds];
    if (bounds.size.width < 568.0) {                                            // iPhone 4
        regFontSize = 28.0;
        specialFontSize = 27.0;
    }
    else if (bounds.size.width > 667.0) {                                       // iPhone 6 Plus
        regFontSize = 40.0;
        specialFontSize = 38.0;
    }
    else if (bounds.size.width < 667.0) {                                       // iPhone 5
        regFontSize = 31.0;
        specialFontSize = 29.0;
    }
    
    NSString *degreeString = [NSString stringWithFormat:@"%@%ld", leftChar, (long)self.number];
    NSMutableAttributedString *degreeAttributedString = [[NSMutableAttributedString alloc] initWithString:degreeString];
    if (self.flat || self.sharp) {
        [degreeAttributedString addAttribute:NSFontAttributeName
                                       value:[UIFont bravuraFontWithSize:specialFontSize]
                                       range:NSMakeRange(0, 1)];
        [degreeAttributedString addAttribute:NSFontAttributeName
                                       value:[UIFont svBasicManualFontWithSize:regFontSize]
                                       range:NSMakeRange(1, 1)];
    } else {
        [degreeAttributedString addAttribute:NSFontAttributeName
                                       value:[UIFont svBasicManualFontWithSize:regFontSize]
                                       range:NSMakeRange(0, 1)];
    }
    return degreeAttributedString;
}

- (NSAttributedString *)toAttributedStringEnharmonic
{
    NSString *leftChar = @"";
    if (self.flat) {
        leftChar = @"b";
    } else if (self.sharp) {
        leftChar = @"#";
    }
    
    CGFloat fontSize = 30.0f;                                                   // iPhone 6
    CGRect bounds = [[UIScreen mainScreen] bounds];
    if (bounds.size.width < 568.0) {                                            // iPhone 4
        fontSize = 24.0f;
    }
    else if (bounds.size.width > 667.0) {                                       // iPhone 6 Plus
        fontSize = 32.0f;
    }
    else if (bounds.size.width < 667.0) {                                       // iPhone 5
        fontSize = 26.0f;
    }

    
    NSString *degreeString = [NSString stringWithFormat:@"%@%ld", leftChar, (long)self.number];
    NSMutableAttributedString *degreeAttributedString = [[NSMutableAttributedString alloc] initWithString:degreeString];
    if (self.flat || self.sharp) {
        [degreeAttributedString addAttribute:NSFontAttributeName
                                       value:[UIFont bravuraFontWithSize:fontSize]
                                       range:NSMakeRange(0, 1)];
        [degreeAttributedString addAttribute:NSFontAttributeName
                                       value:[UIFont svBasicManualFontWithSize:fontSize]
                                       range:NSMakeRange(1, 1)];
    } else {
        [degreeAttributedString addAttribute:NSFontAttributeName
                                       value:[UIFont svBasicManualFontWithSize:fontSize]
                                       range:NSMakeRange(0, 1)];
    }
    return degreeAttributedString;
}

- (NSAttributedString *)toAttributedStringCircleWithFontSize:(CGFloat)fontSize
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
                                       value:[UIFont bravuraFontWithSize:fontSize]
                                       range:NSMakeRange(0, 1)];
        [degreeAttributedString addAttribute:NSFontAttributeName
                                       value:[UIFont svBasicManualFontWithSize:fontSize]
                                       range:NSMakeRange(1, 1)];
    } else {
        [degreeAttributedString addAttribute:NSFontAttributeName
                                       value:[UIFont svBasicManualFontWithSize:fontSize]
                                       range:NSMakeRange(0, 1)];
    }
    


    return degreeAttributedString;
}



@end
