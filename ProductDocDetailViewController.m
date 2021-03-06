//
//  ProductDocDetailViewController.m
//  CONGUA
//
//  Created by Priyanka ghosh on 25/06/15.
//  Copyright (c) 2015 Sandeep Dutta. All rights reserved.
//

#import "ProductDocDetailViewController.h"

@interface ProductDocDetailViewController ()<UIAlertViewDelegate>

@end

@implementation ProductDocDetailViewController
@synthesize mainscroll,lblDesc,lblDocType,lblDocName,WebView,ProductDocCode,lblUserName;

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.mainscroll setContentSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, 520)];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    lblUserName.text=[@"Welcome " stringByAppendingString:[prefs valueForKey:@"FullName"]];
    CustomerCode=[prefs valueForKey:@"CustomerCode"];
    AuthToken=[prefs valueForKey:@"AuthToken"];
    ProductCode=[prefs valueForKey:@"ProductCode"];
    NSLog(@"product doc code=%@",ProductDocCode);
    [[NSUserDefaults standardUserDefaults] setObject:ProductDocCode forKey:@"ProductDocCode"];
    urlobj=[[UrlconnectionObject alloc]init];
    
    [self DocumentViewUrl];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)DocumentViewUrl
{
    @try {
        
        
        
        NSString *str=[NSString stringWithFormat:@"%@GetProductDocInfoDetail/%@?ProductCode=%@&ProductDocCode=%@",URL_LINK,AuthToken,ProductCode,ProductDocCode];
        NSLog(@"str=%@",str);
        BOOL net=[urlobj connectedToNetwork];
        if (net==YES) {
            [urlobj global:str typerequest:@"array" withblock:^(id result, NSError *error,BOOL completed) {
                
                if ([[result valueForKey:@"IsSuccess"] integerValue]==1)
                {
                    /*
                     for ( NSDictionary *tempDict1 in  [result objectForKey:@"ResultInfo"])
                     {
                     [ArrPortDetail addObject:tempDict1];
                     
                     }
                     */
                    
                    lblDocName.text=[[result objectForKey:@"ResultInfo"] valueForKey:@"DocName"];
                    
                    lblDesc.text=[[result objectForKey:@"ResultInfo"] valueForKey:@"Description"];
                    //dynamic height of label
                    NSString *str=[NSString stringWithFormat:@"%@",[[result objectForKey:@"ResultInfo"] valueForKey:@"Description"]];
                    
                    NSInteger rw=ceil(str.length/65.0);
                    NSInteger len=rw*25;
                    
                    
                    lblDesc.frame=CGRectMake(lblDesc.frame.origin.x, lblDesc.frame.origin.y,lblDesc.frame.size.width, len);
                    
                    
                    
                    
                    
                    FileName=[NSString stringWithFormat:@"%@",[[result objectForKey:@"ResultInfo"] valueForKey:@"FileName"]];
                    
                    
                    if ([[[result objectForKey:@"ResultInfo"] valueForKey:@"DocTypeCode"] integerValue] ==1) {
                        lblDocType.text=@"Purchase Receipt";
                    }
                    else if ([[[result objectForKey:@"ResultInfo"] valueForKey:@"DocTypeCode"] integerValue] ==2) {
                        lblDocType.text=@"Insurance Certificate";
                    }
                    else if ([[[result objectForKey:@"ResultInfo"] valueForKey:@"DocTypeCode"] integerValue] ==99) {
                        lblDocType.text=@"Others";
                    }
                    
                    
                    
                }
                else if ([[result valueForKey:@"Description"] isEqualToString:@"AuthToken has expired."])
                {
                    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
                    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
                    login *obj1=[self.storyboard instantiateViewControllerWithIdentifier:@"login"];
                    [self.navigationController pushViewController:obj1 animated:YES];
                }
                else
                {
                    
                    UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"Error" message:@"Unsucessful...." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [aler show];
                }
                
                
                
                
            }];
        }
        else{
            UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"No Network Connection." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [aler show];
        }
    }
    @catch (NSException *exception)
    {
    }
    @finally {
        
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

- (IBAction)BackClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)downloadClick:(id)sender
{
    if (FileName.length==0)
    {
        UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"File not Available" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [aler show];
    }
    else
    {
      //  WebView.hidden=NO;
        [self DownloadUrl];
    }

}
-(void)DownloadUrl
{
    @try {
        
        //  FileName=@"34.png";
        NSString *str=[NSString stringWithFormat:@"%@DownloadFile/%@?CustomerCode=%@&FileName=%@",URL_LINK,AuthToken,CustomerCode,FileName];
        NSLog(@"str=%@",str);
        
         [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    //    NSURL *url = [NSURL URLWithString:str];
    //    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    //    [WebView loadRequest:requestObj];
        
        /*
         BOOL net=[urlobj connectedToNetwork];
         if (net==YES) {
         [urlobj global:str typerequest:@"array" withblock:^(id result, NSError *error,BOOL completed) {
         
         NSLog(@"result=%@",result);
         if ([[result valueForKey:@"IsSuccess"] integerValue]==1)
         {
         
         
         
         
         }
         else if ([[result valueForKey:@"Description"] isEqualToString:@"AuthToken has expired."])
         {
         NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
         [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
         login *obj1=[self.storyboard instantiateViewControllerWithIdentifier:@"login"];
         [self.navigationController pushViewController:obj1 animated:YES];
         }
         else
         {
         
         UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"Error" message:@"Unsucessful...." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
         [aler show];
         }
         
         
         
         
         }];
         }
         else{
         UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"No Network Connection." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
         [aler show];
         }
         */
    }
    @catch (NSException *exception)
    {
    }
    @finally {
        
    }
    
    
    
    
}
- (IBAction)DeleteClick:(id)sender
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert" message:@" Do you want to Delete This Document?" delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
    [alertView show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == [alertView cancelButtonIndex])
    {
        
    }
    else
    {
        [self DeleteDocumentUrl];
        
        
    }
    
    
}
-(void)DeleteDocumentUrl
{
    @try {
        
        
        
        NSString *str=[NSString stringWithFormat:@"%@DeleteProductDoc/%@?ProductCode=%@&ProductDocCode=%@",URL_LINK,AuthToken,ProductCode,ProductDocCode];
        NSLog(@"str=%@",str);
        BOOL net=[urlobj connectedToNetwork];
        if (net==YES) {
            [urlobj global:str typerequest:@"array" withblock:^(id result, NSError *error,BOOL completed) {
                NSLog(@"array=%@",result);
                if ([[result valueForKey:@"IsSuccess"] integerValue]==1)
                {
                    /* UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"Success" message:@"Unsucessful...." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     [aler show];
                     */
                    [self.navigationController popViewControllerAnimated: YES];
                }
                else if ([[result valueForKey:@"Description"] isEqualToString:@"AuthToken has expired."])
                {
                    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
                    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
                    login *obj1=[self.storyboard instantiateViewControllerWithIdentifier:@"login"];
                    [self.navigationController pushViewController:obj1 animated:YES];
                }
                else
                {
                    
                    UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"Error" message:@"Unsucessful...." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [aler show];
                }
                
                
                
                
            }];
        }
        else{
            UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"No Network Connection." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [aler show];
        }
    }
    @catch (NSException *exception)
    {
    }
    @finally {
        
    }
    
    
    
    
}
- (IBAction)EditClick:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    EditProductDocViewController *pv2vc = [storyboard instantiateViewControllerWithIdentifier:@"EditProductDocViewControllersid"];
   
    
    [self.navigationController pushViewController:pv2vc animated:YES];
}
@end
