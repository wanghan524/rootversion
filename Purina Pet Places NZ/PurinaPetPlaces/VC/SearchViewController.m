//
//  SearchViewController.m
//  PurinaPetPlaces
//
//  Created by art_kernel_zyc on 15/4/13.
//
//

#import "SearchViewController.h"
#import "Singleton.h"
#import "MapViewController.h"

@interface SearchViewController ()
{
    BOOL clickStatus;
    @private
    CGFloat width,height,startPointY;
    CGFloat residuceHeight;
    

}
@end

@implementation SearchViewController
@synthesize forwardGeocoder,blackLoadingScreen,currentUserLocation;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initBack];
    clickStatus = NO;
    self.navigationController.navigationBar.hidden = YES;
    width = SCREEN_WIDTH;
    height = SCREEN_HEIGHT;
    if(CD_X(6))
    {
        startPointY = 0;
        navHeight = 44;
    }
    else
        if(CD(7))
        {
            startPointY = 20;
            navHeight = 64;
        }

    residuceHeight = SCREEN_HEIGHT - navHeight;
    [self showCustomeNav];
    [self showSearchView];
    [self showSearchBtn];
    
    
    
}

- (void)initBack{
    
    update = TRUE;
    blackLoadingScreen = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.height, self.view.frame.size.height)];
    [blackLoadingScreen setBackgroundColor:[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.9f]];
    [blackLoadingScreen setTag:2];
    
    UILabel *loading = [[UILabel alloc] initWithFrame:CGRectMake(0, 367/2, 320, 40)];
    [loading setText:@"Searching"];
    [loading setFont:[UIFont fontWithName:@"Antenna" size:30]];
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
}

-(void)showSearchBtn
{
    self.searchCatagoryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.searchCatagoryBtn setFrame:CGRectMake(0, SCREEN_HEIGHT - 50, SCREEN_WIDTH, 50)];
    [self.searchCatagoryBtn setTitle:@"Search" forState:UIControlStateNormal];
    self.searchCatagoryBtn.titleLabel.font = [UIFont fontWithName:@"Antenna" size:22];
    [self.searchCatagoryBtn setBackgroundColor:[UIColor redColor]];
    [self.searchCatagoryBtn addTarget:self action:@selector(searchCataGoryBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.searchCatagoryBtn];
}

