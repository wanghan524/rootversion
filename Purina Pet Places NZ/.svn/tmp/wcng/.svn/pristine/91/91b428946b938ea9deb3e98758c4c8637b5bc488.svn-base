//
//  MyAnnotation.h
//  PurinaPetPlaces
//
//  Created by Josh Bruce on 10/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>


@interface MyAnnotation : NSObject <MKAnnotation> {
    CLLocationCoordinate2D  coordinate;
    NSString                *title;
	NSString                *subtitle;
    int                     locationId;
}

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, assign) int locationId;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, copy) NSString *pincolor;

// add an init method so you can set the coordinate property on startup
- (id)initWithCoordinates:(CLLocationCoordinate2D)location placeName:(NSString *)placeName description:(NSString *)description pincolor:(NSString *)pinColor withId:(int)passedlocationId;;

@end
