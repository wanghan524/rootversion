//
//  ProductsViewController.m
//  PurinaPetPlaces
//
//  Created by BlueApp on 15-4-14.
//
//

#import "ProductsViewController.h"
#import "GrobleSingleton.h"
#import "ProductDetailViewController.h"

@interface ProductsViewController (){
    GrobleSingleton *globelSingle;
}

@end

@implementation ProductsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    globelSingle = [GrobleSingleton sharedGlobleInstance];
    
    [self showCustomeNav];
    [self makeArray];
    [self makeCollectionView];
    [self makeBottomButton];
    
    
    // Do any additional setup after loading the view.
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
    static NSString *iden = @"UICollectionViewCell";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:iden forIndexPath:indexPath];
    if(cell == nil)
    {
        cell = [[UICollectionViewCell alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH/2 , (self.residuHeigth - 70)/((self.imageArray.count)/2.0 ))];
        cell.contentView.backgroundColor = [UIColor whiteColor];
        
    }
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0,0,SCREEN_WIDTH/2, (self.residuHeigth - 70)/((self.imageArray.count)/2.0))];
    backView.layer.borderColor = [UIColor grayColor].CGColor;
    backView.layer.borderWidth = 0.3;
    backView.backgroundColor = [UIColor whiteColor];
    UIImageView *backGroundImage = [[UIImageView alloc] initWithFrame:CGRectMake(cell.contentView.center.x - 51, cell.contentView.center.y - 24, 102, 46)];
    backGroundImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"products-%@.jpg",imageNameArray[indexPath.row]]];
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

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(SCREEN_WIDTH/2, (self.residuHeigth - 70)/((self.imageArray.count)/2.0));
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *imageNameArray = @[@"pro-plan",@"purina-one",@"tux",@"dog-chow",@"mighty-dog",@"beneful",@"beggin"];
    ProductDetailViewController *productDetailVC = [[ProductDetailViewController alloc] init];
    productDetailVC.animalFlag = imageNameArray[indexPath.row];
    productDetailVC.num = indexPath.row;
    [self.navigationController pushViewController:productDetailVC animated:YES];

    
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
