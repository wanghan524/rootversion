//
//  ResultsViewController.m
//  PurinaPetPlaces
//
//  Created by Josh Bruce on 13/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ResultsViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "PCPetCentricSvc.h"
#import "Singleton.h"
#import "Locations.h"

@interface ResultsViewController ()

@end

@implementation ResultsViewController
@synthesize lblHeading, subCategory, resultsTableViewController, resultsArray, subCategoryId, selectedSubCategory;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

        
        CAGradientLayer *gradient = [CAGradientLayer layer];
        [gradient setFrame:self.view.bounds];
        [gradient setColors:[NSArray arrayWithObjects:(id)[UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1].CGColor, (id)[UIColor colorWithRed:253/255.0 green:253/255.0 blue:253/255.0 alpha:1].CGColor, nil]];
        [self.view.layer insertSublayer:gradient atIndex:0];
        
        [lblHeading.layer setShadowColor:[UIColor blackColor].CGColor];
        [lblHeading.layer setShadowOffset:CGSizeMake(2, 2)];
        [lblHeading.layer setShadowOpacity:0.5f];
        [lblHeading.layer setShadowRadius:3.0];
        [lblHeading.layer setMasksToBounds:NO];
        
        
        
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil]; 
        if ([backButton respondsToSelector:@selector(setTintColor:)]) {
            [backButton setTintColor:[UIColor colorWithRed:206/255.0 green:206/255.0 blue:206/255.0 alpha:1]];
            NSDictionary *titleBarProperties = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:89/255.0 green:89/255.0 blue:89/255.0 alpha:1], UITextAttributeTextColor, [UIColor whiteColor], UITextAttributeTextShadowColor, nil];
            [backButton setTitleTextAttributes:titleBarProperties forState:UIControlStateNormal];
        }
        [self.navigationItem setBackBarButtonItem:backButton];
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    Singleton *singletonClass = [Singleton sharedInstance];
    [lblHeading setText:[NSString stringWithFormat:@"Select From %@", singletonClass.selectedSubCategories.CategoryName]];
    
    Locations *locationsClass = [Locations alloc];
    
    resultsTableViewController = [[ResultsTableViewController alloc] initWithStyle:UITableViewStylePlain];
    [resultsTableViewController.view setFrame:CGRectMake(0, 41, 320, 330)];
    [resultsTableViewController setDelegate:self];
    
    [resultsTableViewController setDataSource:[locationsClass locationsByCategoryId:singletonClass.selectedSubCategories.CategoryId fromArray:singletonClass.locationListing]];
    [resultsTableViewController.tableView reloadData];
    [self.view addSubview:resultsTableViewController.view];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void)viewWillAppear:(BOOL)animated {

    
    
    
    
       
}

-(void)itemSelected:(Locations*)selectedLocation {
    
    //[subCategoriesViewController setParentCategory:category];
    
    Singleton *singletonClass = [Singleton sharedInstance];
    [singletonClass setSelectedLocation:selectedLocation];
    
    LocationDetailViewController *locationDetailViewController = [[LocationDetailViewController alloc] initWithNibName:@"LocationDetailViewController" bundle:nil];
    //[locationDetailViewController setSelectedLocation:selectedLocation];
    [self.navigationController pushViewController:locationDetailViewController animated:YES];
    
    
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
