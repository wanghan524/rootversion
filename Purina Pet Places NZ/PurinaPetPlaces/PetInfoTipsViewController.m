//
//  PetInfoTipsViewController.m
//  PurinaPetPlaces
//
//  Created by Josh Bruce on 1/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PetInfoTipsViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface PetInfoTipsViewController ()

@end

@implementation PetInfoTipsViewController
@synthesize petInfoTipsTableViewController, petInfoWebView, petInfoToolbar;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
       
       
        
        
        /*
        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone && [UIScreen mainScreen].bounds.size.height == 568)
        {
            
            petInfoTipsTableViewController = [[PetInfoTipsTableViewController alloc] initWithStyle:UITableViewStylePlain];
            [petInfoTipsTableViewController.tableView setBounces:YES];
            [petInfoTipsTableViewController.view setFrame:CGRectMake(70, 0, 300, 458)];
            [[petInfoTipsTableViewController.view layer] setMasksToBounds:NO];
            [[petInfoTipsTableViewController.view layer] setShadowColor:[UIColor blackColor].CGColor];
            [[petInfoTipsTableViewController.view layer] setShadowRadius:4];
            [[petInfoTipsTableViewController.view layer] setShadowOpacity:0.5f];
            [[petInfoTipsTableViewController.view layer] setShadowOffset:CGSizeMake(-2, -2)];
        }
        
        else {
            
            petInfoTipsTableViewController = [[PetInfoTipsTableViewController alloc] initWithStyle:UITableViewStylePlain];
            [petInfoTipsTableViewController.tableView setBounces:YES];
            [petInfoTipsTableViewController.view setFrame:CGRectMake(70, 0, 300, 370)];
            [[petInfoTipsTableViewController.view layer] setMasksToBounds:NO];
            [[petInfoTipsTableViewController.view layer] setShadowColor:[UIColor blackColor].CGColor];
            [[petInfoTipsTableViewController.view layer] setShadowRadius:4];
            [[petInfoTipsTableViewController.view layer] setShadowOpacity:0.5f];
            [[petInfoTipsTableViewController.view layer] setShadowOffset:CGSizeMake(-2, -2)];
            
        }
        
        */
        
        

        
    }
    return self;
}

-(void)slideTableView {
    UIView *newView = petInfoTipsTableViewController.view;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationDelegate:self];
    [newView setFrame:CGRectMake(20, newView.frame.origin.y, newView.frame.size.width, newView.frame.size.height)];
    [UIView commitAnimations];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"PetInfo" ofType:@"html" inDirectory:@""];
    NSString* htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    [petInfoWebView loadHTMLString:htmlString baseURL:nil];

 
    
    // Do any additional setup after loading the view from its nib.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UIView *newView = petInfoTipsTableViewController.view;
    UITouch *touch = [touches anyObject];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationDelegate:self];
    if (newView.frame.origin.x == 70) {
        [newView setFrame:CGRectMake(20, newView.frame.origin.y, newView.frame.size.width, newView.frame.size.height)];
        if ([touch locationInView:touch.view].y <= 70) {
            [petInfoTipsTableViewController loadUp:1 byName:@"General Tips"];
            //[petInfoTipsTableViewController.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        }else if ([touch locationInView:touch.view].y <= 140) {
            [petInfoTipsTableViewController loadUp:2 byName:@"Cat Tips"];
            //[petInfoTipsTableViewController.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        } else if ([touch locationInView:touch.view].y <= 210) {
            [petInfoTipsTableViewController loadUp:3 byName:@"Dog Tips"];
            //[petInfoTipsTableViewController.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        }
        
    } else {
        [newView setFrame:CGRectMake(70, newView.frame.origin.y, newView.frame.size.width, newView.frame.size.height)];
    }
    [UIView commitAnimations];
    
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
//    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(IBAction)loadGeneralTips:(id)sender {
    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"PetInfo" ofType:@"html" inDirectory:@""];
    NSString* htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    
    [petInfoWebView loadHTMLString:htmlString baseURL:baseURL];
}
-(IBAction)loadCatTips:(id)sender {
    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"CatInfo" ofType:@"html" inDirectory:@""];
    NSString* htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    
    [petInfoWebView loadHTMLString:htmlString baseURL:baseURL];
}
-(IBAction)loadDogTips:(id)sender {
    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"DogInfo" ofType:@"html" inDirectory:@""];
    NSString* htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    
    [petInfoWebView loadHTMLString:htmlString baseURL:baseURL];
}


@end
