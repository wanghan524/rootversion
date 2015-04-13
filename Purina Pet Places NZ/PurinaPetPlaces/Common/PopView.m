//
//  PopView.m
//  PetPlaces
//
//  Created by art_kernel_zyc on 15/4/12.
//  Copyright (c) 2015年 art_kernel_zyc. All rights reserved.
//

#import "PopView.h"

@implementation PopView
-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        
    }
    return self;
}


- (IBAction)dismissBtnClick:(id)sender
{
    [self removeFromSuperview];
    if([self.delegate respondsToSelector:@selector(dismissDarkView)])
    {
        [self.delegate performSelector:@selector(dismissDarkView)];
    }
}
@end
