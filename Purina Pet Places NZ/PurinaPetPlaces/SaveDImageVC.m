//
//  SaveDImageVC.m
//  PurinaPetPlaces
//
//  Created by 菁优数学 on 15/5/26.
//
//

#import "SaveDImageVC.h"


@interface SaveDImageVC ()

@end

@implementation SaveDImageVC
{
    BOOL clickStatus;
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    [self makeArray];
    [self showCustomeNav];
    [self makeCollectionView];
    
    clickStatus = NO;
    
}

-(void)makeArray
{
    
    DBHelper *single = [DBHelper sharedInstance];
    self.imageArray = [single browseImageItem];
    
}

-(void)makeCollectionView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    [flowLayout setItemSize:CGSizeMake(SCREEN_WIDTH/3.5,SCREEN_WIDTH/3.5 )];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 5, 10, 5);
    flowLayout.minimumInteritemSpacing = 5;
    flowLayout.minimumLineSpacing = 5;
    self.picCollection = [[UICollectionView alloc]initWithFrame:CGRectMake(0,64, SCREEN_WIDTH,SCREEN_HEIGHT-64) collectionViewLayout:flowLayout];
    self.picCollection.delegate = self;
    self.picCollection.dataSource = self;
    [self.picCollection setBackgroundColor:[UIColor colorWithRed:244/255.f green:241/255.f blue:230/255.f alpha:1]];
    [self.picCollection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCellnext"];
        [self.view addSubview:self.picCollection];
    
}

#pragma mark collection delegate start
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.imageArray count]>0?[self.imageArray count]:0;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *iden = @"UICollectionViewCellnext";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:iden forIndexPath:indexPath];
    if(cell == nil)
    {
        cell = [[UICollectionViewCell alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH/4, (self.residuHeigth - 110)/(self.imageArray.count))];
    }
    
    
//    cell.backgroundColor = [UIColor colorWithRed:((10 * indexPath.row) / 255.0) green:((20 * indexPath.row)/255.0) blue:((30 * indexPath.row)/255.0) alpha:1.0f];
    UIImageView  *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(cell.contentView.center.x - (cell.contentView.frame.size.width / 2.0), cell.contentView.center.y - (cell.contentView.frame.size.height / 2.0), cell.contentView.frame.size.width, cell.contentView.frame.size.height)];
    if([self.imageArray count] > 0)
    {
        ImageItem *model = [self.imageArray objectAtIndex:indexPath.row];
        
        NSURL *docsUrl = [[[NSFileManager defaultManager]URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask]lastObject];
        NSString *resultStr = [[docsUrl path]stringByAppendingPathComponent:[NSString stringWithFormat:@"dogOrcatImage/%@",[model.path lastPathComponent]]];
        
        UIImage *image =  [UIImage imageWithContentsOfFile:resultStr];
        imageView.image = image;
        
    }
    
    [cell.contentView addSubview:imageView];
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(SCREEN_WIDTH/3.5, SCREEN_WIDTH/3.5);
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
    if([self.imageArray count]> 0)
    {
        DBHelper *help = [DBHelper sharedInstance];
        
        ImageItem *item = [self.imageArray objectAtIndex:indexPath.row];
        help.iimm = item;
        
        editCameraVC *vc = [[editCameraVC alloc]init];
        vc.model = item;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
}
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}




@end
