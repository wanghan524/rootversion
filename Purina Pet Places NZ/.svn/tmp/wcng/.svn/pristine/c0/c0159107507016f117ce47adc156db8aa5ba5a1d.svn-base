//
//  MapViewController.h
//  PurinaPetPlaces
//
//  Created by Josh Bruce on 10/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MapDetailsViewController.h"
#import "Locations.h"

@interface MapViewController : UIViewController <MKMapViewDelegate> {
    MKMapView                       *theMapView;
    CLLocationCoordinate2D          coord;
    BOOL                            regionHasBeenSet;
    MapDetailsViewController        *mapDetailsViewController;
    Locations                       *selectedLocation;
    CLPlacemark                     *searchResult;
    CGFloat                         passedDistance;
    NSString                        *passedCategory; 
    NSString                        *passedSearchString; 
}

@property (nonatomic, retain) IBOutlet MKMapView *theMapView;
@property (nonatomic, retain) CLPlacemark *searchResult;
@property (nonatomic, assign) CGFloat passedDistance;
@property (nonatomic, retain) MapDetailsViewController *mapDetailsViewController;
@property (nonatomic, retain) Locations *selectedLocation;
@property (nonatomic, retain) NSString *passedCategory;
@property (nonatomic, retain) NSString *passedSearchString;
@end