-(void)searchCataGoryBtnClick:(UIButton *)sender
{
    DLog(@"dianji");
    //tfSuburb = (UITextField *)[self.tableView viewWithTag:1];
    
    if (self.searchMapView.suburbTxt.text.length <= 0) {
        UIAlertView *warningText = [[UIAlertView alloc] initWithTitle:nil message:@"Please enter a Suburb, Region or Postcode" delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil, nil];
        [warningText show];
    }else {
        update = TRUE;
        [self.view addSubview:blackLoadingScreen];
        NSString *augString = [NSString stringWithFormat:@"%@, New Zealand", self.searchMapView.suburbTxt.text];
        
        if (self.forwardGeocoder == nil)
            self.forwardGeocoder = [[BSForwardGeocoder alloc] initWithDelegate:self];
        
        if ([self.searchMapView.suburbTxt.text isEqualToString:@"Current Location"]) {
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



-(void)showSearchView
{
    self.searchMapView = (MySearchView *)[[[NSBundle mainBundle]loadNibNamed:@"MySearchView" owner:self options:nil]lastObject];
    [self.searchMapView setFrame: CGRectMake(0, navHeight, SCREEN_WIDTH, residuceHeight - 50)];
    [self.view addSubview:self.searchMapView];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
-(void)viewWillAppear:(BOOL)animated
{
    [self registerTextFieldNotification];
}

-(void)registerTextFieldNotification
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)keyboardWillShow:(NSNotification *)notify
{
    NSDictionary *userInfo = [notify userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    CGFloat height = keyboardRect.size.height;
    CGFloat keyboradHeight = keyboardRect.origin.y - 90;
    CGFloat searchHeight = CGRectGetMaxY(self.searchMapView.searchTermTxt.frame);
    CGFloat suburbHeight = CGRectGetMaxY(self.searchMapView.suburbTxt.frame);
    if([self.searchMapView.searchTermTxt isEditing])
    {
        if(keyboradHeight < searchHeight)
        {
            CGFloat adds = searchHeight - keyboradHeight;
            [self.searchMapView setFrame:CGRectMake(0, navHeight - adds, SCREEN_WIDTH, residuceHeight - 50)];
        }
    }
    
    if([self.searchMapView.suburbTxt isEditing])
    {
        if(keyboradHeight < suburbHeight)
        {
            CGFloat adds = suburbHeight - keyboradHeight;
            [self.searchMapView setFrame:CGRectMake(0, navHeight - adds, SCREEN_WIDTH, residuceHeight - 50)];
        }
    }

}
-(void)keyboardWillHide:(NSNotification *)notify
{
        [self.searchMapView setFrame: CGRectMake(0, navHeight, SCREEN_WIDTH, residuceHeight - 50)];
}


-(void)showCustomeNav
{
    UIView *backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    backGroundView.backgroundColor = [UIColor colorWithRed:242/255.0 green:238/255.0 blue:223/255.0 alpha:1];
    backGroundView.userInteractionEnabled = YES;
    [self.view addSubview:backGroundView];
    
    
    self.lineImageView = [[UIImageView alloc]init];
    self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.profileButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.petPlaceImageView = [[UIImageView alloc]init];
    
    
    [self.lineImageView setFrame:CGRectMake(0, startPointY , SCREEN_WIDTH, 5)];
    [self.lineImageView setBackgroundColor:[UIColor redColor]];
    [backGroundView addSubview:self.lineImageView];
    
    [self.backButton setFrame:CGRectMake(10, CGRectGetMaxY(self.lineImageView.frame) + 5 , 30, 30)];
    [self.backButton setBackgroundImage:[UIImage imageNamed:@"btn-back.jpg"] forState:UIControlStateNormal];
    //[self.backButton setBackgroundColor:[UIColor blackColor]];
    [backGroundView addSubview:self.backButton];
    
    CGPoint point = self.view.center;
    [self.petPlaceImageView setFrame:CGRectMake(point.x - 46, CGRectGetMaxY(self.lineImageView.frame) + 5, 92, 27)];
    self.petPlaceImageView.image = [UIImage imageNamed:@"petcentric2-logo.png"];
    //[self.petPlaceImageView setBackgroundColor:[UIColor blueColor]];
    [backGroundView addSubview:self.petPlaceImageView];
    
    
    
    [self.searchButton setFrame:CGRectMake(SCREEN_WIDTH - 45 , CGRectGetMaxY(self.lineImageView.frame) + 5 , 30, 30)];
    [self.searchButton setBackgroundImage:[UIImage imageNamed:@"btn-search.jpg"] forState:UIControlStateNormal];
    //[self.searchButton setBackgroundColor:[UIColor blackColor]];
    [backGroundView addSubview:self.searchButton];
//    [self.searchButton addTarget:self action:@selector(searchBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.profileButton setFrame:CGRectMake(CGRectGetMinX(self.searchButton.frame) - 45 , CGRectGetMaxY(self.lineImageView.frame) + 5 , 30, 30)];
    [self.profileButton setBackgroundImage:[UIImage imageNamed:@"btn-menu.jpg"] forState:UIControlStateNormal];
    //[self.profileButton setBackgroundColor:[UIColor blackColor]];
    [backGroundView addSubview:self.profileButton];
    
    self.residuHeigth = SCREEN_HEIGHT - navHeight;
    
    [self.profileButton addTarget:self action:@selector(profileBtnClickOrGestureClip:) forControlEvents:UIControlEventTouchUpInside];
    [self.backButton addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
}
-(void)backBtnClick:(UIButton *)sender
{
    if([self.navigationController.viewControllers count] > 0)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)profileBtnClickOrGestureClip:(UIButton *)sender
{
    clickStatus = !clickStatus;
    if(clickStatus == YES)
    {[self makeDarkView];}
    else
    {
        [self.darkView removeFromSuperview];
        self.darkView = nil;
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    if(self.darkView != nil)
    {
        if(touch.view == self.darkView)
        {
            clickStatus = !clickStatus;
            [self.darkView removeFromSuperview];
            self.darkView = nil;
        }
    }
}


-(void)makeDarkView
{
    
    [UIView animateWithDuration:2 animations:^{
        
    } completion:^(BOOL finished) {
        self.darkView = [[UIView alloc]initWithFrame:CGRectMake(0, navHeight, SCREEN_WIDTH, SCREEN_HEIGHT - navHeight)];
        [self.darkView setBackgroundColor:[UIColor colorWithRed:86/255.f green:86/255.f blue:86/255.f alpha:0.7]];
        
        
        [self.view addSubview:self.darkView];
        
        self.menusTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH / 2 + 30, SCREEN_HEIGHT - navHeight) style:UITableViewStylePlain];
        self.menusTable.delegate = self;
        self.menusTable.dataSource = self;
        self.menusTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.menusTable.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        [self.darkView addSubview:self.menusTable];
        
        self.menuArray = [[NSMutableArray alloc]initWithCapacity:0];
        NSArray *arr = @[@"Home",@"Dog Pet Places",@"Photo Fun",@"Pet Friendly Places",@"Stockists",@"Tools",@"Pet Service",@"Tips",@"Products"];
        for(NSUInteger i = 0; i < [arr count]; i++)
        {
            [self.menuArray addObject:arr[i]];
        }
        
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.menuArray count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *imageNameArray = @[@"menu-home.jpg",@"menu-dog-pet-places.jpg",@"menu-photo-fun.jpg",@"menu-pet-friendly-places.jpg",@"menu-stockists.jpg",@"menu-tools.jpg",@"menu-pet-service.jpg",@"menu-tips.jpg",@"menu-products.jpg"];
    static NSString *iden = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:iden];
    if(nil == cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
        UIImageView *iconTemplateView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 8, 33, 33)];
        iconTemplateView.backgroundColor = [UIColor redColor];
        iconTemplateView.image = [UIImage imageNamed:imageNameArray[indexPath.row]];
        [cell.contentView addSubview:iconTemplateView];
        [cell setIndentationLevel:4];
    }
    cell.textLabel.font = [UIFont fontWithName:@"Antenna" size:10];
    cell.textLabel.text = [self.menuArray objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"cell lable: %@",cell.textLabel.text);
    
    if(self.darkView != nil)
    {
        
        clickStatus = !clickStatus;
        [self.darkView removeFromSuperview];
        self.darkView = nil;
        
    }
    
    
    if(indexPath.row == 0)
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else
        if(indexPath.row == 1)
        {
            
        }else
            
            if (indexPath.row == 2) {
                
                
                photoFunViewController *photoFunVC =  [[photoFunViewController alloc] initWithNibName:@"photoFunViewController" bundle:nil];
                //[self presentViewController:photoFunVC animated:YES completion:nil];
                [self.navigationController pushViewController:photoFunVC animated:YES];
            }
    
            else if (indexPath.row == 3) {
                PetFriendlyPlacesViewController *petFriendlyPlacesVC =  [[PetFriendlyPlacesViewController alloc ] init];
                //[self presentViewController:photoFunVC animated:YES completion:nil];
                [self.navigationController pushViewController:petFriendlyPlacesVC animated:YES];
            }
    
            else if (indexPath.row == 4){
                Singleton *singletonClass = [Singleton sharedInstance];
                NSArray *currentCategories = [[NSArray alloc] initWithArray:singletonClass.currentCategories];
                for (Categories *categories in currentCategories) {
                    NSLog(@"Categories name : %@",categories.CategoryName);
                    
                    if ([categories.CategoryName isEqualToString:@"Stockists"]) {
                        [singletonClass setSelectedCategories:categories];
                        NextPetFriendlyPlacesViewController *stockists = [[NextPetFriendlyPlacesViewController alloc] init];
                        stockists.headerImageFlag = categories.CategoryName;
                        [self.navigationController pushViewController:stockists animated:YES];
                        
                    }
                }
                
                
            }
    
            else if (indexPath.row == 5) {
                ToolsViewController *toolsVC =  [[ToolsViewController alloc ] init];
                
                [self.navigationController pushViewController:toolsVC animated:YES];
            }
    
            else if (indexPath.row == 6){
                Singleton *singletonClass = [Singleton sharedInstance];
                NSArray *currentCategories = [[NSArray alloc] initWithArray:singletonClass.currentCategories];
                for (Categories *categories in currentCategories) {
                    NSLog(@"Categories name : %@",categories.CategoryName);
                    
                    if ([categories.CategoryName isEqualToString:@"Pet Services"]) {
                        [singletonClass setSelectedCategories:categories];
                        NextPetFriendlyPlacesViewController *stockists = [[NextPetFriendlyPlacesViewController alloc] init];
                        stockists.headerImageFlag = categories.CategoryName;
                        [self.navigationController pushViewController:stockists animated:YES];
                        
                    }
                }
                
                
            }
    
            else if (indexPath.row == 7) {
                TipsViewController *tipsVC =  [[TipsViewController alloc ] init];
                //[self presentViewController:photoFunVC animated:YES completion:nil];
                [self.navigationController pushViewController:tipsVC animated:YES];
            }
    
            else if (indexPath.row == 8) {
                ProductsViewController *photoFunVC =  [[ProductsViewController alloc ] init];
                //[self presentViewController:photoFunVC animated:YES completion:nil];
                [self.navigationController pushViewController:photoFunVC animated:YES];
            }
    DLog(@"%@",indexPath);
    

    
    
    
}

#pragma mark - BSForwardGeocoderDelegate methods

- (void)forwardGeocoderConnectionDidFail:(BSForwardGeocoder *)geocoder withErrorMessage:(NSString *)errorMessage
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error!" message:errorMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}


- (void)forwardGeocodingDidSucceed:(BSForwardGeocoder *)geocoder withResults:(NSArray *)results
{
    
    //tfSearchTerm = (UITextField *)[self.tableView viewWithTag:3];
    BSKmlResult *place = [results objectAtIndex:0];
    
    
    CLGeocoder *forwardGeo = [[CLGeocoder alloc] init];
    CLLocation *reverseLocation = [[CLLocation alloc] initWithLatitude:place.latitude longitude:place.longitude];
    
    CGFloat distanceFromLocation;
//    switch (segDistance.selectedSegmentIndex) {
//        case 0:
//            distanceFromLocation = 1.0;
//            break;
//        case 1:
//            distanceFromLocation = 5.0;
//            break;
//        case 2:
//            distanceFromLocation = 10.0;
//            break;
//    }
    distanceFromLocation = [self.searchMapView.currentDistanceStr floatValue];
    
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
                    
                    if ([self.searchMapView.searchTermTxt.text length] > 0) {
                        NSRange range = [location.LocationName rangeOfString:self.searchMapView.searchTermTxt.text options:NSCaseInsensitiveSearch];
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

-(void)pushMapView:(CLPlacemark *)placemarkresult distance:(CGFloat)distanceFromLocation {
    MapViewController *mapViewController = [[MapViewController alloc] initWithNibName:@"MapViewController" bundle:nil];
    [mapViewController setSearchResult:placemarkresult];
    [mapViewController setPassedCategory:selectedCategory];
    [mapViewController setPassedSearchString:self.searchMapView.searchTermTxt.text];
    [mapViewController setPassedDistance:distanceFromLocation];
    [self.navigationController pushViewController:mapViewController animated:YES];
}
@end
