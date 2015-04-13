//
//  Locations.m
//  PurinaPetPlaces
//
//  Created by Josh Bruce on 16/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Locations.h"

@implementation Locations
@synthesize LocationId, LocationName, LocationLongLat, LocationAddressLine1, LocationAddressLine2, LocationAddressLine3, LocationAddressLine4, LocationCategoryId, LocationCategoryName, LocationSubCategoryId, LocationSubCategoryName, LocationPhoneNumber, LocationBookABatchId;


-(NSMutableArray *)locationsByCategoryId:(NSNumber*)categoryId fromArray:(NSMutableArray *)locationsArray {
    NSMutableArray *filteredResults = [NSMutableArray array];
    for (Locations *location in locationsArray) {
        if ([location.LocationSubCategoryId intValue] == [categoryId intValue]) {
            [filteredResults addObject:location];
        }
        
    }

    
    return filteredResults;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super init])) {
        [self setLocationId:                [aDecoder decodeObjectForKey:@"LocationId"]];
        [self setLocationName:              [aDecoder decodeObjectForKey:@"LocationName"]];
        [self setLocationLongLat:           [aDecoder decodeObjectForKey:@"LocationLongLat"]];
        [self setLocationAddressLine1:      [aDecoder decodeObjectForKey:@"LocationAddressLine1"]];
        [self setLocationAddressLine2:      [aDecoder decodeObjectForKey:@"LocationAddressLine2"]];
        [self setLocationAddressLine3:      [aDecoder decodeObjectForKey:@"LocationAddressLine3"]];
        [self setLocationAddressLine4:      [aDecoder decodeObjectForKey:@"LocationAddressLine4"]];
        [self setLocationCategoryId:        [aDecoder decodeObjectForKey:@"LocationCategoryId"]];
        [self setLocationCategoryName:      [aDecoder decodeObjectForKey:@"LocationCategoryName"]];
        [self setLocationSubCategoryId:     [aDecoder decodeObjectForKey:@"LocationSubCategoryId"]];
        [self setLocationSubCategoryName:   [aDecoder decodeObjectForKey:@"LocationSubCategoryName"]];
        [self setLocationFaxNumber:         [aDecoder decodeObjectForKey:@"LocationFaxNumber"]];
        [self setLocationPhoneNumber:       [aDecoder decodeObjectForKey:@"LocationPhoneNumber"]];
        [self setLocationBookABatchId:      [aDecoder decodeObjectForKey:@"LocationBookABatchId"]];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:LocationId forKey:@"LocationId"];
    [aCoder encodeObject:LocationName forKey:@"LocationName"];
    [aCoder encodeObject:LocationLongLat forKey:@"LocationLongLat"];
    [aCoder encodeObject:LocationAddressLine1 forKey:@"LocationAddressLine1"];
    [aCoder encodeObject:LocationAddressLine2 forKey:@"LocationAddressLine2"];
    [aCoder encodeObject:LocationAddressLine3 forKey:@"LocationAddressLine3"];
    [aCoder encodeObject:LocationAddressLine4 forKey:@"LocationAddressLine4"];
    [aCoder encodeObject:LocationCategoryId forKey:@"LocationCategoryId"];
    [aCoder encodeObject:LocationCategoryName forKey:@"LocationCategoryName"];
    [aCoder encodeObject:LocationSubCategoryId forKey:@"LocationSubCategoryId"];
    [aCoder encodeObject:LocationSubCategoryName forKey:@"LocationSubCategoryName"];
    [aCoder encodeObject:LocationFaxNumber forKey:@"LocationFaxNumber"];
    [aCoder encodeObject:LocationPhoneNumber forKey:@"LocationPhoneNumber"];
    [aCoder encodeObject:LocationBookABatchId forKey:@"LocationBookABatchId"];
}

 

@end
