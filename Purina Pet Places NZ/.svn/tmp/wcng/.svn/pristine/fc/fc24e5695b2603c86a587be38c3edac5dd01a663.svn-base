//
//  ViewController.h
//  PurinaPetPlaces
//
//  Created by Josh Bruce on 4/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoriesTableViewController.h"
#import "SubCategoriesViewController.h"
#import "ConnectionViewController.h"
#import <MessageUI/MessageUI.h>

@interface ViewController : UIViewController <MFMailComposeViewControllerDelegate> {
    CategoriesTableViewController       *categoriesTableViewController;
    UILabel                             *lblHeading;
    UIButton                            *btnRecommend;
    UIImageView                         *imgDog;
    ConnectionViewController            *connectionViewController;
}

@property (nonatomic, retain) CategoriesTableViewController *categoriesTableViewController;
@property (nonatomic, retain) ConnectionViewController *connectionViewController;   
@property (nonatomic, retain) IBOutlet UILabel *lblHeading;
@property (nonatomic, retain) IBOutlet UIButton *btnRecommend;
@property (nonatomic, retain) IBOutlet UIImageView *imgDog;

-(IBAction)recommendPetPlace:(id)sender;

@end
