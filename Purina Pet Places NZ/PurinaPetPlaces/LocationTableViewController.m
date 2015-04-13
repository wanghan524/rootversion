//
//  LocationTableViewController.m
//  PurinaPetPlaces
//
//  Created by Josh Bruce on 17/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LocationTableViewController.h"
#import "Locations.h"
#import "AppDelegate.h"

@interface LocationTableViewController ()

@end

@implementation LocationTableViewController
@synthesize dataSource, categorySize, locationSize, delegate;

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
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0)
        if ([dataSource.LocationBookABatchId isEqualToString:@"0"])
            return 0;
        else
            return 100;
        
    else
        return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    if (section == 0 && ![dataSource.LocationBookABatchId isEqualToString:@"0"]) {
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];

        UIButton *bookABatchButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 15, 300, 45)];
        [bookABatchButton addTarget:self action:@selector(openWebsite) forControlEvents:UIControlEventTouchUpInside];
        [bookABatchButton setBackgroundImage:[UIImage imageNamed:@"button_BookABatch"] forState:UIControlStateNormal];
        [footerView addSubview:bookABatchButton];
        
        return footerView;
    } else {
        return nil;
    }
}

-(void)openWebsite {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"This will close this application and open this website in a seperate window. Do you wish to continue?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:nil];
	[alert setTag:1];
	[alert addButtonWithTitle:@"Yes"];      
	[alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"AlertViewTag %i", alertView.tag);
    if (buttonIndex == 1) {
        if (alertView.tag == 1) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.bookabach.co.nz/search/view/%@", dataSource.LocationBookABatchId]]];
            
        }else {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://+64%@", [[dataSource.LocationPhoneNumber substringFromIndex:1] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]]];
        }
        
    }
    
    
    
    // NSLog(@"dimissed %@", [NSString stringWithFormat:@"tel://+64%@", [[dataSource.LocationPhoneNumber substringFromIndex:1] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]);
    
}



