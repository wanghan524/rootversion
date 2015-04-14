//
//  LocationPetFriendlyPlacesViewController.h
//  PurinaPetPlaces
//
//  Created by BlueApp on 15-4-13.
//
//

#import "ParentViewController.h"
#import "Locations.h"
#import "LocationTableViewController.h"
#import <MapKit/MapKit.h>
#import "MapDetailsViewController.h"



@interface LocationPetFriendlyPlacesViewController : ParentViewController<MKMapViewDelegate>{
    Locations                           *selectedLocation;
    LocationTableViewController         *locationTableViewController
;
    MKMapView                       *theMapView;
    CLLocationCoordinate2D          coord;
    BOOL                            regionHasBeenSet;
    MapDetailsViewController        *mapDetailsViewController;
   
    CLPlacemark                     *searchResult;
    CGFloat                         passedDistance;
    NSString                        *passedCategory;
    NSString                        *passedSearchString;
}
@property (nonatomic, retain) Locations *selectedLocation;
@property (nonatomic, retain) LocationTableViewController *locationTableViewController;

@property (nonatomic, retain) MKMapView *theMapView;
@property (nonatomic, retain) CLPlacemark *searchResult;
@property (nonatomic, assign) CGFloat passedDistance;
@property (nonatomic, retain) MapDetailsViewController *mapDetailsViewController;

@property (nonatomic, retain) NSString *passedCategory;
@property (nonatomic, retain) NSString *passedSearchString;
@property (nonatomic, strong) NSString *headerImageFlag;
@end
