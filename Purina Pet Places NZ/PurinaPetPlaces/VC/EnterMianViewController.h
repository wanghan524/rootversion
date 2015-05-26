//
//  EnterMianViewController.h
//  PetPlaces
//
//  Created by BlueApp on 15-4-12.
//  Copyright (c) 2015年 art_kernel_zyc. All rights reserved.
//

#import "ParentViewController.h"
#import "PopView.h"
@interface EnterMianViewController : ParentViewController<dismissDelegate,UITextFieldDelegate>
@property(nonatomic,strong)PopView *pop;
@property (weak, nonatomic) IBOutlet UILabel *two;
@property (weak, nonatomic) IBOutlet UILabel *three;

@property (weak, nonatomic) IBOutlet UILabel *one;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;

@property (weak, nonatomic) IBOutlet UIView *petView;
@property (weak, nonatomic) IBOutlet UILabel *pet1;
@property (weak, nonatomic) IBOutlet UILabel *pet2;
@property (weak, nonatomic) IBOutlet UILabel *pet3;
@property (weak, nonatomic) IBOutlet UIButton *edit1;
@property (weak, nonatomic) IBOutlet UIButton *edit2;
@property (weak, nonatomic) IBOutlet UIButton *edit3;
@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
@property (weak, nonatomic) IBOutlet UIButton *dogButton;
@property (weak, nonatomic) IBOutlet UIButton *catButton;

@property (nonatomic, strong) UIButton *edit4;
@property (nonatomic, strong) UIButton *edit5;



- (IBAction)petAddBtnClick:(id)sender;

- (IBAction)petOneBtnClick:(id)sender;

- (IBAction)petTwoBtnClick:(id)sender;

- (IBAction)petThreeBtnClick:(id)sender;

- (IBAction)dogBtnClick:(id)sender;

- (IBAction)catBtnClick:(id)sender;
-(void)dismissDarkView;
-(void)makePop;
@end
