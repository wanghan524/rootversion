//
//  ConnectionViewController.m
//  PurinaPetPlaces
//
//  Created by Josh Bruce on 10/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ConnectionViewController.h"
#import "Reachability.h"

@interface ConnectionViewController ()

@end

@implementation ConnectionViewController
@synthesize connectingImage, btnRetry, delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"YOOYOYUOYOYOYOYOYOYOYOYO");
    stepNumber = 1;
    [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(timerRunning) userInfo:nil repeats:YES];
    // Do any additional setup after loading the view from its nib.
}

-(void)timerRunning {
    [self retryConnection:nil];
    switch (stepNumber + 1) {
        case 1:
            [connectingImage setImage:[UIImage imageNamed:@"connection_step1.png"]];
            break;
        case 2:
            [connectingImage setImage:[UIImage imageNamed:@"connection_step2.png"]];
            break;
        case 3:
            [connectingImage setImage:[UIImage imageNamed:@"connection_step3.png"]];
            break;
        case 4:
            [connectingImage setImage:[UIImage imageNamed:@"connection_step4.png"]];
            break;
        case 5:
            [connectingImage setImage:[UIImage imageNamed:@"connection_step3.png"]];
            break;
        case 6:
            [connectingImage setImage:[UIImage imageNamed:@"connection_step2.png"]];
            break;
        case 7:
            [connectingImage setImage:[UIImage imageNamed:@"connection_step1.png"]];
            stepNumber = 0;
            break;  
            
    }
stepNumber++;
    
}

-(void)retryConnection:(id)sender {
    Reachability* reach = [Reachability reachabilityWithHostname:@"www.google.com"];
    if ([reach isReachable]) {
        [self.view removeFromSuperview];
        [self.delegate continueLoading];
    } 
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
