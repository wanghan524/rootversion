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
@interface EnterMianViewController ()<UIImagePickerControllerDelegate>{
    GrobleSingleton *globeSingle;
    UIDatePicker *_datePicker;
    UIView *backView;
    BOOL loadingFlag;
}
@property(nonatomic,strong)UIView *darkView;
@property(nonatomic,assign)OPETIONDBTYPE typeI;
@property(nonatomic,strong)PetItem *pet;
@property(nonatomic,strong)NSMutableArray *petModelArr;

@property(nonatomic,strong)UILabel *pet4;
@property(nonatomic,strong)UILabel *four;


@property(nonatomic,strong)UILabel *pet5;
@property(nonatomic,strong)UILabel *five;

@end

@implementation EnterMianViewController

-(void)viewWillAppear:(BOOL)animated
{
    
    [self displayPetNumber];
#if 0
    globeSingle = [GrobleSingleton sharedGlobleInstance];
    NSArray *currentArray = @[@"Cassius",@"Miffy",@"Jazz"];
    self.petModelArr = [[DBHelper sharedInstance]browsePetItem];
    if([self.petModelArr count] == 0)
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
#endif

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"heightimage : %lf  dogHeight : %lf  pet3.height : %lf  dictance : %lf  ",self.headerImage.frame.origin.y + self.headerImage.frame.size.height ,self.dogButton.frame.origin.y,self.edit3.frame.origin.y + self.edit3.frame.size.height + self.petView.frame.origin.y, self.edit3.frame.origin.y - self.edit2.frame.origin.y - self.edit2.frame.size.height);
    [self displayPetNumber];
    
#if 0
    globeSingle = [GrobleSingleton sharedGlobleInstance];
    NSArray *currentArray = @[@"Cassius",@"Miffy",@"Jazz"];
    
    self.typeI = OpetiondbInsert;
    self.petModelArr = [[DBHelper sharedInstance]browsePetItem];
    
    if (self.petModelArr.count >= 5) {
        [self.addBtn removeFromSuperview];
        self.addBtn = nil;
    }
    
