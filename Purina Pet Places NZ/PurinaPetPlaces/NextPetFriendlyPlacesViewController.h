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
#import "ResultPetFriendlyPlacesViewController.h"

@interface NextPetFriendlyPlacesViewController : ParentViewController{
    SubCategoriesTableViewController    *subCategoriesTableViewController;
    UILabel                             *lblHeading;
    ResultsViewController               *resultsViewController;
    ResultPetFriendlyPlacesViewController *resultPetVC;
}
@property (nonatomic, strong) SubCategoriesTableViewController *subCategoriesTableViewController;
@property (nonatomic, retain) ResultsViewController *resultsViewController;
@property (nonatomic, strong) Categories *selectedCategory;
@property (nonatomic, strong) UILabel *lblHeading;
@property (nonatomic, strong) ResultPetFriendlyPlacesViewController *resultPetVC;

@property (nonatomic, strong) NSString *headerImageFlag;
@end
