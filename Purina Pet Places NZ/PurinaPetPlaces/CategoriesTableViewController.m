//
//  CategoriesTableViewController.m
//  PurinaPetPlaces
//
//  Created by Josh Bruce on 4/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CategoriesTableViewController.h"
#import "PCServices.h"
#import <QuartzCore/QuartzCore.h>
#import "Categories.h"
#import "Singleton.h"

@interface CategoriesTableViewController ()

@end

@implementation CategoriesTableViewController
@synthesize categoryArray, delegate;

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
    /*
    categoryArray = [NSMutableArray array];
    Singleton *sharedSingleton = [Singleton sharedInstance];
    [self setCategoryArray:sharedSingleton.currentCategories];
    NSLog(@"%@", [sharedSingleton.currentCategories objectAtIndex:1]);
    [self.tableView reloadData];
     */

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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    Singleton *sharedSingleton = [Singleton sharedInstance];
    return [sharedSingleton.currentCategories count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//        UIImageView *iconTemplateView;
//        switch (indexPath.row) {
//            case 0:
//                iconTemplateView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_accommodation.png"]];
//                break;
//            case 1:
//                iconTemplateView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_parks.png"]];
//                break;
//            case 2:
//                iconTemplateView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_cafes.png"]];
//                break;
//            case 3:
//                iconTemplateView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_paw.png"]];
//                break;
//            case 4:
//                iconTemplateView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_Stock.png"]];
//                break;
//        }
        
        Singleton *sharedSingleton = [Singleton sharedInstance];
        Categories *categories = (Categories*)[sharedSingleton.currentCategories objectAtIndex:[indexPath row]];
//        [cell.textLabel setText:categories.CategoryName];
//
        cell.backgroundColor = [UIColor clearColor];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, (SCREEN_HEIGHT - 60 - 100 - 50) / 3.0 / 2.0 - 20, cell.frame.size.width, 40)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.text = categories.CategoryName;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont systemFontOfSize:18];
        titleLabel.textColor = [UIColor grayColor];
        [cell.contentView addSubview:titleLabel];
//        
//        [iconTemplateView setFrame:CGRectMake(8, 8, 33, 33)];
//        [cell addSubview:iconTemplateView];
        [cell setIndentationLevel:4];
    }

    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    //[cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
//    Singleton *sharedSingleton = [Singleton sharedInstance];
//    Categories *categories = (Categories*)[sharedSingleton.currentCategories objectAtIndex:[indexPath row]];
//    [cell.textLabel setText:categories.CategoryName];
//    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 100.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 50.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIImageView * headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    headerImageView.backgroundColor = [UIColor greenColor];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:headerImageView.frame];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = @"Pet Friendly Places";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:22];
    titleLabel.textColor = [UIColor whiteColor];
    [headerImageView addSubview:titleLabel];
    return headerImageView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIImageView *footerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    footerImageView.backgroundColor = [UIColor redColor];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:footerImageView.frame];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = @"RECOMMEND A PET FRIENDLY PLACE";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.textColor = [UIColor whiteColor];
    [footerImageView addSubview:titleLabel];
    return footerImageView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return (SCREEN_HEIGHT - 60 - 100 - 50) / 3.0;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    
    Singleton *sharedSingleton = [Singleton sharedInstance];
    Categories *categories = (Categories*)[sharedSingleton.currentCategories objectAtIndex:[indexPath row]];
    [self.delegate itemSelected:categories];
}

@end
