//
//  SaveDImageVC.h
//  PurinaPetPlaces
//
//  Created by 菁优数学 on 15/5/26.
//
//

#import "ParentViewController.h"
#import "editCameraVC.h"
extern CGFloat navHeight;
@interface SaveDImageVC : ParentViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic)UICollectionView *picCollection;
@property(nonatomic,strong)NSMutableArray *imageArray;


@property(nonatomic,strong)NSMutableArray *menuArray;

@property(nonatomic,strong)UITableView *menusTable;

@property(nonatomic,strong)UIView *darkView;
@end
