//
//  GuitarDataManager.m
//  Guitar Scales Interactive
//
//  Created by Elena Boyd on 2/3/15.
//
//

#import "GuitarDataManager.h"
#import <CoreData/CoreData.h>
#import "Degree.h"
#import "Position.h"
#import "ScaleGroup.h"

static GuitarDataManager *_instance;

@interface GuitarDataManager ()

@property (nonatomic, strong) NSManagedObjectContext *context;

@end

@implementation GuitarDataManager

+ (instancetype)sharedManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[GuitarDataManager alloc] init];
    });
    
    return _instance;
}

- (void)seedData
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
    
    //self.degreeButtonArray = [json objectForKey:@"degreeArray"];
    
    
    NSArray* degrees = [json objectForKey:@"degrees"];
    [Degree importDegreesFromArray:degrees usingContext:self.context];
    
    
    NSArray *positions = [json objectForKey:@"positions"];
    [Position importPositionsFromArray:positions usingContext:self.context];

    NSArray *scaleGroups = [json objectForKey:@"scales"];
    [ScaleGroup importScaleGroupsFromArray:scaleGroups usingContext:self.context];
}

@end
