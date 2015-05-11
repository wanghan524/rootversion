//
//  AppDelegate.m
//  PurinaPetPlaces
//
//  Created by Josh Bruce on 4/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "PCPetCentricSvc.h"
#import "CustomNavigationBar.h"
#import "Singleton.h"
#import "SplashScreenViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "Reachability.h"
#import <Parse/Parse.h>
#import "EditViewController.h"


@implementation AppDelegate

@synthesize window = _window;
@synthesize tabBarController, locationsViewController, temp2locationsViewController, searchTableViewController, progressBackgroundView;





+(BOOL)isVersion6AndBelow{
    
    return floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    
    
    
    [Parse setApplicationId:@"63djxv7dFYyhSC0jfMRTxIUAAbOKYh3oJyHpTB07" clientKey:@"2nytrJ095cqeJKoF4Xzp6ufzY1fKDc0b6asQ6NF7"];
    
    // Under App Delegate Let the device know we want to receive push notifications
	[[UIApplication sharedApplication] registerForRemoteNotificationTypes:
     (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    
    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
    
    NSLog(@"Custom View");
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        
    UIView *backgroundView = [[UIView alloc] initWithFrame: self.window.frame];
    

//    CAGradientLayer *gradient = [CAGradientLayer layer];
//    [gradient setFrame:backgroundView.bounds];
//    [gradient setColors:[NSArray arrayWithObjects:(id)[UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1].CGColor, (id)[UIColor colorWithRed:253/255.0 green:253/255.0 blue:253/255.0 alpha:1].CGColor, nil]];
//    
//    [backgroundView.layer insertSublayer:gradient below:0];
    
    [self.window addSubview:backgroundView];
    
    SplashScreenViewController *spalshScreen = [[SplashScreenViewController alloc] initWithNibName:@"SplashScreenViewController" bundle:nil];
    
//    EditViewController *editVC = [[EditViewController alloc] init];
//    self.window.rootViewController = editVC;
    self.window.rootViewController = spalshScreen;
    
    [self.window makeKeyAndVisible];
    
    
    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1)
    {
        [[UINavigationBar appearance] setTintColor:[UIColor redColor]];
        [[UITabBar appearance] setTintColor:[UIColor redColor]];
    }
    
    
    return YES;

}

// To be able to receive push notifications
- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
	NSLog(@"My token is: %@", deviceToken);
    //    [self registerDeviceToken:deviceToken];
    
    [PFPush storeDeviceToken:deviceToken]; // Send parse the device token
    // Subscribe this user to the broadcast channel, ""
    [PFPush subscribeToChannelInBackground:@"" block:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"Successfully subscribed to the broadcast channel.");
        } else {
            NSLog(@"Failed to subscribe to the broadcast channel.");
        }
    }];
    
}


- (void) application:(UIApplication *)app didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    [PFPush handlePush:userInfo];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
    NSLog(@"test");
    
    progressBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(20, 352, 280, 75)];
    [progressBackgroundView setBackgroundColor:[UIColor blackColor]];
    [progressBackgroundView setAlpha:0.7f];
    [progressBackgroundView.layer setCornerRadius:10.0f];
    
    UILabel *progressText = [[UILabel alloc] init];
    [progressText setFrame:CGRectMake(0, 10, 280, 20)];
    [progressText setTextAlignment:UITextAlignmentCenter];
    [progressText setFont:[UIFont boldSystemFontOfSize:16]];
    [progressText setBackgroundColor:[UIColor clearColor]];
    [progressText setTextColor:[UIColor whiteColor]];
    [progressText setText:@"Updating Locations"];
    [progressBackgroundView addSubview:progressText];
    
    
    UIActivityIndicatorView *progressActivity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [progressActivity setCenter:CGPointMake(progressBackgroundView.frame.size.width/2, 50)];
    [progressActivity startAnimating];
    [progressBackgroundView addSubview:progressActivity];
    
    [self.window setUserInteractionEnabled:NO];
    [self.window addSubview:progressBackgroundView];
    
    [self performSelector:@selector(removeLoading) withObject:nil afterDelay:2.0f];
   
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    if (![prefs boolForKey:@"connectionIssues"]) {
        Singleton *singletonClass = [Singleton sharedInstance];
        [singletonClass.locationListing removeAllObjects];
        [singletonClass.currentCategories removeAllObjects];
        [singletonClass.currentSubCategories removeAllObjects];
        
        self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        SplashScreenViewController *spalshScreen = [[SplashScreenViewController alloc] initWithNibName:@"SplashScreenViewController" bundle:nil];
        
        [self.window setRootViewController:spalshScreen];
        [self.window makeKeyAndVisible];
        
        
    }
    
     */
    
    
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

-(void)removeLoading {
    [progressBackgroundView removeFromSuperview];
    [self.window setUserInteractionEnabled:YES];
}


- (void)applicationDidBecomeActive:(UIApplication *)application
{
    
    
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}






void uncaughtExceptionHandler(NSException *exception) {
    NSLog(@"CRASH: %@", exception);
    NSLog(@"Stack Trace: %@", [exception callStackSymbols]);
    // Internal error reporting
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
    [unarchiver setClass:[CustomNavigationBar class] forClassName:@"UINavigationBar"];
    UINavigationController *customizedNavController = [unarchiver decodeObjectForKey:@"root"];
    
    CustomNavigationBar *navBar = (CustomNavigationBar *)[navController navigationBar];
    [navBar setTintColor:[UIColor colorWithRed:206/255.0 green:206/255.0 blue:206/255.0 alpha:1.0]];

    
    return customizedNavController;
}

@end 

