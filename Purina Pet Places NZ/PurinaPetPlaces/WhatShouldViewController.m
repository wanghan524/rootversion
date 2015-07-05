//
//  WhatShouldViewController.m
//  PurinaPetPlaces
//
//  Created by BlueApp on 15-4-19.
//
//

#import "WhatShouldViewController.h"
#import "GrobleSingleton.h"
#import "ProductSelectorViewController.h"

@interface WhatShouldViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>{
    UILabel *nextLabel;
    UIImageView *nextImage;
    NSMutableArray *selectArray;
    UIScrollView *selectedScrollView;
    GrobleSingleton *globleSingleton;
}

@property (nonatomic, strong) UIButton *nextButton;
@property (nonatomic, strong) NSArray *allSelectContontArray;
@property (nonatomic, strong) NSArray *allSelectNameArray;


///这个是根据大总类dog or cat确定下来的数组
@property (nonatomic, strong) NSMutableArray *finalSelectContentArray;


///这个根据得到的各个选项,是个字典
@property (nonatomic, strong) NSMutableDictionary *selectorMutDic;

///这个是根据那个选择器选择出来的结果
@property (nonatomic, strong) NSMutableArray *fitSegmentMutArray;

@property (nonatomic, strong) NSMutableArray *resultMutArray;

@end

@implementation WhatShouldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    globleSingleton = [GrobleSingleton sharedGlobleInstance];
    
    DLog(@"array : %@",globleSingleton.selectedArray);
    
    
   
    
    [self showCustomeNav];
    
    if (selectArray == nil) {
        selectArray = [[NSMutableArray alloc] init];
    }
    
    
    if (self.allSelectContontArray == nil) {
        self.allSelectContontArray = [[NSArray alloc] init];
    }
    
    if (self.allSelectNameArray == nil) {
        self.allSelectNameArray = [[NSArray alloc] init];
    }
    
    if (self.finalSelectContentArray == nil) {
        self.finalSelectContentArray = [[NSMutableArray alloc] init];
    }
    
    if (self.selectorMutDic == nil) {
        self.selectorMutDic = [[NSMutableDictionary alloc] init];
    }
    
    if (self.fitSegmentMutArray == nil) {
        self.fitSegmentMutArray = [[NSMutableArray alloc] init];
    }
    
    if (self.resultMutArray == nil) {
        self.resultMutArray = [[NSMutableArray alloc] init];
    }
        //这里面是判断选择的食物的
    
    for (NSDictionary *everyInfoDic in globleSingleton.selectedArray) {
        NSString *typeString = [everyInfoDic objectForKey:@"pet_type"];
        
        DLog(@"pet_type :%@",typeString);
        
        if ([globleSingleton.globleCategory isEqualToString:typeString]) {
            [self.finalSelectContentArray addObject:everyInfoDic];
            [self.resultMutArray addObject:everyInfoDic];
            
            DLog(@"finalSelection : %@",self.finalSelectContentArray);
        }
        
    }
    
    if ([globleSingleton.globleCategory isEqualToString:@"dog"]) {
        self.allSelectNameArray = @[@"Select Profile",@"Age",@"I'm looking for",@"Size",@"Does your pet need specialty food?",@"Sort by price"];
        
        self.allSelectContontArray = @[@[@"Cassius",@"Miffy",@"Jazz"],@[@"puppy",@"adult",@"senior"],@[@"Wet/canned dog food",@"Dry dog food"],@[@"Toy(up to 3.5kg)",@"Small(up to 10kg)",@"Medium(10kg - 22kg)",@"Large(22kg-45kg)",@"Giant(45+kg)"],@[@"Weight Management",@"Sensitive System",@"Active & Performance"],@[@"$$",@"$$$",@"$$$$",@"See All"]];
    }else{
       self.allSelectNameArray = @[@"Select Profile",@"age",@"I'm looking for",@"Does your pet need specialty food?",@"Sort by price"];
        
        self.allSelectContontArray = @[@[@"Cassius",@"Miffy",@"Jazz"],@[@"puppy",@"adult",@"senior"],@[@"Wet/canned cat food",@"Dry cat food"],@[@"Weight Management",@"Sensitive System",@"Indoor Cat",@"Hairball Formula",@"Urinary Tract Health"],@[@"$$",@"$$$",@"$$$$",@"See All"]];
    }
    self.view.backgroundColor = [UIColor colorWithRed:242/255.0 green:238/255.0 blue:223/255.0 alpha:1];
    
    UIImageView *titleBackImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 150)];
    titleBackImageView.image = [UIImage imageNamed:@"tools-header.jpg"];
    [self.view addSubview:titleBackImageView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 75 - 30, SCREEN_WIDTH, 60)];
    titleLabel.text = @"Product selector";
    titleLabel.font = [UIFont fontWithName:@"Antenna" size:24];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    [titleBackImageView addSubview:titleLabel];
    
    
    //创建选择视图
    selectedScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64 + 150, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 150 - 50 - 40)];
    selectedScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * self.allSelectContontArray.count, (SCREEN_HEIGHT - 64 - 150 - 50 - 40));
    selectedScrollView.showsHorizontalScrollIndicator = NO;
    selectedScrollView.backgroundColor = [UIColor clearColor];
    selectedScrollView.delegate = self;
    selectedScrollView.pagingEnabled = YES;
    selectedScrollView.bounces = NO;
    [self.view addSubview:selectedScrollView];
    
    
    
    for (int i = 0; i < self.allSelectContontArray.count; i++) {
        UITableView *selectTable = [[UITableView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * i, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 150 - 50 - 40) style:UITableViewStyleGrouped];
        selectTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        selectTable.backgroundColor = [UIColor clearColor];
        selectTable.delegate = self;
        selectTable.dataSource = self;
        selectTable.tag = 200 + i;
        [selectedScrollView addSubview:selectTable];
    }
    
    for (int i = 0; i < self.allSelectContontArray.count; i ++) {
        UIButton *selectedButton = [UIButton buttonWithType:UIButtonTypeCustom];
        selectedButton.frame = CGRectMake((SCREEN_WIDTH / 2.0 - 20.5)  + 10 * i, SCREEN_HEIGHT - 50 - 30, 5, 5);
        selectedButton.tag = 3000 + i;
        if (i == 0) {
            selectedButton.backgroundColor = [UIColor whiteColor];
        }else{
            selectedButton.backgroundColor = [UIColor grayColor];
        }
        
        
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

#pragma mark - scrollerView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    int nowPage = scrollView.contentOffset.x / SCREEN_WIDTH;
    if (scrollView == selectedScrollView) {
        
        UIButton *nowButton = (UIButton *)[self.view viewWithTag:3000 + nowPage];
        
        for (int i = 0; i < 6; i++) {
            UIButton *tempButton = (UIButton *)[self.view viewWithTag:3000 + i];
            if (tempButton == nowButton) {
                tempButton.backgroundColor = [UIColor whiteColor];
            }else{
                tempButton.backgroundColor = [UIColor grayColor];
            }
        }
        
        DLog(@"%d",nowPage);
    }
    
    if (nowPage == self.allSelectNameArray.count - 1) {
        nextLabel.text = @"CHECK RESULT";
        nextImage.hidden = YES;
    }else{
        nextLabel.text = @"NEXT";
        nextImage.hidden = NO;
    }
    
}

