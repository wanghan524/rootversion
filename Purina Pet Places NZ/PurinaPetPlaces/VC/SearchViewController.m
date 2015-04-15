//
//  SearchViewController.m
//  PurinaPetPlaces
//
//  Created by art_kernel_zyc on 15/4/13.
//
//

#import "SearchViewController.h"

@interface SearchViewController ()
{
    BOOL clickStatus;
    @private
    CGFloat width,height,startPointY;
    CGFloat residuceHeight;
    

}
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    clickStatus = NO;
    self.navigationController.navigationBar.hidden = YES;
    width = SCREEN_WIDTH;
    height = SCREEN_HEIGHT;
    if(CD_X(6))
    {
        startPointY = 0;
        navHeight = 44;
    }
    else
        if(CD(7))
        {
            startPointY = 20;
            navHeight = 64;
        }

    residuceHeight = SCREEN_HEIGHT - navHeight;
    [self showCustomeNav];
    [self showSearchView];
    [self showSearchBtn];
    
    
    
}


-(void)showSearchBtn
{
    self.searchCatagoryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.searchCatagoryBtn setFrame:CGRectMake(0, SCREEN_HEIGHT - 50, SCREEN_WIDTH, 50)];
    [self.searchCatagoryBtn setTitle:@"Search" forState:UIControlStateNormal];
    [self.searchCatagoryBtn setBackgroundColor:[UIColor redColor]];
    [self.searchCatagoryBtn addTarget:self action:@selector(searchCataGoryBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.searchCatagoryBtn];
}

-(void)searchCataGoryBtnClick:(UIButton *)sender
{
    DLog(@"dianji");
}



