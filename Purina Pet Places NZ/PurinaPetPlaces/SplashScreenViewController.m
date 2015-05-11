//
//  SplashScreenViewController.m
//  PurinaPetPlaces
//
//  Created by Josh Bruce on 16/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SplashScreenViewController.h"

#import "ViewController.h"
#import "PCPetCentricSvc.h"
#import "CustomNavigationBar.h"
#import "Singleton.h"
#import "Locations.h"
#import "Reachability.h"
#import "ConnectionViewController.h"
#import <MessageUI/MessageUI.h>
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"


@interface SplashScreenViewController ()

@end

@implementation SplashScreenViewController
@synthesize tabBarController, locationsViewController, searchTableViewController, alert, splashScreen, petInfoMainScreenViewController, progressText, progressBackgroundView, progressActivity, prefs, diskArray, progressSubText, connectionViewController, loadingBackgroundView, loadingText;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}


- (void)viewDidLoad
{
    //debug = 1;
    [super viewDidLoad];
    
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone && [UIScreen mainScreen].bounds.size.height == 568)
    {
        [splashScreen setImage:[UIImage imageNamed:@"loading-splash-page.jpg"]];
        
    }else {
        
        [splashScreen setImage:[UIImage imageNamed:@"loading-splash-page.jpg"]];
    }
    
    loadingBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(20, 350, 280, 75)];
    [loadingBackgroundView setBackgroundColor:[UIColor blackColor]];
    [loadingBackgroundView setAlpha:0.7f];
    [loadingBackgroundView setTag:1];
    [loadingBackgroundView.layer setCornerRadius:10.0f];
    
    loadingText = [[UILabel alloc] init];
    [loadingText setTag:3];
    [loadingText setFrame:CGRectMake(0, 40, 280, 20)];
    [loadingText setTextAlignment:NSTextAlignmentCenter];
    [loadingText setFont:[UIFont boldSystemFontOfSize:16]];
    [loadingText setBackgroundColor:[UIColor clearColor]];
    [loadingText setTextColor:[UIColor whiteColor]];
    [loadingText setText:@"Loading"];
    [loadingBackgroundView addSubview:loadingText];
    
    progressActivity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [progressActivity setCenter:CGPointMake(loadingBackgroundView.frame.size.width/2, 25)];
    [progressActivity startAnimating];
    [loadingBackgroundView addSubview:progressActivity];
    
    [self.view addSubview:loadingBackgroundView];
    
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone && [UIScreen mainScreen].bounds.size.height == 568)
    {
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"loading-splash-page.jpg"]];
        
    }else {
        
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"loading-splash-page.jpg"]];
    }
    
    [self checkForConnectivity];
}

-(void)updateProgressView:(int)size {
    /*
    totalSize = totalSize + size;
    [progressText setText:[NSString stringWithFormat:@"%i bytes downloaded", totalSize]];
    NSLog(@"DELEAGTE: %i", size);
    //OBSOLETE METHOD
     */
}

-(void)checkForConnectivity {
    Reachability* reach = [Reachability reachabilityWithHostname:@"www.google.com"];
    if ([reach isReachable]) {
        [self loadEmUp];
         
    } else {
        [self presentError];
    }

}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    [self checkForConnectivity];
}

-(void)loadEmUp {    
    PCPetCentricSvc *service = [[PCPetCentricSvc alloc] init];
    [service LocationCount:self action:@selector(LocationCountHandler:)];
    [service AllCategories:self action:@selector(handleAllCategories:)];
    [service AllSubCategories:self action:@selector(handleAllSubCategories:)];
}

