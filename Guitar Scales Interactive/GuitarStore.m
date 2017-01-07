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

@interface GuitarStore ()


@end

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
    
    self.degreeButtonArray = [json objectForKey:@"degreeArray"];

    
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
    
    NSArray* scalesArrays = [json objectForKey:@"scales"];
    
    self.scales2DArray = [NSMutableArray array];
    
    for (NSArray *scaleArray in scalesArrays) {
        // Block values to return
        NSMutableArray *scales = [NSMutableArray array];
        
        [(NSArray *)scaleArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            Scale *scale = [[Scale alloc] initWithDictionary:obj error:nil];
            [scales addObject:scale];
            
            if ([scale.title isEqualToString:@"Chromatic Scale"]) {
                self.chromaticScale = scale;
            }
        }];
        
        [self.scales2DArray addObject:scales];
    }
    

    
    if ([self.scales2DArray[0] count] > 0) {
        self.selectedScale = self.scales2DArray[0][0];
    }
    
    if (self.callback) {
        self.callback(YES);
    }
}

- (BOOL)displayedTutorial
{
    BOOL displayedTutorial = [[NSUserDefaults standardUserDefaults] boolForKey:@"displayedTutorial"];
    return displayedTutorial;
}

- (void)setDisplayedTutorial
{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"displayedTutorial"];
}

- (void)setShowDegrees:(BOOL)sDegrees
{
    [[NSUserDefaults standardUserDefaults] setBool:sDegrees forKey:@"showDegrees"];
}

- (BOOL)showDegrees
{
    BOOL showDegrees = [[NSUserDefaults standardUserDefaults] boolForKey:@"showDegrees"];
    return showDegrees;
}

- (void)setBassMode:(BOOL)bassMode
{
    [[NSUserDefaults standardUserDefaults] setBool:bassMode forKey:@"isBassMode"];
}

- (BOOL)isBassMode
{
    BOOL isBassMode = [[NSUserDefaults standardUserDefaults] boolForKey:@"isBassMode"];
    return isBassMode;
}


- (void)setLeftHand:(BOOL)leftHand
{
    [[NSUserDefaults standardUserDefaults] setBool:leftHand forKey:@"isLeftHand"];
}

- (BOOL)isLeftHand
{
    BOOL isLeftHand = [[NSUserDefaults standardUserDefaults] boolForKey:@"isLeftHand"];
    return isLeftHand;
}

- (void)setFlipped:(BOOL)flipped
{
    [[NSUserDefaults standardUserDefaults] setBool:flipped forKey:@"isFlipped"];
}

- (BOOL)isFlipped
{
    BOOL isFlipped = [[NSUserDefaults standardUserDefaults] boolForKey:@"isFlipped"];
    return isFlipped;
}


@end
