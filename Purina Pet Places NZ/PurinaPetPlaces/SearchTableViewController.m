//
//  SearchTableViewController.m
//  PurinaPetPlaces
//
//  Created by Josh Bruce on 12/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SearchTableViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "CategoriesViewController.h"
#import "MapViewController.h"
#import "Singleton.h"

@interface SearchTableViewController ()

@end

@implementation SearchTableViewController
@synthesize tfSuburb, segDistance, currentUserLocation, blackLoadingScreen, forwardGeocoder, selectedCategory, tfSearchTerm, btnSearch;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        [self.tableView setBackgroundColor:[UIColor clearColor]];
//        [self.tableView setScrollEnabled:NO];
        
        /*
        
        CAGradientLayer *gradient = [CAGradientLayer layer];
        [gradient setFrame:self.view.bounds];
        [gradient setColors:[NSArray arrayWithObjects:(id)[UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1].CGColor, (id)[UIColor colorWithRed:253/255.0 green:253/255.0 blue:253/255.0 alpha:1].CGColor, nil]];
        [self.tableView.layer insertSublayer:gradient atIndex:0];
        
        //[self.tableView setBackgroundColor:[UIColor greenColor]];
         */
        
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
    
    update = TRUE;
    [super viewDidLoad];
    [self.tableView becomeFirstResponder];
    
    [self itemSelected:@"Accommodation"];
    
    blackLoadingScreen = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.height, self.view.frame.size.height)];
    [blackLoadingScreen setBackgroundColor:[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.9f]];
    [blackLoadingScreen setTag:2];
    
    UILabel *loading = [[UILabel alloc] initWithFrame:CGRectMake(0, 367/2, 320, 40)];
    [loading setText:@"Searching"];
    [loading setFont:[UIFont boldSystemFontOfSize:30]];
    [loading setTextColor:[UIColor whiteColor]];
    [loading setBackgroundColor:[UIColor clearColor]];
    [loading setTextAlignment:UITextAlignmentCenter];
    [loading setShadowColor:[UIColor darkGrayColor]];
    
    UIActivityIndicatorView *benActivity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    //[benActivity setColor:[UIColor whiteColor]];
    [benActivity setCenter:CGPointMake(160, (367/2)-30)];
    [benActivity startAnimating];
    
    [blackLoadingScreen addSubview:benActivity];
    [blackLoadingScreen addSubview:loading];
    
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    backgroundView.backgroundColor = [UIColor whiteColor];
    
    UILabel *introLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    [introLabel setTextAlignment:UITextAlignmentCenter];
    [introLabel setText:@"Enter Your Search Critera Below"];
    
    [backgroundView.layer setShadowColor:[UIColor blackColor].CGColor];
    [backgroundView.layer setShadowOffset:CGSizeMake(2, 2)];
    [backgroundView.layer setShadowOpacity:0.5f];
    [backgroundView.layer setShadowRadius:3.0];
    [backgroundView.layer setMasksToBounds:NO];
    
    [backgroundView addSubview:introLabel];
    [self.view addSubview:backgroundView];

}




- (void)viewDidUnload
{
    [super viewDidUnload];
}



