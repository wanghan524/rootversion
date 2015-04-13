//
//  CategoriesTableViewController.h
//  PurinaPetPlaces
//
//  Created by Josh Bruce on 4/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Categories.h"

@protocol CategoriesTableViewControllerDelegate <NSObject>
-(void)itemSelected:(Categories *)category;
@end

@interface CategoriesTableViewController : UITableViewController {
    NSMutableArray *categoryArray; 
    id<CategoriesTableViewControllerDelegate> delegate;
}

@property (nonatomic, retain) NSMutableArray *categoryArray;
@property (retain) id delegate;

@end
