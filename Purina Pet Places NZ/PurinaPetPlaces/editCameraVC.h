//
//  editCameraVC.h
//  PurinaPetPlaces
//
//  Created by 菁优数学 on 15/5/9.
//
//

#import "ParentViewController.h"
#import "ImageItem.h"
#import "DBHelper.h"

@interface editCameraVC : ParentViewController


@property(nonatomic,strong)UIView *bgView;


@property(nonatomic,strong)ImageItem *model;

@property(nonatomic,strong)UIImageView *dogImageView;
@property(nonatomic,strong)UILabel *editLabel;

@property(nonatomic,strong)UIScrollView *scroller;
@property(nonatomic,strong)UIView *dogFrameview;
@property(nonatomic,strong)UIView *bottom;




@property(nonatomic,strong)UIButton *facebookBtn;
@property(nonatomic,strong)UIButton *cameraBtn;
@property(nonatomic,strong)UIButton *twitterBtn;




@end