-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 120)];
    
    segDistance = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"1", @"5", @"10", nil]];
    [segDistance setSegmentedControlStyle:UISegmentedControlStyleBar];
    [segDistance setSelectedSegmentIndex:2];
    [segDistance setFrame:CGRectMake(80, 30, 160, 35)];
    [segDistance setTintColor:[UIColor colorWithRed:198/255.0 green:33/255.0 blue:33/255.0 alpha:1]];
    
    UILabel *lblDistance = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    [lblDistance setText:@"Distance in kilometers"];
    [lblDistance setFont:[UIFont boldSystemFontOfSize:14]];
    [lblDistance setBackgroundColor:[UIColor clearColor]];
    [lblDistance setTextAlignment:UITextAlignmentCenter];
    
    
    //ios 4.3 Backwards compatable yo
    UIImage *background_button_disabled;
    if ([background_button_disabled respondsToSelector:@selector(resizableImageWithCapInsets:)])
        background_button_disabled = [[UIImage imageNamed:@"background_button_disabled.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    else
        background_button_disabled = [[UIImage imageNamed:@"background_button_disabled.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    
    
    //ios 4.3 Backwards compatable yo
    UIImage *background_button;
    if ([background_button respondsToSelector:@selector(resizableImageWithCapInsets:)])
        background_button = [[UIImage imageNamed:@"background_button.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    else
        background_button = [[UIImage imageNamed:@"background_button.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    
    btnSearch = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btnSearch setBackgroundImage:background_button_disabled forState:UIControlStateDisabled];
    [btnSearch setBackgroundImage:background_button forState:UIControlStateNormal];
    [btnSearch setTitle:@"Search" forState:UIControlStateNormal];

    [btnSearch.layer setBorderColor:[UIColor colorWithRed:171/255.0 green:30/255.0 blue:29/255.0 alpha:1].CGColor];
    [btnSearch.layer setBorderWidth:1];
    [btnSearch.layer setCornerRadius:7];
    [btnSearch.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [btnSearch setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
    [btnSearch setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnSearch addTarget:self action:@selector(buttonPush:) forControlEvents:UIControlEventTouchUpInside];
    [btnSearch setFrame:CGRectMake(10, 80, 300, 40)];
    //[self setupButton];
     
    [footerView addSubview:btnSearch];
    [footerView addSubview:lblDistance];
    [footerView addSubview:segDistance];
    
    return footerView;
}

-(void)viewDidAppear:(BOOL)animated {
    tfSuburb = (UITextField *)[self.tableView viewWithTag:1];
    [tfSuburb resignFirstResponder];
}
    

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 60;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 120;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}




#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    tfSuburb = [[UITextField alloc] init];
    tfSearchTerm = [[UITextField alloc] init];
    
    UIButton *currentLocation = [[UIButton alloc] init];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell.textLabel setFont:[UIFont boldSystemFontOfSize:14]];
        
        [tfSuburb setTag:1];
        [tfSuburb setDelegate:self];
        [tfSuburb setFrame:CGRectMake(45, 11, 245, 22)];
        [tfSuburb setClearButtonMode:UITextFieldViewModeWhileEditing];
        [tfSuburb setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [tfSuburb setFont:[UIFont systemFontOfSize:14]];
        [tfSuburb setPlaceholder:@"Suburb, Region or Postcode"];
        [tfSuburb setTextAlignment:NSTextAlignmentLeft];
        
        [tfSearchTerm setTag:3];
        [tfSearchTerm setDelegate:self];
        [tfSearchTerm setFrame:CGRectMake(10, 11, 280, 22)];
        [tfSearchTerm setClearButtonMode:UITextFieldViewModeWhileEditing];
        [tfSearchTerm setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [tfSearchTerm setFont:[UIFont systemFontOfSize:14]];
        [tfSearchTerm setPlaceholder:@"Search Term"];
        [tfSearchTerm setTextAlignment:NSTextAlignmentLeft];
        
        [currentLocation setTag:2];
        [currentLocation setFrame:CGRectMake(7, 7, 30, 30)];
        [currentLocation setBackgroundImage:[UIImage imageNamed:@"button_currentLocation_selected.png"] forState:UIControlStateNormal];
        [currentLocation setBackgroundImage:[UIImage imageNamed:@"button_currentLocation.png"] forState:UIControlStateHighlighted];
        [currentLocation addTarget:self action:@selector(setCurrentLocation) forControlEvents:UIControlEventTouchUpInside];
        
    }else {
        tfSuburb = (UITextField *)[cell.contentView viewWithTag:1];
        tfSearchTerm = (UITextField *)[cell.contentView viewWithTag:3];
    }
    
    switch ([indexPath row]) {
        case 0:
            [cell.textLabel setText:@"Category"];
            [cell.detailTextLabel setText:selectedCategory];
            [cell.detailTextLabel setFont:[UIFont systemFontOfSize:14]];
            [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
            break;
        case 1:
            [cell.contentView addSubview:tfSearchTerm];
            break;
        case 2:
            [cell.contentView addSubview:tfSuburb];
            [cell.contentView addSubview:currentLocation];
            break;
    }
    
    return cell;
}     

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    tfSuburb = (UITextField *)[self.tableView viewWithTag:1];
    if ([tfSuburb.text isEqualToString:@"Current Location"]) {
        [tfSuburb setText:nil];
        [tfSuburb setTextColor:[UIColor blackColor]];
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    //[self setupButton];
}

-(void)setCurrentLocation {
    tfSuburb = (UITextField *)[self.tableView viewWithTag:1];
    [tfSuburb setText:@"Current Location"];
    [tfSuburb setTextColor:[UIColor redColor]];//[UIColor colorWithRed:0.22 green:0.33 blue:0.53 alpha:1.0]];
    //[self setupButton];
}
     
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tfSuburb resignFirstResponder];
    if ([indexPath row] == 0) {
        CategoriesViewController *categoriesViewController = [[CategoriesViewController alloc] initWithStyle:UITableViewStyleGrouped];
        [categoriesViewController setDelegate:self];
        [self.navigationController pushViewController:categoriesViewController animated:YES];
    }
}

#pragma mark - BSForwardGeocoderDelegate methods

- (void)forwardGeocoderConnectionDidFail:(BSForwardGeocoder *)geocoder withErrorMessage:(NSString *)errorMessage
{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error!" message:errorMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
	[alert show];   
}


- (void)forwardGeocodingDidSucceed:(BSForwardGeocoder *)geocoder withResults:(NSArray *)results
{
    
    tfSearchTerm = (UITextField *)[self.tableView viewWithTag:3];
    BSKmlResult *place = [results objectAtIndex:0];
    
        
    CLGeocoder *forwardGeo = [[CLGeocoder alloc] init];
    CLLocation *reverseLocation = [[CLLocation alloc] initWithLatitude:place.latitude longitude:place.longitude];
    
    CGFloat distanceFromLocation;
    switch (segDistance.selectedSegmentIndex) {
        case 0:
            distanceFromLocation = 1.0;
            break;
        case 1:
            distanceFromLocation = 5.0;
            break;
        case 2:
            distanceFromLocation = 10.0;
            break;
    }
    
    NSLog(@"Searching For: %f / %f", reverseLocation.coordinate.latitude, reverseLocation.coordinate.longitude);
    
    [forwardGeo reverseGeocodeLocation:reverseLocation completionHandler:^(NSArray* placemarks, NSError* error){
        NSLog(@"Placemarks %i", placemarks.count);
        if (placemarks.count >= 1) {
            CLPlacemark *placemarkresult = [[CLPlacemark alloc] initWithPlacemark:[placemarks objectAtIndex:0]];
            CLLocation *placemarkLocation = [[CLLocation alloc] initWithLatitude:placemarkresult.location.coordinate.latitude longitude:placemarkresult.location.coordinate.longitude];
            
            Singleton *singletonClass = [Singleton sharedInstance];
            int locationsCount = 0;
            
            
            for (Locations *location in singletonClass.locationListing) {
                if (![location.LocationLongLat isEqualToString:@""]) {
    
               
                NSArray *longLatSplit = [location.LocationLongLat componentsSeparatedByString:@","];
                
                CLLocationCoordinate2D theCoordinate;
                theCoordinate.latitude = [[longLatSplit objectAtIndex:0] doubleValue];  
                theCoordinate.longitude = [[longLatSplit objectAtIndex:1] doubleValue];
                
                CLLocation *currentScanLoc = [[CLLocation alloc] initWithLatitude:theCoordinate.latitude longitude:theCoordinate.longitude];
                CLLocationDistance distance = [placemarkLocation distanceFromLocation:currentScanLoc];
                
                if ([tfSearchTerm.text length] > 0) {
                    NSRange range = [location.LocationName rangeOfString:tfSearchTerm.text options:NSCaseInsensitiveSearch];
                    if (distance / 1000 <= distanceFromLocation && [location.LocationCategoryName isEqualToString:selectedCategory] && range.location != NSNotFound) {
                        locationsCount ++;
                    }
                }else {
                    if (distance / 1000 <= distanceFromLocation && [location.LocationCategoryName isEqualToString:selectedCategory]) {
                        locationsCount ++;
                    }
                }
                }
            }
            
            [blackLoadingScreen removeFromSuperview];
            
            
            
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"No results found" delegate:nil cancelButtonTitle:@"Close" otherButtonTitles: nil];
            
            if (locationsCount > 0)
                [self pushMapView:placemarkresult distance:distanceFromLocation];
            else
                [alert show];  
        }else {
            NSLog(@"nogo?");
        }
        
        
        
        
        
        
        }];
    
        

}

- (void)forwardGeocodingDidFail:(BSForwardGeocoder *)geocoder withErrorCode:(int)errorCode andErrorMessage:(NSString *)errorMessage
{
    NSString *message = @"";
    
    switch (errorCode) {
        case G_GEO_BAD_KEY:
            message = @"The API key is invalid.";
            break;
            
        case G_GEO_UNKNOWN_ADDRESS:
            message = [NSString stringWithFormat:@"Sorry, location could not be found"];
            [blackLoadingScreen removeFromSuperview];
            break;
            
        case G_GEO_TOO_MANY_QUERIES:
            message = @"Too many queries has been made for this API key.";
            break;
            
        case G_GEO_SERVER_ERROR:
            message = @"Server error, please try again.";
            break;
            
            
        default:
            break;
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Information" 
                                                    message:message
                                                   delegate:nil 
                                          cancelButtonTitle:@"OK" 
                                          otherButtonTitles: nil];
    [alert show];
    [blackLoadingScreen removeFromSuperview];
}


#pragma mark - Delegate Methods

-(void)itemSelected:(NSString *)passedSelectedCategory {
    self.selectedCategory = passedSelectedCategory;
    [self.tableView reloadData];
}

#pragma mark - Location Delegate Methods

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    if (update) {
        [currentUserLocation stopUpdatingLocation];
        [self passCurrentLocation:newLocation];
        update = FALSE;
    }
    
    
}

#pragma mark - Custom Display/Setup


-(void)buttonPush:(id)sender{
    
    tfSuburb = (UITextField *)[self.tableView viewWithTag:1];
    
    if (tfSuburb.text.length <= 0) {
        UIAlertView *warningText = [[UIAlertView alloc] initWithTitle:nil message:@"Please enter a Suburb, Region or Postcode" delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil, nil];
        [warningText show];
    }else {
        update = TRUE;
        [self.view addSubview:blackLoadingScreen];
        NSString *augString = [NSString stringWithFormat:@"%@, New Zealand", self.tfSuburb.text];
    
        if (self.forwardGeocoder == nil)
            self.forwardGeocoder = [[BSForwardGeocoder alloc] initWithDelegate:self];
	
        if ([tfSuburb.text isEqualToString:@"Current Location"]) {
            currentUserLocation = [[CLLocationManager alloc] init];
            [currentUserLocation setDelegate:self];
            [currentUserLocation startUpdatingLocation];
        } else {
            [self.forwardGeocoder forwardGeocodeWithQuery:augString regionBiasing:nil success:^(NSArray *results) {
                [self forwardGeocodingDidSucceed:self.forwardGeocoder withResults:results];
            } failure:^(int status, NSString *errorMessage) {
                if (status == G_GEO_NETWORK_ERROR) {
                    [self forwardGeocoderConnectionDidFail:self.forwardGeocoder withErrorMessage:errorMessage];
                    [blackLoadingScreen removeFromSuperview];
                } else {
                    [self forwardGeocodingDidFail:self.forwardGeocoder withErrorCode:status andErrorMessage:errorMessage];
                    [blackLoadingScreen removeFromSuperview];
                }
            }];
            
        }
    }
}



-(void)passCurrentLocation:(CLLocation *)userLocation {
    CGFloat distanceFromLocation;
    switch (segDistance.selectedSegmentIndex) {
        case 0:
            distanceFromLocation = 1.0;
            break;
        case 1:
            distanceFromLocation = 5.0;
            break;
        case 2:
            distanceFromLocation = 10.0;
            break;
    }
    
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:userLocation completionHandler:^(NSArray* placemarks, NSError* error){
        
        CLPlacemark *placemarkresult = [[CLPlacemark alloc] initWithPlacemark:[placemarks objectAtIndex:0]];
        //CLLocation *placemarkLocation = [[CLLocation alloc] initWithLatitude:placemarkresult.location.coordinate.latitude longitude:placemarkresult.location.coordinate.longitude];
        
        Singleton *singletonClass = [Singleton sharedInstance];
        int locationsCount = 0;
        
        
        for (Locations *location in singletonClass.locationListing) {
            if (![location.LocationLongLat isEqualToString:@""]) {
            NSArray *longLatSplit = [location.LocationLongLat componentsSeparatedByString:@","];
            CLLocationCoordinate2D theCoordinate;
            theCoordinate.latitude = [[longLatSplit objectAtIndex:0] doubleValue];  
            theCoordinate.longitude = [[longLatSplit objectAtIndex:1] doubleValue];
            
            CLLocation *currentScanLoc = [[CLLocation alloc] initWithLatitude:theCoordinate.latitude longitude:theCoordinate.longitude];
            CLLocationDistance distance = [userLocation distanceFromLocation:currentScanLoc];
            
            if ([tfSearchTerm.text length] > 0) {
                NSRange range = [location.LocationName rangeOfString:tfSearchTerm.text options:NSCaseInsensitiveSearch];
                if (distance / 1000 <= distanceFromLocation && [location.LocationCategoryName isEqualToString:selectedCategory] && range.location != NSNotFound) {
                    locationsCount ++;
                }
            }else {
                if (distance / 1000 <= distanceFromLocation && [location.LocationCategoryName isEqualToString:selectedCategory]) {
                    locationsCount ++;
                }
            }
            }
        }
        
        [blackLoadingScreen removeFromSuperview];
        
        
        
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"No results found" delegate:nil cancelButtonTitle:@"Close" otherButtonTitles: nil];
        
        if (locationsCount > 0)
            [self pushMapView:placemarkresult distance:distanceFromLocation];
        else
            [alert show];    
    }];
    
    //[self pushMapView:placemarkresult distance:distanceFromLocation];
    
}


-(void)pushMapView:(CLPlacemark *)placemarkresult distance:(CGFloat)distanceFromLocation {
    MapViewController *mapViewController = [[MapViewController alloc] initWithNibName:@"MapViewController" bundle:nil];
    [mapViewController setSearchResult:placemarkresult];
    [mapViewController setPassedCategory:selectedCategory];
    [mapViewController setPassedSearchString:tfSearchTerm.text];
    [mapViewController setPassedDistance:distanceFromLocation];
    [self.navigationController pushViewController:mapViewController animated:YES];
}




@end
