//
//  LocationTableViewController.h
//  PurinaPetPlaces
//
//  Created by Josh Bruce on 17/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Locations.h"

@protocol LocationTableViewControllerDelegate <NSObject>
-(void)itemSelected:(Locations*)mySelectedLocation;
@end

@interface LocationTableViewController : UITableViewController <UIAlertViewDelegate, UIAlertViewDelegate> {
    Locations      *dataSource;
    CGSize          locationSize;
    CGSize          categorySize;
    id<LocationTableViewControllerDelegate> delegate;

}
@property (nonatomic, retain) Locations *dataSource;
@property (nonatomic) CGSize locationSize;
@property (nonatomic) CGSize categorySize;
@property (retain) id delegate;

@end
