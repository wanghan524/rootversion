//
//  ProductSelectorViewController.m
//  PurinaPetPlaces
//
//  Created by BlueApp on 15-6-6.
//
//

#import "ProductSelectorViewController.h"
#import "GrobleSingleton.h"

#import "ProductDetailViewController.h"


#import "ProductsViewController.h"

@interface ProductSelectorViewController ()<UITableViewDataSource,UITableViewDelegate>{
    GrobleSingleton *globleSingleton;
    
}



@property (nonatomic, strong) UITableView *myTableView;

@property (nonatomic, strong) NSMutableArray *contentArray;

@property (nonatomic, strong) UIButton *productButton;

@end

@implementation ProductSelectorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     globleSingleton = [GrobleSingleton sharedGlobleInstance];
    
    if (self.contentArray == nil) {
        self.contentArray = [[NSMutableArray alloc] init];
    }
    
    for (NSDictionary *nowDic in self.displayArray) {
        NSString *productNameString = [nowDic objectForKey:@"product_name"];
        NSArray *productName = [productNameString componentsSeparatedByString:@";"];
        for (NSString *nameString in productName) {
            [self.contentArray addObject:nameString];
        }
    }
    DLog(@"name : %@",self.contentArray);
    
    [self showCustomeNav];
    
    self.view.backgroundColor = [UIColor colorWithRed:242/255.0 green:238/255.0 blue:223/255.0 alpha:1];
    
    if(self.contentArray.count == 0){
        UILabel *displayLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.center.y - 30, self.view.frame.size.width, 60)];
        displayLabel.text = @"No food for your choice";
        displayLabel.font = [UIFont systemFontOfSize:17];
        displayLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:displayLabel];
        
        [self makeBottomButton];
    }else{
//        self.myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStyleGrouped];
//        self.myTableView.backgroundColor = [UIColor colorWithRed:242/255.0 green:238/255.0 blue:223/255.0 alpha:1];
//        self.myTableView.dataSource = self;
//        self.myTableView.delegate = self;
//        [self.view addSubview:self.myTableView];
        
        [self makeArray];
        [self makeCollectionView];
        [self makeBottomButton];
    }
    
    
    // Do any additional setup after loading the view.
}

#pragma mark collection delegate end
-(void)makeCollectionView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    [flowLayout setItemSize:CGSizeMake(SCREEN_WIDTH/2, (SCREEN_HEIGHT - 64 - 70 - 100)/((self.contentArray.count)/2))];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    flowLayout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, 50);
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,64, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 70 - 100) collectionViewLayout:flowLayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    
    [self.collectionView setBackgroundColor:[UIColor colorWithRed:242/255.0 green:238/255.0 blue:223/255.0 alpha:1]];
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView"];
    
    [self.view addSubview:self.collectionView];
    
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
    
    //NSArray *titleArray = @[@"Photo Fun",@"Pet Friendly Places",@"Stockists",@"Tools",@"Pet Services",@"Tips",@"Products"];
    NSArray *imageNameArray = @[@"pro-plan",@"purina-one",@"tux",@"dog-chow",@"mighty-dog",@"beneful",@"beggin"];
    
    
    NSArray *catImageNameArray = @[@"cat-chow",@"cat-fancy-feast",@"cat-friskies",@"cat-one",@"cat-pro-plan",@"cat-treats"];
    static NSString *iden = @"UICollectionViewCell";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:iden forIndexPath:indexPath];
    if(cell == nil)
    {
        cell = [[UICollectionViewCell alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH/2 , (SCREEN_HEIGHT - 64 - 70 - 100)/2.0)];
        cell.contentView.backgroundColor = [UIColor whiteColor];
        
    }
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0,0,SCREEN_WIDTH/2, (SCREEN_HEIGHT - 64 - 70 - 100)/2.0)];
    backView.layer.borderColor = [UIColor grayColor].CGColor;
    backView.layer.borderWidth = 0.3;
    backView.backgroundColor = [UIColor whiteColor];
    UIImageView *backGroundImage = [[UIImageView alloc] initWithFrame:CGRectMake(cell.contentView.center.x - 51, cell.contentView.center.y - 24, 102, 46)];
    
    if ([globleSingleton.globleCategory isEqualToString:@"dog"]) {
        backGroundImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"products-%@.jpg",imageNameArray[indexPath.row]]];
    }else{
        backGroundImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"products-%@.jpg",catImageNameArray[indexPath.row]]];
    }
    
    [backView addSubview:backGroundImage];
    
    //cell.backgroundColor = [UIColor colorWithRed:((10 * indexPath.row) / 255.0) green:((20 * indexPath.row)/255.0) blue:((30 * indexPath.row)/255.0) alpha:1.0f];
    //    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(cell.contentView.center.x - (cell.contentView.frame.size.width / 2.0), cell.contentView.center.y - (cell.contentView.frame.size.height / 2.0) + 30, cell.contentView.frame.size.width, cell.contentView.frame.size.height)];
    //    label.textColor = [UIColor whiteColor];
    //    label.textAlignment = NSTextAlignmentCenter;
    //    label.text = [NSString stringWithFormat:@"%@",titleArray[indexPath.row]];
    
    for (id subView in cell.contentView.subviews) {
        [subView removeFromSuperview];
    }
    [cell.contentView addSubview:backView];
    //[cell.contentView addSubview:label];
    return cell;
}