#pragma mark - Table view data source



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([dataSource.LocationBookABatchId isEqualToString:@"0"]) {
        return 2;
    } else {
        return 1;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            if (![dataSource.LocationLongLat isEqualToString:@""])
                return 2;
            else
                return 1;
            break;
        case 1:
            if ([dataSource.LocationBookABatchId isEqualToString:@"0"])
                return 2;
            break;
    }
    return 0;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    
    UILabel *lblLocationName = [[UILabel alloc] init];
    [lblLocationName setFont:[UIFont boldSystemFontOfSize:16]];
    [lblLocationName setBackgroundColor:[UIColor clearColor]];
    [lblLocationName setNumberOfLines:0];
    [lblLocationName setLineBreakMode:UILineBreakModeWordWrap];
    [lblLocationName setTag:1];
    
    UILabel *lblLocationCategory = [[UILabel alloc] initWithFrame:CGRectMake(87, 30, 260, 20)];
    [lblLocationCategory setFont:[UIFont italicSystemFontOfSize:14]];
    [lblLocationCategory setBackgroundColor:[UIColor clearColor]];
    [lblLocationCategory setTextColor:[UIColor grayColor]];
    [lblLocationCategory setNumberOfLines:0];
    [lblLocationCategory setLineBreakMode:UILineBreakModeWordWrap];
    [lblLocationCategory setTag:2];
    
    UILabel *lblViewLocation = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
    [lblViewLocation setFont:[UIFont systemFontOfSize:14]];
    [lblViewLocation setBackgroundColor:[UIColor clearColor]];
    [lblViewLocation setTextColor:[UIColor colorWithRed:54/255.0 green:101/255.0 blue:174/255.0 alpha:1]];
    [lblViewLocation setTextAlignment:UITextAlignmentCenter];
    [lblViewLocation setTag:4];
    
    UIImageView *mapsIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_map.png"]];
    mapsIcon.layer.masksToBounds = YES;
    mapsIcon.layer.cornerRadius = 8.0f;
    [mapsIcon setFrame:CGRectMake(5, 5, 72, 72)];
    [mapsIcon setTag:3];
    
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
        
        if ([indexPath section] == 0) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }else{
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
    }else {
        
        lblLocationName = (UILabel *)[cell viewWithTag:1];
        [lblLocationName removeFromSuperview];
        
        lblLocationCategory = (UILabel *)[cell viewWithTag:2];
        [lblLocationCategory removeFromSuperview];
        
        lblViewLocation = (UILabel *)[cell viewWithTag:4];
        [lblViewLocation removeFromSuperview];
        
        mapsIcon = (UIImageView *)[cell viewWithTag:3];
        [mapsIcon removeFromSuperview];
        
    }
    
    if ([indexPath section] == 0) {
        
        switch ([indexPath row]) {
        case 0:
                /*
                NSLog(@"=======================================");
                NSLog(@"Location Id: %@", dataSource.LocationId);
                NSLog(@"Location Name: %@", dataSource.LocationName);
                NSLog(@"Location A1: %@", dataSource.LocationAddressLine1);
                NSLog(@"Location A2: %@", dataSource.LocationAddressLine2);
                NSLog(@"Location A3: %@", dataSource.LocationAddressLine3);
                NSLog(@"Location A4: %@", dataSource.LocationAddressLine4);
                NSLog(@"Location Fax: %@", dataSource.LocationFaxNumber);
                NSLog(@"Location Long Lat: %@", dataSource.LocationLongLat);
                NSLog(@"Location Phone Number: %@", dataSource.LocationPhoneNumber);
                NSLog(@"Location Book a Batch: %@", dataSource.LocationBookABatchId);
                NSLog(@"=======================================");
                 */
            
            [lblLocationName setText:dataSource.LocationName];
            [lblLocationName setFrame:CGRectMake(87, 10, locationSize.width + 10, locationSize.height)];
            [lblLocationCategory setText:[NSString stringWithFormat:@"%@ - %@", dataSource.LocationCategoryName, dataSource.LocationSubCategoryName]];
            [lblLocationCategory setFrame:CGRectMake(87, locationSize.height + 10, categorySize.width + 10, categorySize.height)];
                NSLog(@"Cat %f / %f", categorySize.width, categorySize.height);
            [cell.contentView addSubview:mapsIcon];
            [cell.contentView addSubview:lblLocationName];
            [cell.contentView addSubview:lblLocationCategory];
            break;
        case 1:

            [lblViewLocation setText:@"View Location on Map"];
            [cell.contentView addSubview:lblViewLocation];
            [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
            [lblViewLocation setTextColor: [UIColor redColor]];
        }
        
    }else {
        switch ([indexPath row]) {
            case 0:
                [cell.detailTextLabel setText:[NSString stringWithFormat:@"%@ \n%@ \n%@ \n%@", dataSource.LocationAddressLine1, dataSource.LocationAddressLine2, dataSource.LocationAddressLine3, dataSource.LocationAddressLine4 ]];
                [cell.detailTextLabel setLineBreakMode:UILineBreakModeWordWrap];
                [cell.detailTextLabel setNumberOfLines:0];
                [cell.textLabel setText:@"Address"];
                [cell.textLabel setTextColor: [UIColor darkGrayColor]];
                break;
            case 1:
                if ([dataSource.LocationPhoneNumber isEqualToString:@""]){
                    [cell.detailTextLabel setText:@""];
                    [cell.detailTextLabel setTextColor:[UIColor lightGrayColor]];
                } else {
                    [cell.detailTextLabel setText:dataSource.LocationPhoneNumber];
                }
                [cell.detailTextLabel setLineBreakMode:UILineBreakModeWordWrap];
                [cell.detailTextLabel setNumberOfLines:0];
                [cell.textLabel setText:@"Phone"];
                [cell.textLabel setTextColor: [UIColor darkGrayColor]];
                break;
                /*
            case 2:
                if ([dataSource.LocationFaxNumber isEqualToString:@""]){
                    [cell.detailTextLabel setText:@""];
                    [cell.detailTextLabel setTextColor:[UIColor lightGrayColor]];
                } else {
                    [cell.detailTextLabel setText:dataSource.LocationFaxNumber];
                }
                [cell.detailTextLabel setLineBreakMode:UILineBreakModeWordWrap];
                [cell.detailTextLabel setNumberOfLines:0];
                [cell.textLabel setText:@"Fax"];
                [cell.textLabel setTextColor: [UIColor darkGrayColor]];
                break;
                 */
        }
    }
    
    
    
    
      
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGSize dynamicAddressSize = [[NSString  stringWithFormat:@"%@\n%@\n%@\n%@", dataSource.LocationAddressLine1, dataSource.LocationAddressLine2, dataSource.LocationAddressLine3, dataSource.LocationAddressLine4] sizeWithFont:[UIFont italicSystemFontOfSize:16] constrainedToSize:CGSizeMake(200, 500) lineBreakMode:UILineBreakModeWordWrap];
    
    if ([indexPath section] == 0) {
        switch ([indexPath row]) {
            case 0:
                return [self rowHeightDirtyDetails:indexPath];
                break;
            case 1:
                return 40;
                break;
        }
    } else {
        switch ([indexPath row]) {
            case 0:
                return dynamicAddressSize.height + 20;
                break;
            case 1:
                return 40;
                break;
            case 2:
                return 40;
                break;
        }
    }
    return 100;
}

- (CGFloat)rowHeightDirtyDetails:(NSIndexPath *)indexPath {
    locationSize = [dataSource.LocationName sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(200, 500) lineBreakMode:UILineBreakModeWordWrap];
    categorySize = [[NSString stringWithFormat:@"%@ - %@", dataSource.LocationCategoryName, dataSource.LocationSubCategoryName] sizeWithFont:[UIFont italicSystemFontOfSize:14] constrainedToSize:CGSizeMake(200, 500) lineBreakMode:UILineBreakModeWordWrap];
    
    CGSize dynamicSize = CGSizeMake(0, locationSize.height + categorySize.height + 30);
    
    if (dynamicSize.height < 82) {
        return 92;
    }else {
        return dynamicSize.height;
    }

}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([indexPath row] == 1 && [indexPath section] == 0)
        [self.delegate itemSelected:dataSource];
    
    
    if (![dataSource.LocationPhoneNumber isEqualToString:@""]) {
        if ([indexPath row] == 1 && [indexPath section] == 1) {
            UIAlertView *callAlert = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"%@", dataSource.LocationPhoneNumber] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Call", nil];
            [callAlert setTag:2];
            [callAlert setDelegate:self];
            [callAlert show];
            
        }
    }
    

}




@end
