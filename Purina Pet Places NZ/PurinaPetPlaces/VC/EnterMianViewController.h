//
//  EnterMianViewController.h
//  PetPlaces
//
//  Created by BlueApp on 15-4-12.
//  Copyright (c) 2015年 art_kernel_zyc. All rights reserved.
//

#import "ParentViewController.h"
#import "PopView.h"
@interface EnterMianViewController : ParentViewController<dismissDelegate>
@property(nonatomic,strong)PopView *pop;

- (IBAction)petAddBtnClick:(id)sender;

- (IBAction)petOneBtnClick:(id)sender;

- (IBAction)petTwoBtnClick:(id)sender;

- (IBAction)petThreeBtnClick:(id)sender;

- (IBAction)dogBtnClick:(id)sender;

- (IBAction)catBtnClick:(id)sender;

@end
