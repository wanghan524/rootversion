//
//  ToolsViewController.m
//  PurinaPetPlaces
//
//  Created by BlueApp on 15-4-18.
//
//

#import "ToolsViewController.h"
#import "PetHealthViewController.h"
#import "WhatShouldViewController.h"
#import "ProductsViewController.h"
#import "TipsContentViewController.h"
#import "SearchViewController.h"
#import "photoFunViewController.h"
#import "Singleton.h"
#import "Categories.h"
#import "NextPetFriendlyPlacesViewController.h"
#import "ProductsViewController.h"
#import "TipsViewController.h"
#import "ToolsViewController.h"
#import "PetFriendlyPlacesViewController.h"
#import "BodyConditionViewController.h"

@interface ToolsViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSArray *titleArray;
}


@property (nonatomic, strong) UITableView *myTableView;
@end



@implementation ToolsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self showCustomeNav];
    
    self.view.backgroundColor = [UIColor colorWithRed:242/255.0 green:238/255.0 blue:223/255.0 alpha:1];
    
    self.myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStyleGrouped];
    self.myTableView.backgroundColor = [UIColor colorWithRed:242/255.0 green:238/255.0 blue:223/255.0 alpha:1];
    self.myTableView.dataSource = self;
    self.myTableView.delegate = self;
    [self.view addSubview:self.myTableView];
    // Do any additional setup after loading the view.
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.menusTable) {
        return 44;
    }
    
    return (SCREEN_HEIGHT - 64 - 100) / 3.0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //Singleton *sharedSingleton = [Singleton sharedInstance];
    
    if (tableView == self.menusTable) {
        return [self.menuArray count];
    }
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     NSArray *imageNameArray = @[@"menu-home.jpg",@"menu-dog-pet-places.jpg",@"menu-photo-fun.jpg",@"menu-pet-friendly-places.jpg",@"menu-stockists.jpg",@"menu-tools.jpg",@"menu-pet-service.jpg",@"menu-tips.jpg"];
    
    titleArray = [[NSArray alloc] init];
    
    titleArray = @[@"Pet health compass",@"Product selector",@"Body Condition"];
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        
        if (tableView == self.menusTable) {
            UIImageView *iconTemplateView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 8, 33, 33)];
            iconTemplateView.backgroundColor = [UIColor redColor];
            iconTemplateView.image = [UIImage imageNamed:imageNameArray[indexPath.row]];
            [cell.contentView addSubview:iconTemplateView];
            [cell setIndentationLevel:4];
            cell.textLabel.font = [UIFont fontWithName:@"Antenna" size:10];
            cell.textLabel.text = [self.menuArray objectAtIndex:indexPath.row];
        }
        
        if (tableView == self.myTableView) {
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, (SCREEN_HEIGHT - 64 - 100) / 3.0 / 2.0- 20, cell.frame.size.width, 40)];
            titleLabel.backgroundColor = [UIColor clearColor];
            titleLabel.text = titleArray[indexPath.row];
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.font = [UIFont fontWithName:@"Antenna" size:20];
            titleLabel.textColor = [UIColor grayColor];
            [cell.contentView addSubview:titleLabel];
            //
            //        [iconTemplateView setFrame:CGRectMake(8, 8, 33, 33)];
            //        [cell addSubview:iconTemplateView];
            [cell setIndentationLevel:4];
            UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, (SCREEN_HEIGHT - 64 - 100) / 3.0)];
            backView.backgroundColor = [UIColor whiteColor];
            cell.selectedBackgroundView = backView;
        }
        
        
    }
    
    
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleDefault];
    //[cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView == self.menusTable) {
        return 1;
    }
    return 100.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView == self.menusTable) {
        return nil;
    }
    UIImageView * headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    headerImageView.image = [UIImage imageNamed:@"tools-header0.png"];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:headerImageView.frame];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = @"Tools";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont fontWithName:@"Antenna" size:22];
    titleLabel.textColor = [UIColor whiteColor];
    [headerImageView addSubview:titleLabel];
    return headerImageView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.menusTable) {
        
        
        if(self.darkView != nil)
        {
            
            clickStatus = !clickStatus;
            [self.darkView removeFromSuperview];
            self.darkView = nil;
            
        }
        
        
        if(indexPath.row == 0)
        {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else
            if(indexPath.row == 1)
            {
                
            }else
                
                if (indexPath.row == 2) {
                    
                    
                    photoFunViewController *photoFunVC =  [[photoFunViewController alloc] initWithNibName:@"photoFunViewController" bundle:nil];
                    //[self presentViewController:photoFunVC animated:YES completion:nil];
                    [self.navigationController pushViewController:photoFunVC animated:YES];
                }
        
                else if (indexPath.row == 3) {
                    PetFriendlyPlacesViewController *petFriendlyPlacesVC =  [[PetFriendlyPlacesViewController alloc ] init];
                    //[self presentViewController:photoFunVC animated:YES completion:nil];
                    [self.navigationController pushViewController:petFriendlyPlacesVC animated:YES];
                }
        
                else if (indexPath.row == 4){
                    Singleton *singletonClass = [Singleton sharedInstance];
                    NSArray *currentCategories = [[NSArray alloc] initWithArray:singletonClass.currentCategories];
                    for (Categories *categories in currentCategories) {
                        NSLog(@"Categories name : %@",categories.CategoryName);
                        
                        if ([categories.CategoryName isEqualToString:@"Stockists"]) {
                            [singletonClass setSelectedCategories:categories];
                            NextPetFriendlyPlacesViewController *stockists = [[NextPetFriendlyPlacesViewController alloc] init];
                            stockists.headerImageFlag = categories.CategoryName;
                            [self.navigationController pushViewController:stockists animated:YES];
                            
                        }
                    }
                    
                    
                }
        
                else if (indexPath.row == 5) {
                    ToolsViewController *toolsVC =  [[ToolsViewController alloc ] init];
                    
                    [self.navigationController pushViewController:toolsVC animated:YES];
                }
        
                else if (indexPath.row == 6){
                    Singleton *singletonClass = [Singleton sharedInstance];
                    NSArray *currentCategories = [[NSArray alloc] initWithArray:singletonClass.currentCategories];
                    for (Categories *categories in currentCategories) {
                        NSLog(@"Categories name : %@",categories.CategoryName);
                        
                        if ([categories.CategoryName isEqualToString:@"Pet Services"]) {
                            [singletonClass setSelectedCategories:categories];
                            NextPetFriendlyPlacesViewController *stockists = [[NextPetFriendlyPlacesViewController alloc] init];
                            stockists.headerImageFlag = categories.CategoryName;
                            [self.navigationController pushViewController:stockists animated:YES];
                            
                        }
                    }
                    
                    
                }
        
                else if (indexPath.row == 7) {
                    TipsViewController *tipsVC =  [[TipsViewController alloc ] init];
                    //[self presentViewController:photoFunVC animated:YES completion:nil];
                    [self.navigationController pushViewController:tipsVC animated:YES];
                }
        
                else if (indexPath.row == 8) {
                    ProductsViewController *photoFunVC =  [[ProductsViewController alloc ] init];
                    //[self presentViewController:photoFunVC animated:YES completion:nil];
                    [self.navigationController pushViewController:photoFunVC animated:YES];
                }
        DLog(@"%@",indexPath);

        
        
    }
    else{
        if(0 == indexPath.row){
            PetHealthViewController *petHealthVC = [[PetHealthViewController alloc] init];
            [self.navigationController pushViewController:petHealthVC animated:NO];
            
        }
        else if (1 == indexPath.row){
            WhatShouldViewController *whatShouldVC = [[WhatShouldViewController alloc] init];
            [self.navigationController pushViewController:whatShouldVC animated:NO];
        }
        
        else if (2 == indexPath.row){
            BodyConditionViewController *bodyConditionVC = [[BodyConditionViewController alloc] init];
            [self.navigationController pushViewController:bodyConditionVC animated:NO];
        }
    }
    
   
}

