//
//  CustomNavigationBar.m
//  PurinaPetPlaces
//
//  Created by Josh Bruce on 11/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CustomNavigationBar.h"
#import "AppDelegate.h"

@implementation CustomNavigationBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    UIImage *backgroundImage = [UIImage imageNamed:@"background_navbar_7.png"];
    [backgroundImage drawInRect:CGRectMake(0, 0, 320, 64)];
    
    if ([AppDelegate isVersion6AndBelow])
    {
        backgroundImage = [UIImage imageNamed:@"background_navbar.png"];
        [backgroundImage drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    }

}

@end
