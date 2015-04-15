//
//  photoFunViewController.m
//  PurinaPetPlaces
//
//  Created by BlueApp on 15-4-13.
//
//

#import "photoFunViewController.h"

@interface photoFunViewController ()

@end

@implementation photoFunViewController
{
    BOOL clickStatus;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self makeArray];
    [self showCustomeNav];
    [self makeCollectionView];
    
    clickStatus = NO;
    // Do any additional setup after loading the view from its nib.
}

-(void)makeArray
{
    self.imageArray = [[NSMutableArray alloc]initWithCapacity:0];
    for(NSUInteger i = 0; i < 6; i++)
    {
        [self.imageArray addObject:[NSString stringWithFormat:@"%lu",(unsigned long)i]];
    }
}

#pragma mark collection delegate end

-(void)makeCollectionView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    [flowLayout setItemSize:CGSizeMake(SCREEN_WIDTH/3, (self.residuHeigth - 70)/((self.imageArray.count)/2))];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    //self.toolCollection = [[UICollectionView alloc]initWithFrame:CGRectMake(0,324, SCREEN_WIDTH, 244) collectionViewLayout:flowLayout];
    self.toolCollection.delegate = self;
    self.toolCollection.dataSource = self;
    [self.toolCollection setBackgroundColor:[UIColor clearColor]];
    [self.toolCollection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCellnext"];
    [self.view addSubview:self.toolCollection];
    
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
    
    NSArray *titleArray = @[@"Photo Fun",@"Pet Friendly Places",@"Stockists",@"Tools",@"Pet Services",@"Tips"];
    static NSString *iden = @"UICollectionViewCellnext";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:iden forIndexPath:indexPath];
    if(cell == nil)
    {
        cell = [[UICollectionViewCell alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH/4, (self.residuHeigth - 100)/(self.imageArray.count))];
    }
    cell.backgroundColor = [UIColor colorWithRed:((10 * indexPath.row) / 255.0) green:((20 * indexPath.row)/255.0) blue:((30 * indexPath.row)/255.0) alpha:1.0f];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(cell.contentView.center.x - (cell.contentView.frame.size.width / 2.0), cell.contentView.center.y - (cell.contentView.frame.size.height / 2.0), cell.contentView.frame.size.width, cell.contentView.frame.size.height)];
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
    return CGSizeMake(SCREEN_WIDTH/3.4, (self.residuHeigth - 70)/((self.imageArray.count)/2));
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(3, 5, 3, 5);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    //    if (indexPath.row == 1) {
    //        ToolsViewController *photoFunVC =  [[ToolsViewController alloc ] initWithNibName:@"ToolsViewController" bundle:nil];
    //        [self presentViewController:photoFunVC animated:YES completion:nil];
    //        //[self.navigationController pushViewController:photoFunVC animated:YES];
    //    }
    DLog(@"%@",indexPath);
}
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (IBAction)savedImageBtnClicked:(id)sender {
}

- (IBAction)cameraBtnClicked:(id)sender
{
    
    
    
}







@end
