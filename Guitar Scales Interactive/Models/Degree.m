//
//  Degree.m
//  Guitar Scales Interactive
//
//  Created by Elena Boyd on 1/22/15.
//
//

#import "Degree.h"


@implementation Degree

@dynamic id;
@dynamic number;
@dynamic flat;
@dynamic sharp;
@dynamic coordinates;

+ (NSDictionary*)mappingDictionary
{
    return @{
                                                       @"degree_id" : @"identifier",
                                                       @"degree_number"   : @"number",
                                                       @"flat"   : @"flat",
                                                       @"sharp": @"sharp",
                                
                                                       @"degree_positions"    : @"degreePositions"};
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
                                       value:[UIFont bravuraFontWithSize:19.0]
                                       range:NSMakeRange(0, 1)];
        [degreeAttributedString addAttribute:NSFontAttributeName
                                       value:[UIFont svBasicManualFontWithSize:19.0f]
                                       range:NSMakeRange(1, 1)];
    } else {
        [degreeAttributedString addAttribute:NSFontAttributeName
                                       value:[UIFont svBasicManualFontWithSize:19.0f]
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
                                       value:[UIFont bravuraFontWithSize:14.0]
                                       range:NSMakeRange(0, 1)];
        [degreeAttributedString addAttribute:NSFontAttributeName
                                       value:[UIFont svBasicManualFontWithSize:14.0]
                                       range:NSMakeRange(1, 1)];
    } else {
        [degreeAttributedString addAttribute:NSFontAttributeName
                                       value:[UIFont svBasicManualFontWithSize:14.0]
                                       range:NSMakeRange(0, 1)];
    }
    
    return degreeAttributedString;
}

@end
