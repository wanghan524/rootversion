//
//  WhatShouldViewController.m
//  PurinaPetPlaces
//
//  Created by BlueApp on 15-4-19.
//
//

#import "WhatShouldViewController.h"
#import "GrobleSingleton.h"

@interface WhatShouldViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>{
    UILabel *nextLabel;
    UIImageView *nextImage;
    NSMutableArray *selectArray;
    UIScrollView *selectedScrollView;
    GrobleSingleton *globleSingleton;
}

@property (nonatomic, strong) UIButton *nextButton;
@end

@implementation WhatShouldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    globleSingleton = [GrobleSingleton sharedGlobleInstance];
    
    [self showCustomeNav];
    
    if (selectArray == nil) {
        selectArray = [[NSMutableArray alloc] init];
    }
    
    self.view.backgroundColor = [UIColor colorWithRed:242/255.0 green:238/255.0 blue:223/255.0 alpha:1];
    
    UIImageView *titleBackImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 150)];
    titleBackImageView.image = [UIImage imageNamed:@"tools-header.jpg"];
    [self.view addSubview:titleBackImageView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 75 - 30, SCREEN_WIDTH, 60)];
    titleLabel.text = @"What should I feed my dog";
    titleLabel.font = [UIFont fontWithName:@"Antenna" size:24];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    [titleBackImageView addSubview:titleLabel];
    
    
    //创建选择视图
    selectedScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64 + 150, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 150 - 50 - 40)];
    selectedScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 5, (SCREEN_HEIGHT - 64 - 150 - 50 - 40));
    selectedScrollView.showsHorizontalScrollIndicator = NO;
    selectedScrollView.backgroundColor = [UIColor clearColor];
    selectedScrollView.delegate = self;
    selectedScrollView.pagingEnabled = YES;
    selectedScrollView.bounces = NO;
    [self.view addSubview:selectedScrollView];
    
    for (int i = 0; i < 5; i++) {
        UITableView *selectTable = [[UITableView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * i, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 150 - 50 - 40) style:UITableViewStyleGrouped];
        selectTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        selectTable.backgroundColor = [UIColor clearColor];
        selectTable.delegate = self;
        selectTable.dataSource = self;
        selectTable.tag = 200 + i;
        [selectedScrollView addSubview:selectTable];
    }
    
    for (int i = 0; i < 5; i ++) {
        UIButton *selectedButton = [UIButton buttonWithType:UIButtonTypeCustom];
        selectedButton.frame = CGRectMake((SCREEN_WIDTH / 2.0 - 20.5)  + 10 * i, SCREEN_HEIGHT - 50 - 40, 5, 5);
        selectedButton.tag = 300 + i;
        selectedButton.backgroundColor = [UIColor grayColor];
        [selectedButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [selectedButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateSelected];
        [self.view addSubview:selectedButton];
    }
    
    
    UILabel *visitLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 50, (SCREEN_WIDTH / 5.0) * 1.5 - 1, 50)];
    visitLabel.backgroundColor = [UIColor redColor];
    NSString *str = @"START    OVER";
    visitLabel.text = str;
    visitLabel.textColor = [UIColor whiteColor];
    visitLabel.numberOfLines = 0;
    visitLabel.textAlignment = NSTextAlignmentCenter;
    visitLabel.font = [UIFont fontWithName:@"Antenna" size:15];
    [self.view addSubview:visitLabel];
    
    
    
    self.nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.nextButton.frame = CGRectMake((SCREEN_WIDTH / 5.0) * 1.5, SCREEN_HEIGHT - 50, (SCREEN_WIDTH / 5.0) * 3.5, 50);
    self.nextButton.backgroundColor = [UIColor redColor];
    [self.nextButton addTarget:self action:@selector(nextButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.nextButton];
    
    nextLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, (SCREEN_WIDTH / 5.0) * 3.5, 50)];
    nextLabel.backgroundColor = [UIColor redColor];
    nextLabel.text = @"NEXT";
    nextLabel.textColor = [UIColor whiteColor];
    nextLabel.textAlignment = NSTextAlignmentCenter;
    nextLabel.font = [UIFont fontWithName:@"Antenna" size:15];
    nextLabel.numberOfLines = 0;
    [self.nextButton addSubview:nextLabel];
    
    nextImage = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH / 5.0) * 3.5 - 80, 17.5, 15, 15)];
    nextImage.image = [UIImage imageNamed:@"next-btn.jpg"];
    [self.nextButton addSubview:nextImage];
    
    // Do any additional setup after loading the view.
}

