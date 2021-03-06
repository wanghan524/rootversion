//
//  CategoriesViewController.h
//  PurinaPetPlaces
//
//  Created by Josh Bruce on 23/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


#import <UIKit/UIKit.h>


@protocol CategoriesViewControllerDelegate <NSObject>
-(void)itemSelected:(NSString *)passedSelectedCategory;
@end

@interface CategoriesViewController : UITableViewController {
    NSMutableArray                          *categories;
    id<CategoriesViewControllerDelegate>    delegate;
 
}

@property (nonatomic, retain) NSMutableArray *categories;
@property (retain) id delegate;


@end
