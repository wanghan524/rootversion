//
//  PetInfoTableViewController.m
//  PurinaPetPlaces
//
//  Created by Josh Bruce on 30/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PetInfoTableViewController.h"
#import "PetInfoTipsViewController.h"

@interface PetInfoTableViewController ()

@end

@implementation PetInfoTableViewController
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
    dataSource = [[NSMutableArray alloc] initWithObjects:@"Pet Products", @"Pet Tips and Facts", nil];
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
    return [dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        UIImageView *iconTemplateView;
        if (indexPath.row == 1)
            iconTemplateView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_PetTips.png"]];
        else 
            iconTemplateView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_PetProducts.png"]];
        
        [iconTemplateView setFrame:CGRectMake(8, 8, 33, 33)];
        [cell addSubview:iconTemplateView];
        [cell setIndentationLevel:4];
    }
    
    [cell.textLabel setText:[dataSource objectAtIndex:[indexPath row]]];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    return cell;

}

#pragma mark - Table view delegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        [self.delegate itemSelected];
    } else {
        [self.delegate openImage];
    }
    
}


@end
