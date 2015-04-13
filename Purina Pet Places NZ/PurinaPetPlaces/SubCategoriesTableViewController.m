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
    UIImageView * headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    headerImageView.backgroundColor = [UIColor greenColor];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:headerImageView.frame];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = singleton.selectedCategories.CategoryName;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:22];
    titleLabel.textColor = [UIColor whiteColor];
    [headerImageView addSubview:titleLabel];
    return headerImageView;
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
    
   return [dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Categories *subcategories = (Categories*)[dataSource objectAtIndex:[indexPath row]];
        
    static NSString *CellIdentifier = @"Cell";
    UILabel *roundedBall = [[UILabel alloc] init];
    
    
    CGSize countSize = [[NSString stringWithFormat:@"%@", subcategories.CategoryCount] sizeWithFont:[UIFont boldSystemFontOfSize:12] constrainedToSize:CGSizeMake(100, 30) lineBreakMode:UILineBreakModeClip];
    CGSize textSize = [[NSString stringWithFormat:@"%@", subcategories.CategoryName] sizeWithFont:[UIFont boldSystemFontOfSize:20] constrainedToSize:CGSizeMake(200, 30) lineBreakMode:UILineBreakModeClip];
    textSize.width = textSize.width + 20;
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];

        [roundedBall.layer setCornerRadius:8];
        [roundedBall setFont:[UIFont boldSystemFontOfSize:12]];
        [roundedBall setBackgroundColor:[UIColor colorWithRed:170/255.0 green:170/255.0 blue:170/255.0 alpha:1]];
        [roundedBall setTextColor:[UIColor whiteColor]];
        [roundedBall setTag:11];
        [roundedBall setTextAlignment:NSTextAlignmentCenter];
        [roundedBall.layer setCornerRadius:8];
        [roundedBall setFrame:CGRectMake(textSize.width, 9, countSize.width + 20, 25)];
        [cell.contentView addSubview:roundedBall];
    }else {
        roundedBall = (UILabel *)[cell.contentView viewWithTag:11];
        [roundedBall setFrame:CGRectMake(textSize.width, 9, countSize.width + 20, 25)];
    }

    [roundedBall setText:[NSString stringWithFormat:@"%@", subcategories.CategoryCount]];
    [cell.textLabel setText:[NSString stringWithFormat:@"%@", subcategories.CategoryName]];           
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Categories *subcategories = (Categories*)[dataSource objectAtIndex:[indexPath row]];
    [self.delegate itemSelected:subcategories];
}

@end
