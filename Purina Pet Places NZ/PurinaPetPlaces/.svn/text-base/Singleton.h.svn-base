//
//  Singleton.h
//  PurinaPetPlaces
//
//  Created by Josh Bruce on 16/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Locations.h"
#import "Categories.h"

@interface Singleton : NSObject {
    NSString            *someProperty;
    NSMutableArray      *currentCategories; 
    NSMutableArray      *currentSubCategories;
    NSMutableArray      *locationListing;
    Locations           *selectedLocation;
    Categories          *selectedCategories;
    Categories          *selectedSubCategories;
}
@property (nonatomic, retain) NSString *someProperty;
@property (nonatomic, retain) NSMutableArray *currentCategories; 
@property (nonatomic, retain) NSMutableArray *currentSubCategories;
@property (nonatomic, retain) NSMutableArray *locationListing;
@property (nonatomic, retain) Locations *selectedLocation;
@property (nonatomic, retain) Categories *selectedCategories;
@property (nonatomic, retain) Categories *selectedSubCategories;

+ (id)sharedInstance;

@end

