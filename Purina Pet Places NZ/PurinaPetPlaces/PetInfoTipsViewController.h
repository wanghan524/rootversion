//
//  PetInfoTipsViewController.h
//  PurinaPetPlaces
//
//  Created by Josh Bruce on 1/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PetInfoTipsTableViewController.h"

@interface PetInfoTipsViewController : UIViewController {
    PetInfoTipsTableViewController      *petInfoTipsTableViewController;
    UIWebView                           *petInfoWebView;
    UIToolbar                           *petInfoToolbar;
}
@property (nonatomic, retain) PetInfoTipsTableViewController *petInfoTipsTableViewController;
@property (nonatomic, strong) IBOutlet UIWebView *petInfoWebView;
@property (nonatomic, strong) IBOutlet UIToolbar *petInfoToolbar;

-(IBAction)loadGeneralTips:(id)sender;
-(IBAction)loadCatTips:(id)sender;
-(IBAction)loadDogTips:(id)sender;

@end
