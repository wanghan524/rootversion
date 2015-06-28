//
//  SubCategoriesTableViewController.h
//  PurinaPetPlaces
//
//  Created by Josh Bruce on 4/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Categories.h"

@protocol SubCategoriesTableViewControllerDelegate <NSObject>
-(void)itemSelected:(Categories*)category;


- (void)nextButtonClickWith:(NSString *)flagString;


@end

@interface SubCategoriesTableViewController : UITableViewController {
    NSMutableArray      *dataSource;
    NSNumber            *selectedCategory;
    id<SubCategoriesTableViewControllerDelegate> delegate;
}

@property (nonatomic, retain) NSMutableArray *dataSource;
@property (nonatomic, retain) NSNumber *selectedCategory;
@property (retain) id delegate;
@property (nonatomic, strong) NSString *currentHeaderImageFlag;

@end
