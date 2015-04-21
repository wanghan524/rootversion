//
//  PetHealthViewController.h
//  PurinaPetPlaces
//
//  Created by BlueApp on 15-4-19.
//
//

#import "ParentViewController.h"

@interface PetHealthViewController : ParentViewController{
    BOOL clickStatus;
}

@property(nonatomic,strong)NSMutableArray *menuArray;

@property(nonatomic,strong)UITableView *menusTable;

@property(nonatomic,strong)UIView *darkView;

@end
