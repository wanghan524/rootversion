//
//  ResultPetFriendlyPlacesViewController.m
//  PurinaPetPlaces
//
//  Created by BlueApp on 15-4-13.
//
//

#import "ResultPetFriendlyPlacesViewController.h"
#import "Singleton.h"
#import "Locations.h"

@interface ResultPetFriendlyPlacesViewController ()

@end

@implementation ResultPetFriendlyPlacesViewController
@synthesize resultsTableViewController,selectedSubCategory;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self showCustomeNav];
    
    self.view.backgroundColor = [UIColor colorWithRed:242/255.0 green:238/255.0 blue:223/255.0 alpha:1];
    
    Singleton *singletonClass = [Singleton sharedInstance];

    Locations *locationsClass = [Locations alloc];
    
    resultsTableViewController = [[ResultsTableViewController alloc] initWithStyle:UITableViewStylePlain];
    [resultsTableViewController.view setFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    resultsTableViewController.currentHeaderImageFlag = self.headerImageFlag;
    [resultsTableViewController setDelegate:self];
    
    [resultsTableViewController setDataSource:[locationsClass locationsByCategoryId:singletonClass.selectedSubCategories.CategoryId fromArray:singletonClass.locationListing]];
    [resultsTableViewController.tableView reloadData];
    [self.view addSubview:resultsTableViewController.view];
    
    // Do any additional setup after loading the view.
}

-(void)itemSelected:(Locations*)selectedLocation {
    
    //[subCategoriesViewController setParentCategory:category];
    
    Singleton *singletonClass = [Singleton sharedInstance];
    [singletonClass setSelectedLocation:selectedLocation];
    
    LocationPetFriendlyPlacesViewController *locationDetailViewController = [[LocationPetFriendlyPlacesViewController alloc] init];
    //[locationDetailViewController setSelectedLocation:selectedLocation];
    [self.navigationController pushViewController:locationDetailViewController animated:YES];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