- (void)customloadView {
    Singleton* sharedSingleton = [Singleton sharedInstance];
    if (sharedSingleton.currentCategories.count == 0) {
        [self loadEmUp];
    } else {
        
    EnterMianViewController *editVC = [[EnterMianViewController alloc] initWithNibName:@"EnterMianViewController" bundle:nil];
    //[self.navigationController pushViewController:editVC animated:YES];
        [editVC makePop];
        [self presentViewController:editVC animated:YES completion:nil];
#if 0
    
    NSString *iconPlaces = @"icon_Places_7.png";
    NSString *iconSearch = @"icon_Search_7.png";
    NSString *iconPetInfo = @"icon_PetInfo_7.png";
    
    if ([AppDelegate isVersion6AndBelow])
    {
        iconPlaces = @"icon_Places.png";
        iconSearch = @"icon_Search.png";
        iconPetInfo = @"icon_PetInfo.png";
    }
        
    UINavigationController *locationsNavigationController = [self customizedNavigationController];
    locationsViewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    [locationsNavigationController setViewControllers:[NSArray arrayWithObject:locationsViewController]];
    if ([locationsNavigationController.tabBarItem respondsToSelector:@selector(setFinishedSelectedImage:withFinishedUnselectedImage:)]) {
        [locationsNavigationController.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:iconPlaces] withFinishedUnselectedImage:[UIImage imageNamed:@"icon_Places_disabled.png"]];
    } else {
        [locationsNavigationController.tabBarItem setTitle:@"Locations"];
        [locationsNavigationController.tabBarItem setImage:[UIImage imageNamed:@"icon_Places.png"]];
    }
    [locationsViewController setTitle:@"Locations"];
    [locationsViewController.navigationItem setTitle:nil];
        
    UINavigationController *templocationsNavigationController = [self customizedNavigationController];
    searchTableViewController = [[SearchTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    [templocationsNavigationController setViewControllers:[NSArray arrayWithObject:searchTableViewController]];

    if ([templocationsNavigationController.tabBarItem respondsToSelector:@selector(setFinishedSelectedImage:withFinishedUnselectedImage:)]) {
        [templocationsNavigationController.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:iconSearch] withFinishedUnselectedImage:[UIImage imageNamed:@"icon_Search_disabled.png"]];
    } else {
        [templocationsNavigationController.tabBarItem setTitle:@"Search"];
        [templocationsNavigationController.tabBarItem setImage:[UIImage imageNamed:@"icon_Search.png"]];
    }
    [searchTableViewController setTitle:@"Search"];
    [searchTableViewController.navigationItem setTitle:nil];
        
    
    UINavigationController *petInfoNavigationController = [self customizedNavigationController];
    petInfoMainScreenViewController = [[PetInfoMainScreenViewController alloc] initWithNibName:@"PetInfoMainScreenViewController" bundle:nil];
    [petInfoNavigationController setViewControllers:[NSArray arrayWithObject:petInfoMainScreenViewController]];
    if ([petInfoNavigationController.tabBarItem respondsToSelector:@selector(setFinishedSelectedImage:withFinishedUnselectedImage:)]) {
        [petInfoNavigationController.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:iconPetInfo] withFinishedUnselectedImage:[UIImage imageNamed:@"icon_PetInfo_disabled.png"]];
    } else {
        [petInfoNavigationController.tabBarItem setTitle:@"Pet Info"];
        [petInfoNavigationController.tabBarItem setImage:[UIImage imageNamed:@"icon_PetInfo.png"]];
    }
    [petInfoMainScreenViewController setTitle:@"Pet Info"];
    [petInfoMainScreenViewController.navigationItem setTitle:nil];
    
    
    
    tabBarController = [[UITabBarController alloc] init];
    
        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone && [UIScreen mainScreen].bounds.size.height == 568)
        {
            [splashScreen setImage:[UIImage imageNamed:@"background_gradient-568h.png"]];
            
            if ([AppDelegate isVersion6AndBelow]) {

                [tabBarController.view setFrame:CGRectMake(0, 0, 320, 548)];
            }
            else
                [tabBarController.view setFrame:CGRectMake(0, 0, 320, 568)];
            
        }else {
            [splashScreen setImage:[UIImage imageNamed:@"background_gradient.png"]];
            
            if ([AppDelegate isVersion6AndBelow]) {
                [tabBarController.view setFrame:CGRectMake(0, 0, 320, 460)];
            }
            else {
                [tabBarController.view setFrame:CGRectMake(0, 0, 320, 480)];
            }
        }
        

    if ([tabBarController.tabBar respondsToSelector:@selector(setTintColor:)]){
//        [[UITabBar appearance] setTintColor:[UIColor colorWithRed:148/255.0 green:25/255.0 blue:25/255.0 alpha:1]];
    } else {
        CGSize tabBarSize = [tabBarController.tabBar frame].size;
        UIImageView *backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background_tabbar.png"]];
        [backgroundImage setFrame:CGRectMake(0,1,tabBarSize.width, tabBarSize.height)];
        [tabBarController.tabBar insertSubview:backgroundImage atIndex:0];
    }
    [tabBarController setViewControllers:[NSArray arrayWithObjects:locationsNavigationController, templocationsNavigationController, petInfoNavigationController, nil]];
            
    
    [self.view addSubview:tabBarController.view];
