//
//  PetInfoProductsViewController.h
//  PurinaPetPlaces
//
//  Created by Josh Bruce on 2/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface PetInfoProductsViewController : UIViewController <UIAlertViewDelegate, MFMailComposeViewControllerDelegate, UIWebViewDelegate> {
    UIScrollView        *theCatScroller;
    UIScrollView        *theDogScroller;
    UIImageView         *catInfoGraphic;
    UIImageView         *dogInfoGraphic;
    UITouch             *touch;
    NSArray             *catLinkArray;
    NSArray             *dogLinkArray;
    
    UIWebView           *petProductsWebview;
    UIToolbar           *petInfoToolbar;
}
@property (nonatomic, retain) UIScrollView *theCatScroller;
@property (nonatomic, retain) UIScrollView *theDogScroller;
@property (nonatomic, retain) UIImageView *catinfoGraphic;
@property (nonatomic, retain) UIImageView *dogInfoGraphic;
@property (nonatomic, retain) UITouch *touch;
@property (nonatomic, retain) NSArray *catLinkArray;
@property (nonatomic, retain) NSArray *dogLinkArray;
@property (nonatomic, retain) IBOutlet UIWebView *petProductsWebview;
@property (nonatomic, strong) IBOutlet UIToolbar *petInfoToolbar;

-(void)menuSlideOut:(NSString *)petType;
-(void)showMeThe:(NSString*)petType;
-(UIScrollView *)tellMeWhatsVisible;

-(IBAction)catProducts:(id)sender;
-(IBAction)dogProducts:(id)sender;
@end
