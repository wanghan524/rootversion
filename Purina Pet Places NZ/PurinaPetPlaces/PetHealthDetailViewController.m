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
@synthesize pieview;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    globleSingleton = [GrobleSingleton sharedGlobleInstance];
    
    [self showCustomeNav];
    
    self.view.backgroundColor = [UIColor colorWithRed:242/255.0 green:238/255.0 blue:223/255.0 alpha:1];
    
    
    NSMutableArray * floatarray = [[NSMutableArray alloc] initWithCapacity:8];
    
    float a = 10.0;
    float b = 10.0;
    float c = 10.0;
    float d = 10.0;
    float e = 10.0;
    float f = 10.0;
    float g = 10.0;
    float h = 10.0;
    
    float abcdefgh = a+b+c+d+e+f+g+h;
    float aa = a/abcdefgh;
    float bb = b/abcdefgh;
    float cc = c/abcdefgh;
    float dd = d/abcdefgh;
    float ee = e/abcdefgh;
    float ff = f/abcdefgh;
    float gg = g/abcdefgh;
    float hh = h/abcdefgh;

    [floatarray addObject:[[NSString alloc] initWithFormat:@"%f",aa]];
    [floatarray addObject:[[NSString alloc] initWithFormat:@"%f",bb]];
    [floatarray addObject:[[NSString alloc] initWithFormat:@"%f",cc]];
    [floatarray addObject:[[NSString alloc] initWithFormat:@"%f",dd]];
    [floatarray addObject:[[NSString alloc] initWithFormat:@"%f",ee]];
    [floatarray addObject:[[NSString alloc] initWithFormat:@"%f",ff]];
    [floatarray addObject:[[NSString alloc] initWithFormat:@"%f",gg]];
    [floatarray addObject:[[NSString alloc] initWithFormat:@"%f",hh]];

    
    //
    pieview = [[PieChatView alloc] initWithFrame:CGRectMake(0.0, 0.0, SCREEN_WIDTH , SCREEN_HEIGHT)  withNum:[floatarray count] withArray:floatarray];
    //pieview.center = CGPointMake(160, 240);
    [self.view addSubview:pieview];

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