-(void)nextButtonClick:(UIButton *)sender
{
    
    
    /**
     
     
     
     if ([globleSingleton.globleCategory isEqualToString:@"dog"]) {
     self.allSelectNameArray = @[@"Select Profile",@"I'm looking for",@"Size",@"Does your pet need specialty food?",@"Sort by price"];
     
     self.allSelectContontArray = @[@[@"puppy",@"adult",@"senior"],@[@"Wet/canned dog food",@"Dry dog food"],@[@"Toy(up to 3.5kg)",@"Small(up to 10kg)",@"Medium(10kg - 22kg)",@"Large(22kg-45kg)",@"Giant(45+kg)"],@[@"Weight Management",@"Sensitive System",@"Active & Performance"],@[@"$$",@"$$$",@"$$$$",@"See All"]];
     }else{
     self.allSelectNameArray = @[@"age",@"I'm looking for",@"Does your pet need specialty food?",@"Sort by price"];
     
     self.allSelectContontArray = @[@[@"puppy",@"adult",@"senior"],@[@"Wet/canned cat food",@"Dry cat food"],@[@"Weight-Management",@"Sensitive-System",@"Active",@"Hair-Ball",@"Urinary-Tract",@"Indoor"],@[@"$$",@"$$$",@"$$$$",@"See All"]];
     }
     */
    DLog(@"%lf",selectedScrollView.contentOffset.x);
    NSInteger nowPage = selectedScrollView.contentOffset.x / self.view.frame.size.width ;
    
    
   
    
    if (nowPage == self.allSelectNameArray.count - 1) {
        if (self.selectorMutDic.count == 0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"请选择条件" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
            
            return;
        }else{
            
            NSArray *allKeyArray = self.selectorMutDic.allKeys;
            
            for (NSString *keyString in allKeyArray) {
                if ([keyString isEqualToString:@"product_specialty"]) {
                    NSArray *nowResultArray = [self.selectorMutDic objectForKey:keyString];
                    
                    if (self.resultMutArray.count != 0) {
                        for (NSDictionary *nowDic in self.finalSelectContentArray) {
                            NSArray *nowSelectArray = [nowDic objectForKey:keyString];
                            
                            if (![nowSelectArray isEqualToArray:nowResultArray]) {
                                [self.resultMutArray removeObject:nowDic];
                            }
                            
                        }
                        
                        DLog(@"product_specialty resultMutArray : %@",self.resultMutArray);
                        
                    }
                    
                    
                    
                    
                }
                else if ([keyString isEqualToString:@"product_price"]){
                    NSString *nowPriceString = [self.selectorMutDic objectForKey:keyString];
                    
                    if (self.resultMutArray.count != 0) {
                        for (NSDictionary *nowDic in self.finalSelectContentArray) {
                            NSString *nowSelectPriceString = [nowDic objectForKey:keyString];
                            if ([nowPriceString isEqualToString:@"0-9"]) {
                                if (![nowSelectPriceString intValue] >= 0 && [nowSelectPriceString intValue] <= 9) {
                                    [self.resultMutArray removeObject:nowDic];
                                }
                            }
                            else if ([nowPriceString isEqualToString:@"10-99"]){
                                if (![nowSelectPriceString intValue] >= 10 && [nowSelectPriceString intValue] <= 99) {
                                    [self.resultMutArray removeObject:nowDic];
                                }
                            }
                            else if ([nowPriceString isEqualToString:@"100-999"]){
                                if (![nowSelectPriceString intValue] >= 100 && [nowSelectPriceString intValue] <= 999) {
                                    [self.resultMutArray removeObject:nowDic];
                                }
                            }
                            else if ([nowPriceString isEqualToString:@"all"]){
                                
                            }
                            
                        }
                        
                        DLog(@"product_price resultMutArray : %@",self.resultMutArray);
                        
                    }
                    
                    
                    
                    
                }
                
                else if ([keyString isEqualToString:@"pet_size"]){
                    NSString *nowSizeString = [self.selectorMutDic objectForKey:keyString];
                    if (self.resultMutArray.count != 0) {
                        for (NSDictionary *nowDic in self.finalSelectContentArray){
                            NSArray *nowSelectSizeArray = [nowDic objectForKey:keyString];
                            if (![nowSelectSizeArray containsObject:nowSizeString]) {
                                [self.resultMutArray removeObject:nowDic];
                            }
                        }
                    }
                    
                    DLog(@"pet_size resultMutArray : %@",self.resultMutArray);
                    
                }
                else{
                    
                    NSString *nowOtherCategoryString = [self.selectorMutDic objectForKey:keyString];
                    if (self.resultMutArray.count != 0) {
                        for (NSDictionary *nowDic in self.finalSelectContentArray) {
                            NSString *nowSelectOtherCategoryString = [nowDic objectForKey:keyString];
                            
                            if (![nowSelectOtherCategoryString isEqualToString:nowOtherCategoryString]) {
                                [self.resultMutArray removeObject:nowDic];
                            }
                            
                        }
                    }
                    
                    
                    DLog(@"product_other resultMutArray : %@",self.resultMutArray);
                    
                }
            }
            
        }
        
        ProductSelectorViewController *productSelectorVC = [[ProductSelectorViewController alloc] init];
        productSelectorVC.displayArray = self.resultMutArray;
        
        [self.navigationController pushViewController:productSelectorVC animated:YES];
        
        
        DLog(@"\n\n\n\nSELECT DIC : %@   \n%@",self.selectorMutDic,self.resultMutArray);
    }
    
    else if (nowPage == self.allSelectNameArray.count - 2){
        
        UIButton *nowButton = (UIButton *)[self.view viewWithTag:3000 + nowPage + 1];
        
        for (int i = 0; i < 6; i++) {
            UIButton *tempButton = (UIButton *)[self.view viewWithTag:3000 + i];
            if (tempButton == nowButton) {
                tempButton.backgroundColor = [UIColor whiteColor];
            }else{
                tempButton.backgroundColor = [UIColor grayColor];
            }
        }
        
        nextLabel.text = @"CHECK RESULT";
        nextImage.hidden = YES;
        
        [selectedScrollView setContentOffset:CGPointMake(SCREEN_WIDTH * (nowPage + 1), 0)];
    }
    
    else{
        
        
        UIButton *nowButton = (UIButton *)[self.view viewWithTag:3000 + nowPage + 1];
        
        for (int i = 0; i < 6; i++) {
            UIButton *tempButton = (UIButton *)[self.view viewWithTag:3000 + i];
            if (tempButton == nowButton) {
                tempButton.backgroundColor = [UIColor whiteColor];
            }else{
                tempButton.backgroundColor = [UIColor grayColor];
            }
        }
        nextImage.hidden = NO;
        [selectedScrollView setContentOffset:CGPointMake(SCREEN_WIDTH * (nowPage + 1), 0)];
        //selectedScrollView.backgroundColor = [UIColor redColor];
    }
    
    
    
    
}

