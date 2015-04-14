//
//  SearchViewController.h
//  PurinaPetPlaces
//
//  Created by art_kernel_zyc on 15/4/13.
//
//

#import <UIKit/UIKit.h>
extern CGFloat navHeight;
@interface SearchViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,assign)CGFloat residuHeigth;
@property(nonatomic,strong)UIImageView *lineImageView;
@property(nonatomic,strong)UIButton *backButton;
@property(nonatomic,strong)UIButton *profileButton;
@property(nonatomic,strong)UIButton *searchButton;
@property(nonatomic,strong)UIImageView *petPlaceImageView;

@property(nonatomic,strong)NSMutableArray *menuArray;

@property(nonatomic,strong)UITableView *menusTable;

@property(nonatomic,strong)UIView *darkView;

@end
