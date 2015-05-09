//
//  ProductDetailViewController.m
//  PurinaPetPlaces
//
//  Created by BlueApp on 15-4-15.
//
//

#import "ProductDetailViewController.h"

@interface ProductDetailViewController ()<UIWebViewDelegate>{
    UIWebView *petProductsWebview ;
    UILabel *nextLabel;
    UIImageView *nextImage;
   
}

@property (nonatomic, strong) UIButton *nextButton;
@end

@implementation ProductDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self showCustomeNav];
    
    petProductsWebview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 60)];
    [self.view addSubview:petProductsWebview];
    
    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"dog-%@",self.animalFlag] ofType:@"html" inDirectory:@""];
    NSString* htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    
    [petProductsWebview setDelegate:self];
    [petProductsWebview loadHTMLString:htmlString baseURL:baseURL];
    
    
    UILabel *visitLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 60, (SCREEN_WIDTH / 5.0) * 1.5 - 1, 60)];
    visitLabel.backgroundColor = [UIColor redColor];
    NSString *str = @"VISIT    WEBSITE";
    visitLabel.text = str;
    visitLabel.textColor = [UIColor whiteColor];
    visitLabel.numberOfLines = 0;
    visitLabel.textAlignment = NSTextAlignmentCenter;
    visitLabel.font = [UIFont fontWithName:@"Antenna" size:15];
    [self.view addSubview:visitLabel];
    
    self.nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.nextButton.frame = CGRectMake((SCREEN_WIDTH / 5.0) * 1.5, SCREEN_HEIGHT - 60, (SCREEN_WIDTH / 5.0) * 3.5, 60);
    self.nextButton.backgroundColor = [UIColor redColor];
    [self.nextButton addTarget:self action:@selector(nextButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.nextButton];
    
    nextLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, (SCREEN_WIDTH / 5.0) * 3.5, 60)];
    nextLabel.backgroundColor = [UIColor redColor];
    nextLabel.text = @"NEXT PRODUCT";
    nextLabel.textColor = [UIColor whiteColor];
    nextLabel.textAlignment = NSTextAlignmentCenter;
    nextLabel.font = [UIFont fontWithName:@"Antenna" size:15];
    nextLabel.numberOfLines = 0;
    [self.nextButton addSubview:nextLabel];
    
    nextImage = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH / 5.0) * 3.5 - 40, 20, 20, 20)];
    nextImage.image = [UIImage imageNamed:@"next-btn.jpg"];
    [self.nextButton addSubview:nextImage];


    // Do any additional setup after loading the view.
}

- (void)nextButtonClick{
    
    
    
    
    NSArray *imageNameArray = @[@"pro-plan",@"purina-one",@"tux",@"dog-chow",@"mighty-dog",@"beneful",@"beggin"];
    
    if (self.num < imageNameArray.count - 1) {
        
        self.num ++;
        NSString *htmlFile = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"dog-%@",imageNameArray[self.num]] ofType:@"html" inDirectory:@""];
        NSString* htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
        
        NSString *path = [[NSBundle mainBundle] bundlePath];
        NSURL *baseURL = [NSURL fileURLWithPath:path];
        
        [petProductsWebview loadHTMLString:htmlString baseURL:baseURL];
    }else{
        
        NSString *htmlFile = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"dog-%@",imageNameArray[self.num]] ofType:@"html" inDirectory:@""];
        NSString* htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
        
        NSString *path = [[NSBundle mainBundle] bundlePath];
        NSURL *baseURL = [NSURL fileURLWithPath:path];
        
        [petProductsWebview loadHTMLString:htmlString baseURL:baseURL];
        nextLabel.text = @"LAST ONE";
        nextLabel.font = [UIFont fontWithName:@"Antenna" size:15];
        nextImage.image = [UIImage imageNamed:@""];
        nextImage.backgroundColor = [UIColor clearColor];
    
    }
    
    
    
    
   
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
