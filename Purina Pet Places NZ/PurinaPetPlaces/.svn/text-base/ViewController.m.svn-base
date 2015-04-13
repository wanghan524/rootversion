//
//  ViewController.m
//  PurinaPetPlaces
//
//  Created by Josh Bruce on 4/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "PCPetCentricSvc.h"
#import "Singleton.h"
#import "ConnectionViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <MessageUI/MessageUI.h>
#import "AppDelegate.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize lblHeading, btnRecommend, imgDog, categoriesTableViewController, connectionViewController;

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
        
        [self.view bringSubviewToFront:btnRecommend]; 
        [self.view bringSubviewToFront:imgDog];
        //Test Comment
        
        
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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationMethods:) name:@"DisplayEmail" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationMethods:) name:@"DisplayTipsEmail" object:nil];
    [UIApplication sharedApplication].statusBarOrientation = self.interfaceOrientation;
//    [self.view setBackgroundColor:[UIColor redColor]];

    categoriesTableViewController = [[CategoriesTableViewController alloc] initWithStyle:UITableViewStylePlain];
    
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone && [UIScreen mainScreen].bounds.size.height == 568)
    {
            [categoriesTableViewController.view setFrame:CGRectMake(0, 41, 320, 418)];
        
    } else {
            [categoriesTableViewController.view setFrame:CGRectMake(0, 41, 320, 330)];
    }
    
    [categoriesTableViewController setDelegate:self];
    [self.view addSubview:categoriesTableViewController.view];
    
    
    if (![AppDelegate isVersion6AndBelow])
    {
        self.imgDog.transform = CGAffineTransformMakeTranslation(0, -44);
        self.btnRecommend.transform = CGAffineTransformMakeTranslation(0, -44);
    }

}

-(void)presentBibOverlay {
    
    UIView *newView = connectionViewController.view;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5f];
    [UIView setAnimationDelegate:self];
    [newView setFrame:CGRectMake(newView.frame.origin.x, newView.frame.origin.y, newView.frame.size.width, newView.frame.size.height)];
    [UIView commitAnimations];
    

    
   // [self.navigationController presentModalViewController:modalView animated:YES];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

-(void)itemSelected:(Categories*)category {
    Singleton *singletonClass = [Singleton sharedInstance];
    [singletonClass setSelectedCategories:category];
    
    SubCategoriesViewController *subCategoriesViewController = [[SubCategoriesViewController alloc] initWithNibName:@"SubCategoriesViewController" bundle:nil];
    [self.navigationController pushViewController:subCategoriesViewController animated:YES];
    
}

- (void) notificationMethods:(NSNotification *) notification {
    
    if ([[notification name] isEqualToString:@"DisplayEmail"]) {
        
        MFMailComposeViewController *emailVC = [[MFMailComposeViewController alloc] init];
        [emailVC setTitle:@""];
        [emailVC setMailComposeDelegate:self];
        [emailVC setToRecipients:[NSArray arrayWithObjects:@"purina.petplace@nz.nestle.com", nil]];
        [emailVC setSubject:@"Purina - New Pet Friendly Place"];
        [emailVC setMessageBody:@"Please fill in the information for your Pet Friendly Location below. <br /> <br/> Location Name: <br />Location Type: <br /><br />Address Line 1:<br />Address Line 2:<br />Address Line 3:<br />Address Line 4:<br />Phone Number:<br />" isHTML:YES];
        [self presentModalViewController:emailVC animated:YES];
    }
    
    if ([[notification name] isEqualToString:@"DisplayTipsEmail"]) {
        
        MFMailComposeViewController *emailVC = [[MFMailComposeViewController alloc] init];
        [emailVC setTitle:@""];
        [emailVC setMailComposeDelegate:self];
        [emailVC setToRecipients:[NSArray arrayWithObjects:@"askpurina@nz.nestle.com", nil]];
        [emailVC setSubject:@"Purina Pet Places iPhone App New Zealand"];
        [emailVC setMessageBody:@"" isHTML:YES];
        [self presentModalViewController:emailVC animated:YES];
    }

}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    if (result == MFMailComposeResultCancelled || result == MFMailComposeResultSaved) {
        [self dismissModalViewControllerAnimated:YES];
    }
    
    if (result == MFMailComposeResultSent) {
        [self dismissModalViewControllerAnimated:YES];
    }
}

-(IBAction)recommendPetPlace:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"DisplayEmail" object:self];
}

@end
