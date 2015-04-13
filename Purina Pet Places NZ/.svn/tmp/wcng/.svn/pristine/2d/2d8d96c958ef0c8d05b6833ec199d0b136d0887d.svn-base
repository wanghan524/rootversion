//
//  ResultsTableViewController.h
//  PurinaPetPlaces
//
//  Created by Josh Bruce on 13/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Locations.h"

@protocol ResultsTableViewControllerDelegate <NSObject>
-(void)itemSelected:(Locations*)selectedLocation;
@end


@interface ResultsTableViewController : UITableViewController {
    NSMutableArray      *dataSource;
    id<ResultsTableViewControllerDelegate> delegate;
}

@property (nonatomic, retain) NSMutableArray *dataSource;
@property (retain) id delegate;
@end
 