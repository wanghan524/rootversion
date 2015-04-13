//
//  SubCategoriesViewController.h
//  PurinaPetPlaces
//
//  Created by Josh Bruce on 4/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SubCategoriesTableViewController.h"
#import "ResultsViewController.h"
#import "Categories.h"

@interface SubCategoriesViewController : UIViewController {
    SubCategoriesTableViewController    *subCategoriesTableViewController;
    ResultsViewController               *resultsViewController;
    NSString                            *parentCategory;
    UILabel                             *lblHeading;
    NSMutableArray                      *arraySubCategories;
    Categories                          *selectedCategory;
}
@property (nonatomic, retain) SubCategoriesTableViewController *subCategoriesTableViewController;
@property (nonatomic, retain) ResultsViewController *resultsViewController;
@property (nonatomic, retain) Categories *selectedCategory;
@property (nonatomic, retain) NSString *parentCategory;
@property (nonatomic, retain) NSMutableArray *arraySubCategories;
@property (nonatomic, retain) IBOutlet UILabel *lblHeading;

@end
