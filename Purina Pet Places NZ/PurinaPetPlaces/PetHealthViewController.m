//
//  PetHealthViewController.m
//  PurinaPetPlaces
//
//  Created by BlueApp on 15-4-19.
//
//

#import "PetHealthViewController.h"
#import "GrobleSingleton.h"
#import "PetHealthDetailViewController.h"
#import "PetItem.h"

@interface PetHealthViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UILabel *nextLabel;
    UIImageView *nextImage;
    GrobleSingleton *globleSingleton;
}

@end

@implementation PetHealthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self showCustomeNav];
    
    globleSingleton = [GrobleSingleton sharedGlobleInstance];
    
    self.view.backgroundColor = [UIColor colorWithRed:242/255.0 green:238/255.0 blue:223/255.0 alpha:1];
    
    UIImageView *titleBackImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 150)];
    titleBackImageView.image = [UIImage imageNamed:@"tools-header2.jpg"];
    [self.view addSubview:titleBackImageView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 75 - 30, SCREEN_WIDTH, 60)];
    titleLabel.text = @"Pet Health Compass";

    titleLabel.font = [UIFont fontWithName:@"Antenna" size:24];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    [titleBackImageView addSubview:titleLabel];
    
    UITableView *allAnimalTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64 + 150, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 150 - 60) style:UITableViewStyleGrouped];
    allAnimalTableView.backgroundColor = [UIColor clearColor];
    allAnimalTableView.bounces = NO;
    allAnimalTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    allAnimalTableView.dataSource = self;
    allAnimalTableView.delegate = self;
    [self.view addSubview:allAnimalTableView];
    
    
    
    
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    nextButton.frame = CGRectMake(0, SCREEN_HEIGHT - 60, SCREEN_WIDTH, 60);
    nextButton.backgroundColor = [UIColor redColor];
    [nextButton addTarget:self action:@selector(nextButtonClick) forControlEvents:UIControlEventTouchUpInside];
    nextButton.userInteractionEnabled = YES;
    [self.view addSubview:nextButton];
    
    nextLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
    nextLabel.text = @"NEXT";
    nextLabel.textColor = [UIColor whiteColor];
    nextLabel.textAlignment = NSTextAlignmentCenter;
    nextLabel.font = [UIFont fontWithName:@"Antenna" size:20];
    nextLabel.numberOfLines = 0;
    [nextButton addSubview:nextLabel];
    
    nextImage = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH / 5.0) * 3 , 20, 30, 20)];
    nextImage.image = [UIImage imageNamed:@"next-btn.jpg"];
    [nextButton addSubview:nextImage];
    
    // Do any additional setup after loading the view.
}

#pragma mark - 
#pragma mark - tableViewDatasourse and delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.menusTable) {
        return [self.menuArray count];
    }
    return [globleSingleton getAllAnimalNameArray].count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray *imageNameArray = @[@"menu-home.jpg",@"menu-dog-pet-places.jpg",@"menu-photo-fun.jpg",@"menu-pet-friendly-places.jpg",@"menu-stockists.jpg",@"menu-tools.jpg",@"menu-pet-service.jpg",@"menu-tips.jpg"];
    
    static NSString *identifier = @"petHealth";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    if (tableView == self.menusTable) {
        UIImageView *iconTemplateView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 8, 33, 33)];
        iconTemplateView.backgroundColor = [UIColor redColor];
        iconTemplateView.image = [UIImage imageNamed:imageNameArray[indexPath.row]];
        [cell.contentView addSubview:iconTemplateView];
        [cell setIndentationLevel:4];
        cell.textLabel.font = [UIFont fontWithName:@"Antenna" size:10];
        cell.textLabel.text = [self.menuArray objectAtIndex:indexPath.row];
    }else{
        PetItem *item = [[globleSingleton getAllAnimalNameArray]objectAtIndex:indexPath.row];
        cell.textLabel.text = item.name;
        cell.textLabel.textColor = [UIColor grayColor];
        cell.textLabel.font = [UIFont fontWithName:@"Antenna" size:17];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView == self.menusTable) {
        return nil;
    }
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80)];
    headerLabel.text = @"Select Dog Profile";
    headerLabel.textAlignment = NSTextAlignmentCenter;
    headerLabel.font = [UIFont fontWithName:@"Antenna" size:20];
    return headerLabel;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView == self.menusTable) {
        return 1;
    }
    return 80;
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
        
//                else if (indexPath.row == 8) {
//                    ProductsViewController *photoFunVC =  [[ProductsViewController alloc ] init];
//                    //[self presentViewController:photoFunVC animated:YES completion:nil];
//                    [self.navigationController pushViewController:photoFunVC animated:YES];
//                }
//        DLog(@"%@",indexPath);
        
        
        

        
    }
    
    globleSingleton.selectedAnimalName = [[globleSingleton getAllAnimalNameArray] objectAtIndex:indexPath.row];
    NSLog(@"indexPath : %@",globleSingleton.selectedAnimalName);

}

- (void)nextButtonClick{
    PetHealthDetailViewController *petHealthDetailVC = [[PetHealthDetailViewController alloc] init];
    
    [self.navigationController pushViewController:petHealthDetailVC animated:NO];
}

#pragma mark -
#pragma mark - 侧滑
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
    
    //[UIView animateWithDuration:2.0 animations:^{
    self.darkView = [[UIView alloc]initWithFrame:CGRectMake(0, navHeight, SCREEN_WIDTH, SCREEN_HEIGHT - navHeight)];
    [self.darkView setBackgroundColor:[UIColor colorWithRed:86/255.f green:86/255.f blue:86/255.f alpha:0.7]];
    
    
    [self.view addSubview:self.darkView];
    
    self.menusTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH / 2 + 30, SCREEN_HEIGHT - navHeight) style:UITableViewStylePlain];
    self.menusTable.tag = 100;
    self.menusTable.delegate = self;
    self.menusTable.dataSource = self;
    self.menusTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.menusTable.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self.darkView addSubview:self.menusTable];
    
    self.menuArray = [[NSMutableArray alloc]initWithCapacity:0];
    NSArray *arr = @[@"Home",@"Dog Pet Places",@"Photo Fun",@"Pet Friendly Places",@"Stockists",@"Tools",@"Pet Service",@"Tips"];
    for(NSUInteger i = 0; i < [arr count]; i++)
    {
        [self.menuArray addObject:arr[i]];
    }
    
    //}];
    
}
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