#pragma mark - 
#pragma mark - tableViewDatasourse and delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.menusTable) {
        return [self.menuArray count];
    }
    
    return ((NSArray *)[self.allSelectContontArray objectAtIndex:tableView.tag - 200]).count;
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
    
    
    //DLog(@" table height : %lf ",tableView.frame.size.height);
    return (tableView.frame.size.height - 80) / 5.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView == self.menusTable) {
        return nil;
    }
    
    NSArray *titleArray = [[NSArray alloc] init];

    if ([globleSingleton.globleCategory isEqualToString:@"dog"]) {
        titleArray = @[@"Select Profile",@"Age",@"I'm looking for",@"Size",@"Does your pet need specialty food?",@"Sort by price"];
        
        
    }else{
        titleArray = @[@"Select Profile",@"Age",@"I'm looking for",@"Does your pet need specialty food?",@"Sort by price"];
    }
    
    
  
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80)];
    
    titleLabel.font = [UIFont fontWithName:@"Antenna" size:22];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor grayColor];
    titleLabel.text = [titleArray objectAtIndex:(tableView.tag -200)];
    titleLabel.numberOfLines = 0;
    
    return titleLabel;

}


#pragma mark - table select
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
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
        }
        else if(indexPath.row == 1)
        {
            
        }
        else if (indexPath.row == 2) {
                
                
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
    
//            else if (indexPath.row == 8) {
//                ProductsViewController *photoFunVC =  [[ProductsViewController alloc ] init];
//                //[self presentViewController:photoFunVC animated:YES completion:nil];
//                [self.navigationController pushViewController:photoFunVC animated:YES];
//            }
//    DLog(@"%@",indexPath);
    }else{
        
        
        //NSMutableArray *fitCategoryMutArray = [[NSMutableArray alloc] init];
//        NSMutableArray *fitAgeMutArray = [[NSMutableArray alloc] init];
//        
//        NSMutableArray *fitProductTypeMutArray = [[NSMutableArray alloc] init];
//        
//        NSMutableArray *fitSizeMutArray = [[NSMutableArray alloc] init];
//        NSMutableArray *fitSpeciallyMutArray = [[NSMutableArray alloc] init];
//        
//        NSMutableArray *fitPriceMutArray = [[NSMutableArray alloc] init];
        
        
       
        
        
        
        
        //进行分类讨论
        if ([globleSingleton.globleCategory isEqualToString:@"dog"]) {
           //如果进入到dog
            
            
            /*
             
             
             @[@"age",@"I'm looking for",@"Size",@"Does your pet need specialty food?",@"Sort by price"];
             
             self.allSelectContontArray = @[@[@"puppy",@"adult",@"senior"],@[@"Wet",@"Dry"],@[@"Toy",@"Small",@"Medium",@"Large",@"Giant"],@[@"Weight-Management",@"Sensitive-System",@"Active",@"Hair-Ball",@"Urinary-Tract",@"Indoor"],@[@"$$",@"$$$",@"$$$$",@"See All"]];
             
             
             */
            
#if 0
            
            if (tableView.tag == 200) {
                UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
                DLog(@"agetext: %@",cell.textLabel.text);
                
                for (NSDictionary *ageInfoDic in fitCategoryMutArray) {
                    NSString *ageString = [[ageInfoDic objectForKey:@"pet_age"] lowercaseString];
                    if ([ageString isEqualToString:[cell.textLabel.text lowercaseString]]) {
                        [fitAgeMutArray addObject:ageInfoDic];
                    }
                    
                }
                
                
            }
            
            if (tableView.tag == 201) {
                UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
                DLog(@"looking for text: %@",cell.textLabel.text);
                
//                if (fitAgeMutArray.count == 0) {
//                    DLog(@"请按照顺序选择");
//                }else{
                    for (NSDictionary *lookingInfoDic in fitAgeMutArray) {
                        NSString *lookingInfoString = [[lookingInfoDic objectForKey:@"product_type"] lowercaseString];
                        if ([lookingInfoString isEqualToString:[cell.textLabel.text lowercaseString]]) {
                            [fitProductTypeMutArray addObject:lookingInfoString];
                        }
                    }
//                }
            
            }
#endif
            /*
             @[@"age",@"I'm looking for",@"Size",@"Does your pet need specialty food?",@"Sort by price"];
             */
            
            
            /**
             
             
             
             if ([globleSingleton.globleCategory isEqualToString:@"dog"]) {
             self.allSelectNameArray = @[@"Select Profile",@"I'm looking for",@"Size",@"Does your pet need specialty food?",@"Sort by price"];
             
             self.allSelectContontArray = @[@[@"puppy",@"adult",@"senior"],@[@"Wet/canned dog food",@"Dry dog food"],@[@"Toy(up to 3.5kg)",@"Small(up to 10kg)",@"Medium(10kg - 22kg)",@"Large(22kg-45kg)",@"Giant(45+kg)"],@[@"Weight Management",@"Sensitive System",@"Active & Performance"],@[@"$$",@"$$$",@"$$$$",@"See All"]];
             }else{
             self.allSelectNameArray = @[@"age",@"I'm looking for",@"Does your pet need specialty food?",@"Sort by price"];
             
             self.allSelectContontArray = @[@[@"puppy",@"adult",@"senior"],@[@"Wet/canned cat food",@"Dry cat food"],@[@"Weight-Management",@"Sensitive-System",@"Active",@"Hair-Ball",@"Urinary-Tract",@"Indoor"],@[@"$$",@"$$$",@"$$$$",@"See All"]];
             }
             */
            
            /**
             
             if ([globleSingleton.globleCategory isEqualToString:@"dog"]) {
             self.allSelectNameArray = @[@"Select Profile",@"Age",@"I'm looking for",@"Size",@"Does your pet need specialty food?",@"Sort by price"];
             
             self.allSelectContontArray = @[@[@"Cassius",@"Miffy",@"Jazz"],@[@"puppy",@"adult",@"senior"],@[@"Wet/canned dog food",@"Dry dog food"],@[@"Toy(up to 3.5kg)",@"Small(up to 10kg)",@"Medium(10kg - 22kg)",@"Large(22kg-45kg)",@"Giant(45+kg)"],@[@"Weight Management",@"Sensitive System",@"Active & Performance"],@[@"$$",@"$$$",@"$$$$",@"See All"]];
             }else{
             self.allSelectNameArray = @[@"Select Profile",@"age",@"I'm looking for",@"Does your pet need specialty food?",@"Sort by price"];
             
             self.allSelectContontArray = @[@[@"Cassius",@"Miffy",@"Jazz"],@[@"puppy",@"adult",@"senior"],@[@"Wet/canned cat food",@"Dry cat food"],@[@"Weight Management",@"Sensitive System",@"Indoor Cat",@"Hairball Formula",@"Urinary Tract Health"],@[@"$$",@"$$$",@"$$$$",@"See All"]];
             }
             
             */
            
            if (tableView.tag == 201) {
                UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
                
                //NSDictionary *ageDic = [[NSDictionary alloc] initWithObjectsAndKeys:[cell.textLabel.text lowercaseString], @"pet_age",nil];
                //NSLog(@"ageDic : %@",ageDic);
                //[self.selectorMutArray addObject:ageDic];
            
                
                
                
                
                [self.selectorMutDic setObject:[cell.textLabel.text lowercaseString] forKey:@"pet_age"];
                
            }
            
            if (tableView.tag == 202) {
                UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
                
//                NSDictionary *productTypeDic = [[NSDictionary alloc] initWithObjectsAndKeys:[cell.textLabel.text lowercaseString],@"product_type", nil];
//                [self.selectorMutArray addObject:productTypeDic];
                
                NSString *typeString;
                
                if ([globleSingleton.globleCategory isEqualToString:@"dog"]) {
                    if ([cell.textLabel.text isEqualToString:@"Wet/canned dog food"]) {
                        typeString = @"wet";
                    }
                    
                    else if ([cell.textLabel.text isEqualToString:@"Dry dog food"]) {
                        typeString = @"dry";
                    }
                }
                else{
                    if ([cell.textLabel.text isEqualToString:@"Wet/canned cat food"]) {
                        typeString = @"wet";
                    }
                    
                    else if ([cell.textLabel.text isEqualToString:@"Dry cat food"]) {
                        typeString = @"dry";
                    }
                }
                
                [self.selectorMutDic setObject:typeString forKey:@"product_type"];
            }
            
            if (tableView.tag == 203) {
                UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
                
//                NSDictionary *sizeDic = [[NSDictionary alloc] initWithObjectsAndKeys:[cell.textLabel.text lowercaseString],@"pet_size", nil];
//                [self.selectorMutArray addObject:sizeDic];
                
                
                NSString *sizeString;
                
                
                if ([cell.textLabel.text isEqualToString:@"Toy(up to 3.5kg)"]) {
                    sizeString = @"toy";
                }
                
                else if ([cell.textLabel.text isEqualToString:@"Small(up to 10kg)"]) {
                    sizeString = @"small";
                }
                
                else if ([cell.textLabel.text isEqualToString:@"Medium(10kg - 22kg)"]) {
                    sizeString = @"medium";
                }
                
                else if ([cell.textLabel.text isEqualToString:@"Large(22kg-45kg)"]) {
                    sizeString = @"large";
                }
                
                else if ([cell.textLabel.text isEqualToString:@"Giant(45+kg)"]) {
                    sizeString = @"giant";
                }
                
                [self.selectorMutDic setObject:sizeString forKey:@"pet_size"];
            }
            
            if (tableView.tag == 205) {
                NSString *priceString;
                
                if (indexPath.row == 0) {
                    priceString = @"0-9";
                }
                if (indexPath.row == 1) {
                    priceString = @"10-99";
                }
                if (indexPath.row == 2) {
                    priceString = @"100-999";
                }
                if (indexPath.row == 3) {
                    priceString = @"all";
                }
                
                [self.selectorMutDic setObject:priceString forKey:@"product_price"];
                
                //NSDictionary *sizeDic = [[NSDictionary alloc] initWithObjectsAndKeys:[cell.textLabel.text lowercaseString],@"product_price", nil];
            }
            
            
        }else{
            //如果进入到cat
            /*
             titleArray = @[@"age",@"I'm looking for",@"Does your pet need specialty food?",@"Sort by price"];
             
             */
            
            
            if (tableView.tag == 201) {
                UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
                
                
               
                
                [self.selectorMutDic setObject:[cell.textLabel.text lowercaseString] forKey:@"pet_age"];
                
            }
            
            
            if (tableView.tag == 202) {
                UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
                
                
                NSString *typeString;
                
                if ([globleSingleton.globleCategory isEqualToString:@"dog"]) {
                    if ([cell.textLabel.text isEqualToString:@"Wet/canned dog food"]) {
                        typeString = @"wet";
                    }
                    
                    else if ([cell.textLabel.text isEqualToString:@"Dry dog food"]) {
                        typeString = @"dry";
                    }
                }
                else{
                    if ([cell.textLabel.text isEqualToString:@"Wet/canned cat food"]) {
                        typeString = @"wet";
                    }
                    
                    else if ([cell.textLabel.text isEqualToString:@"Dry cat food"]) {
                        typeString = @"dry";
                    }
                }
                
                [self.selectorMutDic setObject:typeString forKey:@"product_type"];
            }
            
            
            if (tableView.tag == 204) {
                NSString *priceString;
                
                if (indexPath.row == 0) {
                    priceString = @"0-9";
                }
                if (indexPath.row == 1) {
                    priceString = @"10-99";
                }
                if (indexPath.row == 2) {
                    priceString = @"100-999";
                }
                if (indexPath.row == 3) {
                    priceString = @"all";
                }
                
                [self.selectorMutDic setObject:priceString forKey:@"product_price"];
                
                DLog(@" final dic : %@",self.selectorMutDic);
                
                //NSDictionary *sizeDic = [[NSDictionary alloc] initWithObjectsAndKeys:[cell.textLabel.text lowercaseString],@"product_price", nil];
            }

            
        }
        
        
        
        
        
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray *imageNameArray = @[@"menu-home.jpg",@"menu-dog-pet-places.jpg",@"menu-photo-fun.jpg",@"menu-pet-friendly-places.jpg",@"menu-stockists.jpg",@"menu-tools.jpg",@"menu-pet-service.jpg",@"menu-tips.jpg"];
    
    //NSArray *contentArray = @[@[@"Wet",@"Dry"],@[@"Toy",@"Small",@"Medium",@"Large",@"Giant"],@[@"Weight-Management",@"Sensitive-System",@"Active",@"Hair-Ball",@"Urinary-Tract",@"Indoor"],@[@"$$",@"$$$",@"$$$$",@"See All"]];
    
    
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
        cell.textLabel.font = [UIFont fontWithName:@"Antenna" size:15];
        cell.textLabel.text = [self.menuArray objectAtIndex:indexPath.row];
    }else{
        NSArray *nowContentArray = [[NSArray alloc] init];
//        if (tableView.tag == 200) {
//            
//            if ([globleSingleton.globleCategory isEqualToString:@"dog"]) {
//                nowContentArray = @[@"puppy",@"adult",@"senior"];
//            }else{
//                nowContentArray = @[@"kitten",@"adult",@"senior"];
//            }
//            
//        }else{
            nowContentArray = [self.allSelectContontArray objectAtIndex:(tableView.tag - 200)];
//        }
    
        cell.backgroundColor = [UIColor clearColor];
        
        
        UIView *selectView = [[UIView alloc] initWithFrame:cell.frame];
        selectView.backgroundColor = [UIColor whiteColor];
        cell.selectedBackgroundView = selectView;
        //cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        if ([globleSingleton.globleCategory isEqualToString:@"dog"]) {
            if(tableView.tag == 204){
                
                UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, (SCREEN_WIDTH / 3.0) * 2, (tableView.frame.size.height - 80) / 5.0)];
                contentLabel.textColor = [UIColor grayColor];
                contentLabel.text = [nowContentArray objectAtIndex:indexPath.row];
                contentLabel.font = [UIFont fontWithName:@"Antenna" size:15];
                contentLabel.textAlignment = NSTextAlignmentCenter;
                [cell.contentView addSubview:contentLabel];
                
                NSArray *titleArr = @[@"Yes",@"No"];
                
                UISegmentedControl *seg = [[UISegmentedControl alloc] initWithItems:titleArr];
                seg.tag = 300 + indexPath.row;
                seg.frame = CGRectMake((SCREEN_WIDTH / 3.0) * 2, 3, (SCREEN_WIDTH / 3.0) - 20, (tableView.frame.size.height - 80) / 5.0 - 6);
                seg.selectedSegmentIndex = 0;
                seg.tintColor = [UIColor redColor];
                [seg addTarget:self action:@selector(segmentValueChanged:) forControlEvents:UIControlEventValueChanged];
                [cell.contentView addSubview:seg];
                
                
            }else{
                
                UIView *selectView = [[UIView alloc] initWithFrame:cell.frame];
                selectView.backgroundColor = [UIColor whiteColor];
                cell.selectedBackgroundView = selectView;
                
                //cell.selectionStyle = UITableViewCellSelectionStyleNone;
//                if(tableView.tag == 200)
//                {
//                    cell.textLabel.text = [nowContentArray objectAtIndex:indexPath.row];
//                }
//                else{
//                    cell.textLabel.text = [nowContentArray objectAtIndex:indexPath.row];
//                }
                cell.textLabel.text = [nowContentArray objectAtIndex:indexPath.row];
                cell.textLabel.textAlignment = NSTextAlignmentCenter;
                cell.textLabel.textColor = [UIColor grayColor];
                cell.textLabel.font = [UIFont fontWithName:@"Antenna" size:15];
            }

        }else{
            if(tableView.tag == 203){
                
                UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, (SCREEN_WIDTH / 3.0) * 2, (tableView.frame.size.height - 80) / 5.0)];
                contentLabel.textColor = [UIColor grayColor];
                contentLabel.text = [[self.allSelectContontArray objectAtIndex:tableView.tag-200] objectAtIndex:indexPath.row];
                contentLabel.font = [UIFont fontWithName:@"Antenna" size:15];
                contentLabel.textAlignment = NSTextAlignmentCenter;
                [cell.contentView addSubview:contentLabel];
                
                NSArray *titleArr = @[@"Yes",@"No"];
                
                UISegmentedControl *seg = [[UISegmentedControl alloc] initWithItems:titleArr];
                seg.tag = 300 + indexPath.row;
                seg.frame = CGRectMake((SCREEN_WIDTH / 3.0) * 2, 3, (SCREEN_WIDTH / 3.0) - 20, (tableView.frame.size.height - 80) / 5.0 - 6);
                seg.selectedSegmentIndex = 0;
                seg.tintColor = [UIColor redColor];
                [seg addTarget:self action:@selector(segmentValueChanged:) forControlEvents:UIControlEventValueChanged];
                [cell.contentView addSubview:seg];
                
                
            }else{
                UIView *selectView = [[UIView alloc] initWithFrame:cell.frame];
                selectView.backgroundColor = [UIColor whiteColor];
                cell.selectedBackgroundView = selectView;
                //cell.selectionStyle = UITableViewCellSelectionStyleNone;
                if(tableView.tag == 200)
                {
                    cell.textLabel.text = [nowContentArray objectAtIndex:indexPath.row];
                }
                else{
                    cell.textLabel.text = [nowContentArray objectAtIndex:indexPath.row];
                }
                cell.textLabel.textAlignment = NSTextAlignmentCenter;
                cell.textLabel.textColor = [UIColor grayColor];
                cell.textLabel.font = [UIFont fontWithName:@"Antenna" size:15];
            }

        }
        
