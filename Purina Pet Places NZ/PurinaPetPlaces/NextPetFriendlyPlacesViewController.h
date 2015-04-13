//
//  NextPetFriendlyPlacesViewController.h
//  PurinaPetPlaces
//
//  Created by BlueApp on 15-4-13.
//
//

#import "ParentViewController.h"
#import "SubCategoriesTableViewController.h"
#import "ResultsViewController.h"
#import "Categories.h"

@interface NextPetFriendlyPlacesViewController : ParentViewController{
    SubCategoriesTableViewController    *subCategoriesTableViewController;
    UILabel                             *lblHeading;
}
@property (nonatomic, strong) SubCategoriesTableViewController *subCategoriesTableViewController;
@property (nonatomic, strong) Categories *selectedCategory;
@property (nonatomic, strong) UILabel *lblHeading;
@end
