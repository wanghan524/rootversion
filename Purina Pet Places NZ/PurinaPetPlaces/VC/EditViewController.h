//
//  EditViewController.h
//  PetPlaces
//
//  Created by BlueApp on 15-4-12.
//  Copyright (c) 2015年 art_kernel_zyc. All rights reserved.
//

#import "ParentViewController.h"

@interface EditViewController : ParentViewController
@property (weak, nonatomic) IBOutlet UIImageView *titleImageView;
@property (weak, nonatomic) IBOutlet UIImageView *SelectBackImageView;
- (IBAction)EditButtonclick:(id)sender;
- (IBAction)SelecteDog:(id)sender;

- (IBAction)SelectedCat:(id)sender;
@end
