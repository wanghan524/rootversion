//
//  SearchTableViewController.h
//  PurinaPetPlaces
//
//  Created by Josh Bruce on 12/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "BSForwardGeocoder.h"
#import "BSKmlResult.h"

@interface SearchTableViewController : UITableViewController <UITextFieldDelegate, CLLocationManagerDelegate, BSForwardGeocoderDelegate> {
    UITextField             *tfSuburb;
    UITextField             *tfSearchTerm;
    UISegmentedControl      *segDistance;
    CLLocationManager       *currentUserLocation;
    UIView                  *blackLoadingScreen;
    BSForwardGeocoder       *forwardGeocoder;
    NSString                *selectedCategory;
    UIButton                *btnSearch;
    BOOL                    update;
}

@property (nonatomic, retain) UITextField *tfSuburb;
@property (nonatomic, retain) UITextField *tfSearchTerm;
@property (nonatomic, retain) UISegmentedControl *segDistance;
@property (nonatomic, retain) CLLocationManager *currentUserLocation;
@property (nonatomic, retain) UIView *blackLoadingScreen;
@property (nonatomic, retain) BSForwardGeocoder *forwardGeocoder;
@property (nonatomic, retain) NSString *selectedCategory;
@property (nonatomic, retain) UIButton *btnSearch;

-(void)itemSelected:(NSString *)passedSelectedCategory;

@end
