//
//  ProductsViewController.h
//  PurinaPetPlaces
//
//  Created by BlueApp on 15-4-14.
//
//

#import "ParentViewController.h"

extern CGFloat navHeight;

@interface ProductsViewController : ParentViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong)NSMutableArray *imageArray;

@property(nonatomic,strong)UICollectionView *collectionView;

@property(nonatomic,strong)UIButton *bottomButton;

@end
