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


@interface LocationPetFriendlyPlacesViewController : ParentViewController{
    Locations                           *selectedLocation;
    LocationTableViewController         *locationTableViewController;
}
@property (nonatomic, retain) Locations *selectedLocation;
@property (nonatomic, retain) LocationTableViewController *locationTableViewController;
@end
