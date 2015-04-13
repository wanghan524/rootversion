//
//  EnterMianViewController.m
//  PetPlaces
//
//  Created by BlueApp on 15-4-12.
//  Copyright (c) 2015年 art_kernel_zyc. All rights reserved.
//

#import "EnterMianViewController.h"
#import "MainViewController.h"

@interface EnterMianViewController ()
@property(nonatomic,strong)UIView *darkView;

@end

@implementation EnterMianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
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
    if(self.darkView != nil)
    {
        [self.darkView removeFromSuperview];
        self.darkView = nil;
    }
}

- (IBAction)petAddBtnClick:(id)sender
{
    [self makePop];
    
}

- (IBAction)petOneBtnClick:(id)sender {
    [self makePop];
}

- (IBAction)petTwoBtnClick:(id)sender {
    [self makePop];
}

- (IBAction)petThreeBtnClick:(id)sender {
    [self makePop];
}

- (IBAction)dogBtnClick:(id)sender
{
    MainViewController *main = [[MainViewController alloc]init];

    [self.navigationController pushViewController:main
                                         animated:YES];

    
}

- (IBAction)catBtnClick:(id)sender
{
    MainViewController *main = [[MainViewController alloc]init];
    
    [self.navigationController pushViewController:main
                                         animated:YES];
}
@end