#endif

    }
}

-(void)presentError {
    connectionViewController = [[ConnectionViewController alloc] initWithNibName:@"ConnectionViewController" bundle:nil]; 
    [connectionViewController setDelegate:self];
    [self.view addSubview:connectionViewController.view];
    [self.view bringSubviewToFront:connectionViewController.view];
}

- (void)viewDidUnload
{
    [super viewDidUnload];

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    UIView *newView = progressBackgroundView;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0f];
    [UIView setAnimationDelegate:self];
    [newView setFrame:CGRectMake(newView.frame.origin.x, 352, newView.frame.size.width, newView.frame.size.height)];
    [UIView commitAnimations];
    
    [prefs setObject:@"FALSE" forKey:@"connectionIssues"];
    PCPetCentricSvc *service = [[PCPetCentricSvc alloc] init];
    [service AllCategories:self action:@selector(handleAllCategories:)];
    [service AllSubCategories:self action:@selector(handleAllSubCategories:)];
    [service AllLocations:self action:@selector(handleAllLocations:)];
    
}


#pragma mark - Webserice Intergration

- (void)handleAllSubCategories:(id)sender {
    if([sender isKindOfClass: [NSError class]] || [sender isKindOfClass: [SoapFault class]]) {
        NSLog(@"error");
	} else {
        NSMutableArray *currentSubCategories = [NSMutableArray array];
        for (PCCategoryInfo* location in sender) { 
            Categories *subCategory = [Categories alloc];
            [subCategory setCategoryName: location.SubCategoryName];
            [subCategory setCategoryId:[NSNumber numberWithInt:location.SubCategoryID]];
            [subCategory setParentCategoryId:[NSNumber numberWithInt:location.CategoryID]];
            [subCategory setCategoryCount:[NSNumber numberWithInt:location.Count]];
            [currentSubCategories addObject:subCategory];
        }
        Singleton* sharedSingleton = [Singleton sharedInstance];
        [sharedSingleton setCurrentSubCategories:currentSubCategories];
    }
}

- (void)handleAllCategories:(id)sender {
    if([sender isKindOfClass: [NSError class]] || [sender isKindOfClass: [SoapFault class]]) {
        NSLog(@"error");
	} else {
        NSMutableArray *currentCategories = [NSMutableArray array];
        for (PCCategoryInfo* location in sender) { 
            Categories *category = [Categories alloc];
            [category setCategoryName: location.CategoryName];
            [category setCategoryId:[NSNumber numberWithInt:location.CategoryID]];
            [currentCategories addObject:category];
        }
        Singleton* sharedSingleton = [Singleton sharedInstance];
        [sharedSingleton setCurrentCategories:currentCategories];
    }
}


-(void)handleAllLocations:(id)sender {
    
    if([sender isKindOfClass: [NSError class]] || [sender isKindOfClass: [SoapFault class]]) {
        NSLog(@"error");
	} else {
        NSMutableArray *locationsArray = [NSMutableArray array];
        for (PCLocationInfo *locations in sender) {
            Locations *currentLocation = [Locations alloc];
            [currentLocation setLocationId:[NSNumber numberWithInt:locations.LocationID]];
            [currentLocation setLocationSubCategoryId:[NSNumber numberWithInt:locations.SubCategoryID]];
            [currentLocation setLocationCategoryId:[NSNumber numberWithInt:locations.CategoryID]];
            [currentLocation setLocationName:locations.Name];
            [currentLocation setLocationLongLat:locations.LatLng];
            [currentLocation setLocationAddressLine1:locations.AddressLine1];
            [currentLocation setLocationAddressLine2:locations.AddressLine2];
            [currentLocation setLocationAddressLine3:locations.AddressLine3];
            [currentLocation setLocationAddressLine4:locations.AddressLine4];
            [currentLocation setLocationCategoryName:locations.Category];
            [currentLocation setLocationSubCategoryName:locations.SubCategory];
            [currentLocation setLocationPhoneNumber:locations.PhoneNumber];
//            [currentLocation setLocationFaxNumber:locations.FaxNumber];
            [currentLocation setLocationBookABatchId:[NSString stringWithFormat:@"%i", locations.BookabachID]];
            [locationsArray addObject:currentLocation];
            
            /*
            dispatch_async(dispatch_get_main_queue(), ^{
                 [[NSNotificationCenter defaultCenter] postNotificationName:@"xmlFinishedLoading" object:nil];
            });
            */

        }
        NSLog(@"Loading Done");
        [self saveDataToDisk:locationsArray];
        [self loadDataFromDisk];
        
    }

}