-(void)nextButtonClick:(UIButton *)sender
{
    
}

#pragma mark - 
#pragma mark - tableViewDatasourse and delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.menusTable) {
        return [self.menuArray count];
    }
    
    if (tableView.tag == 200) {
        return globleSingleton.animalArray.count;
    }
    else if (tableView.tag == 201){
        return 2;
    }
    return 3;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView == self.menusTable) {
        return 1;
    }
    return 80;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.menusTable) {
        return 44;
    }
    return (SCREEN_HEIGHT - 64 - 150 - 50 - 40 - 80 - 30) / 3.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView == self.menusTable) {
        return nil;
    }
    NSArray *titleArray = @[@"Select Profile",@"I'm looking for",@"Size",@"Does your pet need specialty food?",@"Sort by price"];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80)];
    
    titleLabel.font = [UIFont fontWithName:@"Antenna" size:22];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor grayColor];
    titleLabel.text = [titleArray objectAtIndex:(tableView.tag -200)];
    titleLabel.numberOfLines = 0;
    
    return titleLabel;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"cell lable: %@",cell.textLabel.text);
    if(tableView == self.menusTable)
    {
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
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray *imageNameArray = @[@"menu-home.jpg",@"menu-dog-pet-places.jpg",@"menu-photo-fun.jpg",@"menu-pet-friendly-places.jpg",@"menu-stockists.jpg",@"menu-tools.jpg",@"menu-pet-service.jpg",@"menu-tips.jpg",@"menu-products.jpg"];
    
    NSArray *contentArray = @[@[@"Wet/canned dog food",@"Dry dog food"],@[@"Small",@"Medium",@"Large"],@[@"Weight Management",@"Sensitive System",@"Active & Performance"],@[@"$$",@"$$$",@"$$$$"]];
    
    
    static NSString *identifier = @"whatId";
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
        NSArray *nowContentArray = [[NSArray alloc] init];
        if (tableView.tag == 200) {
            nowContentArray = globleSingleton.getAllAnimalNameArray;
        }else{
            nowContentArray = [contentArray objectAtIndex:(tableView.tag - 200 - 1)];
        }
        
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        if(tableView.tag == 203){
            
            UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, (SCREEN_WIDTH / 3.0) * 2, (SCREEN_HEIGHT - 64 - 150 - 50 - 40 - 80 - 30) / 3.0)];
            contentLabel.textColor = [UIColor grayColor];
            contentLabel.text = [nowContentArray objectAtIndex:indexPath.row];
            contentLabel.font = [UIFont fontWithName:@"Antenna" size:10];
            contentLabel.textAlignment = NSTextAlignmentCenter;
            [cell.contentView addSubview:contentLabel];
            
            NSArray *titleArr = @[@"Yes",@"No"];
            
            UISegmentedControl *seg = [[UISegmentedControl alloc] initWithItems:titleArr];
            seg.tag = 300 + indexPath.row;
            seg.frame = CGRectMake((SCREEN_WIDTH / 3.0) * 2, 10, (SCREEN_WIDTH / 3.0) - 20, (SCREEN_HEIGHT - 64 - 150 - 50 - 40 - 80 - 30) / 3.0 - 20);
            seg.selectedSegmentIndex = 0;
            seg.tintColor = [UIColor redColor];
            [seg addTarget:self action:@selector(segmentValueChanged:) forControlEvents:UIControlEventValueChanged];
            [cell.contentView addSubview:seg];
            
            
        }else{
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if(tableView.tag == 200)
            {
                cell.textLabel.text = ((PetItem*)[nowContentArray objectAtIndex:indexPath.row]).name;
            }
            else{
                cell.textLabel.text = [nowContentArray objectAtIndex:indexPath.row];}
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            cell.textLabel.textColor = [UIColor grayColor];
            cell.textLabel.font = [UIFont fontWithName:@"Antenna" size:10];
        }
    }
   
    
    
    return cell;
}

-(void)segmentValueChanged:(UISegmentedControl*)seg
{
    NSString *title = [seg titleForSegmentAtIndex:seg.selectedSegmentIndex];
    NSLog(@"%@ , %d， %d",title,seg.selectedSegmentIndex,seg.tag);
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
    NSArray *arr = @[@"Home",@"Dog Pet Places",@"Photo Fun",@"Pet Friendly Places",@"Stockists",@"Tools",@"Pet Service",@"Tips",@"Products"];
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
