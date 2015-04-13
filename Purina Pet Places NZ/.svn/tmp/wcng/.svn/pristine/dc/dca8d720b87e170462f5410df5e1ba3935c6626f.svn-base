//
//  PetInfoProductsViewController.m
//  PurinaPetPlaces
//
//  Created by Josh Bruce on 2/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PetInfoProductsViewController.h"

@interface PetInfoProductsViewController ()

@end

@implementation PetInfoProductsViewController
@synthesize theCatScroller, theDogScroller, catinfoGraphic, dogInfoGraphic, touch, catLinkArray, dogLinkArray, petInfoToolbar, petProductsWebview;

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
    
    //catLinkArray = [NSMutableArray arrayWithObjects:@"www.proplan.co.nz", @"www.purinaone.co.nz", @"www.catchow.co.nz", @"www.friskies.co.nz", @"www.fancyfeast.co.nz", @"www.purina.co.nz", @"www.facebook.com/purinanz", nil];
    //dogLinkArray = [NSMutableArray arrayWithObjects:@"www.proplan.co.nz", @"www.purinaone.co.nz", @"www.beneful.co.nz", @"www.tux.co.nz", @"www.dogchow.co.nz", @"www.purina.co.nz", @"www.facebook.com/purinanz", nil];
    
    
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithRed:45/255.0 green:45/255.0 blue:45/255.0 alpha:1]];
    
    
    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"products_cat" ofType:@"html" inDirectory:@""];
    NSString* htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    
    [petProductsWebview setDelegate:self];
    [petProductsWebview loadHTMLString:htmlString baseURL:baseURL];
    
    
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
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    if (result == MFMailComposeResultCancelled || result == MFMailComposeResultSaved) {
        [self dismissModalViewControllerAnimated:YES];
    }
    
if (result == MFMailComposeResultSent) {
    [self dismissModalViewControllerAnimated:YES];
}
}

-(void)openPhoneNumber:(id)sender {
    UIAlertView *callAlert = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"0800 738 847"] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Call", nil];
    [callAlert setDelegate:self];
    [callAlert show];
}

-(void)openEmail:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"DisplayTipsEmail" object:self];
}

-(void)openWebsite:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%@", [catLinkArray objectAtIndex:[sender tag] - 1]] message:[NSString stringWithFormat:@"This will close the app and open %@ in Safari. Are you sure you wish to continue?", [catLinkArray objectAtIndex:[sender tag] - 1]] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Yes", nil];
    [alert setDelegate:self];
    [alert show];
}

-(void)openDogWebsite:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%@", [dogLinkArray objectAtIndex:[sender tag] - 1]] message:[NSString stringWithFormat:@"This will close the app and open %@ in Safari. Are you sure you wish to continue?", [dogLinkArray objectAtIndex:[sender tag] - 1]] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Yes", nil];
    [alert setDelegate:self];
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        if (alertView.title.length == 0) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://0800738847"]];
        } else {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@",alertView.title]]];
        }
        
    }
}

-(void)slideTableView {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationDelegate:self];
    [theCatScroller setFrame:CGRectMake(20, theCatScroller.frame.origin.y, theCatScroller.frame.size.width, theCatScroller.frame.size.height)];
    [UIView commitAnimations];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    touch = [touches anyObject];
    
    if (theCatScroller.frame.origin.x == 20) {
        [self menuSlideOut:@"cat"];
    } else if (theDogScroller.frame.origin.x == 20) {
        [self menuSlideOut:@"dog"];
    } else if ([touch locationInView:self.view].y <= 140) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.2];
        [UIView setAnimationDelegate:self];
        
        if ([self tellMeWhatsVisible] == theCatScroller && [touch locationInView:self.view].y <= 70) {
            [theCatScroller setFrame:CGRectMake(20, 0, theCatScroller.frame.size.width, theCatScroller.frame.size.height)];
        } else if ([self tellMeWhatsVisible] == theDogScroller && [touch locationInView:self.view].y >= 70) {
            [theDogScroller setFrame:CGRectMake(20, 0, theDogScroller.frame.size.width, theDogScroller.frame.size.height)];
        } else {
            [UIView setAnimationDidStopSelector:@selector(showMeThe:)];
            [theCatScroller setFrame:CGRectMake(400, 0, theCatScroller.frame.size.width, theCatScroller.frame.size.height)];
            [theDogScroller setFrame:CGRectMake(400, 0, theDogScroller.frame.size.width, theDogScroller.frame.size.height)];
        }
        
        [UIView commitAnimations];
        
    } else {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.2];
        [UIView setAnimationDelegate:self];
        [[self tellMeWhatsVisible] setFrame:CGRectMake(20, 0, [self tellMeWhatsVisible].frame.size.width, [self tellMeWhatsVisible].frame.size.height)];
    }

    
    
}

