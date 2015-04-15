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

+(id)sharedGlobleInstance;

@end
