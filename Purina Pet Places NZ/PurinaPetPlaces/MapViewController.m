//
//  MapViewController.m
//  PurinaPetPlaces
//
//  Created by Josh Bruce on 10/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MapViewController.h"
#import "MyAnnotation.h"
#import "PCServices.h"
#import "Singleton.h"
#import "Locations.h"
#import "LocationDetailViewController.h"


@interface MapViewController ()

@end

@implementation MapViewController
@synthesize theMapView, mapDetailsViewController, selectedLocation, searchResult, passedDistance, passedCategory, passedSearchString;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    mapDetailsViewController = [[MapDetailsViewController alloc] initWithNibName:@"MapViewController" bundle:nil];
    
    [theMapView setShowsUserLocation:YES];
    [theMapView setDelegate:self];
    Singleton *singletonClass = [Singleton sharedInstance];
    
    if (selectedLocation == nil && searchResult == nil) {
        for (Locations *location in singletonClass.locationListing) {
            if (![location.LocationLongLat isEqualToString:@""]) {
                NSArray *longLatSplit = [location.LocationLongLat componentsSeparatedByString:@","];
                CLLocationCoordinate2D theCoordinate;
                theCoordinate.latitude = [[longLatSplit objectAtIndex:0] doubleValue];
                theCoordinate.longitude = [[longLatSplit objectAtIndex:1] doubleValue];
            
                MyAnnotation *anno1 = [[MyAnnotation alloc] initWithCoordinates:theCoordinate placeName:location.LocationName description:location.LocationCategoryName pincolor:@"pin_red.png" withId:[location.LocationId intValue]] ;
                [theMapView addAnnotation:anno1];
            }
        }
    } else if (searchResult != nil) {
        
        CLLocation *searchResultLocation = [[CLLocation alloc] initWithLatitude:searchResult.location.coordinate.latitude longitude:searchResult.location.coordinate.longitude];
        
        for (Locations *location in singletonClass.locationListing) {
            if (![location.LocationLongLat isEqualToString:@""]) {
                NSArray *longLatSplit = [location.LocationLongLat componentsSeparatedByString:@","];
                CLLocationCoordinate2D theCoordinate;
                theCoordinate.latitude = [[longLatSplit objectAtIndex:0] doubleValue];  
                theCoordinate.longitude = [[longLatSplit objectAtIndex:1] doubleValue];
            
                CLLocation *currentScanLoc = [[CLLocation alloc] initWithLatitude:theCoordinate.latitude longitude:theCoordinate.longitude];
                CLLocationDistance distance = [searchResultLocation distanceFromLocation:currentScanLoc];
            
                if ([passedSearchString length] > 0) {
                    NSRange range = [location.LocationName rangeOfString:passedSearchString options:NSCaseInsensitiveSearch];
                    if (distance / 1000 <= passedDistance && [location.LocationCategoryName isEqualToString:passedCategory] && range.location != NSNotFound) {
                        MyAnnotation *anno1 = [[MyAnnotation alloc] initWithCoordinates:theCoordinate placeName:location.LocationName description:location.LocationCategoryName pincolor:@"pin_red.png" withId:[location.LocationId intValue]];
                        [theMapView addAnnotation:anno1];
                    }
                }else {
                    if (distance / 1000 <= passedDistance && [location.LocationCategoryName isEqualToString:passedCategory]) {
                        MyAnnotation *anno1 = [[MyAnnotation alloc] initWithCoordinates:theCoordinate placeName:location.LocationName description:location.LocationCategoryName pincolor:@"pin_red.png" withId:[location.LocationId intValue]];
                        [theMapView addAnnotation:anno1];
                    }
                }
            }
            
            
            
        }
        if ([theMapView.annotations count] >= 1)
            [self zoomToFitMapAnnotations:self.theMapView];
        
    } else {
        NSArray *longLatSplit = [selectedLocation.LocationLongLat componentsSeparatedByString:@","];
        CLLocationCoordinate2D theCoordinate;
        theCoordinate.latitude = [[longLatSplit objectAtIndex:0] doubleValue];
        theCoordinate.longitude = [[longLatSplit objectAtIndex:1] doubleValue];
        
        MyAnnotation *anno1 = [[MyAnnotation alloc] initWithCoordinates:theCoordinate placeName:selectedLocation.LocationName description:selectedLocation.LocationCategoryName pincolor:@"pin_red.png" withId:0];
        [theMapView addAnnotation:anno1];
        
        CLLocation *selectedLoc = [[CLLocation alloc] initWithLatitude:theCoordinate.latitude longitude:theCoordinate.longitude];
        CLLocation *userLoc = [[CLLocation alloc] initWithLatitude:self.theMapView.userLocation.location.coordinate.latitude longitude:self.theMapView.userLocation.location.coordinate.longitude];
        
        CLLocationDistance distance = [userLoc distanceFromLocation:selectedLoc];
        
        MKCoordinateRegion region;
        region.center.latitude = (userLoc.coordinate.latitude + selectedLoc.coordinate.latitude) / 2.0;
        region.center.longitude = (userLoc.coordinate.longitude + selectedLoc.coordinate.longitude) / 2.0;
        region.span.latitudeDelta = distance / 111320;
        region.span.longitudeDelta = 0.0;
        
        //MACoordinateSpan span = MACoordinateSpanMake(0.008 0.008);
//        MKCoordinateSpan spans = MKCoordinateSpanMake(0.008, 0.008);
//        region.span = spans;
        
        [self.theMapView setRegion:region animated:TRUE];
        [self.theMapView regionThatFits:region];
        
    }
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil];
    if ([backButton respondsToSelector:@selector(setTintColor:)]) {
        [backButton setTintColor:[UIColor colorWithRed:206/255.0 green:206/255.0 blue:206/255.0 alpha:1]];
        NSDictionary *titleBarProperties = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:89/255.0 green:89/255.0 blue:89/255.0 alpha:1], UITextAttributeTextColor, [UIColor whiteColor], UITextAttributeTextShadowColor, nil];
        [backButton setTitleTextAttributes:titleBarProperties forState:UIControlStateNormal];
    }
    [self.navigationItem setBackBarButtonItem:backButton];
    
    [super viewDidLoad];
}


