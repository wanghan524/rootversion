//
//  ProductSelectorViewController.h
//  PurinaPetPlaces
//
//  Created by BlueApp on 15-6-6.
//
//

#import "ParentViewController.h"

@interface ProductSelectorViewController : ParentViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>{
    BOOL clickStatus;
}

@property(nonatomic,strong)NSMutableArray *menuArray;

@property(nonatomic,strong)UITableView *menusTable;

@property(nonatomic,strong)UIView *darkView;

@property(nonatomic,strong)NSArray *displayArray;

@property(nonatomic,strong)NSMutableArray *imageArray;

@property(nonatomic,strong)UICollectionView *collectionView;

@property(nonatomic,strong)UIButton *bottomButton;

@end
