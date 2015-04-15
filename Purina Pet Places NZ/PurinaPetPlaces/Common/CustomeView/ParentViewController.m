//
//  ParentViewController.m
//  PetPlaces
//
//  Created by art_kernel_zyc on 15/4/12.
//  Copyright (c) 2015年 art_kernel_zyc. All rights reserved.
//

#import "ParentViewController.h"


CGFloat navHeight;
@interface ParentViewController ()
{
    BOOL clickStatus;
    @private
    CGFloat width,height,startPointY;
    
}

@end

@implementation ParentViewController

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

//    self.view.backgroundColor = [UIColor colorWithRed:242/255.0 green:238/255.0 blue:223/255.0 alpha:1];
//    
    //self.view.backgroundColor = [UIColor redColor];
    
}
-(void)hideCustomeNav
{
    
    
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
     [self.searchButton addTarget:self action:@selector(searchBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.profileButton setFrame:CGRectMake(CGRectGetMinX(self.searchButton.frame) - 45 , CGRectGetMaxY(self.lineImageView.frame) + 5 , 30, 30)];
    [self.profileButton setBackgroundImage:[UIImage imageNamed:@"btn-menu.jpg"] forState:UIControlStateNormal];
    //[self.profileButton setBackgroundColor:[UIColor blackColor]];
    [backGroundView addSubview:self.profileButton];
    
    self.residuHeigth = SCREEN_HEIGHT - navHeight;
    
    [self.profileButton addTarget:self action:@selector(profileBtnClickOrGestureClip:) forControlEvents:UIControlEventTouchUpInside];
    [self.backButton addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
}


-(void)searchBtnClick:(UIButton *)sender
{
    
    
}


-(void)backBtnClick:(UIButton *)sender
{
    if([self.navigationController.viewControllers count] > 0)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
@end
