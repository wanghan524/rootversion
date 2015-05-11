//
//  PetItem.h
//  PurinaPetPlaces
//
//  Created by 菁优数学 on 15/5/11.
//
//

#import <Foundation/Foundation.h>

@interface PetItem : NSObject
@property(nonatomic,assign)NSUInteger uid;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *dateTimes;
@property(nonatomic,copy)NSString *breed;

@end
