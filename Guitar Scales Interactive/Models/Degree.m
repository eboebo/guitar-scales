//
//  Degree.m
//  Guitar Scales Interactive
//
//  Created by Elena Boyd on 1/22/15.
//
//

#import "Degree.h"
#import <CoreData/CoreData.h>
#import "Coordinate.h"



@implementation Degree

@dynamic id;
@dynamic number;
@dynamic flat;
@dynamic sharp;
@dynamic coordinates;

+ (NSDictionary*)mappingDictionary
{
    return @{@"degree_id" : @"id",
             @"degree_number"   : @"number",
               @"flat"   : @"flat",
               @"sharp": @"sharp"};
}

+ (void)importDegreesFromArray:(NSArray *)degrees usingContext:(NSManagedObjectContext *)context;
{

    for (NSDictionary *degreeDictionary in degrees)
    {
        Degree *degree = [NSEntityDescription insertNewObjectForEntityForName:@"Degree"
                                                       inManagedObjectContext:context];
        [Degree performDataMappingForObject:degree
                      withMappingDictionary:[Degree mappingDictionary]
                         withDataDictionary:degreeDictionary];
        [Coordinate importCoordinatesFromArray:degreeDictionary[@"degree_positions"] toDegree:degree usingContext:context];
    }
    NSError *error = nil;
    [context save:&error];
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
                                       value:[UIFont bravuraFontWithSize:32.0]
                                       range:NSMakeRange(0, 1)];
        [degreeAttributedString addAttribute:NSFontAttributeName
                                       value:[UIFont svBasicManualFontWithSize:32.0f]
                                       range:NSMakeRange(1, 1)];
    } else {
        [degreeAttributedString addAttribute:NSFontAttributeName
                                       value:[UIFont svBasicManualFontWithSize:32.0f]
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
    
    NSString *degreeString = [NSString stringWithFormat:@"%@%ld", leftChar, (long)self.number];
    NSMutableAttributedString *degreeAttributedString = [[NSMutableAttributedString alloc] initWithString:degreeString];
    if (self.flat || self.sharp) {
        [degreeAttributedString addAttribute:NSFontAttributeName
                                       value:[UIFont bravuraFontWithSize:26.0]
                                       range:NSMakeRange(0, 1)];
        [degreeAttributedString addAttribute:NSFontAttributeName
                                       value:[UIFont svBasicManualFontWithSize:26.0f]
                                       range:NSMakeRange(1, 1)];
    } else {
        [degreeAttributedString addAttribute:NSFontAttributeName
                                       value:[UIFont svBasicManualFontWithSize:26.0f]
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
                                       value:[UIFont svBasicManualFontWithSize:18.0]
                                       range:NSMakeRange(1, 1)];
    } else {
        [degreeAttributedString addAttribute:NSFontAttributeName
                                       value:[UIFont svBasicManualFontWithSize:18.0]
                                       range:NSMakeRange(0, 1)];
    }
    
    return degreeAttributedString;
}

@end
