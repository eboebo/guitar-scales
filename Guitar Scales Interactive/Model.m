//
//  Model.m
//  Guitar Scales Interactive
//
//  Created by Elena Boyd on 8/12/14.
//
//

#import "Model.h"

@implementation Model

- (void)parseDictionary:(NSDictionary *)d withMap:(NSDictionary *)map transform:(NSDictionary *)tMap
{
    for(NSString *k in d) {
        if(map[k]) {
            id value = d[k];
            if(tMap[k]) {
                id (^transformer)(id incoming) = tMap[k];
                value = transformer(value);
            }
            [self setValue:value
                forKeyPath:map[k]];
        }
    }
}

@end
