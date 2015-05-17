//
//  EnterMianViewController.m
//  PetPlaces
//
//  Created by BlueApp on 15-4-12.
//  Copyright (c) 2015年 art_kernel_zyc. All rights reserved.
//

#import "EnterMianViewController.h"
#import "MainViewController.h"
#import "GrobleSingleton.h"
#import "EditViewController.h"
#import "DBHelper.h"

typedef NS_ENUM(NSUInteger, OPETIONDBTYPE)
{
    OpetiondbInsert,
    OpetiondbUpdate
};
@interface EnterMianViewController (){
    GrobleSingleton *globeSingle;
}
@property(nonatomic,strong)UIView *darkView;
@property(nonatomic,assign)OPETIONDBTYPE typeI;
@property(nonatomic,strong)PetItem *pet;
@property(nonatomic,strong)NSMutableArray *petModelArr;

@end

@implementation EnterMianViewController

-(void)viewWillAppear:(BOOL)animated
{
    globeSingle = [GrobleSingleton sharedGlobleInstance];
    NSArray *currentArray = @[@"Cassius",@"Miffy",@"Jazz"];
    self.petModelArr = [[DBHelper sharedInstance]browsePetItem];
    if([self.petModelArr count] <= 2)
    {
        [self.petModelArr removeAllObjects];
        PetItem *mode1 = [[PetItem alloc]init];
        mode1.name = currentArray[0];
        mode1.dateTimes = @"2015-05-10 03:42:21";
        mode1.breed = @"apple";
        
        PetItem *mode2 = [[PetItem alloc]init];
        mode2.name = currentArray[1];
        mode2.dateTimes = @"2015-05-10 03:42:21";
        mode2.breed = @"bread";
        
        PetItem *mode3 = [[PetItem alloc]init];
        mode3.name = currentArray[2];
        mode3.dateTimes = @"2015-05-10 03:42:21";
        mode3.breed = @"app";
        [self.petModelArr addObject:mode1];
        [self.petModelArr addObject:mode2];
        [self.petModelArr addObject:mode3];
        
    }
    globeSingle.animalArray = self.petModelArr;
    PetItem *one  = self.petModelArr[0];
    self.one.text = one.name;
    PetItem *two = self.petModelArr[1];
    self.two.text = two.name;
    
    PetItem *three = self.petModelArr[2];
    self.three.text = three.name;
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    globeSingle = [GrobleSingleton sharedGlobleInstance];
    NSArray *currentArray = @[@"Cassius",@"Miffy",@"Jazz"];
    
    self.typeI = OpetiondbInsert;
    self.petModelArr = [[DBHelper sharedInstance]browsePetItem];
    if([self.petModelArr count] <= 2)
    {
        [self.petModelArr removeAllObjects];
        PetItem *mode1 = [[PetItem alloc]init];
        mode1.name = currentArray[0];
        mode1.dateTimes = @"2015-05-10 03:42:21";
        mode1.breed = @"apple";
        
        PetItem *mode2 = [[PetItem alloc]init];
        mode2.name = currentArray[1];
        mode2.dateTimes = @"2015-05-10 03:42:21";
        mode2.breed = @"bread";
        
        PetItem *mode3 = [[PetItem alloc]init];
        mode3.name = currentArray[2];
        mode3.dateTimes = @"2015-05-10 03:42:21";
        mode3.breed = @"app";
        [self.petModelArr addObject:mode1];
        [self.petModelArr addObject:mode2];
        [self.petModelArr addObject:mode3];
        
    }
    globeSingle.animalArray = self.petModelArr;
    PetItem *one  = self.petModelArr[0];
    self.one.text = one.name;
    PetItem *two = self.petModelArr[1];
    self.two.text = two.name;
    
    PetItem *three = self.petModelArr[2];
    self.three.text = three.name;
    
}


-(void)makeDarkView
{
    self.darkView = [[UIView alloc]initWithFrame:self.view.bounds];
    [self.darkView setBackgroundColor:[UIColor colorWithRed:86/255.f green:86/255.f blue:86/255.f alpha:0.7]];
    [self.view addSubview:self.darkView];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)makePop
{
    self.pop = (PopView *)[[[NSBundle mainBundle]loadNibNamed:@"PopView" owner:self options:nil]lastObject];
    [self.pop setFrame:CGRectMake((SCREEN_WIDTH - 300)/2, (SCREEN_HEIGHT - 390)/2, 300, 390)];
    self.pop.delegate = self;
    if(self.darkView == nil)
    {
        [self makeDarkView];
    }
    
    [self.darkView addSubview:self.pop];
}

-(void)dismissDarkView
{
    
    NSLog(@"pop : %@  %@  %@",self.pop.name.text,self.pop.dateTimes.text,self.pop.breed.text);
    if(self.darkView != nil)
    {
        [self.darkView removeFromSuperview];
        self.darkView = nil;
    }
    if(self.typeI == OpetiondbInsert)
    {
        PetItem *model =[[PetItem alloc]init];
        model.name = self.pop.name.text?self.pop.name.text:@"";
        model.dateTimes = self.pop.dateTimes.text?self.pop.dateTimes.text:@"";
        model.breed = self.pop.breed.text?self.pop.breed.text:@"";
        DBHelper *help = [DBHelper sharedInstance];
        if([help insertPetItem:model] == YES)
        {
            DLog(@"insert ok;");
        }
        else
        {
            DLog(@"error");
        }
    }
    else
    {
        DBHelper *help = [DBHelper sharedInstance];
        if([help updatePetItem:self.pet])
        {
            DLog(@"update ok;");
        }
        else
        {
            DLog(@"error");
        }
    }
//    EditViewController *edit = [[EditViewController alloc]initWithNibName:@"EditViewController" bundle:nil];
//    [self presentViewController:edit animated:YES completion:nil];
    

}

- (IBAction)petAddBtnClick:(id)sender
{
    [self makePop];
    self.typeI = OpetiondbInsert;
    
}

- (IBAction)petOneBtnClick:(id)sender {
    [self makePop];
    self.typeI = OpetiondbUpdate;
    self.pet = self.petModelArr[0];
    self.pop.name.text = self.pet.name;
    self.pop.dateTimes.text = self.pet.dateTimes;
    self.pop.breed.text = self.pet.breed;
    
}

- (IBAction)petTwoBtnClick:(id)sender {
    [self makePop];
    self.typeI = OpetiondbUpdate;
    self.pet = self.petModelArr[1];
    self.pop.name.text = self.pet.name;
    self.pop.dateTimes.text = self.pet.dateTimes;
    self.pop.breed.text = self.pet.breed;
}

- (IBAction)petThreeBtnClick:(id)sender {
    [self makePop];
    
    self.typeI = OpetiondbUpdate;
    self.pet = self.petModelArr[2];
    self.pop.name.text = self.pet.name;
    self.pop.dateTimes.text = self.pet.dateTimes;
    self.pop.breed.text = self.pet.breed;
}

- (IBAction)dogBtnClick:(id)sender
{
    
    globeSingle.globleCategory = @"dog";
    MainViewController *main = [[MainViewController alloc]init];

    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:main];
    [self presentViewController:nav animated:YES completion:nil];
    //[self.navigationController pushViewController:nav animated:YES];

    
}

- (IBAction)catBtnClick:(id)sender
{
    
    globeSingle.globleCategory = @"cat";
    MainViewController *main = [[MainViewController alloc]init];
    
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:main];
    [self presentViewController:nav animated:YES completion:nil];
    //[self.navigationController pushViewController:nav animated:YES];
 }


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
@end
