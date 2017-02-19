//
//  DegreeFull.m
//  Guitar Scales Interactive
//
//  Created by Chris McQueen on 2/4/17.
//
//

#import "DegreeFull.h"

@implementation DegreeFull

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
                                                       @"coordinates": @"coordinates"}];
}

- (NSAttributedString *)toAttributedString
{
    NSString *leftChar = @"";
    if (self.flat) {
        leftChar = @"b";
    } else if (self.sharp) {
        leftChar = @"#";
    }
    
    CGRect bounds = [[UIScreen mainScreen] bounds];
    CGFloat regFontSize = bounds.size.width / 18.53;
    CGFloat specialFontSize = bounds.size.width / 19.62;
    
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
    
    CGRect bounds = [[UIScreen mainScreen] bounds];
    CGFloat fontSize = bounds.size.width / 22.23;
    
    
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
