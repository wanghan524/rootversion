//
//  photoFunViewController.m
//  PurinaPetPlaces
//
//  Created by BlueApp on 15-4-13.
//
//

#import "photoFunViewController.h"
#import "editCameraVC.h"
#import "SaveDImageVC.h"

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

    DBHelper *single = [DBHelper sharedInstance];
    self.imageArray = [single browseImageItem];
 
}

#pragma mark collection delegate end

-(void)makeCollectionView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    [flowLayout setItemSize:CGSizeMake(SCREEN_WIDTH/3,SCREEN_WIDTH/3 )];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    //self.toolCollection = [[UICollectionView alloc]initWithFrame:CGRectMake(0,324, SCREEN_WIDTH, 244) collectionViewLayout:flowLayout];
    self.toolCollection.delegate = self;
    self.toolCollection.dataSource = self;
    [self.toolCollection setBackgroundColor:[UIColor colorWithRed:244/255.f green:241/255.f blue:230/255.f alpha:1]];
    [self.toolCollection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCellnext"];
//    [self.view addSubview:self.toolCollection];
    
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
        cell = [[UICollectionViewCell alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH/4, (self.residuHeigth - 100)/(self.imageArray.count))];
    }
    
   
    cell.backgroundColor = [UIColor colorWithRed:((10 * indexPath.row) / 255.0) green:((20 * indexPath.row)/255.0) blue:((30 * indexPath.row)/255.0) alpha:1.0f];
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
    return CGSizeMake(SCREEN_WIDTH/3.4, SCREEN_WIDTH/3);
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

/*
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
    cell.textLabel.font = [UIFont fontWithName:@"Antenna" size:10];
    cell.textLabel.text = [self.menuArray objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"cell lable: %@",cell.textLabel.text);
    
}
*/

-(void)viewWillAppear:(BOOL)animated
{
    self.imageArray = [[DBHelper sharedInstance]browseImageItem];
    [self.toolCollection reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (IBAction)savedImageBtnClicked:(id)sender {
    SaveDImageVC *save = [[SaveDImageVC alloc]init];
    [self.navigationController pushViewController:save animated:YES];
}

- (IBAction)cameraBtnClicked:(id)sender
{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
    
    if([UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera])
    {
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    }else
    {
        imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    
    [self presentViewController:imagePickerController animated:YES completion:nil];
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    NSString *imagePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"dogOrcatImage/"];
    NSFileManager *files = [NSFileManager defaultManager];
    if(![files fileExistsAtPath:imagePath])
    {
        [files createDirectoryAtPath:imagePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    ImageItem *model = [[ImageItem alloc]init];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    model.dateTimes = [dateFormatter stringFromDate:[NSDate date]];
    model.path = [imagePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",model.dateTimes]];
    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
    [imageData writeToFile:model.path atomically:YES];
    
    DBHelper *db = [DBHelper sharedInstance];
    if([db insertImageItem:model])
    {
//        [self makeArray];
//        [self.toolCollection reloadData];
        
    }
    
    
    
}





-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}





@end
