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

    [self showCustomeNav];
}
-(void)showCustomeNav
{
    self.lineImageView = [[UIImageView alloc]init];
    self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.profileButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.petPlaceImageView = [[UIImageView alloc]init];
    
    
    [self.lineImageView setFrame:CGRectMake(0, startPointY , SCREEN_WIDTH, 5)];
    [self.lineImageView setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:self.lineImageView];
    
    [self.backButton setFrame:CGRectMake(10, CGRectGetMaxY(self.lineImageView.frame) + 5 , 30, 30)];
    [self.backButton setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:self.backButton];
    
    CGPoint point = self.view.center;
    [self.petPlaceImageView setFrame:CGRectMake(point.x - 50, CGRectGetMaxY(self.lineImageView.frame) + 5, 100, 30)];
    
    [self.petPlaceImageView setBackgroundColor:[UIColor blueColor]];
    [self.view addSubview:self.petPlaceImageView];
    
    
    
    [self.searchButton setFrame:CGRectMake(SCREEN_WIDTH - 45 , CGRectGetMaxY(self.lineImageView.frame) + 5 , 30, 30)];
    [self.searchButton setBackgroundColor:[UIColor blackColor]];
    
    [self.view addSubview:self.searchButton];
    
    [self.profileButton setFrame:CGRectMake(CGRectGetMinX(self.searchButton.frame) - 45 , CGRectGetMaxY(self.lineImageView.frame) + 5 , 30, 30)];
    [self.profileButton setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:self.profileButton];
    
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
    
    [UIView animateWithDuration:2.0 animations:^{
        self.darkView = [[UIView alloc]initWithFrame:CGRectMake(0, navHeight, SCREEN_WIDTH, SCREEN_HEIGHT - navHeight)];
        [self.darkView setBackgroundColor:[UIColor colorWithRed:86/255.f green:86/255.f blue:86/255.f alpha:0.7]];
        
        
        [self.view addSubview:self.darkView];
        
        self.menusTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH / 2 + 30, SCREEN_HEIGHT - navHeight) style:UITableViewStylePlain];
        self.menusTable.delegate = self;
        self.menusTable.dataSource = self;
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
    static NSString *iden = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:iden];
    if(nil == cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
    }
    cell.textLabel.text = [self.menuArray objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"cell lable: %@",cell.textLabel.text);
    
}


@end
