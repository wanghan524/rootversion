//
//  MyAnnotation.m
//  PurinaPetPlaces
//
//  Created by Josh Bruce on 10/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MyAnnotation.h"

@implementation MyAnnotation
@synthesize coordinate;
@synthesize title, subtitle, pincolor, locationId;

- (id)initWithCoordinates:(CLLocationCoordinate2D)location placeName:(NSString *)placeName description:(NSString *)description pincolor:(NSString *)pinColor withId:(int)passedlocationId;
{
    self = [super init];
    if (self != nil) {
        coordinate = location;
        title = placeName;
        subtitle = description;
        pincolor = pinColor;
        locationId = passedlocationId;
    }
    return self;
}

@end
