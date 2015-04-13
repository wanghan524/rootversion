//
//  PetInfoTableViewController.h
//  PurinaPetPlaces
//
//  Created by Josh Bruce on 30/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PetInfoTableViewControllerDelegate <NSObject>
-(void)itemSelected;
-(void)openImage;
@end

@interface PetInfoTableViewController : UITableViewController {
    NSMutableArray *dataSource;
    id<PetInfoTableViewControllerDelegate> delegate;
}
@property (nonatomic, retain) NSMutableArray *dataSource;
@property (retain) id delegate;

@end
