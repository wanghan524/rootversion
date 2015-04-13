//
//  CategoriesViewController.m
//  PurinaPetPlaces
//
//  Created by Josh Bruce on 23/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CategoriesViewController.h"
#import "Singleton.h"
#import "Categories.h"

@interface CategoriesViewController ()

@end

@implementation CategoriesViewController
@synthesize categories, delegate;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
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

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    Singleton *singltonClass = [Singleton sharedInstance];
    return [singltonClass.currentCategories count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Singleton *singltonClass = [Singleton sharedInstance];
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    Categories *category = (Categories *)[singltonClass.currentCategories objectAtIndex:[indexPath row]];
    [cell.textLabel setText:category.CategoryName];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *selectedCell = (UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    [selectedCell setAccessoryType:UITableViewCellAccessoryCheckmark];
    [self.delegate itemSelected:selectedCell.textLabel.text];
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
