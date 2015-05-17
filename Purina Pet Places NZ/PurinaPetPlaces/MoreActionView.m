//
//  MoreActionView.m
//  PurinaPetPlaces
//
//  Created by 菁优数学 on 15/5/10.
//
//

#import "MoreActionView.h"

@implementation MoreActionView

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self creataUI];
    }
    return self;
}


-(void)creataUI
{
    self.darkView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];

    [self.darkView setBackgroundColor:[UIColor colorWithRed:86/255.f green:86/255.f blue:86/255.f alpha:0.7]];
    [self addSubview:self.darkView];
    
    UIView *smallView = [[UIView alloc]initWithFrame:CGRectMake(40,100, SCREEN_WIDTH - 80, 200 )];
    smallView.backgroundColor = [UIColor colorWithRed:242/255.0 green:238/255.0 blue:223/255.0 alpha:1];
    CGPoint point = self.darkView.center;
    point.y = point.y - 64;
    smallView.center = point;

    [self.darkView addSubview:smallView];
    
    
    UILabel *infoLab = [[UILabel alloc]initWithFrame:CGRectMake(30, 20,smallView.frame.size.width-60, 80)];
    infoLab.textAlignment = NSTextAlignmentCenter;
    infoLab.text = @"Have you performed this task";
    infoLab.font = [UIFont fontWithName:@"Antenna" size:15];
    infoLab.numberOfLines = 2;
    [smallView addSubview:infoLab];
    
    
    self.moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.moreBtn setFrame:CGRectMake(0,smallView.frame.size.height-82, smallView.frame.size.width, 40)];
    [self.moreBtn setTitle:@"MORE INFO" forState:UIControlStateNormal];
    self.moreBtn.titleLabel.font = [UIFont fontWithName:@"Antenna" size:10];
    [self.moreBtn setBackgroundColor:[UIColor redColor]];
    [self.moreBtn addTarget:self action:@selector(hidden:) forControlEvents:UIControlEventTouchUpInside];
    [smallView addSubview:self.moreBtn];
    
    self.yesBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.yesBtn setFrame:CGRectMake(0, smallView.frame.size.height-40, smallView.frame.size.width/2-1, 40)];
    [self.yesBtn setTitle:@"YES" forState:UIControlStateNormal];
    self.yesBtn.titleLabel.font = [UIFont fontWithName:@"Antenna" size:10];
    [self.yesBtn setBackgroundColor:[UIColor redColor]];
    
    [self.yesBtn addTarget:self action:@selector(hidden:) forControlEvents:UIControlEventTouchUpInside];
    [smallView addSubview:self.yesBtn];
    
    self.noBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.noBtn setFrame:CGRectMake(smallView.frame.size.width/2+1, smallView.frame.size.height-40,smallView.frame.size.width/2-1, 40)];
    [self.noBtn setTitle:@"NO" forState:UIControlStateNormal];
    self.noBtn.titleLabel.font = [UIFont fontWithName:@"Antenna" size:10];
    [self.noBtn addTarget:self action:@selector(hidden:) forControlEvents:UIControlEventTouchUpInside];
    [self.noBtn setBackgroundColor:[UIColor redColor]];
    [smallView addSubview:self.noBtn];
    
    
}


-(void)hidden:(UIButton *)sender
{
    [self removeFromSuperview];
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end