#pragma mark -
#pragma mark - 侧滑

//-(void)profileBtnClickOrGestureClip:(UIButton *)sender
//{
//    clickStatus = !clickStatus;
//    if(clickStatus == YES)
//    {[self makeDarkView];}
//    else
//    {
//        [self.darkView removeFromSuperview];
//        self.darkView = nil;
//    }
//    
//}
//
//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    UITouch *touch = [touches anyObject];
//    if(self.darkView != nil)
//    {
//        if(touch.view == self.darkView)
//        {
//            clickStatus = !clickStatus;
//            [self.darkView removeFromSuperview];
//            self.darkView = nil;
//        }
//    }
//}
//
//
//-(void)makeDarkView
//{
//    
//    //[UIView animateWithDuration:2.0 animations:^{
//    self.darkView = [[UIView alloc]initWithFrame:CGRectMake(0, navHeight, SCREEN_WIDTH, SCREEN_HEIGHT - navHeight)];
//    [self.darkView setBackgroundColor:[UIColor colorWithRed:86/255.f green:86/255.f blue:86/255.f alpha:0.7]];
//    
//    
//    [self.view addSubview:self.darkView];
//    
//    self.menusTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH / 2 + 30, SCREEN_HEIGHT - navHeight) style:UITableViewStylePlain];
//    self.menusTable.tag = 100;
//    self.menusTable.delegate = self;
//    self.menusTable.dataSource = self;
//    self.menusTable.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.menusTable.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
//    [self.darkView addSubview:self.menusTable];
//    
//    self.menuArray = [[NSMutableArray alloc]initWithCapacity:0];
//    NSArray *arr = @[@"Home",@"Dog Pet Places",@"Photo Fun",@"Pet Friendly Places",@"Stockists",@"Tools",@"Pet Service",@"Tips",@"Products"];
//    for(NSUInteger i = 0; i < [arr count]; i++)
//    {
//        [self.menuArray addObject:arr[i]];
//    }
//    
//    //}];
//    
//}
//

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
