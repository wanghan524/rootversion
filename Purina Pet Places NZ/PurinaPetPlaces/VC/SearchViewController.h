//
//  SearchViewController.h
//  PurinaPetPlaces
//
//  Created by art_kernel_zyc on 15/4/13.
//
//

#import <UIKit/UIKit.h>
#import "MySearchView.h"
#import <MapKit/MapKit.h>
#import "BSForwardGeocoder.h"
#import "BSKmlResult.h"

extern CGFloat navHeight;
@interface SearchViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,BSForwardGeocoderDelegate,CLLocationManagerDelegate>{
    CLLocationManager       *currentUserLocation;
    UIView                  *blackLoadingScreen;
    BSForwardGeocoder       *forwardGeocoder;
    BOOL                    update;
    NSString                *selectedCategory;
}

@property(nonatomic,strong)MySearchView *searchMapView;
@property (nonatomic, retain) NSString *selectedCategory;
@property (nonatomic, retain) CLLocationManager *currentUserLocation;
@property (nonatomic, retain) UIView *blackLoadingScreen;
@property (nonatomic, retain) BSForwardGeocoder *forwardGeocoder;
@property(nonatomic,assign)CGFloat residuHeigth;
@property(nonatomic,strong)UIImageView *lineImageView;
@property(nonatomic,strong)UIButton *backButton;
@property(nonatomic,strong)UIButton *profileButton;
@property(nonatomic,strong)UIButton *searchButton;
@property(nonatomic,strong)UIImageView *petPlaceImageView;

@property(nonatomic,strong)NSMutableArray *menuArray;

@property(nonatomic,strong)UITableView *menusTable;

@property(nonatomic,strong)UIView *darkView;


///搜索中 category 需要的数据
@property(nonatomic,strong)NSMutableArray *categoryArr;

@property(nonatomic,strong)UIButton *searchCatagoryBtn;


@end
