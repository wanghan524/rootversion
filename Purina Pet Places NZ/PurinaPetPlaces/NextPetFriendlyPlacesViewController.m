//
//  NextPetFriendlyPlacesViewController.m
//  PurinaPetPlaces
//
//  Created by BlueApp on 15-4-13.
//
//

#import "NextPetFriendlyPlacesViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "Categories.h"
#import "Singleton.h"
#import "PCPetCentricSvc.h"
#import "AppDelegate.h"

@interface NextPetFriendlyPlacesViewController ()

@end

@implementation NextPetFriendlyPlacesViewController
@synthesize lblHeading,subCategoriesTableViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
//        CAGradientLayer *gradient = [CAGradientLayer layer];
//        [gradient setFrame:self.view.bounds];
//        [gradient setColors:[NSArray arrayWithObjects:(id)[UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1].CGColor, (id)[UIColor colorWithRed:253/255.0 green:253/255.0 blue:253/255.0 alpha:1].CGColor, nil]];
//        [self.view.layer insertSublayer:gradient atIndex:0];
//        
//        [lblHeading.layer setShadowColor:[UIColor blackColor].CGColor];
//        [lblHeading.layer setShadowOffset:CGSizeMake(2, 2)];
//        [lblHeading.layer setShadowOpacity:0.5f];
//        [lblHeading.layer setShadowRadius:3.0];
//        [lblHeading.layer setMasksToBounds:NO];
        
        
        
        
        
        [self.view addSubview:subCategoriesTableViewController.view];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self showCustomeNav];
    
    Singleton *singleton = [Singleton sharedInstance];
   // [lblHeading setText:[NSString stringWithFormat:@"%@", singleton.selectedCategories.CategoryName]];
    
    subCategoriesTableViewController = [[SubCategoriesTableViewController alloc] initWithStyle:UITableViewStylePlain];
    
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone && [UIScreen mainScreen].bounds.size.height == 568)
    {
        [subCategoriesTableViewController.view setFrame:CGRectMake(0, 60, SCREEN_WIDTH, SCREEN_HEIGHT - 60)];
        
    } else {
        [subCategoriesTableViewController.view setFrame:CGRectMake(0, 60, SCREEN_WIDTH, SCREEN_HEIGHT - 60)];
    }
    
    [subCategoriesTableViewController setDelegate:self];
    [subCategoriesTableViewController setDataSource:singleton.currentSubCategories];
    [self setDelegateByParentId:singleton.currentSubCategories withParentId:singleton.selectedCategories.CategoryId];
    // Do any additional setup after loading the view.
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
