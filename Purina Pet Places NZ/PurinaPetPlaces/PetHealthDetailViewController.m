//
//  PetHealthDetailViewController.m
//  PurinaPetPlaces
//
//  Created by BlueApp on 15-4-19.
//
//

#import "PetHealthDetailViewController.h"
#import "GrobleSingleton.h"
#import "MoreActionView.h"
#import "PetItem.h"

@interface PetHealthDetailViewController (){
    GrobleSingleton *globleSingleton;
}


@property(nonatomic,strong)UIButton *oneBtn;
@property(nonatomic,strong)UIButton *twoBtn;
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

    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 30)];
    label.text = ((PetItem *)(globleSingleton.selectedAnimalName)).name;
    label.font = [UIFont fontWithName:@"Antenna" size:20];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    [self.view addSubview:label];
    
    UILabel *detail = [[UILabel alloc]initWithFrame:CGRectMake(0, 95, SCREEN_WIDTH, 15)];
    detail.text = @"Select tile to check off";
    detail.font = [UIFont fontWithName:@"Antenna" size:13];
    detail.textAlignment = NSTextAlignmentCenter;
    detail.textColor = [UIColor grayColor];
    [self.view addSubview:detail];
    UILabel *two = [[UILabel alloc]initWithFrame:CGRectMake(0, 110, SCREEN_WIDTH, 15)];
    two.textColor = [UIColor grayColor];
    two.text = @"tasks as you go";
    two.textAlignment = NSTextAlignmentCenter;
    two.font = [UIFont fontWithName:@"Antenna" size:13];
    [self.view addSubview:two];
    
    
    //
    pieview = [[PieChatView alloc] initWithFrame:CGRectMake(0.0, 64+60, SCREEN_WIDTH , SCREEN_HEIGHT-64-180)  withNum:[floatarray count] withArray:floatarray];
    //pieview.center = CGPointMake(160, 240);
    pieview.delegate = self;
    [self.view addSubview:pieview];
    
    UILabel *more = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(pieview.frame), SCREEN_WIDTH-20, 80 )];
    more.numberOfLines = 0;
    more.font = [UIFont fontWithName:@"Antenna" size:13];
    more.textColor = [UIColor grayColor];
    more.text = @"*We recommend speaking to your local Veterinarian about any health related queries for your pet. The health compass is a friendly reminder application and is not to be used as a substitute for Veterinary advice.";
    more.backgroundColor = [UIColor clearColor];
    [self.view addSubview:more];

    
    self.oneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.oneBtn.frame = CGRectMake(0, SCREEN_HEIGHT - 40, SCREEN_WIDTH, 40);
    [self.oneBtn setTitle:@"TURN OFF PUSH NOTIFICATIONS" forState:UIControlStateNormal];
    self.oneBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.oneBtn.titleLabel.font = [UIFont fontWithName:@"Antenna" size:13];
    [self.oneBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.oneBtn setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:self.oneBtn];
    
    
#if 0
    
    self.twoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.twoBtn.frame = CGRectMake(0, SCREEN_HEIGHT - 40, SCREEN_WIDTH, 40);
    [self.twoBtn setTitle:@"CLICK HERE TO SEE OTHER CHECKS YOU MAY NEED TO DO DEPENDING ON YOUR CITY" forState:UIControlStateNormal];
    self.twoBtn.titleLabel.numberOfLines = 2;
    self.twoBtn.titleLabel.font = [UIFont fontWithName:@"Antenna" size:13];
    [self.twoBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.twoBtn setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:self.twoBtn];
#endif
    
    
    // Do any additional setup after loading the view.
}

- (void)transformIndex:(NSInteger)index{
//    MoreActionView *view = [[MoreActionView alloc]initWithFrame:self.view.frame];
//    [self.view addSubview:view];
    NSLog(@"index : %ld",(long)index);
}


-(void)btnClick:(UIButton *)sender
{
    MoreActionView *view = [[MoreActionView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:view];
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
