//
//  EditViewController.m
//  PetPlaces
//
//  Created by BlueApp on 15-4-12.
//  Copyright (c) 2015年 art_kernel_zyc. All rights reserved.
//

#import "EditViewController.h"
#import "EnterMianViewController.h"

@interface EditViewController ()

@end

@implementation EditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    [self hideCustomeNav];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)EditButtonclick:(id)sender {
    
    EnterMianViewController *enterVC = [[EnterMianViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:enterVC];
    
    [self presentViewController:nav animated:YES completion:nil];
}

- (IBAction)SelecteDog:(id)sender {
    
    EnterMianViewController *enterVC = [[EnterMianViewController alloc] init];
    
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:enterVC];
    
    [self presentViewController:nav animated:YES completion:nil];

}

- (IBAction)SelectedCat:(id)sender {
    EnterMianViewController *enterVC = [[EnterMianViewController alloc] init];
    
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:enterVC];
    
    [self presentViewController:nav animated:YES completion:nil];

}
@end
