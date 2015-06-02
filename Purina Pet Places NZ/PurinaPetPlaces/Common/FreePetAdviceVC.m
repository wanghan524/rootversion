//
//  FreePetAdviceVC.m
//  PurinaPetPlaces
//
//  Created by 菁优数学 on 15/6/2.
//
//

#import "FreePetAdviceVC.h"

@interface FreePetAdviceVC ()
@property(nonatomic,strong)UIImageView *petImg;
@property (nonatomic, strong) UITableView *myTableView;
@end


@implementation FreePetAdviceVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self showCustomeNav];
    
    self.view.backgroundColor = [UIColor colorWithRed:242/255.0 green:238/255.0 blue:223/255.0 alpha:1];
    [self makeTable];

}


-(void)makeTable
{
    self.myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStyleGrouped];
    self.myTableView.backgroundColor = [UIColor colorWithRed:242/255.0 green:238/255.0 blue:223/255.0 alpha:1];
    self.myTableView.dataSource = self;
    self.myTableView.delegate = self;
    [self.view addSubview:self.myTableView];

}
#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.menusTable) {
        return 44;
    }
    switch (indexPath.row) {
        case 0:
        {
        }
        case 1:
        {
            
        }
        case 2:
        {
            return 72/2.0f+10;
            break;
            
        }
        case 3:
        {
            return 138/2.0f+30;
            break;
        }
        default:
            break;
    }
    return 50;
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
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *imageNameArray = @[@"menu-home.jpg",@"menu-dog-pet-places.jpg",@"menu-photo-fun.jpg",@"menu-pet-friendly-places.jpg",@"menu-stockists.jpg",@"menu-tools.jpg",@"menu-pet-service.jpg",@"menu-tips.jpg"];
    
    NSArray *btnArray = @[@"visit.png",@"email.png",@"www.png",@"call.png"];
    
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
        
        if (tableView == self.myTableView)
        {
            CGFloat heightTmp = 0.0f;
            CGFloat widthTmp = 0.0f;
            switch (indexPath.row) {
                case 0:
                {
                    widthTmp = 231/2.0f;
                    heightTmp = 72/2.0f;
                    break;
                }
                case 1:
                {
                    widthTmp = 334/2.0f;
                    heightTmp = 72/2.0f;
                    break;
                }
                case 2:
                {
                    heightTmp = 72/2.0f;
                    widthTmp = 385/2.0f;
                    break;
                    
                }
                case 3:
                {
                    heightTmp = 138/2.0f;
                    widthTmp = 431/2.0f;
                    break;
                }
                default:
                    break;
            }

            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            
            btn.frame = CGRectMake((SCREEN_WIDTH - widthTmp)/2.0f, 3, widthTmp, heightTmp);
            [btn setBackgroundImage:[UIImage imageNamed:btnArray[indexPath.row]] forState:UIControlStateNormal];
            btn.tag = indexPath.row;
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:btn];
    
        }
    }
    
    
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    //[cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    
    return cell;
}


-(void)btnClick:(UIButton *)sender
{
    switch (sender.tag) {
        case 0:
        {
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"http://www.purina.co.nz"]];
            break;
        }
        case 1:
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mailto://askpurina@nz.nestle.com"]];
            
            break;
        }
        case 2:
        {
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"http://www.facebook.com/purinanz"]];
            break;
        }
        case 3:
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://0800738847"]];
            break;
        }
        default:
            break;
    }

}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView == self.menusTable) {
        return 1;
    }
    return 962/2.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView == self.menusTable) {
        return nil;
    }
    UIImageView * headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 962/2.f)];
    headerImageView.image = [UIImage imageNamed:@"freepetadvice.png"];
    
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
    else
    {
        switch (indexPath.row) {
            case 0:
            {
                [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"http://www.purina.co.nz"]];
                break;
            }
            case 1:
            {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mailto://askpurina@nz.nestle.com"]];
                
                break;
            }
            case 2:
            {
                [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"http://www.facebook.com/purinanz"]];
                break;
            }
            case 3:
            {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://0800738847"]];
                break;
            }
            default:
                break;
        }
    }
    
    
    
    
    
    
    
}



@end
