//
//  PopView.h
//  PetPlaces
//
//  Created by art_kernel_zyc on 15/4/12.
//  Copyright (c) 2015年 art_kernel_zyc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol dismissDelegate <NSObject>

-(void)dismissDarkView;

@end

@interface PopView : UIView
@property(nonatomic,weak)id<dismissDelegate>delegate;

-(instancetype)initWithFrame:(CGRect)frame;
- (IBAction)dismissBtnClick:(id)sender;

@end
