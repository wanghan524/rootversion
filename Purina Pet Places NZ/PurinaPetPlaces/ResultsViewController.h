//
//  ResultsViewController.h
//  PurinaPetPlaces
//
//  Created by Josh Bruce on 13/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResultsTableViewController.h"
#import "LocationDetailViewController.h"
#import "Categories.h"

@interface ResultsViewController : UIViewController {
    NSString                            *subCategory;
    NSNumber                            *subCategoryId;
    UILabel                             *lblHeading;
    NSMutableArray                      *resultsArray;
    ResultsTableViewController          *resultsTableViewController;
    //LocationDetailViewController        *locationDetailViewController;
    Categories                          *selectedSubCategory;
}

@property (nonatomic, retain) NSString *subCategory;
@property (nonatomic, retain) NSNumber *subCategoryId;
@property (nonatomic, retain) IBOutlet UILabel *lblHeading;
@property (nonatomic, retain) NSMutableArray *resultsArray;
@property (nonatomic, retain) ResultsTableViewController *resultsTableViewController;
//@property (nonatomic, retain) LocationDetailViewController *locationDetailViewController;
@property (nonatomic, retain) Categories *selectedSubCategory;
@end