-(UIScrollView *)tellMeWhatsVisible {
    if (theCatScroller.frame.origin.x != 400) {
        return theCatScroller;
    } else {
        return theDogScroller;
    }
    
}

-(void)showMeThe:(NSString *)petType {
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationDelegate:self];

    if ([touch locationInView:self.view].y <= 70) {
        [theCatScroller setFrame:CGRectMake(20, 0, theCatScroller.frame.size.width, theCatScroller.frame.size.height)];
        [theCatScroller setContentOffset:CGPointMake(0, 0) animated:YES];

    } else if ([touch locationInView:self.view].y <= 140) {
        [theDogScroller setFrame:CGRectMake(20, 0, theDogScroller.frame.size.width, theDogScroller.frame.size.height)];
        [theDogScroller setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    [UIView commitAnimations];
    
    
        
}

-(void)menuSlideOut:(NSString *)petType  {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationDelegate:self];
    if ([petType isEqualToString:@"cat"]) {
        [theCatScroller setFrame:CGRectMake(70, theCatScroller.frame.origin.y, theCatScroller.frame.size.width, theCatScroller.frame.size.height)];
    } else {
        [theDogScroller setFrame:CGRectMake(70, theDogScroller.frame.origin.y, theDogScroller.frame.size.width, theDogScroller.frame.size.height)];
    }
    
    [UIView commitAnimations];
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

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSLog(@"Clicky Click! : %@ ", request.URL);
    NSString *url = [NSString stringWithFormat:@"%@", request.URL];
    if ([url hasPrefix:@"file://"] || [url hasPrefix:@"tel"]) {
        return YES;
    } else if ([url hasPrefix:@"mailto:"]) {
        MFMailComposeViewController *emailVC = [[MFMailComposeViewController alloc] init];
        [emailVC setTitle:@""];
        [emailVC setMailComposeDelegate:self];
        [emailVC setToRecipients:[NSArray arrayWithObjects:@"purina.petplace@nz.nestle.com", nil]];
        [emailVC setSubject:@"Purina - New Pet Friendly Place"];
        [emailVC setMessageBody:@"Please fill in the information for your Pet Friendly Location below. <br /> <br/> Location Name: <br />Location Type: <br /><br />Address Line 1:<br />Address Line 2:<br />Address Line 3:<br />Address Line 4:<br />Phone Number:<br />" isHTML:YES];
        [self presentModalViewController:emailVC animated:YES];
        return NO; 
    } else {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:url message:[NSString stringWithFormat:@"This will close the app and open %@ in Safari. Are you sure you wish to continue?", url] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Yes", nil];
        [alert setDelegate:self];
        [alert show];
        return NO;
    }
}


-(IBAction)catProducts:(id)sender {
    
    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"products_cat" ofType:@"html" inDirectory:@""];
    NSString* htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    
    [petProductsWebview setDelegate:self];
    [petProductsWebview loadHTMLString:htmlString baseURL:baseURL];
}
-(IBAction)dogProducts:(id)sender {
    
    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"products_dog" ofType:@"html" inDirectory:@""];
    NSString* htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    
    [petProductsWebview setDelegate:self];
    [petProductsWebview loadHTMLString:htmlString baseURL:baseURL];
}

@end
