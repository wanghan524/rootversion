//
//  ParentViewController.h
//  PetPlaces
//
//  Created by art_kernel_zyc on 15/4/12.
//  Copyright (c) 2015年 art_kernel_zyc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchViewController.h"

extern CGFloat navHeight;

@interface ParentViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,assign)CGFloat residuHeigth;
@property(nonatomic,strong)UIImageView *lineImageView;
@property(nonatomic,strong)UIButton *backButton;
@property(nonatomic,strong)UIButton *profileButton;
@property(nonatomic,strong)UIButton *searchButton;
@property(nonatomic,strong)UIImageView *petPlaceImageView;
@property(nonatomic,strong)SearchViewController *searchVC;

-(void)hideCustomeNav;
-(void)showCustomeNav;
-(void)profileBtnClickOrGestureClip:(UIButton *)sender;
-(void)searchBtnClick:(UIButton *)sender;

@property(nonatomic,strong)NSMutableArray *menuArray;

@property(nonatomic,strong)UITableView *menusTable;

@property(nonatomic,strong)UIView *darkView;
@end
