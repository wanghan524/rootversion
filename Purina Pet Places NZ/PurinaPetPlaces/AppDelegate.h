//
//  AppDelegate.h
//  PurinaPetPlaces
//
//  Created by Josh Bruce on 4/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved...
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "SearchTableViewController.h"
#import "GrobleSingleton.h"



@class ViewController;


@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    UITabBarController              *tabBarController;
    ViewController                  *locationsViewController;

    SearchTableViewController       *searchTableViewController;
    ViewController                  *temp2locationsViewController;
    UIView                          *progressBackgroundView;
    
    GrobleSingleton                 *grobleSingleton;
}
@property (nonatomic, retain) UITabBarController *tabBarController;
@property (nonatomic, retain) ViewController *locationsViewController;

@property (nonatomic, retain) SearchTableViewController *searchTableViewController;
@property (nonatomic, retain) ViewController *temp2locationsViewController;
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) UIView *progressBackgroundView;

+(BOOL)isVersion6AndBelow;
@end
