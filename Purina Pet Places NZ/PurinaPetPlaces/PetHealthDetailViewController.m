//
//  PetHealthDetailViewController.m
//  PurinaPetPlaces
//
//  Created by BlueApp on 15-4-19.
//
//

#import "PetHealthDetailViewController.h"
#import "GrobleSingleton.h"

@interface PetHealthDetailViewController (){
    GrobleSingleton *globleSingleton;
}

@end

@implementation PetHealthDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    globleSingleton = [GrobleSingleton sharedGlobleInstance];
    
    [self showCustomeNav];
    
    self.view.backgroundColor = [UIColor colorWithRed:242/255.0 green:238/255.0 blue:223/255.0 alpha:1];

    // Do any additional setup after loading the view.
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

@end