//头部显示的内容
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView" forIndexPath:indexPath];
    
//    UIImageView * headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
//    headerImageView.image = [UIImage imageNamed:@"products-header.jpg"];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = [NSString stringWithFormat:@"You have %ld matches",(unsigned long)self.imageArray.count];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont fontWithName:@"Antenna" size:22];
    titleLabel.textColor = [UIColor blackColor];
    //[headerImageView addSubview:titleLabel];
    [headerView addSubview:titleLabel];
    
    return headerView;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(SCREEN_WIDTH/2, (SCREEN_HEIGHT - 64 - 70 - 100)/2);
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *imageNameArray = @[@"pro-plan",@"purina-one",@"tux",@"dog-chow",@"mighty-dog",@"beneful",@"beggin"];
    
    NSArray *catImageNameArray = @[@"cat-chow",@"cat-fancy-feast",@"cat-friskies",@"cat-one",@"cat-pro-plan",@"cat-treats"];
    ProductDetailViewController *productDetailVC = [[ProductDetailViewController alloc] init];
    
    if ([globleSingleton.globleCategory isEqualToString:@"dog"]) {
        productDetailVC.animalFlag = imageNameArray[indexPath.row];
    }else{
        productDetailVC.animalFlag = catImageNameArray[indexPath.row];
    }
    
    productDetailVC.num = indexPath.row;
    [self.navigationController pushViewController:productDetailVC animated:YES];
    
    
}

-(void)makeArray
{
    self.imageArray = [[NSMutableArray alloc]initWithCapacity:0];
    if ([globleSingleton.globleCategory isEqualToString:@"dog"]) {
        for(NSUInteger i = 0; i < 7; i++)
        {
            
            
            //[self.imageArray addObject:[NSString stringWithFormat:@"%lu",(unsigned long)i]];
        }
        [self.imageArray addObjectsFromArray:self.contentArray];
    }else{
        for(NSUInteger i = 0; i < 6; i++)
        {
            
            //[self.imageArray addObject:[NSString stringWithFormat:@"%lu",(unsigned long)i]];
        }
        [self.imageArray addObjectsFromArray:self.contentArray];
    }
    
    
}


-(void)makeBottomButton
{
    
    self.productButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.productButton setFrame:CGRectMake(0, SCREEN_HEIGHT - 100 - 70, SCREEN_WIDTH, 95)];
    [self.productButton setTitle:@"ALL PRODUCT" forState:UIControlStateNormal];
    [self.productButton.titleLabel setFont:[UIFont fontWithName:@"Antenna" size:18]];
    [self.productButton addTarget:self action:@selector(productButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.productButton setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:self.productButton];
    
    self.bottomButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.bottomButton setFrame:CGRectMake(0, SCREEN_HEIGHT - 70, SCREEN_WIDTH, 70)];
    [self.bottomButton setTitle:@"START OVER" forState:UIControlStateNormal];
    [self.bottomButton.titleLabel setFont:[UIFont fontWithName:@"Antenna" size:18]];
    [self.bottomButton setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:self.bottomButton];
}

- (void)productButtonClick{
    ProductsViewController *photoFunVC =  [[ProductsViewController alloc ] init];
    //[self presentViewController:photoFunVC animated:YES completion:nil];
    [self.navigationController pushViewController:photoFunVC animated:YES];
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.menusTable) {
        return 44;
    }
    
    return (SCREEN_HEIGHT - 64 - 100 -100 - 70) / 5.0;
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
    return self.contentArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *imageNameArray = @[@"menu-home.jpg",@"menu-dog-pet-places.jpg",@"menu-photo-fun.jpg",@"menu-pet-friendly-places.jpg",@"menu-stockists.jpg",@"menu-tools.jpg",@"menu-pet-service.jpg",@"menu-tips.jpg"];
    
    //    titleArray = [[NSArray alloc] init];
    //
    //    titleArray = @[@"Pet health compass",@"Product selector",@"Body Condition"];
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
            
            cell.textLabel.text = [self.contentArray objectAtIndex:indexPath.row];
            cell.textLabel.numberOfLines = 0;
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
        }
        
        
    }
    
    
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
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
    titleLabel.text = @"Product selector";
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
