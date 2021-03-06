//
//  TipsViewController.h
//  PurinaPetPlaces
//
//  Created by BlueApp on 15-4-16.
//
//

#import "ParentViewController.h"

@interface TipsViewController : ParentViewController<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray          *generalTips;
    NSMutableArray          *dogTips;
    NSMutableArray          *catTips;
    NSMutableArray          *dataSource;
    NSString                *currentTitle;
    BOOL clickStatus;
}

@property (nonatomic, strong) NSMutableArray *generalTips;
@property (nonatomic, strong) NSMutableArray *dogTips;
@property (nonatomic, strong) NSMutableArray *catTips;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSString *currentTitle;

@property(nonatomic,strong)NSMutableArray *menuArray;

@property(nonatomic,strong)UITableView *menusTable;

@property(nonatomic,strong)UIView *darkView;

@end
