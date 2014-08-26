//
//  GuitarStore.m
//  Guitar Scales Interactive
//
//  Created by Elena Boyd on 8/16/14.
//
//

#import "GuitarStore.h"
#import "Degree.h"
#import "Scale.h"
#import "Position.h"

@implementation GuitarStore

#pragma mark - Initialization

+ (GuitarStore *)sharedStore
{
    static GuitarStore *sharedStore = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedStore = [[self alloc] init];
    });
    
    return sharedStore;
}

- (void)parseData
{
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"notes" ofType:@"json"];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSData* data = [NSData dataWithContentsOfFile:
                        filePath];
        [self performSelectorOnMainThread:@selector(fetchedData:)
                               withObject:data waitUntilDone:YES];
    });
}

- (void)fetchedData:(NSData *)responseData
{
    NSError* error;
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:responseData //1
                          options:kNilOptions
                          error:&error];
    
    NSArray* degrees = [json objectForKey:@"degrees"];
    
    // Block values to return
    self.degrees = [NSMutableArray array];
    
    [(NSArray *)degrees enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        Degree *degree = [[Degree alloc] initWithDictionary:obj error:nil];
        [self.degrees addObject:degree];
    }];
    
    self.positions = [NSMutableArray array];
    
    NSArray *positions = [json objectForKey:@"positions"];
    [(NSArray *)positions enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        Position *pos = [[Position alloc] initWithDictionary:obj error:nil];
        [self.positions addObject:pos];
    }];
    
    NSArray* scales = [json objectForKey:@"scales"];
    
    // Block values to return
    self.scales = [NSMutableArray array];
    
    [(NSArray *)scales enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        Scale *scale = [[Scale alloc] initWithDictionary:obj error:nil];
        [self.scales addObject:scale];
    }];
    
    if (self.scales.count > 0) {
        self.selectedScale = self.scales[0];
    }
    
    if (self.callback) {
        self.callback(YES);
    }
}


@end
