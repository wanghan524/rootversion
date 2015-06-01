//
//  BodyConditionViewController.h
//  PurinaPetPlaces
//
//  Created by BlueApp on 15-6-1.
//
//

#import "ParentViewController.h"

@interface BodyConditionViewController : ParentViewController{
    BOOL clickStatus;
}

@property(nonatomic,strong)NSMutableArray *menuArray;

@property(nonatomic,strong)UITableView *menusTable;

@property(nonatomic,strong)UIView *darkView;

@end
