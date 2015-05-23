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
    
    
    if (self.name.text.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Notices" message:@"Please enter Name" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        return;
    }
    if (self.dateTimes.text.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Notices" message:@"Please enter Brith" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        return;
    }
    [self removeFromSuperview];
    if([self.delegate respondsToSelector:@selector(dismissDarkView)])
    {
        [self.delegate performSelector:@selector(dismissDarkView)];
    }
}
@end