//        if(tableView.tag == 203){
//            
//            UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, (SCREEN_WIDTH / 3.0) * 2, (SCREEN_HEIGHT - 64 - 150 - 50 - 40 - 80 - 30) / 3.0)];
//            contentLabel.textColor = [UIColor grayColor];
//            contentLabel.text = [nowContentArray objectAtIndex:indexPath.row];
//            contentLabel.font = [UIFont fontWithName:@"Antenna" size:13];
//            contentLabel.textAlignment = NSTextAlignmentCenter;
//            [cell.contentView addSubview:contentLabel];
//            
//            NSArray *titleArr = @[@"Yes",@"No"];
//            
//            UISegmentedControl *seg = [[UISegmentedControl alloc] initWithItems:titleArr];
//            seg.tag = 300 + indexPath.row;
//            seg.frame = CGRectMake((SCREEN_WIDTH / 3.0) * 2, 10, (SCREEN_WIDTH / 3.0) - 20, (SCREEN_HEIGHT - 64 - 150 - 50 - 40 - 80 - 30) / 3.0 - 20);
//            seg.selectedSegmentIndex = 0;
//            seg.tintColor = [UIColor redColor];
//            [seg addTarget:self action:@selector(segmentValueChanged:) forControlEvents:UIControlEventValueChanged];
//            [cell.contentView addSubview:seg];
//            
//            
//        }else{
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            if(tableView.tag == 200)
//            {
//                cell.textLabel.text = [nowContentArray objectAtIndex:indexPath.row];
//            }
//            else{
//                cell.textLabel.text = [nowContentArray objectAtIndex:indexPath.row];}
//            cell.textLabel.textAlignment = NSTextAlignmentCenter;
//            cell.textLabel.textColor = [UIColor grayColor];
//            cell.textLabel.font = [UIFont fontWithName:@"Antenna" size:10];
//        }
    }
   
    
    
    return cell;
}