- (UINavigationController *)customizedNavigationController
{
    UINavigationController *navController = [[UINavigationController alloc] initWithNibName:nil bundle:nil];
    
    [navController navigationBar];
    
    NSMutableData *data = [NSMutableData data];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:navController forKey:@"root"];
    [archiver finishEncoding];
    
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
//    [unarchiver setClass:[CustomNavigationBar class] forClassName:@"UINavigationBar"];
    UINavigationController *customizedNavController = [unarchiver decodeObjectForKey:@"root"];
    
//    CustomNavigationBar *navBar = (CustomNavigationBar *)[navController navigationBar];
//    [navBar setTintColor:[UIColor colorWithRed:206/255.0 green:206/255.0 blue:206/255.0 alpha:1.0]];
    
    
    UIImage *navBarImage = [UIImage imageNamed:@"background_navbar_7.png"];
    
    if ([AppDelegate isVersion6AndBelow])
    {
        navBarImage = [UIImage imageNamed:@"background_navbar.png"];
    }
    
    [[UINavigationBar appearance] setBackgroundImage:navBarImage forBarMetrics:UIBarMetricsDefault];

    return customizedNavController;
}

#pragma mark - Custom Load

- (NSString *) pathForDataFile {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSURL *pathURL= [NSURL fileURLWithPath:documentsDirectory];
    [self addSkipBackupAttributeToItemAtURL:pathURL];
    
    
    return [documentsDirectory stringByAppendingPathComponent:@"locations_listing.plist"]; // !!!
    
}

- (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL
{
    assert([[NSFileManager defaultManager] fileExistsAtPath: [URL path]]);
    
    NSError *error = nil;
    BOOL success = [URL setResourceValue: [NSNumber numberWithBool: YES]
                                  forKey: NSURLIsExcludedFromBackupKey error: &error];
    if(!success){
        NSLog(@"Error excluding %@ from backup %@", [URL lastPathComponent], error);
    }
    return success;
}


- (void) saveDataToDisk:(NSMutableArray *)passedArray {
    NSString * path = [self pathForDataFile];
    
    NSMutableDictionary * rootObject;
    rootObject = [NSMutableDictionary dictionary];
    
    [rootObject setValue: passedArray forKey:@"locations"];
    [NSKeyedArchiver archiveRootObject: rootObject toFile: path];
}

-(int)loadRawFromDisk {
    NSString     *path = [self pathForDataFile];
    NSDictionary *rootObject;
    
    rootObject = [NSKeyedUnarchiver unarchiveObjectWithFile:path]; 
    
    NSMutableArray *tempArray = (NSMutableArray *)[rootObject valueForKey:@"locations"];
     NSLog(@"RAW count %i", tempArray.count);
    return tempArray.count;
}

- (int) loadDataFromDisk {
    NSString     *path = [self pathForDataFile];
    NSDictionary *rootObject;
    
    rootObject = [NSKeyedUnarchiver unarchiveObjectWithFile:path]; 

    NSMutableArray *tempArray = (NSMutableArray *)[rootObject valueForKey:@"locations"];
    NSLog(@"KA count %i", tempArray.count);
    NSLog(@"Live Count %i", liveCount);
    
    while (liveCount == 0) {
        NSLog(@"Waitning on you Live Count");
    }
    
    if (liveCount != tempArray.count) {
        NSLog(@"HERS WHY: %i | %i", liveCount, tempArray.count);
        [self displayDownloadingScreen];
        PCPetCentricSvc *service = [[PCPetCentricSvc alloc] init];
        [service AllLocations:self action:@selector(handleAllLocations:)];
    }else {
        Singleton* sharedSingleton = [Singleton sharedInstance];
        [sharedSingleton setLocationListing:tempArray];
        
        UIView *newView = progressBackgroundView;
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:1.0f];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(customloadView)];
        [newView setFrame:CGRectMake(newView.frame.origin.x, newView.frame.origin.y + 200, newView.frame.size.width, newView.frame.size.height)];
        [UIView commitAnimations];
        
        UIView *aView = loadingBackgroundView;
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:1.0f];
        [UIView setAnimationDelegate:self];
        [aView setFrame:CGRectMake(aView.frame.origin.x, 600, aView.frame.size.width, aView.frame.size.height)];
        [UIView commitAnimations];
    }
    
    return tempArray.count;
    
}

