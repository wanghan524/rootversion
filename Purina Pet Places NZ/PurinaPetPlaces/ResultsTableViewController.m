//
//  ResultsTableViewController.m
//  PurinaPetPlaces
//
//  Created by Josh Bruce on 13/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ResultsTableViewController.h"
#import "PCPetCentricSvc.h"
#import "Locations.h"
#import "Singleton.h"

@interface ResultsTableViewController ()

@end

@implementation ResultsTableViewController
@synthesize dataSource, delegate;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
       [self.view setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    dataSource = [NSMutableArray array];
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 100.0f;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    Singleton *singleton = [Singleton sharedInstance];
    UIImageView * headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    if ([self.currentHeaderImageFlag isEqualToString:@"Stockists"]) {
        headerImageView.image = [UIImage imageNamed:@"stockists-header.jpg"];
    }
    else if ([self.currentHeaderImageFlag isEqualToString:@"Pet Services"]) {
        headerImageView.image = [UIImage imageNamed:@"pet-service-header.jpg"];
    }
    
    else{
        headerImageView.image = [UIImage imageNamed:@"pet-friendly-places-header.jpg"];
    }

    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:headerImageView.frame];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = singleton.selectedSubCategories.CategoryName;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont fontWithName:@"Antenna" size:22];
    titleLabel.textColor = [UIColor whiteColor];
    [headerImageView addSubview:titleLabel];
    return headerImageView;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    cell.backgroundColor = [UIColor clearColor];

    Locations *location = (Locations*)[dataSource objectAtIndex:[indexPath row]];
    
    [cell.textLabel setText:location.LocationName];
    [cell.textLabel setTextColor:[UIColor grayColor]];
    cell.textLabel.font = [UIFont fontWithName:@"Antenna" size:14];
//    if (location.LocationAddressLine1 != NULL) {
//        [cell.detailTextLabel setText:[NSString stringWithFormat:@"%@, %@, %@", location.LocationAddressLine1, location.LocationAddressLine2, location.LocationAddressLine3]];
//        [cell.detailTextLabel setTextColor:[UIColor grayColor]];
//        cell.detailTextLabel.font = [UIFont fontWithName:@"Antenna" size:10];
//    }else {
//        [cell.detailTextLabel setText:@"www.bookabach.co.nz"];
//        [cell.detailTextLabel setTextColor:[UIColor grayColor]];
//        cell.detailTextLabel.font = [UIFont fontWithName:@"Antenna" size:10];
//    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Locations *selectedLocation = (Locations *)[dataSource objectAtIndex:[indexPath row]];
    [self.delegate itemSelected:selectedLocation];
}

@end