-(void)zoomToFitMapAnnotations:(MKMapView*)mapView
{

    if([mapView.annotations count] == 0)
        return;
//    mapView.region.span.latitudeDelta = 0;
    CLLocationCoordinate2D topLeftCoord;
    topLeftCoord.latitude = -90;
    topLeftCoord.longitude = 180;
    
    CLLocationCoordinate2D bottomRightCoord;
    bottomRightCoord.latitude = 90;
    bottomRightCoord.longitude = -180;
    
    for(MyAnnotation* annotation in mapView.annotations)
    {
        topLeftCoord.longitude = fmin(topLeftCoord.longitude, annotation.coordinate.longitude);
        topLeftCoord.latitude = fmax(topLeftCoord.latitude, annotation.coordinate.latitude);
        
        bottomRightCoord.longitude = fmax(bottomRightCoord.longitude, annotation.coordinate.longitude);
        bottomRightCoord.latitude = fmin(bottomRightCoord.latitude, annotation.coordinate.latitude);
    }
    
    MKCoordinateRegion region;
    region.center.latitude = topLeftCoord.latitude - (topLeftCoord.latitude - bottomRightCoord.latitude) * 0.5;
    region.center.longitude = topLeftCoord.longitude + (bottomRightCoord.longitude - topLeftCoord.longitude) * 0.5;
    
    if ([mapView.annotations count] == 1) {
        region.span.latitudeDelta = 0.08; // Add a little extra space on the sides
        region.span.longitudeDelta = 0.08; // Add a little extra space on the sides
    }else {
        region.span.latitudeDelta = fabs(topLeftCoord.latitude - bottomRightCoord.latitude) * 1.1; // Add a little extra space on the sides
        region.span.longitudeDelta = fabs(bottomRightCoord.longitude - topLeftCoord.longitude) * 1.1; // Add a little extra space on the sides

    }
        
    region = [mapView regionThatFits:region];
    [mapView setRegion:region animated:YES];
    
    
}


- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    
    if (annotation == self.theMapView.userLocation) {	
        if (!regionHasBeenSet && searchResult == nil) {
            
            NSArray *longLatSplit = [selectedLocation.LocationLongLat componentsSeparatedByString:@","];
            CLLocationCoordinate2D selectedLocationCoord;
            selectedLocationCoord.latitude = [[longLatSplit objectAtIndex:0] doubleValue];
            selectedLocationCoord.longitude = [[longLatSplit objectAtIndex:1] doubleValue];
            
            CLLocationCoordinate2D southWest = selectedLocationCoord;
            CLLocationCoordinate2D northEast = southWest;
            
            southWest.latitude = MIN(southWest.latitude, self.theMapView.userLocation.location.coordinate.latitude);
            southWest.longitude = MIN(southWest.longitude, self.theMapView.userLocation.location.coordinate.longitude);
            
            northEast.latitude = MAX(northEast.latitude, self.theMapView.userLocation.location.coordinate.latitude);
            northEast.longitude = MAX(northEast.longitude, self.theMapView.userLocation.location.coordinate.longitude);
            
            NSLog(@"CurrentLocation %f - %f", self.theMapView.userLocation.location.coordinate.latitude, self.theMapView.userLocation.location.coordinate.longitude);
            NSLog(@"SouthWest %f - %f ", southWest.latitude, southWest.longitude );
            NSLog(@"NorthEast %f - %f ", northEast.latitude, northEast.longitude );
            
           // MyAnnotation *anno1 = [[MyAnnotation alloc] initWithCoordinates:theCoordinate placeName:selectedLocation.LocationName description:selectedLocation.LocationCategoryName];
           // [theMapView addAnnotation:anno1];
            
            CLLocation *locSouthWest = [[CLLocation alloc] initWithLatitude:southWest.latitude longitude:southWest.longitude];
            CLLocation *locNorthEast = [[CLLocation alloc] initWithLatitude:northEast.latitude longitude:northEast.longitude];
            
            CLLocationDistance distance = [locSouthWest distanceFromLocation:locNorthEast];
            
            MKCoordinateRegion region;
            region.center.latitude = (southWest.latitude + northEast.latitude) / 2.0;
            region.center.longitude = (southWest.longitude + northEast.longitude) / 2.0;
            region.span.latitudeDelta = distance / 111320;
            region.span.longitudeDelta = 0.0;
            
            [self.theMapView setRegion:region animated:TRUE];
            [self.theMapView regionThatFits:region];
            
            regionHasBeenSet = TRUE;
        }
		return nil;
    }else {
        
        MKAnnotationView *aView = [mapView dequeueReusableAnnotationViewWithIdentifier:@"pinView"];
         
        if (!aView) {
            aView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"pinView"];
        }
        
        MyAnnotation *myannotation = (MyAnnotation *)annotation;
        UIButton *disclosureButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        disclosureButton.tintColor = [UIColor redColor];
//        [aView setRightCalloutAccessoryView:[UIButton buttonWithType:UIButtonTypeDetailDisclosure]];
        [aView setTag:myannotation.locationId];
        [aView setRightCalloutAccessoryView:disclosureButton];
        
        //[(UIButton*)aView.rightCalloutAccessoryView addTarget:self action:@selector(showDetails:) forControlEvents:UIControlEventTouchUpInside];
        [aView setCanShowCallout:YES];
        
        [aView setEnabled:YES];
        [aView setImage:[UIImage imageNamed:myannotation.pincolor]];
        [aView setCenterOffset:CGPointMake(0, 0)];
         
        return aView;

    }
        
}

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    
    Singleton *singltonClass = [Singleton sharedInstance];
    for (Locations *locationDetails in singltonClass.locationListing) {
        if ([locationDetails.LocationId intValue] == view.tag) {
            NSLog(@"%i - %i", [locationDetails.LocationId intValue], view.tag);
            //locationsDetailsView.selectedLocation = locationDetails;
            
            singltonClass.selectedLocation = locationDetails;
        }
    }
    
    LocationDetailViewController *locationsDetailsView = [[LocationDetailViewController alloc] initWithNibName:@"LocationDetailViewController" bundle:nil];
    [self.navigationController pushViewController:locationsDetailsView animated:YES];

}


 

@end
