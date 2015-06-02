//
//  FreePetAdviceVC.h
//  PurinaPetPlaces
//
//  Created by 菁优数学 on 15/6/2.
//
//

#import "ParentViewController.h"

@interface FreePetAdviceVC : ParentViewController<UITableViewDataSource,UITableViewDelegate>
{
    BOOL clickStatus;
}

@property(nonatomic,strong)NSMutableArray *menuArray;

@property(nonatomic,strong)UITableView *menusTable;

@property(nonatomic,strong)UIView *darkView;

@end
