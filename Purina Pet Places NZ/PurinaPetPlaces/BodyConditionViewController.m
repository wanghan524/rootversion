//
//  BodyConditionViewController.m
//  PurinaPetPlaces
//
//  Created by BlueApp on 15-6-1.
//
//

#import "BodyConditionViewController.h"
#import "GrobleSingleton.h"
#import "BodyConditionDetailViewController.h"

@interface BodyConditionViewController ()<UITableViewDataSource,UITableViewDelegate>{
    GrobleSingleton *globleSingleton;
    NSArray *titleArray;
    
    
    
    ///动物图片的数组
    NSArray *animalImageArray;
    
    NSArray *nextVCimageArray;
    
}

@property (nonatomic, strong) UITableView *myTableView;
@end

@implementation BodyConditionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    globleSingleton = [GrobleSingleton sharedGlobleInstance];
    
    if (animalImageArray == nil) {
        animalImageArray = [[NSArray alloc] init];
    }
    if(nextVCimageArray == nil)
    {
        nextVCimageArray = [[NSArray alloc]init];
    }
    if ([globleSingleton.globleCategory isEqualToString:@"dog"]) {
        animalImageArray = @[@"dd1",@"dd2",@"dd3",@"dd4",@"dd5"];
        nextVCimageArray = @[@"ddd1",@"ddd2",@"ddd3",@"ddd4",@"ddd5"];
    }else{
        animalImageArray = @[@"dd1",@"dd2",@"dd3",@"dd4",@"dd5"];
        nextVCimageArray = @[@"ddd1",@"ddd2",@"ddd3",@"ddd4",@"ddd5"];
    }
    
    
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
    
    return (SCREEN_HEIGHT - 64 - 100) / 5.0;
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
    return animalImageArray.count;
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
            
            UIImageView *animalImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2.0 -( (SCREEN_HEIGHT - 64 - 100) / 5.0 - 10) / 2.0, 5, (SCREEN_HEIGHT - 64 - 100) / 5.0 - 10, (SCREEN_HEIGHT - 64 - 100) / 5.0 - 10)];
            animalImageView.image = [UIImage imageNamed:animalImageArray[indexPath.row]];
            [cell.contentView addSubview:animalImageView];
            
            
            
            
//            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, (SCREEN_HEIGHT - 64 - 100) / 3.0 / 2.0- 20, cell.frame.size.width, 40)];
//            titleLabel.backgroundColor = [UIColor clearColor];
//            titleLabel.text = titleArray[indexPath.row];
//            titleLabel.textAlignment = NSTextAlignmentCenter;
//            titleLabel.font = [UIFont fontWithName:@"Antenna" size:20];
//            titleLabel.textColor = [UIColor grayColor];
//            [cell.contentView addSubview:titleLabel];
            //
            //        [iconTemplateView setFrame:CGRectMake(8, 8, 33, 33)];
            //        [cell addSubview:iconTemplateView];
           // [cell setIndentationLevel:4];
//            UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, (SCREEN_HEIGHT - 64 - 100) / 5.0)];
//            backView.backgroundColor = [UIColor whiteColor];
//            cell.selectedBackgroundView = backView;
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
    UIImageView * headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
    headerImageView.image = [UIImage imageNamed:@"bodycondition.png"];

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
    
    BodyConditionDetailViewController *bodyConditionDVC = [[BodyConditionDetailViewController alloc] init];
    
    bodyConditionDVC.DisplayTipsCurrent = nextVCimageArray;
    
    bodyConditionDVC.indexNumber = indexPath.row;
    
    [self.navigationController pushViewController:bodyConditionDVC animated:YES];
    
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
