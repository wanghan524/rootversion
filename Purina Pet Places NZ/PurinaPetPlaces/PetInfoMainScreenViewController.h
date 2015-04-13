//
//  PetInfoMainScreenViewController.h
//  PurinaPetPlaces
//
//  Created by Josh Bruce on 30/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PetInfoTableViewController.h"


@interface PetInfoMainScreenViewController : UIViewController {
    UILabel                             *lblHeading;
    PetInfoTableViewController          *petInfoTableViewController;
}

@property (nonatomic, retain) IBOutlet UILabel *lblHeading;
@property (nonatomic, retain) PetInfoTableViewController *petInfoTableViewController;

@end
