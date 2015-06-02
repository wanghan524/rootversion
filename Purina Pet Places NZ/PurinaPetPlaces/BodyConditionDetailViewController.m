//
//  BodyConditionDetailViewController.m
//  PurinaPetPlaces
//
//  Created by BlueApp on 15-6-1.
//
//

#import "BodyConditionDetailViewController.h"


@interface BodyConditionDetailViewController (){
    UILabel *nextLabel;
    UIImageView *nextImage;
    UIImageView *headerImageView;
    UILabel *titleLabel;
    UILabel *contentLabel;
}

@property (nonatomic, strong) UIButton *nextButton;
@property (nonatomic,strong )UIImageView *viewImg;

@end

@implementation BodyConditionDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self showCustomeNav];
    
    self.view.backgroundColor = [UIColor colorWithRed:242/255.0 green:238/255.0 blue:223/255.0 alpha:1];
    
    self.viewImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT -64 - 60)];
    self.viewImg.image = [UIImage imageNamed:self.DisplayTipsCurrent[self.indexNumber]];
    [self.view addSubview:self.viewImg];
    
    self.nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.nextButton.frame = CGRectMake(0, SCREEN_HEIGHT - 60, SCREEN_WIDTH , 60);
    self.nextButton.backgroundColor = [UIColor redColor];
    [self.nextButton addTarget:self action:@selector(nextButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.nextButton];
    
    nextLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, (SCREEN_WIDTH / 5.0) * 5, 60)];
    nextLabel.backgroundColor = [UIColor redColor];
    nextLabel.text = @"NEXT";
    nextLabel.textColor = [UIColor whiteColor];
    nextLabel.textAlignment = NSTextAlignmentCenter;
    nextLabel.font = [UIFont fontWithName:@"Antenna" size:15];
    nextLabel.numberOfLines = 0;
    [self.nextButton addSubview:nextLabel];
    
    nextImage = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH / 5.0) * 4 - 40, 20, 20, 20)];
    nextImage.image = [UIImage imageNamed:@"next-btn.jpg"];
    [self.nextButton addSubview:nextImage];
    // Do any additional setup after loading the view.
}

- (void)nextButtonClick{
    
    if (self.indexNumber <= self.DisplayTipsCurrent.count - 2) {
        self.indexNumber ++;
        [self.viewImg setImage:[UIImage imageNamed:self.DisplayTipsCurrent[self.indexNumber]]];

        
    }else{
        nextLabel.text = @"LAST ONE";
        nextLabel.font = [UIFont fontWithName:@"Antenna" size:22];
        nextImage.image = [UIImage imageNamed:@""];
        nextImage.backgroundColor = [UIColor clearColor];
    }
    
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
