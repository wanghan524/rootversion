//
//  SearchView.h
//  PurinaPetPlaces
//
//  Created by art_kernel_zyc on 15/4/14.
//
//

#import <UIKit/UIKit.h>

@interface MySearchView : UIView<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property(nonatomic,strong)NSString *currentDistanceStr;

@property (weak, nonatomic) IBOutlet UILabel *cateGoryLabel;
- (IBAction)cateGoryBtnClick:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *searchTermTxt;
@property (weak, nonatomic) IBOutlet UITextField *suburbTxt;
@property (weak, nonatomic) IBOutlet UIButton *btnOne;
@property (weak, nonatomic) IBOutlet UIButton *btnTwo;
@property (weak, nonatomic) IBOutlet UIButton *btnThree;

@property(nonatomic,strong)UITableView *cateGoryTable;

@property(nonatomic,strong)NSMutableArray *cateGoryMuArr;

-(instancetype)initWithFrame:(CGRect)frame;
@end
