//
//  LocationPetFriendlyPlacesViewController.m
//  PurinaPetPlaces
//
//  Created by BlueApp on 15-4-13.
//
//

#import "LocationPetFriendlyPlacesViewController.h"
#import "Singleton.h"
#import "MapViewController.h"


@interface LocationPetFriendlyPlacesViewController ()

@end

@implementation LocationPetFriendlyPlacesViewController

@synthesize selectedLocation,locationTableViewController;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self showCustomeNav];
    
    self.view.backgroundColor = [UIColor colorWithRed:242/255.0 green:238/255.0 blue:223/255.0 alpha:1];
    
    
    locationTableViewController = [[LocationTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    [locationTableViewController.view setFrame:CGRectMake(0, 41, 320, 330)];
    [locationTableViewController setDelegate:self];
    [self.view addSubview:locationTableViewController.view];
    
    
    Singleton *singletonClass = [Singleton sharedInstance];
    
    [locationTableViewController setDataSource:singletonClass.selectedLocation];
    [locationTableViewController.tableView reloadData];

    // Do any additional setup after loading the view.
}

-(void)itemSelected:(Locations*)mySelectedLocation {
    MapViewController *mapViewController = [[MapViewController alloc] initWithNibName:@"MapViewController" bundle:nil];
    [mapViewController setSelectedLocation:mySelectedLocation];
    [self.navigationController pushViewController:mapViewController animated:YES];
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
