//
//  DisplayTipsContentViewController.m
//  PurinaPetPlaces
//
//  Created by BlueApp on 15-4-16.
//
//

#import "DisplayTipsContentViewController.h"


@interface DisplayTipsContentViewController (){
    UILabel *nextLabel;
    UIImageView *nextImage;
    UIImageView *headerImageView;
    UILabel *titleLabel;
    UILabel *contentLabel;
}

@property (nonatomic, strong) UIButton *nextButton;
@end

@implementation DisplayTipsContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self showCustomeNav];
    
    self.view.backgroundColor = [UIColor colorWithRed:242/255.0 green:238/255.0 blue:223/255.0 alpha:1];
    
    headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, (506 * SCREEN_WIDTH) / 750.0)];
    
    if ([self.currentCategory isEqualToString:@"General"]) {
        headerImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"tips-articles-general%d.jpg",self.indexNumber + 1]];
    }
    
    else if ([self.currentCategory isEqualToString:@"For your cat"]){
        headerImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"tips-articles-cats%d.jpg",self.indexNumber+ 1]];
    }
    
    else if ([self.currentCategory isEqualToString:@"For your dog"]){
        headerImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"tips-thumb-%d.jpg",self.indexNumber + 1]];
    }
    [self.view addSubview:headerImageView];
    
    
    
    
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 200 / 2.0 - 30, SCREEN_WIDTH, 60)];
    titleLabel.text = [[self.DisplayTipsCurrent objectAtIndex:self.indexNumber] objectAtIndex:0];
    titleLabel.numberOfLines = 0;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont fontWithName:@"Antenna" size:22];
    [headerImageView addSubview:titleLabel];
    
    
    UIView *contentBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 64 + (506 * SCREEN_WIDTH) / 750.0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 200 - 60)];
    contentBackView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:contentBackView];
    
    contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, SCREEN_WIDTH - 80, SCREEN_HEIGHT - 64 - (506 * SCREEN_WIDTH) / 750.0 - 60)];
    contentLabel.text = [[self.DisplayTipsCurrent objectAtIndex:self.indexNumber] objectAtIndex:1];
    contentLabel.numberOfLines = 0;
    
    contentLabel.font = [UIFont fontWithName:@"Antenna" size:15];
    [contentBackView addSubview:contentLabel];
    
    
    self.nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.nextButton.frame = CGRectMake(0, SCREEN_HEIGHT - 60, SCREEN_WIDTH , 60);
    self.nextButton.backgroundColor = [UIColor redColor];
    [self.nextButton addTarget:self action:@selector(nextButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.nextButton];
    
    nextLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, (SCREEN_WIDTH / 5.0) * 5, 60)];
    nextLabel.backgroundColor = [UIColor redColor];
    nextLabel.text = @"NEXT TIP";
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
        titleLabel.text = [[self.DisplayTipsCurrent objectAtIndex:self.indexNumber] objectAtIndex:0];
        
        titleLabel.font = [UIFont fontWithName:@"Antenna" size:22];
        contentLabel.text = [[self.DisplayTipsCurrent objectAtIndex:self.indexNumber] objectAtIndex:1];
        contentLabel.font = [UIFont fontWithName:@"Antenna" size:20];
        if ([self.currentCategory isEqualToString:@"General"]) {
            headerImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"tips-articles-general%d.jpg",self.indexNumber + 1]];
        }
        
        else if ([self.currentCategory isEqualToString:@"For your cat"]){
            headerImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"tips-articles-cats%d.jpg",self.indexNumber+ 1]];
        }
        
        else if ([self.currentCategory isEqualToString:@"For your dog"]){
            headerImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"tips-thumb-%d.jpg",self.indexNumber + 1]];
        }
        
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
