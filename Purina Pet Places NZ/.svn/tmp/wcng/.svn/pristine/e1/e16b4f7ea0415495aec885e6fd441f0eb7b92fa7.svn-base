//
//  MapDetailsViewController.m
//  PurinaPetPlaces
//
//  Created by Josh Bruce on 11/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MapDetailsViewController.h"

@interface MapDetailsViewController ()

@end

@implementation MapDetailsViewController

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
    // Do any additional setup after loading the view from its nib.
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil];
    if ([backButton respondsToSelector:@selector(setTintColor:)]) {
        [backButton setTintColor:[UIColor colorWithRed:206/255.0 green:206/255.0 blue:206/255.0 alpha:1]];
        NSDictionary *titleBarProperties = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:89/255.0 green:89/255.0 blue:89/255.0 alpha:1], UITextAttributeTextColor, [UIColor whiteColor], UITextAttributeTextShadowColor, nil];
        [backButton setTitleTextAttributes:titleBarProperties forState:UIControlStateNormal];
    }
    [self.navigationItem setBackBarButtonItem:backButton];
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
