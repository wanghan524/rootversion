//
//  LocationDetailViewController.m
//  PurinaPetPlaces
//
//  Created by Josh Bruce on 17/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LocationDetailViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "Singleton.h"
#import "MapViewController.h"

@interface LocationDetailViewController ()

@end

@implementation LocationDetailViewController
@synthesize lblLocationName, selectedLocation, locationTableViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        locationTableViewController = [[LocationTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
        [locationTableViewController.view setFrame:CGRectMake(0, 41, 320, 330)];
        [locationTableViewController setDelegate:self];
        [self.view addSubview:locationTableViewController.view];

        
        CAGradientLayer *gradient = [CAGradientLayer layer];
        [gradient setFrame:self.view.bounds];
        [gradient setColors:[NSArray arrayWithObjects:(id)[UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1].CGColor, (id)[UIColor colorWithRed:253/255.0 green:253/255.0 blue:253/255.0 alpha:1].CGColor, nil]];
        [self.view.layer insertSublayer:gradient atIndex:0];
        
        [lblLocationName.layer setShadowColor:[UIColor blackColor].CGColor];
        [lblLocationName.layer setShadowOffset:CGSizeMake(2, 2)];
        [lblLocationName.layer setShadowOpacity:0.5f];
        [lblLocationName.layer setShadowRadius:3.0];
        [lblLocationName.layer setMasksToBounds:NO];
        
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
    [lblLocationName setText:singletonClass.selectedLocation.LocationName];
    [locationTableViewController setDataSource:singletonClass.selectedLocation];
    [locationTableViewController.tableView reloadData];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void)viewDidAppear:(BOOL)animated {
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)itemSelected:(Locations*)mySelectedLocation {
    MapViewController *mapViewController = [[MapViewController alloc] initWithNibName:@"MapViewController" bundle:nil];
    [mapViewController setSelectedLocation:mySelectedLocation];
    [self.navigationController pushViewController:mapViewController animated:YES];
}


@end
