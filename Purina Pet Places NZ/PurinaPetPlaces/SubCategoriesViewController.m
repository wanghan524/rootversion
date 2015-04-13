//
//  SubCategoriesViewController.m
//  PurinaPetPlaces
//
//  Created by Josh Bruce on 4/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SubCategoriesViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "Categories.h"
#import "Singleton.h"
#import "PCPetCentricSvc.h"
#import "AppDelegate.h"

@interface SubCategoriesViewController ()

@end

@implementation SubCategoriesViewController
@synthesize subCategoriesTableViewController, parentCategory, lblHeading, resultsViewController, arraySubCategories, selectedCategory;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        CAGradientLayer *gradient = [CAGradientLayer layer];
        [gradient setFrame:self.view.bounds];
        [gradient setColors:[NSArray arrayWithObjects:(id)[UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1].CGColor, (id)[UIColor colorWithRed:253/255.0 green:253/255.0 blue:253/255.0 alpha:1].CGColor, nil]];
        [self.view.layer insertSublayer:gradient atIndex:0];
        
        [lblHeading.layer setShadowColor:[UIColor blackColor].CGColor];
        [lblHeading.layer setShadowOffset:CGSizeMake(2, 2)];
        [lblHeading.layer setShadowOpacity:0.5f];
        [lblHeading.layer setShadowRadius:3.0];
        [lblHeading.layer setMasksToBounds:NO];
        
        
        
        
        
        [self.view addSubview:subCategoriesTableViewController.view]; 
        
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil]; 
        if ([backButton respondsToSelector:@selector(setTintColor:)]) {
            [backButton setTintColor:[UIColor colorWithRed:206/255.0 green:206/255.0 blue:206/255.0 alpha:1]];
            NSDictionary *titleBarProperties = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:89/255.0 green:89/255.0 blue:89/255.0 alpha:1], UITextAttributeTextColor, [UIColor whiteColor], UITextAttributeTextShadowColor, nil];
            [backButton setTitleTextAttributes:titleBarProperties forState:UIControlStateNormal];
        }
        [self.navigationItem setBackBarButtonItem:backButton];
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    Singleton *singleton = [Singleton sharedInstance];
    [lblHeading setText:[NSString stringWithFormat:@"Select from %@", singleton.selectedCategories.CategoryName]];
    
    subCategoriesTableViewController = [[SubCategoriesTableViewController alloc] initWithStyle:UITableViewStylePlain];
    
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone && [UIScreen mainScreen].bounds.size.height == 568)
    {
            [subCategoriesTableViewController.view setFrame:CGRectMake(0, 41, 320, 418)];
        
    } else {
            [subCategoriesTableViewController.view setFrame:CGRectMake(0, 41, 320, 330)];
    }
    
    [subCategoriesTableViewController setDelegate:self];
    [subCategoriesTableViewController setDataSource:singleton.currentSubCategories];
    [self setDelegateByParentId:singleton.currentSubCategories withParentId:singleton.selectedCategories.CategoryId];

    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

-(void)viewWillAppear:(BOOL)animated {

}

-(void)setDelegateByParentId:(NSMutableArray *)singletonArray withParentId:(NSNumber *)parentId {
    NSMutableArray *filteredArray = [NSMutableArray array];
    for (Categories* category in singletonArray) { 
        if (category.ParentCategoryId == parentId) {
            [filteredArray addObject:category];
            
        }
    }
    [subCategoriesTableViewController setDataSource:filteredArray];
    [subCategoriesTableViewController.tableView reloadData];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)itemSelected:(Categories*)category {
    
    Singleton *singleton = [Singleton sharedInstance];
    [singleton setSelectedSubCategories:category];
    
    resultsViewController = [[ResultsViewController alloc] initWithNibName:@"ResultsViewController" bundle:nil];
    [self.navigationController pushViewController:resultsViewController animated:YES];
    
    
}

@end