//    for (PetItem * pet in self.petModelArr) {
//        NSLog(@"name : %@  dataTimes : %@   breed : %@",pet.name,pet.dateTimes,pet.breed);
//    }
    if([self.petModelArr count] == 0)
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
    
    
    if (self.petModelArr.count > 0 && self.petModelArr.count <= 3) {
        for (int i = 0; i < self.petModelArr.count; i++) {
            PetItem * petItem = self.petModelArr[i];
            if (self.petModelArr.count == 1) {
                self.one.text = petItem.name;
                [self.pet2 removeFromSuperview];
                self.pet2 = nil;
                
                [self.pet3 removeFromSuperview];
                self.pet3 = nil;
            }
            
            if (self.petModelArr.count == 2) {
                
                if (i == 0) {
                    self.one.text = petItem.name;
                }
                if (i == 1) {
                    self.two.text = petItem.name;
                }
                [self.pet3 removeFromSuperview];
                self.pet3 = nil;
            }
            
            if (self.petModelArr.count == 3) {
                
                if (i == 0) {
                    self.one.text = petItem.name;
                }
                if (i == 1) {
                    self.two.text = petItem.name;
                }
                if (i == 2) {
                    self.three.text = petItem.name;
                }
                
            }
            
        }
    }else{
        
        
        for (int i = 0; i < self.petModelArr.count; i++) {
            PetItem * petItem = self.petModelArr[i];
            
            if (self.petModelArr.count == 4) {
                
                if (0 == i) {
                    self.one.text = petItem.name;
                }
                else if (1 == i){
                    self.two.text = petItem.name;
                }
                else if (2 == i){
                    self.three.text = petItem.name;
                }
                else if (3 == i){
                    self.pet4 = [[UILabel alloc] initWithFrame:CGRectMake(self.pet3.frame.origin.x, self.pet3.frame.origin.y + self.pet3.frame.size.height + (self.pet3.frame.origin.y - (self.pet2.frame.origin.y + self.pet2.frame.size.height)), self.pet3.frame.size.width, self.pet3.frame.size.height)];
                    self.pet4.text = @"Pet 4";
                    self.pet4.textAlignment = NSTextAlignmentLeft;
                    self.pet4.font = [UIFont fontWithName:@"Antenna-ExtraLight" size:19];
                    [self.petView addSubview:self.pet4];
                    
                    self.four = [[UILabel alloc] initWithFrame:CGRectMake(self.three.frame.origin.x, self.three.frame.origin.y + self.three.frame.size.height - (self.three.frame.origin.y - (self.two.frame.origin.y + self.two.frame.size.height)), self.three.frame.size.width, self.three.frame.size.height)];
                    self.four.font = [UIFont fontWithName:@"Antenna-Regular" size:16];
                    self.four.textAlignment = NSTextAlignmentLeft;
                    self.four.text = petItem.name;
                    [self.petView addSubview:self.four];
                    
                    
                    UIButton *editButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                    editButton.frame = CGRectMake(self.edit3.frame.origin.x, self.edit3.frame.origin.y + self.edit3.frame.size.height - (self.edit3.frame.origin.y - (self.edit2.frame.origin.y + self.edit2.frame.size.height)), self.edit3.frame.size.width, self.edit3.frame.size.height);
                    editButton.backgroundColor = [UIColor redColor];
                    [editButton setTitle:@"EDIT" forState:UIControlStateNormal];
                    [editButton addTarget:self action:@selector(editBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
                    editButton.tag = 13;
                    [self.petView addSubview:editButton];
                }
                
                
            }
            else if (self.petModelArr.count == 5){
                if (0 == i) {
                    self.one.text = petItem.name;
                }
                else if (1 == i){
                    self.two.text = petItem.name;
                }
                else if (2 == i){
                    self.three.text = petItem.name;
                }
                else if (3 == i){
                    self.pet4 = [[UILabel alloc] initWithFrame:CGRectMake(self.pet3.frame.origin.x, self.pet3.frame.origin.y + self.pet3.frame.size.height + (self.pet3.frame.origin.y - (self.pet2.frame.origin.y + self.pet2.frame.size.height)), self.pet3.frame.size.width, self.pet3.frame.size.height)];
                    self.pet4.text = @"Pet 4";
                    self.pet4.textAlignment = NSTextAlignmentLeft;
                    self.pet4.font = [UIFont fontWithName:@"Antenna-ExtraLight" size:19];
                    [self.petView addSubview:self.pet4];
                    
                    self.four = [[UILabel alloc] initWithFrame:CGRectMake(self.three.frame.origin.x, self.three.frame.origin.y + self.three.frame.size.height + (self.three.frame.origin.y - (self.two.frame.origin.y + self.two.frame.size.height)), self.three.frame.size.width, self.three.frame.size.height)];
                    self.four.font = [UIFont fontWithName:@"Antenna-Regular" size:16];
                    self.four.textAlignment = NSTextAlignmentLeft;
                    self.four.text = petItem.name;
                    [self.petView addSubview:self.four];
                    
                    
                    UIButton *editButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                    editButton.frame = CGRectMake(self.edit3.frame.origin.x, self.edit3.frame.origin.y + self.edit3.frame.size.height + (self.edit3.frame.origin.y - (self.edit2.frame.origin.y + self.edit2.frame.size.height)), self.edit3.frame.size.width, self.edit3.frame.size.height);
                    editButton.backgroundColor = [UIColor redColor];
                    [editButton setTitle:@"EDIT" forState:UIControlStateNormal];
                
                    [editButton addTarget:self action:@selector(editBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
                    editButton.tag = 13;
                    [self.petView addSubview:editButton];
                }
                else if (4 == i){
                    self.pet5 = [[UILabel alloc] initWithFrame:CGRectMake(self.pet3.frame.origin.x, self.pet3.frame.origin.y + self.pet3.frame.size.height + (self.pet3.frame.origin.y - (self.pet2.frame.origin.y + self.pet2.frame.size.height)) * 2 + self.pet3.frame.size.height, self.pet3.frame.size.width, self.pet3.frame.size.height)];
                    self.pet5.text = @"Pet 5";
                    self.pet5.textAlignment = NSTextAlignmentLeft;
                    self.pet5.font = [UIFont fontWithName:@"Antenna-ExtraLight" size:19];
                    [self.petView addSubview:self.pet5];
                    
                    self.five = [[UILabel alloc] initWithFrame:CGRectMake(self.three.frame.origin.x, self.three.frame.origin.y + self.three.frame.size.height + (self.three.frame.origin.y - (self.two.frame.origin.y + self.two.frame.size.height)) * 2 + self.three.frame.size.height , self.three.frame.size.width, self.three.frame.size.height)];
                    self.five.font = [UIFont fontWithName:@"Antenna-Regular" size:16];
                    self.five.textAlignment = NSTextAlignmentLeft;
                    self.five.text = petItem.name;
                    [self.petView addSubview:self.five];
                    
                    
                    UIButton *editButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                    editButton.frame = CGRectMake(self.edit3.frame.origin.x, self.edit3.frame.origin.y + self.edit3.frame.size.height + (self.edit3.frame.origin.y - (self.edit2.frame.origin.y + self.edit2.frame.size.height)) * 2 + self.edit3.frame.size.height, self.edit3.frame.size.width, self.edit3.frame.size.height);
                    editButton.backgroundColor = [UIColor redColor];
                    [editButton setTitle:@"EDIT" forState:UIControlStateNormal];
                    [editButton addTarget:self action:@selector(editBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
                    editButton.tag = 14;
                    [self.petView addSubview:editButton];
                }

            }
            
            
            
        }
        
    
    }
#endif
//    PetItem *one  = self.petModelArr[0];
//    self.one.text = one.name;
//    PetItem *two = self.petModelArr[1];
//    self.two.text = two.name;
//    
//    PetItem *three = self.petModelArr[2];
//    self.three.text = three.name;
    
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
    self.pop.name.delegate = self;
    self.pop.dateTimes.delegate = self;
    self.pop.breed.delegate = self;
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
            [self displayPetNumber];
            DLog(@"insert ok;");
        }
        else
        {
            DLog(@"error");
        }
    }
    else
    {
        self.pet.name = self.pop.name.text;
        self.pet.dateTimes = self.pop.dateTimes.text;
        self.pet.breed = self.pop.breed.text;
        DBHelper *help = [DBHelper sharedInstance];
        if([help updatePetItem:self.pet])
        {
            
            self.petModelArr = [[DBHelper sharedInstance]browsePetItem];
            for (int i = 0; i < self.petModelArr.count; i++) {
                PetItem * petItem = self.petModelArr[i];
                if (i == 0) {
                    self.one.text = petItem.name;
                }
                else if (i == 1){
                    self.two.text = petItem.name;
                }
                else if (i == 2){
                    self.three.text = petItem.name;
                }
                else if (i == 3){
                    self.four.text = petItem.name;
                }
                else if (i == 4){
                    self.five.text = petItem.name;
                }
            }
//            PetItem *one  = self.petModelArr[0];
//            self.one.text = one.name;
//            PetItem *two = self.petModelArr[1];
//            self.two.text = two.name;
//            
//            PetItem *three = self.petModelArr[2];
//            self.three.text = three.name;
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

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
   
    if(textField.tag == 11){
        
         //[self.view endEditing:YES];
        [textField resignFirstResponder];
        if(!loadingFlag)
        {
            loadingFlag = YES;
            backView = [[UIView alloc] initWithFrame:CGRectMake(0, (320/(float)568) *self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - (320/(float)568) *self.view.frame.size.height)];
            backView.backgroundColor = [UIColor lightGrayColor];
            [self.view addSubview:backView];
            UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            rightButton.frame = CGRectMake(250, 0, 40, 30);
            [rightButton setTitle:@"确定" forState:UIControlStateNormal];
            [rightButton addTarget:self action:@selector(dateRightButtonClicked) forControlEvents:UIControlEventTouchUpInside];
            [backView addSubview:rightButton];
            
            UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            leftButton.frame = CGRectMake(30, 0, 40, 30);
            [leftButton setTitle:@"取消" forState:UIControlStateNormal];
            [leftButton addTarget:self action:@selector(dateLeftButtonClicked) forControlEvents:UIControlEventTouchUpInside];
            [backView addSubview:leftButton];
            
            _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, (30/(float)568 )* self.view.frame.size.height, self.view.frame.size.width, (80 / (float)568) * self.view.frame.size.height)];
            NSDate *now = [[NSDate alloc] init];
            [_datePicker setDate:now animated:YES];
            _datePicker.datePickerMode = UIDatePickerModeDate;
            [backView addSubview:_datePicker];
            
            
            
        }
        

    }
    NSLog(@"textField.tag : %d",textField.tag);
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.tag == 10) {
        [textField resignFirstResponder];
    }
}
#pragma mark - 日期选择器的确定方法
-(void)dateRightButtonClicked{
    loadingFlag = NO;
    NSDate *selected = [_datePicker date];
    NSString *date = [[NSString alloc] initWithFormat:@"%@",selected];
    NSString *selectTime = [date substringToIndex:10];
    
    NSArray *dataArray = [selectTime componentsSeparatedByString:@"-"];
    
    NSString *finalString = [NSString stringWithFormat:@"%@/%@/%@",dataArray[dataArray.count-1],dataArray[dataArray.count - 2],dataArray[dataArray.count - 3]];
    //placeLabel.text = selectTime;
    self.pop.dateTimes.text = finalString;
    
    [backView removeFromSuperview];
    NSLog(@"%@",selectTime);
}

#pragma mark - 日期选择器的取消方法
-(void)dateLeftButtonClicked{
    
    loadingFlag = NO;
    [backView removeFromSuperview];
    
    
    
}


#pragma mark - 每一个edit按钮的点击方法
- (void)editBtnClicked:(UIButton *)btn{
    [self makePop];
    
    self.typeI = OpetiondbUpdate;
    self.pet = self.petModelArr[btn.tag - 10];
    self.pop.name.text = self.pet.name;
    self.pop.dateTimes.text = self.pet.dateTimes;
    self.pop.breed.text = self.pet.breed;
}

#pragma mark - 根据添加的pet显示

- (void)displayPetNumber{
    globeSingle = [GrobleSingleton sharedGlobleInstance];
    NSArray *currentArray = @[@"Cassius",@"Miffy",@"Jazz"];
    
    self.typeI = OpetiondbInsert;
    self.petModelArr = [[DBHelper sharedInstance]browsePetItem];
    
    if (self.petModelArr.count >= 5) {
        [self.addBtn removeFromSuperview];
        self.addBtn = nil;
    }
    
    //    for (PetItem * pet in self.petModelArr) {
    //        NSLog(@"name : %@  dataTimes : %@   breed : %@",pet.name,pet.dateTimes,pet.breed);
    //    }
    if([self.petModelArr count] == 0)
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
    
    
    if (self.petModelArr.count > 0 && self.petModelArr.count <= 3) {
        for (int i = 0; i < self.petModelArr.count; i++) {
            PetItem * petItem = self.petModelArr[i];
            if (self.petModelArr.count == 1) {
                self.one.text = petItem.name;
                
                self.two.hidden = YES;
                self.edit2.hidden = YES;
                self.pet2.hidden = YES;
                
                self.three.hidden = YES;
                self.edit3.hidden = YES;
                self.pet3.hidden = YES;
                
#if 0
                [self.two removeFromSuperview];
                self.two = nil;
                [self.edit2 removeFromSuperview];
                self.edit2 = nil;
                [self.pet2 removeFromSuperview];
                self.pet2 = nil;
                
                [self.three removeFromSuperview];
                self.three = nil;
                [self.edit3 removeFromSuperview];
                self.edit3 = nil;
                [self.pet3 removeFromSuperview];
                self.pet3 = nil;
#endif
            }
            
            if (self.petModelArr.count == 2) {
                
                if (i == 0) {
                    self.one.text = petItem.name;
                }
                if (i == 1) {
                    self.two.hidden = NO;
                    self.edit2.hidden = NO;
                    self.pet2.hidden = NO;
                    self.two.text = petItem.name;
                }
                self.three.hidden = YES;
                self.edit3.hidden = YES;
                self.pet3.hidden = YES;
                
#if 0
                [self.pet3 removeFromSuperview];
                self.pet3 = nil;
                [self.edit3 removeFromSuperview];
                self.edit3 = nil;
                [self.three removeFromSuperview];
                self.three = nil;
#endif
            }
            
            if (self.petModelArr.count == 3) {
                
                if (i == 0) {
                    self.one.text = petItem.name;
                }
                if (i == 1) {
                    self.two.hidden = NO;
                    self.edit2.hidden = NO;
                    self.pet2.hidden = NO;
                    self.two.text = petItem.name;
                }
                if (i == 2) {
                    self.three.hidden = NO;
                    self.edit3.hidden = NO;
                    self.pet3.hidden = NO;
                    self.three.text = petItem.name;
                }
                
            }
            
        }
    }else{
        
        
        for (int i = 0; i < self.petModelArr.count; i++) {
            PetItem * petItem = self.petModelArr[i];
            
            if (self.petModelArr.count == 4) {
                
                
                //self.addBtn.frame = CGRectMake(self.edit3.frame.origin.x, self.edit3.frame.origin.y + self.edit3.frame.size.height + (self.edit3.frame.origin.y - (self.edit2.frame.origin.y + self.edit2.frame.size.height)) * 2 + self.edit3.frame.size.height, self.edit3.frame.size.width, self.edit3.frame.size.height);
                if (0 == i) {
                    
                    self.one.text = petItem.name;
                }
                else if (1 == i){
                    self.two.hidden = NO;
                    self.edit2.hidden = NO;
                    self.pet2.hidden = NO;
                    self.two.text = petItem.name;
                }
                else if (2 == i){
                    self.three.hidden = NO;
                    self.edit3.hidden = NO;
                    self.pet3.hidden = NO;
                    self.three.text = petItem.name;
                }
                else if (3 == i){
                    self.pet4 = [[UILabel alloc] initWithFrame:CGRectMake(self.pet3.frame.origin.x, self.pet3.frame.origin.y + self.pet3.frame.size.height + (self.pet3.frame.origin.y - (self.pet2.frame.origin.y + self.pet2.frame.size.height)), self.pet3.frame.size.width, self.pet3.frame.size.height)];
                    self.pet4.text = @"Pet 4";
                    self.pet4.textAlignment = NSTextAlignmentLeft;
                    self.pet4.font = [UIFont fontWithName:@"Antenna-ExtraLight" size:19];
                    [self.petView addSubview:self.pet4];
                    
                    self.four = [[UILabel alloc] initWithFrame:CGRectMake(self.three.frame.origin.x, self.three.frame.origin.y + self.three.frame.size.height + (self.three.frame.origin.y - (self.two.frame.origin.y + self.two.frame.size.height)), self.three.frame.size.width, self.three.frame.size.height)];
                    self.four.textColor = [UIColor colorWithRed:128/255.0 green:128/255.0 blue:128/255.0 alpha:1];
                    self.four.backgroundColor = [UIColor whiteColor];
                    self.four.font = [UIFont fontWithName:@"Antenna-Regular" size:16];
                    self.four.textAlignment = NSTextAlignmentLeft;
                    self.four.text = petItem.name;
                    [self.petView addSubview:self.four];
                    
                    
                    self.edit4= [UIButton buttonWithType:UIButtonTypeRoundedRect];
                    self.edit4.frame = CGRectMake(self.edit3.frame.origin.x, self.edit3.frame.origin.y + self.edit3.frame.size.height + (self.edit3.frame.origin.y - (self.edit2.frame.origin.y + self.edit2.frame.size.height)), self.edit3.frame.size.width, self.edit3.frame.size.height);
                    self.edit4.backgroundColor = [UIColor redColor];
                    [self.edit4 setTitle:@"EDIT" forState:UIControlStateNormal];
                    [self.edit4 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    [self.edit4 addTarget:self action:@selector(editBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
                    self.edit4.tag = 13;
                    [self.petView addSubview:self.edit4];
                }
                
                
            }
            else if (self.petModelArr.count == 5){
                if (0 == i) {
                    
                    self.one.text = petItem.name;
                }
                else if (1 == i){
                    self.two.hidden = NO;
                    self.edit2.hidden = NO;
                    self.pet2.hidden = NO;
                    self.two.text = petItem.name;
                }
                else if (2 == i){
                    self.three.hidden = NO;
                    self.edit3.hidden = NO;
                    self.pet3.hidden = NO;
                    self.three.text = petItem.name;
                }
                else if (3 == i){
                    
                    if (self.pet4 == nil) {
                        self.pet4 = [[UILabel alloc] initWithFrame:CGRectMake(self.pet3.frame.origin.x, self.pet3.frame.origin.y + self.pet3.frame.size.height + (self.pet3.frame.origin.y - (self.pet2.frame.origin.y + self.pet2.frame.size.height)), self.pet3.frame.size.width, self.pet3.frame.size.height)];
                        self.pet4.text = @"Pet 4";
                        self.pet4.textAlignment = NSTextAlignmentLeft;
                        self.pet4.font = [UIFont fontWithName:@"Antenna-ExtraLight" size:19];
                        [self.petView addSubview:self.pet4];
                        
                        self.four = [[UILabel alloc] initWithFrame:CGRectMake(self.three.frame.origin.x, self.three.frame.origin.y + self.three.frame.size.height + (self.three.frame.origin.y - (self.two.frame.origin.y + self.two.frame.size.height)), self.three.frame.size.width, self.three.frame.size.height)];
                        self.four.textColor = [UIColor colorWithRed:128/255.0 green:128/255.0 blue:128/255.0 alpha:1];
                        self.four.backgroundColor = [UIColor whiteColor];
                        self.four.font = [UIFont fontWithName:@"Antenna-Regular" size:16];
                        self.four.textAlignment = NSTextAlignmentLeft;
                        self.four.text = petItem.name;
                        [self.petView addSubview:self.four];
                        
                        
                        self.edit4= [UIButton buttonWithType:UIButtonTypeRoundedRect];
                        self.edit4.frame = CGRectMake(self.edit3.frame.origin.x, self.edit3.frame.origin.y + self.edit3.frame.size.height + (self.edit3.frame.origin.y - (self.edit2.frame.origin.y + self.edit2.frame.size.height)), self.edit3.frame.size.width, self.edit3.frame.size.height);
                        self.edit4.backgroundColor = [UIColor redColor];
                        [self.edit4 setTitle:@"EDIT" forState:UIControlStateNormal];
                         [self.edit4 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                        [self.edit4 addTarget:self action:@selector(editBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
                        self.edit4.tag = 13;
                        [self.petView addSubview:self.edit4];
                    }
                    
                }
                else if (4 == i){
                    self.pet5 = [[UILabel alloc] initWithFrame:CGRectMake(self.pet3.frame.origin.x, self.pet3.frame.origin.y + self.pet3.frame.size.height + (self.pet3.frame.origin.y - (self.pet2.frame.origin.y + self.pet2.frame.size.height)) * 2 + self.pet3.frame.size.height, self.pet3.frame.size.width, self.pet3.frame.size.height)];
                    self.pet5.text = @"Pet 5";
                    self.pet5.textAlignment = NSTextAlignmentLeft;
                    self.pet5.font = [UIFont fontWithName:@"Antenna-ExtraLight" size:19];
                    [self.petView addSubview:self.pet5];
                    
                    self.five = [[UILabel alloc] initWithFrame:CGRectMake(self.three.frame.origin.x, self.three.frame.origin.y + self.three.frame.size.height + (self.three.frame.origin.y - (self.two.frame.origin.y + self.two.frame.size.height)) * 2 + self.three.frame.size.height , self.three.frame.size.width, self.three.frame.size.height)];
                    self.five.textColor = [UIColor colorWithRed:128/255.0 green:128/255.0 blue:128/255.0 alpha:1];
                    self.five.backgroundColor = [UIColor whiteColor];
                    self.five.font = [UIFont fontWithName:@"Antenna-Regular" size:16];
                    self.five.textAlignment = NSTextAlignmentLeft;
                    self.five.text = petItem.name;
                    [self.petView addSubview:self.five];
                    
                    
                    self.edit5 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                    self.edit5.frame = CGRectMake(self.edit3.frame.origin.x, self.edit3.frame.origin.y + self.edit3.frame.size.height + (self.edit3.frame.origin.y - (self.edit2.frame.origin.y + self.edit2.frame.size.height)) * 2 + self.edit3.frame.size.height, self.edit3.frame.size.width, self.edit3.frame.size.height);
                    self.edit5.backgroundColor = [UIColor redColor];
                    [self.edit5 setTitle:@"EDIT" forState:UIControlStateNormal];
                    [self.edit5 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    [self.edit5 addTarget:self action:@selector(editBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
                    self.edit5.tag = 14;
                    [self.petView addSubview:self.edit5];
                }
                
            }
            
            
            
        }
        
        
    }

}
@end
