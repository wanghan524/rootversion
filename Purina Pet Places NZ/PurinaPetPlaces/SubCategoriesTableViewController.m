//
//  SubCategoriesTableViewController.m
//  PurinaPetPlaces
//
//  Created by Josh Bruce on 4/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SubCategoriesTableViewController.h"
#import "Categories.h"
#import <QuartzCore/QuartzCore.h>
#import "Singleton.h"
#import "StockistsWebviewViewController.h"

@interface SubCategoriesTableViewController ()

@end

@implementation SubCategoriesTableViewController
@synthesize dataSource, selectedCategory, delegate;

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
-(void)viewDidAppear:(BOOL)animated {
    
}
-(void)viewWillAppear:(BOOL)animated {
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    
        return 100.0f;
    
    
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
        Singleton *singleton = [Singleton sharedInstance];
    
    
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
        
        
        
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
        titleLabel.text = singleton.selectedCategories.CategoryName;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont fontWithName:@"Antenna" size:22];
        titleLabel.textColor = [UIColor whiteColor];
        [headerImageView addSubview:titleLabel];
        [backView addSubview:headerImageView];
        
        return backView;
    
    
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    if ([self.currentHeaderImageFlag isEqualToString:@"Pet Services"] || [self.currentHeaderImageFlag isEqualToString:@"Stockists"]) {
        
        
        UIButton *footerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        footerButton.frame = CGRectMake(0, 0, SCREEN_WIDTH, 50);
        footerButton.backgroundColor = [UIColor redColor];
        [footerButton setTitle:@"RECOMMEND A PET FRIENDLY PLACE" forState:UIControlStateNormal];
        footerButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [footerButton addTarget:self action:@selector(footerButtonClick) forControlEvents:UIControlEventTouchUpInside];
        
//        UIImageView *footerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
//        footerImageView.backgroundColor = [UIColor redColor];
//        
//        UILabel *titleLabel = [[UILabel alloc] initWithFrame:footerImageView.frame];
//        titleLabel.backgroundColor = [UIColor clearColor];
//        titleLabel.text = @"RECOMMEND A PET FRIENDLY PLACE";
//        titleLabel.textAlignment = NSTextAlignmentCenter;
//        titleLabel.font = [UIFont fontWithName:@"Antenna" size:14];
//        titleLabel.textColor = [UIColor whiteColor];
//        [footerImageView addSubview:titleLabel];
        return footerButton;
    }else{
        return nil;
    }
    
}

- (void)headerButtonClick{
    
    
    NSLog(@"headerButton");
}

- (void)footerButtonClick{
    [self.delegate nextButtonClickWith:@""];
    
    NSLog(@"footerButton");
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    //return 2;
    
    if ([self.currentHeaderImageFlag isEqualToString:@"Stockists"]){
        return dataSource.count  + 1;
    }else{
        return [dataSource count];
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self.currentHeaderImageFlag isEqualToString:@"Stockists"]) {
        
        if ([dataSource count] > 3) {
            return (SCREEN_HEIGHT - 60 - 100 - 50) / 4.0;
        }else{
            return (SCREEN_HEIGHT - 60 - 100 - 50) / 3.0;
        }
    
        
    }else if([self.currentHeaderImageFlag isEqualToString:@"Pet Services"]){
        if ([dataSource count] > 5) {
            return (SCREEN_HEIGHT - 60 - 100 - 50) / 6.0;

        }else{
            return (SCREEN_HEIGHT - 60 - 100 - 50) / (float)[dataSource count];

        }
    }else{
        return (SCREEN_HEIGHT - 60 - 100) / 4.0;

    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if ([self.currentHeaderImageFlag isEqualToString:@"Pet Services"] || [self.currentHeaderImageFlag isEqualToString:@"Stockists"]) {
        return 50.0f;
    }else{
        return 0;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        
    static NSString *CellIdentifier = @"Cell";
//    UILabel *roundedBall = [[UILabel alloc] init];
//    
//    
//    CGSize countSize = [[NSString stringWithFormat:@"%@", subcategories.CategoryCount] sizeWithFont:[UIFont boldSystemFontOfSize:12] constrainedToSize:CGSizeMake(100, 30) lineBreakMode:UILineBreakModeClip];
//    CGSize textSize = [[NSString stringWithFormat:@"%@", subcategories.CategoryName] sizeWithFont:[UIFont boldSystemFontOfSize:20] constrainedToSize:CGSizeMake(200, 30) lineBreakMode:UILineBreakModeClip];
//    textSize.width = textSize.width + 20;
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];


    }
    if ([self.currentHeaderImageFlag isEqualToString:@"Stockists"]){
        if (indexPath.row == 0) {
            cell.backgroundColor = [UIColor clearColor];
            cell.textLabel.text = @"On line";
            cell.textLabel.font = [UIFont fontWithName:@"Antenna" size:14];
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            cell.textLabel.textColor = [UIColor grayColor];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }else{
            
            Categories *subcategories = (Categories*)[dataSource objectAtIndex:indexPath.row - 1];
            cell.backgroundColor = [UIColor clearColor];
            [cell.textLabel setText:[NSString stringWithFormat:@"%@", subcategories.CategoryName]];
            cell.textLabel.font = [UIFont fontWithName:@"Antenna" size:14];
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            cell.textLabel.textColor = [UIColor grayColor];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
    }else{
        Categories *subcategories = (Categories*)[dataSource objectAtIndex:[indexPath row]];
        cell.backgroundColor = [UIColor clearColor];
        [cell.textLabel setText:[NSString stringWithFormat:@"%@", subcategories.CategoryName]];
        cell.textLabel.font = [UIFont fontWithName:@"Antenna" size:14];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.textColor = [UIColor grayColor];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    
    
    return cell;
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([self.currentHeaderImageFlag isEqualToString:@"Stockists"]){
        if (indexPath.row == 0) {
            [self.delegate onlineButtonClick];
        }else{
            Categories *subcategories = (Categories*)[dataSource objectAtIndex:indexPath.row - 1];
            [self.delegate itemSelected:subcategories];
        }
    }else{
        Categories *subcategories = (Categories*)[dataSource objectAtIndex:[indexPath row]];
        [self.delegate itemSelected:subcategories];
    }
    
    
}

@end
