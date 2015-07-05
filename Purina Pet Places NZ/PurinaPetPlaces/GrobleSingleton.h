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

@property (nonatomic, strong) NSMutableArray *selectedArray;

@property (nonatomic, strong) NSString *selectedProfile;

@property (nonatomic, strong) NSMutableArray *pieClickArray;

+(id)sharedGlobleInstance;

- (void)insertAnimalName:(NSString *)animalName;

- (NSArray *)getAllAnimalNameArray;

@end
