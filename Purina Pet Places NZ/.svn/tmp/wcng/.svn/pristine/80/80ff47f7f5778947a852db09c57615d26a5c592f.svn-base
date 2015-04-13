//
//  ConnectionViewController.h
//  PurinaPetPlaces
//
//  Created by Josh Bruce on 10/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ConnectionViewControllerDelegate <NSObject>
-(void)continueLoading;
@end

@interface ConnectionViewController : UIViewController {
    UIImageView         *connectingImage;
    int                 stepNumber;
    UIButton            *btnRetry;
    id<ConnectionViewControllerDelegate> delegate;
}

@property (retain) id delegate;
@property (nonatomic,retain) IBOutlet UIImageView *connectingImage;
@property (nonatomic, retain) IBOutlet UIButton *btnRetry;

-(IBAction)retryConnection:(id)sender;

@end
