//
//  photoFunViewController.h
//  PurinaPetPlaces
//
//  Created by BlueApp on 15-4-13.
//
//

#import "ParentViewController.h"

extern CGFloat navHeight;

@interface photoFunViewController : ParentViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *toolBackImage;
@property (weak, nonatomic) IBOutlet UIButton *savedImageBtn;
@property (weak, nonatomic) IBOutlet UIButton *cameraBtn;
- (IBAction)savedImageBtnClicked:(id)sender;
- (IBAction)cameraBtnClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UICollectionView *toolCollection;

@property(nonatomic,strong)NSMutableArray *imageArray;


@property(nonatomic,strong)NSMutableArray *menuArray;

@property(nonatomic,strong)UITableView *menusTable;

@property(nonatomic,strong)UIView *darkView;
@end
