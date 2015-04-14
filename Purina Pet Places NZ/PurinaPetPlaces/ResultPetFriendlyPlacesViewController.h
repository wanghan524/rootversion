//
//  ResultPetFriendlyPlacesViewController.h
//  PurinaPetPlaces
//
//  Created by BlueApp on 15-4-13.
//
//

#import "ParentViewController.h"
#import "ResultsTableViewController.h"
#import "LocationDetailViewController.h"
#import "Categories.h"


@interface ResultPetFriendlyPlacesViewController : ParentViewController{
    ResultsTableViewController          *resultsTableViewController;
    Categories                          *selectedSubCategory;

}

@property (nonatomic, retain) ResultsTableViewController *resultsTableViewController;
@property (nonatomic, retain) Categories *selectedSubCategory;

@end