- (void) LocationCountHandler: (NSNumber *) value {
    
	liveCount = [value intValue];
    PCPetCentricSvc *service = [[PCPetCentricSvc alloc] init];
    
    if ([self loadRawFromDisk] == 0 || debug) {
        [self displayDownloadingScreen];
        [service setDelegate:self];
        [service AllLocations:self action:@selector(handleAllLocations:)];
    } else {
        [self loadDataFromDisk];
    }
}

-(void)removeData {
    
    [[NSFileManager defaultManager] removeItemAtPath:[self pathForDataFile] error:NULL];
}

-(void)displayDownloadingScreen {
    
    UIView *aView = loadingBackgroundView;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0f];
    [UIView setAnimationDelegate:self];
    [aView setFrame:CGRectMake(aView.frame.origin.x, 600, aView.frame.size.width, aView.frame.size.height)];
    [UIView commitAnimations];
    
    progressBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(20, 600, 280, 125)];
    [progressBackgroundView setBackgroundColor:[UIColor blackColor]];
    [progressBackgroundView setAlpha:0.7f];
    [progressBackgroundView setTag:1];
    [progressBackgroundView.layer setCornerRadius:10.0f];
    
    UIActivityIndicatorView *aiv = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [aiv setCenter:CGPointMake(progressBackgroundView.frame.size.width / 2, 30)];
    [aiv startAnimating];
    
    [progressBackgroundView addSubview:aiv];
    
    progressText = [[UILabel alloc] init];
    [progressText setTag:3];
    [progressText setFrame:CGRectMake(0, 50, 280, 20)];
    [progressText setTextAlignment:UITextAlignmentCenter];
    [progressText setFont:[UIFont boldSystemFontOfSize:16]];
    [progressText setBackgroundColor:[UIColor clearColor]];
    [progressText setTextColor:[UIColor whiteColor]];
    [progressText setText:@"Downloading Locations"];
    [progressBackgroundView addSubview:progressText];
    
    progressSubText = [[UILabel alloc] init];
    [progressSubText setFrame:CGRectMake(10, 70, 260, 40)];
    [progressSubText setTextAlignment:UITextAlignmentCenter];
    [progressSubText setFont:[UIFont boldSystemFontOfSize:11]];
    [progressSubText setBackgroundColor:[UIColor clearColor]];
    [progressSubText setNumberOfLines:0];
    [progressSubText setLineBreakMode:UILineBreakModeWordWrap];
    [progressSubText setTextColor:[UIColor whiteColor]];
    [progressSubText setText:@"We are downloading a full list of Pet Friendly Locations - this may take a few minutes."];
    [progressBackgroundView addSubview:progressSubText];
    
    [self.view addSubview:progressBackgroundView];

    
    
    UIView *newView = progressBackgroundView;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0f];
    [UIView setAnimationDelegate:self];
    [newView setFrame:CGRectMake(newView.frame.origin.x, 400, newView.frame.size.width, newView.frame.size.height)];
    [UIView commitAnimations];
}

-(void)continueLoading {
    
    NSLog(@"Delegate");
    [self loadEmUp];
}






@end
