//
//  PetFriendlyPlacesViewController.h
//  PurinaPetPlaces
//
//  Created by BlueApp on 15-4-13.
//
//

#import "ParentViewController.h"
#import "CategoriesTableViewController.h"
#import "SubCategoriesViewController.h"
#import "Singleton.h"
#import "Categories.h"
#import "NextPetFriendlyPlacesViewController.h"

extern CGFloat navHeight;

@interface PetFriendlyPlacesViewController : ParentViewController<UITableViewDelegate,UITableViewDataSource,CategoriesTableViewControllerDelegate>{
    CategoriesTableViewController       *categoriesTableViewController;
    BOOL clickStatus;
}

@property (nonatomic, strong) CategoriesTableViewController *categoriesTableViewController;


@property(nonatomic,strong)NSMutableArray *menuArray;

@property(nonatomic,strong)UITableView *menusTable;

@property(nonatomic,strong)UIView *darkView;

@end
