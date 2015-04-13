//
//  Locations.h
//  PurinaPetPlaces
//
//  Created by Josh Bruce on 16/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Locations : NSObject <NSCoding> {
    NSNumber    *LocationId;
    NSString    *LocationName;
    NSString    *LocationLongLat;
    NSString    *LocationAddressLine1;
    NSString    *LocationAddressLine2;
    NSString    *LocationAddressLine3;
    NSString    *LocationAddressLine4;
    NSNumber    *LocationCategoryId;
    NSString    *LocationCategoryName;
    NSString    *LocationSubCategoryName;
    NSNumber    *LocationSubCategoryId;
    NSString    *LocationPhoneNumber;
    NSString    *LocationFaxNumber;
    NSString    *LocationBookABatchId;
}
@property (nonatomic, retain) NSNumber    *LocationId;
@property (nonatomic, retain) NSString    *LocationName;
@property (nonatomic, retain) NSString    *LocationLongLat;
@property (nonatomic, retain) NSString    *LocationAddressLine1;
@property (nonatomic, retain) NSString    *LocationAddressLine2;
@property (nonatomic, retain) NSString    *LocationAddressLine3;
@property (nonatomic, retain) NSString    *LocationAddressLine4;
@property (nonatomic, retain) NSNumber    *LocationCategoryId;
@property (nonatomic, retain) NSString    *LocationCategoryName;
@property (nonatomic, retain) NSString    *LocationSubCategoryName;
@property (nonatomic, retain) NSString    *LocationPhoneNumber;
@property (nonatomic, retain) NSString    *LocationFaxNumber;
@property (nonatomic, retain) NSNumber    *LocationSubCategoryId;
@property (nonatomic, retain) NSString    *LocationBookABatchId;

-(NSMutableArray *)locationsByCategoryId:(NSNumber*)categoryId fromArray:(NSMutableArray *)locationsArray;
@end


