//
//  GrobleSingleton.m
//  PurinaPetPlaces
//
//  Created by BlueApp on 15-4-14.
//
//

#import "GrobleSingleton.h"

static GrobleSingleton * single = nil;

@implementation GrobleSingleton

+(id)sharedGlobleInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        single = [[GrobleSingleton alloc] init];
        single.animalArray = [[NSMutableArray alloc] init];
        single.selectedArray = [[NSMutableArray alloc] init];
        single.pieClickArray = [[NSMutableArray alloc] init];
    });
    return single;
}


- (void)insertAnimalName:(NSString *)animalName{
    [single.animalArray addObject:animalName];
}


- (NSArray *)getAllAnimalNameArray{
    return single.animalArray;
}
@end
