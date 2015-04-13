//
//  PetInfoMainScreenViewController.m
//  PurinaPetPlaces
//
//  Created by Josh Bruce on 30/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PetInfoMainScreenViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "PetInfoTipsViewController.h"
#import "PetInfoProductsViewController.h"
#import "AppDelegate.h"

@interface PetInfoMainScreenViewController ()

@end

@implementation PetInfoMainScreenViewController
@synthesize lblHeading, petInfoTableViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        CAGradientLayer *gradient = [CAGradientLayer layer];
        [gradient setFrame:self.view.bounds];
        [gradient setColors:[NSArray arrayWithObjects:(id)[UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1].CGColor, (id)[UIColor colorWithRed:253/255.0 green:253/255.0 blue:253/255.0 alpha:1].CGColor, nil]];
        [self.view.layer insertSublayer:gradient atIndex:0];
        
        [lblHeading.layer setShadowColor:[UIColor blackColor].CGColor];
        [lblHeading.layer setShadowOffset:CGSizeMake(2, 2)];
        [lblHeading.layer setShadowOpacity:0.5f];
        [lblHeading.layer setShadowRadius:3.0];
        [lblHeading.layer setMasksToBounds:NO];
        
        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone && [UIScreen mainScreen].bounds.size.height == 568)
        {
            petInfoTableViewController = [[PetInfoTableViewController alloc] initWithStyle:UITableViewStylePlain];
            
                [petInfoTableViewController.view setFrame:CGRectMake(0, 41, 320, 418)];
            
            [petInfoTableViewController setDelegate:self];
            [self.view addSubview:petInfoTableViewController.view];
            
        } else {
            
            petInfoTableViewController = [[PetInfoTableViewController alloc] initWithStyle:UITableViewStylePlain];
            
                [petInfoTableViewController.view setFrame:CGRectMake(0, 41, 320, 330)];
            
            [petInfoTableViewController setDelegate:self];
            [self.view addSubview:petInfoTableViewController.view];
            
        }

        
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil]; 
        if ([backButton respondsToSelector:@selector(setTintColor:)]) {
            [backButton setTintColor:[UIColor colorWithRed:206/255.0 green:206/255.0 blue:206/255.0 alpha:1]];
            NSDictionary *titleBarProperties = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:89/255.0 green:89/255.0 blue:89/255.0 alpha:1], UITextAttributeTextColor, [UIColor whiteColor], UITextAttributeTextShadowColor, nil];
            [backButton setTitleTextAttributes:titleBarProperties forState:UIControlStateNormal];
        }
        [self.navigationItem setBackBarButtonItem:backButton];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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

-(void)itemSelected {

    PetInfoTipsViewController *petInfoTipsViewController = [[PetInfoTipsViewController alloc] initWithNibName:@"PetInfoTipsViewController" bundle:nil];
    [self.navigationController pushViewController:petInfoTipsViewController animated:YES];
}

-(void)openImage {
    PetInfoProductsViewController *petInfoProductsDetailViewController = [[PetInfoProductsViewController alloc] initWithNibName:@"PetInfoProductsViewController" bundle:nil];
    [self.navigationController pushViewController:petInfoProductsDetailViewController animated:YES];
}

@end
