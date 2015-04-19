//
//  ToolsViewController.m
//  PurinaPetPlaces
//
//  Created by BlueApp on 15-4-18.
//
//

#import "ToolsViewController.h"

@interface ToolsViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSArray *titleArray;;
}


@property (nonatomic, strong) UITableView *myTableView;
@end



@implementation ToolsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self showCustomeNav];
    
    self.view.backgroundColor = [UIColor colorWithRed:242/255.0 green:238/255.0 blue:223/255.0 alpha:1];
    
    self.myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStyleGrouped];
    self.myTableView.backgroundColor = [UIColor colorWithRed:242/255.0 green:238/255.0 blue:223/255.0 alpha:1];
    self.myTableView.dataSource = self;
    self.myTableView.delegate = self;
    [self.view addSubview:self.myTableView];
    // Do any additional setup after loading the view.
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return (SCREEN_HEIGHT - 64 - 100) / 3.0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //Singleton *sharedSingleton = [Singleton sharedInstance];
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    titleArray = [[NSArray alloc] init];
    
    titleArray = @[@"Pet health compass",@"What should i feed my dog",@"Products"];
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, (SCREEN_HEIGHT - 64 - 100) / 3.0 / 2.0- 20, cell.frame.size.width, 40)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.text = titleArray[indexPath.row];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont systemFontOfSize:20];
        titleLabel.textColor = [UIColor grayColor];
        [cell.contentView addSubview:titleLabel];
        //
        //        [iconTemplateView setFrame:CGRectMake(8, 8, 33, 33)];
        //        [cell addSubview:iconTemplateView];
        [cell setIndentationLevel:4];
    }
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, (SCREEN_HEIGHT - 64 - 100) / 3.0)];
    backView.backgroundColor = [UIColor whiteColor];
    cell.selectedBackgroundView = backView;
    
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleDefault];
    //[cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 100.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIImageView * headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    headerImageView.image = [UIImage imageNamed:@"tools-header0.png"];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:headerImageView.frame];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = @"Tools";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:22];
    titleLabel.textColor = [UIColor whiteColor];
    [headerImageView addSubview:titleLabel];
    return headerImageView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
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
