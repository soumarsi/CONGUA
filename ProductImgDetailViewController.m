//
//  ProductImgDetailViewController.m
//  CONGUA
//
//  Created by Priyanka ghosh on 25/06/15.
//  Copyright (c) 2015 Sandeep Dutta. All rights reserved.
//

#import "ProductImgDetailViewController.h"

@interface ProductImgDetailViewController ()

@end

@implementation ProductImgDetailViewController
@synthesize lblDesc,WebView,ProductImgCode,lblUserName;
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    lblUserName.text=[@"Welcome " stringByAppendingString:[prefs valueForKey:@"FullName"]];
    CustomerCode=[prefs valueForKey:@"CustomerCode"];
    AuthToken=[prefs valueForKey:@"AuthToken"];
    ProductCode=[prefs valueForKey:@"ProductCode"];
//    NSLog(@"product doc code=%@",ProductDocCode);
 //   [[NSUserDefaults standardUserDefaults] setObject:ProductDocCode forKey:@"ProductDocCode"];
 //   urlobj=[[UrlconnectionObject alloc]init];
    
  //  [self DocumentViewUrl];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (IBAction)DeleteClick:(id)sender {
}

- (IBAction)EditClick:(id)sender {
}

- (IBAction)BackClick:(id)sender {
}
@end