-(void)showSearchView
{
    self.searchMapView = (MySearchView *)[[[NSBundle mainBundle]loadNibNamed:@"MySearchView" owner:self options:nil]lastObject];
    [self.searchMapView setFrame: CGRectMake(0, navHeight, SCREEN_WIDTH, residuceHeight - 50)];
    [self.view addSubview:self.searchMapView];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
-(void)viewWillAppear:(BOOL)animated
{
    [self registerTextFieldNotification];
}

-(void)registerTextFieldNotification
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)keyboardWillShow:(NSNotification *)notify
{
    NSDictionary *userInfo = [notify userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    CGFloat height = keyboardRect.size.height;
    CGFloat keyboradHeight = keyboardRect.origin.y - 90;
    CGFloat searchHeight = CGRectGetMaxY(self.searchMapView.searchTermTxt.frame);
    CGFloat suburbHeight = CGRectGetMaxY(self.searchMapView.suburbTxt.frame);
    if([self.searchMapView.searchTermTxt isEditing])
    {
        if(keyboradHeight < searchHeight)
        {
            CGFloat adds = searchHeight - keyboradHeight;
            [self.searchMapView setFrame:CGRectMake(0, navHeight - adds, SCREEN_WIDTH, residuceHeight - 50)];
        }
    }
    
    if([self.searchMapView.suburbTxt isEditing])
    {
        if(keyboradHeight < suburbHeight)
        {
            CGFloat adds = suburbHeight - keyboradHeight;
            [self.searchMapView setFrame:CGRectMake(0, navHeight - adds, SCREEN_WIDTH, residuceHeight - 50)];
        }
    }

}
-(void)keyboardWillHide:(NSNotification *)notify
{
        [self.searchMapView setFrame: CGRectMake(0, navHeight, SCREEN_WIDTH, residuceHeight - 50)];
}


-(void)showCustomeNav
{
    UIView *backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    backGroundView.backgroundColor = [UIColor colorWithRed:242/255.0 green:238/255.0 blue:223/255.0 alpha:1];
    backGroundView.userInteractionEnabled = YES;
    [self.view addSubview:backGroundView];
    
    
    self.lineImageView = [[UIImageView alloc]init];
    self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.profileButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.petPlaceImageView = [[UIImageView alloc]init];
    
    
    [self.lineImageView setFrame:CGRectMake(0, startPointY , SCREEN_WIDTH, 5)];
    [self.lineImageView setBackgroundColor:[UIColor redColor]];
    [backGroundView addSubview:self.lineImageView];
    
    [self.backButton setFrame:CGRectMake(10, CGRectGetMaxY(self.lineImageView.frame) + 5 , 30, 30)];
    [self.backButton setBackgroundImage:[UIImage imageNamed:@"btn-back.jpg"] forState:UIControlStateNormal];
    //[self.backButton setBackgroundColor:[UIColor blackColor]];
    [backGroundView addSubview:self.backButton];
    
    CGPoint point = self.view.center;
    [self.petPlaceImageView setFrame:CGRectMake(point.x - 46, CGRectGetMaxY(self.lineImageView.frame) + 5, 92, 27)];
    self.petPlaceImageView.image = [UIImage imageNamed:@"pet-places-logo.jpg"];
    //[self.petPlaceImageView setBackgroundColor:[UIColor blueColor]];
    [backGroundView addSubview:self.petPlaceImageView];
    
    
    
    [self.searchButton setFrame:CGRectMake(SCREEN_WIDTH - 45 , CGRectGetMaxY(self.lineImageView.frame) + 5 , 30, 30)];
    [self.searchButton setBackgroundImage:[UIImage imageNamed:@"btn-search.jpg"] forState:UIControlStateNormal];
    //[self.searchButton setBackgroundColor:[UIColor blackColor]];
    [backGroundView addSubview:self.searchButton];
//    [self.searchButton addTarget:self action:@selector(searchBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.profileButton setFrame:CGRectMake(CGRectGetMinX(self.searchButton.frame) - 45 , CGRectGetMaxY(self.lineImageView.frame) + 5 , 30, 30)];
    [self.profileButton setBackgroundImage:[UIImage imageNamed:@"btn-menu.jpg"] forState:UIControlStateNormal];
    //[self.profileButton setBackgroundColor:[UIColor blackColor]];
    [backGroundView addSubview:self.profileButton];
    
    self.residuHeigth = SCREEN_HEIGHT - navHeight;
    
    [self.profileButton addTarget:self action:@selector(profileBtnClickOrGestureClip:) forControlEvents:UIControlEventTouchUpInside];
    [self.backButton addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
}
-(void)backBtnClick:(UIButton *)sender
{
    if([self.navigationController.viewControllers count] > 0)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)profileBtnClickOrGestureClip:(UIButton *)sender
{
    clickStatus = !clickStatus;
    if(clickStatus == YES)
    {[self makeDarkView];}
    else
    {
        [self.darkView removeFromSuperview];
        self.darkView = nil;
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    if(self.darkView != nil)
    {
        if(touch.view == self.darkView)
        {
            clickStatus = !clickStatus;
            [self.darkView removeFromSuperview];
            self.darkView = nil;
        }
    }
}


-(void)makeDarkView
{
    
    [UIView animateWithDuration:2 animations:^{
        
    } completion:^(BOOL finished) {
        self.darkView = [[UIView alloc]initWithFrame:CGRectMake(0, navHeight, SCREEN_WIDTH, SCREEN_HEIGHT - navHeight)];
        [self.darkView setBackgroundColor:[UIColor colorWithRed:86/255.f green:86/255.f blue:86/255.f alpha:0.7]];
        
        
        [self.view addSubview:self.darkView];
        
        self.menusTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH / 2 + 30, SCREEN_HEIGHT - navHeight) style:UITableViewStylePlain];
        self.menusTable.delegate = self;
        self.menusTable.dataSource = self;
        self.menusTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.menusTable.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        [self.darkView addSubview:self.menusTable];
        
        self.menuArray = [[NSMutableArray alloc]initWithCapacity:0];
        NSArray *arr = @[@"Home",@"Dog Pet Places",@"Photo Fun",@"Pet Friendly Places",@"Stockists",@"Tools",@"Pet Service",@"Tips",@"Products"];
        for(NSUInteger i = 0; i < [arr count]; i++)
        {
            [self.menuArray addObject:arr[i]];
        }
        
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.menuArray count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *imageNameArray = @[@"menu-home.jpg",@"menu-dog-pet-places.jpg",@"menu-photo-fun.jpg",@"menu-pet-friendly-places.jpg",@"menu-stockists.jpg",@"menu-tools.jpg",@"menu-pet-service.jpg",@"menu-tips.jpg",@"menu-products.jpg"];
    static NSString *iden = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:iden];
    if(nil == cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
        UIImageView *iconTemplateView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 8, 33, 33)];
        iconTemplateView.backgroundColor = [UIColor redColor];
        iconTemplateView.image = [UIImage imageNamed:imageNameArray[indexPath.row]];
        [cell.contentView addSubview:iconTemplateView];
        [cell setIndentationLevel:4];
    }
    cell.textLabel.text = [self.menuArray objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"cell lable: %@",cell.textLabel.text);
    
}


@end
