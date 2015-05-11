//
//  SplashScreenViewController.h
//  PurinaPetPlaces
//
//  Created by Josh Bruce on 16/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

#import "SearchTableViewController.h"
#import "PetInfoMainScreenViewController.h"
#import "ConnectionViewController.h"
#import "EditViewController.h"
#import "PopView.h"
#import "EnterMianViewController.h"

@interface SplashScreenViewController : UIViewController <UIAlertViewDelegate> {
    UITabBarController              *tabBarController;
    UIImageView                     *splashScreen;
    ViewController                  *locationsViewController;
    SearchTableViewController       *searchTableViewController;
    PetInfoMainScreenViewController *petInfoMainScreenViewController;
    ConnectionViewController        *connectionViewController;
    BOOL                            didFail;
    BOOL                            debug;
    BOOL                            alertShowing;
    int                             successCount;
    int                             enterCount;
    int                             liveCount;
    int                             totalSize;
    UIAlertView                     *alert;
    UIView                          *loadingBackgroundView;
    UILabel                         *loadingText;
    UILabel                         *progressText;
    UILabel                         *progressSubText;
    UIView                          *progressBackgroundView;
    UIActivityIndicatorView         *progressActivity;
    NSUserDefaults                  *prefs;
    NSMutableArray                  *diskArray;
}
@property (nonatomic, retain) UITabBarController *tabBarController;
@property (nonatomic, retain) ViewController *locationsViewController;
@property (nonatomic, retain) SearchTableViewController *searchTableViewController;
@property (nonatomic, retain) ConnectionViewController *connectionViewController;
@property (nonatomic, retain) PetInfoMainScreenViewController *petInfoMainScreenViewController;
@property (nonatomic, retain) UIAlertView *alert;
@property (nonatomic, retain) IBOutlet UIImageView *splashScreen;
@property (nonatomic, retain) UILabel *progressText;
@property (nonatomic, retain) UILabel *progressSubText;
@property (nonatomic, retain) UIView *progressBackgroundView;
@property (nonatomic, retain) UIView *loadingBackgroundView;
@property (nonatomic, retain) UILabel *loadingText;
@property (nonatomic, retain) UIActivityIndicatorView *progressActivity;
@property (nonatomic, retain) NSUserDefaults *prefs;
@property (nonatomic, retain) NSMutableArray *diskArray;

-(NSString *) pathForDataFile;
-(void) saveDataToDisk:(NSMutableArray *)passedArray;
-(int) loadDataFromDisk;
-(void)customloadView;
-(void)removeData;
-(void)displayDownloadingScreen;
-(void)checkForConnectivity;
-(void)loadEmUp;
-(void)continueLoading;
-(void)updateProgressView:(int)size;

@end
