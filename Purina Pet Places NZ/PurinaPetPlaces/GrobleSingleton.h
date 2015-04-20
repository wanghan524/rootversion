//
//  GrobleSingleton.h
//  PurinaPetPlaces
//
//  Created by BlueApp on 15-4-14.
//
//

#import <Foundation/Foundation.h>

@interface GrobleSingleton : NSObject

@property (nonatomic, strong) NSString *globleCategory;

@property (nonatomic, strong) NSMutableArray *animalArray;

@property (nonatomic, strong) NSString *selectedAnimalName;

+(id)sharedGlobleInstance;

- (void)insertAnimalName:(NSString *)animalName;

- (NSArray *)getAllAnimalNameArray;

@end
