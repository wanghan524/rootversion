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


- (IBAction)petAddBtnClick:(id)sender;

- (IBAction)petOneBtnClick:(id)sender;

- (IBAction)petTwoBtnClick:(id)sender;

- (IBAction)petThreeBtnClick:(id)sender;

- (IBAction)dogBtnClick:(id)sender;

- (IBAction)catBtnClick:(id)sender;
-(void)dismissDarkView;
-(void)makePop;
@end
