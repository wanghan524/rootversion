//
//  TipsContentViewController.h
//  PurinaPetPlaces
//
//  Created by BlueApp on 15-4-16.
//
//

#import "ParentViewController.h"

@interface TipsContentViewController : ParentViewController<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray          *generalTips;
    NSMutableArray          *dogTips;
    NSMutableArray          *catTips;
    NSMutableArray          *dataSource;
    NSString                *currentTitle;
}

@property (nonatomic, strong) NSMutableArray *generalTips;
@property (nonatomic, strong) NSMutableArray *dogTips;
@property (nonatomic, strong) NSMutableArray *catTips;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSString *currentTitle;

@end
