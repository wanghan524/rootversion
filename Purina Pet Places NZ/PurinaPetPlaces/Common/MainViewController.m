//
//  MainViewController.m
//  PetPlaces
//
//  Created by art_kernel_zyc on 15/4/12.
//  Copyright (c) 2015年 art_kernel_zyc. All rights reserved.
//

#import "MainViewController.h"
#import "Singleton.h"
#import "Categories.h"
#import "NextPetFriendlyPlacesViewController.h"
#import "ProductsViewController.h"


@implementation MainViewController
{
    BOOL clickStatus;
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    [self showCustomeNav];
    [self makeArray];
    [self makeCollectionView];
    [self makeBottomButton];
    clickStatus = NO;
    
}

-(void)searchBtnClick:(UIButton *)sender
{
    self.searchVC = [[SearchViewController alloc]init];
    [self.navigationController pushViewController:self.searchVC animated:YES];
    
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
    
    [UIView animateWithDuration:2.0 animations:^{
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



-(void)makeBottomButton
{
    self.bottomButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.bottomButton setFrame:CGRectMake(0, CGRectGetMaxY(self.collectionView.frame), SCREEN_WIDTH, 70)];
    [self.bottomButton setTitle:@"FREE PET ADVICE" forState:UIControlStateNormal];
    [self.bottomButton setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:self.bottomButton];
}

-(void)makeArray
{
    self.imageArray = [[NSMutableArray alloc]initWithCapacity:0];
    for(NSUInteger i = 0; i < 7; i++)
    {
        [self.imageArray addObject:[NSString stringWithFormat:@"%lu",(unsigned long)i]];
    }
}

#pragma mark collection delegate start
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.imageArray count];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSArray *titleArray = @[@"Photo Fun",@"Pet Friendly Places",@"Stockists",@"Tools",@"Pet Services",@"Tips",@"Products"];
    NSArray *imageNameArray = @[@"tile1-photo-fun.jpg",@"tile2-pet-friendly-places.jpg",@"tile3-stockist.jpg",@"tile4-tools.jpg",@"tile5-pet-service.jpg",@"tile6-tips.jpg",@"tile7-products.jpg"];
    static NSString *iden = @"UICollectionViewCell";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:iden forIndexPath:indexPath];
    if(cell == nil)
    {
        cell = [[UICollectionViewCell alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH/2, (self.residuHeigth - 70)/(self.imageArray.count))];
    }
    UIImageView *backGroundImage = [[UIImageView alloc] initWithFrame:cell.frame];
    backGroundImage.image = [UIImage imageNamed:imageNameArray[indexPath.row]];
    cell.backgroundView = backGroundImage;
    //cell.backgroundColor = [UIColor colorWithRed:((10 * indexPath.row) / 255.0) green:((20 * indexPath.row)/255.0) blue:((30 * indexPath.row)/255.0) alpha:1.0f];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(cell.contentView.center.x - (cell.contentView.frame.size.width / 2.0), cell.contentView.center.y - (cell.contentView.frame.size.height / 2.0) + 30, cell.contentView.frame.size.width, cell.contentView.frame.size.height)];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = [NSString stringWithFormat:@"%@",titleArray[indexPath.row]];
    
    for (id subView in cell.contentView.subviews) {
        [subView removeFromSuperview];
    }
    [cell.contentView addSubview:label];
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(SCREEN_WIDTH/2, (self.residuHeigth - 70)/((self.imageArray.count)/2));
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
        photoFunViewController *photoFunVC =  [[photoFunViewController alloc ] initWithNibName:@"photoFunViewController" bundle:nil];
        //[self presentViewController:photoFunVC animated:YES completion:nil];
        [self.navigationController pushViewController:photoFunVC animated:YES];
    }
    
    else if (indexPath.row == 1) {
        PetFriendlyPlacesViewController *petFriendlyPlacesVC =  [[PetFriendlyPlacesViewController alloc ] init];
        //[self presentViewController:photoFunVC animated:YES completion:nil];
        [self.navigationController pushViewController:petFriendlyPlacesVC animated:YES];
    }
    
    else if (indexPath.row == 2){
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
    
    else if (indexPath.row == 4){
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
    
    else if (indexPath.row == 6) {
        ProductsViewController *photoFunVC =  [[ProductsViewController alloc ] init];
        //[self presentViewController:photoFunVC animated:YES completion:nil];
        [self.navigationController pushViewController:photoFunVC animated:YES];
    }
    DLog(@"%@",indexPath);
}
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
#pragma mark collection delegate end

-(void)makeCollectionView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    [flowLayout setItemSize:CGSizeMake(SCREEN_WIDTH/2, (self.residuHeigth - 70)/((self.imageArray.count)/2))];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,navHeight, SCREEN_WIDTH, self.residuHeigth - 70) collectionViewLayout:flowLayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView setBackgroundColor:[UIColor colorWithRed:242/255.0 green:238/255.0 blue:223/255.0 alpha:1]];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    [self.view addSubview:self.collectionView];
    
}
@end