#pragma mark - segment change
-(void)segmentValueChanged:(UISegmentedControl*)seg
{
    NSString *title = [seg titleForSegmentAtIndex:seg.selectedSegmentIndex];
    
    /*
     @[@"Weight-Management",@"Sensitive-System",@"Active",@"Hair-Ball",@"Urinary-Tract",@"Indoor"]
     */
    
    NSString *segmentNameString;
    
    if ([globleSingleton.globleCategory isEqualToString:@"dog"]) {
        
        NSArray *segmentAllArray =  @[@"weight-management",@"sensitive-system",@"active"];
        
        self.fitSegmentMutArray = [[NSMutableArray alloc] initWithArray:segmentAllArray];

        if (seg.tag == 300) {
            segmentNameString = @"weight-management";
        }
        if (seg.tag == 301) {
            segmentNameString = @"sensitive-system";
        }
        if (seg.tag == 302) {
            segmentNameString = @"active";
        }
    }
    else{
        
        
        NSArray *segmentAllArray =  @[@"weight-management",@"sensitive-system",@"active",@"hair-ball",@"urinary-tract",@"indoor"];
        
        self.fitSegmentMutArray = [[NSMutableArray alloc] initWithArray:segmentAllArray];

        if (seg.tag == 300) {
            segmentNameString = @"weight-management";
        }
        if (seg.tag == 301) {
            segmentNameString = @"sensitive-system";
        }
        if (seg.tag == 302) {
            segmentNameString = @"indoor";
        }
        if (seg.tag == 303) {
            segmentNameString = @"hair-ball";
        }
        if (seg.tag == 304) {
            segmentNameString = @"urinary-tract";
        }
    }
    
    
    
    
    
    if(seg.selectedSegmentIndex == 0){
        if (![self.fitSegmentMutArray containsObject:segmentNameString ]) {
            [self.fitSegmentMutArray addObject:segmentNameString];
        }
        
    }else{
        if ([self.fitSegmentMutArray containsObject:segmentNameString]) {
            [self.fitSegmentMutArray removeObject:segmentNameString];
        }
    }
    
    //NSDictionary *segmentDic = [[NSDictionary alloc] initWithObjectsAndKeys:self.fitSegmentMutArray,@"product_specialty", nil];
    
    [self.selectorMutDic setObject:self.fitSegmentMutArray forKey:@"product_specialty"];
    
    
    
    NSLog(@"%@ , %d, %d  %@  %@",title,seg.selectedSegmentIndex,seg.tag,self.fitSegmentMutArray,self.selectorMutDic);
    
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
