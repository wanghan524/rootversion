//
//  StockistsWebviewViewController.m
//  PurinaPetPlaces
//
//  Created by BlueApp on 15-6-28.
//
//

#import "StockistsWebviewViewController.h"
#import "MBProgressHUD.h"

@interface StockistsWebviewViewController ()<UIWebViewDelegate>{
    UIWebView *petProductsWebview ;
    MBProgressHUD *hud;
 
}


@end

@implementation StockistsWebviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.flag = @"nav";
    
    [self showCustomeNav];
    CGRect rect = [self.view frame];
    NSURL *url = [NSURL URLWithString:self.webString];
    
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, rect.size.width,rect.size.height - 64)];
    
    webView.scalesPageToFit = YES;
    webView.delegate = self;
    [webView loadRequest:request];
    [self.view addSubview:webView];
    
    hud = [[MBProgressHUD alloc] initWithView:self.view];
    hud.dimBackground = YES;
    hud.labelText = @"Wait...";
    [self.view addSubview:hud];
    [hud show:YES];
    // Do any additional setup after loading the view.
}


- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [hud removeFromSuperview];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [hud removeFromSuperview];
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
