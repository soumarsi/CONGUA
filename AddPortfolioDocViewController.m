//
//  AddPortfolioDocViewController.m
//  CONGUA
//
//  Created by Priyanka ghosh on 13/06/15.
//  Copyright (c) 2015 Sandeep Dutta. All rights reserved.
//

#import "AddPortfolioDocViewController.h"

@interface AddPortfolioDocViewController ()<UITextFieldDelegate,UITextViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate>

@end

@implementation AddPortfolioDocViewController
@synthesize mainscroll,btnDocType,txtDocName,txtvwDescription,lblDesc,lblDocType,DocImage,btnSubmit;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    CustomerCode=[prefs valueForKey:@"CustomerCode"];
    AuthToken=[prefs valueForKey:@"AuthToken"];
    PortfolioCode=[prefs valueForKey:@"PortfolioCode"];
    NSLog(@"portfolio code=%@",PortfolioCode);
    
    urlobj=[[UrlconnectionObject alloc]init];
    
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"background"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,18, 20)];
    txtDocName.leftView = paddingView;
    txtDocName.leftViewMode = UITextFieldViewModeAlways;
    
    ArrDocType=[[NSMutableArray alloc]initWithObjects:@"Purchase Receipt",@"Insurance Certificate",@"Others",nil];
    
    txtDocName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Document Name" attributes:@{NSForegroundColorAttributeName: [UIColor grayColor]}];
    lblDesc.textColor=[UIColor grayColor];
    lblDocType.textColor=[UIColor grayColor];
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    
    textView.autocorrectionType = UITextAutocorrectionTypeNo;
    if(textView==txtvwDescription)
    {
        lblDesc.hidden=YES;
       // [mainscroll setContentOffset:CGPointMake(0.0f,170.0f) animated:YES];
    }
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        if(textView==txtvwDescription)
        {
          //  [self.mainscroll setContentOffset:CGPointMake(0.0f,0.0f) animated:YES];
            
            if (txtvwDescription.text.length==0)
            {
                lblDesc.hidden=NO;
            }
        }
        
    }
    return YES;
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

- (IBAction)BackClk:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)DocTypeClk:(id)sender
{
    [txtDocName resignFirstResponder];
    if (btnDocType.selected==NO)
    {
        btnDocType.selected=YES;
        //    [mainscroll setContentOffset:CGPointMake(0,priceview.frame.origin.y+50) animated:YES];
        [Doctypeview removeFromSuperview];
        
        Doctypeview=[[UIView alloc]initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width,self.view.frame.size.height)];
        [Doctypeview setBackgroundColor:[[UIColor blackColor]colorWithAlphaComponent:0.8]];
        [self.view addSubview:Doctypeview];
        
        
        
        //picker create
        
        Doctypepicker=[[UIPickerView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-125, 180, 250,150)];
        //   amtpicker=[[UIPickerView alloc]initWithFrame:CGRectMake(self.view.frame.origin.x, 50, self.view.frame.size.width,150)];
        Doctypepicker.delegate=self;
        Doctypepicker.dataSource=self;
        [Doctypepicker setBackgroundColor:[UIColor whiteColor]];
        [Doctypeview addSubview:Doctypepicker];
        
        btnDoctypesave=[[UIButton alloc] initWithFrame:CGRectMake(Doctypepicker.frame.origin.x+Doctypepicker.frame.size.width-50, Doctypepicker.frame.origin.y-50, 50, 50)];
        [btnDoctypesave setTitle:@"Save" forState:UIControlStateNormal];
        btnDoctypesave.backgroundColor = [UIColor clearColor];
        [btnDoctypesave setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal ];
        btnDoctypesave.titleLabel.font = [UIFont fontWithName:@"OpenSans-Semibold" size:14.0];
        [btnDoctypesave addTarget:self action:@selector(DoctypepickerChange) forControlEvents:UIControlEventTouchUpInside];
        [Doctypeview addSubview:btnDoctypesave];
        
        btnDoctypeCancel=[[UIButton alloc] initWithFrame:CGRectMake(Doctypepicker.frame.origin.x, Doctypepicker.frame.origin.y-50, 60, 50)];
        [btnDoctypeCancel setTitle:@"Cancel" forState:UIControlStateNormal];
        btnDoctypeCancel.backgroundColor = [UIColor clearColor];
        [btnDoctypeCancel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal ];
        btnDoctypeCancel.titleLabel.font = [UIFont fontWithName:@"OpenSans-Semibold" size:14.0];
        [btnDoctypeCancel addTarget:self action:@selector(DoctypepickerCancel) forControlEvents:UIControlEventTouchUpInside];
        [Doctypeview addSubview:btnDoctypeCancel];
        
    }
    else
    {
        btnDocType.selected=NO;
        [Doctypeview removeFromSuperview];
        
    }
}
-(void)DoctypepickerCancel
{
    btnDocType.selected=NO;
    [Doctypeview removeFromSuperview];
}
-(void)DoctypepickerChange
{
    
    if (DocType.length==0) {
        
        lblDocType.text=[ArrDocType objectAtIndex:0];
    }
    else
    {
        lblDocType.text=DocType;
    }
    lblDocType.textColor=[UIColor blackColor];
    DocType=@"";
    btnDocType.selected=NO;
    [Doctypeview removeFromSuperview];
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(pickerView==Doctypepicker)
    {
        return ArrDocType.count;
    }
    else
    {
        return 0;
    }
}
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(pickerView==Doctypepicker)
    {
        return ArrDocType[row];
    }
    else
    {
        return @"";
    }
    
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if(pickerView==Doctypepicker){
        
        DocType= ArrDocType[row];
        lblDocType.textColor=[UIColor blackColor];
    }
    
    else
    {
        
    }
}
- (IBAction)AddDocClk:(id)sender
{
    [txtvwDescription resignFirstResponder];
    actionsheet=[[UIActionSheet alloc]initWithTitle:@"" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Camera", @"Photo Library", nil];
    [actionsheet showInView:self.view];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex

{
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.delegate = (id)self;
    picker.allowsEditing = YES;
    
    switch (buttonIndex) {
            
        case 0:
            
            
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self.navigationController presentViewController:picker animated:YES completion:NULL];
            
            break;
            
        case 1:
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self.navigationController presentViewController:picker animated:YES completion:NULL];
            break;
            
        default:
            break;
    }
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    DocImage.image=info[UIImagePickerControllerEditedImage];
    DocImage.contentMode = UIViewContentModeScaleAspectFit;
    DocImage.clipsToBounds=YES;
    btnSubmit.frame=CGRectMake(btnSubmit.frame.origin.x, DocImage.frame.origin.y+DocImage.frame.size.height+10, btnSubmit.frame.size.width, btnSubmit.frame.size.height);
    
 //   [DocImage setUserInteractionEnabled:YES];
    
    
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    
    
    
}
- (IBAction)SubmitClk:(id)sender
{
   
    if ([lblDocType.text isEqualToString:@"Purchase Receipt"]) {
        DocType1=@"1";
    }
    else if ([lblDocType.text isEqualToString:@"Insurance Certificate"]) {
        DocType1=@"2";
    }
    else if ([lblDocType.text isEqualToString:@"Others"]) {
        DocType1=@"99";
    }
    if(txtDocName.text.length==0)
    {
        txtDocName.text=@"";
        txtDocName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Enter Document Name" attributes:@{NSForegroundColorAttributeName: [UIColor redColor]}];
        //  [Main_acroll setContentOffset:CGPointMake(0,0) animated:YES];
    }
    
    else if (lblDocType.text.length==0 || [lblDocType.text isEqualToString:@"Document Type"])
    {
        lblDocType.text=@"Document Type";
        lblDocType.textColor=[UIColor redColor];
    }
  //  else if([DocImage.image isEqual:[UIImage imageNamed:@"doc"]])
    else if(DocImage.image==nil)
    {
        UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please Add Document" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [aler show];
    }
   
    else
    {
        
        [self ImageUploadUrl];
        
    }

}
-(void)ImageUploadUrl
{
    
  //filename
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd-HH:mm:ss"];
    NSString *currentTime = [dateFormatter stringFromDate:today];
    FileName=[NSString stringWithFormat:@"%@%@%@",@"PortDoc",currentTime,@".png"];
    //[@"PortDoc" stringByAppendingString:currentTime];
    NSLog(@"time=%@",FileName);
    
    //image upload
    CGSize size = DocImage.image.size;
    CGFloat ratio = 0;
    if (size.width > size.height) {
        ratio = 600.0 / size.width;
    }
    else {
        ratio = 600.0 / size.height;
    }
    CGRect rect = CGRectMake(0.0, 0.0, ratio * size.width, ratio * size.height);
    
    UIGraphicsBeginImageContext(rect.size);
    [DocImage.image drawInRect:rect];
    UIImage *thumbnail = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSData *imageData = UIImageJPEGRepresentation(thumbnail,1.0f);
    //    NSData *plainData = [plainString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64String = [imageData base64EncodedStringWithOptions:0];
    
 //   NSString *encodedText = [self encodeToPercentEscapeString:base64String];
    [self checkLoader];
    tempDict = [[NSDictionary alloc] initWithObjectsAndKeys:FileName,@"FileName",[base64String stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],@"FileContent",nil];
    NSLog(@"tempdic=%@",tempDict);
    NSString *loginstring = [NSString stringWithFormat:@"%@UploadFile/%@?CustomerCode=%@",URL_LINK,AuthToken,CustomerCode];
//    NSString *loginstring = [NSString stringWithFormat:@"%@InsertPortfolioDoc/%@?PortfolioCode=%@",URL_LINK,AuthToken,PortfolioCode];
  
    NSLog(@"--- %@",loginstring);
    
    NSError *localErr;
    
    NSData *jsonData2 = [NSJSONSerialization dataWithJSONObject:(NSDictionary *) tempDict options:NSJSONWritingPrettyPrinted error:&localErr];
    
    NSString *jsonString = [[NSString alloc] initWithData:jsonData2 encoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:loginstring]];
    
    NSString *params = jsonString; //[jsonString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [request setHTTPMethod:@"POST"];
    
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    
    [request setHTTPShouldHandleCookies:NO];
    
    [request setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    BOOL net=[urlobj connectedToNetwork];
    if (net==YES)
    {
       
        [urlobj globalPost:request typerequest:@"array" withblock:^(id result, NSError *error,BOOL completed) {
            
            NSLog(@"event result----- %@", result);
            //    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
            //    dic=[result valueForKey:@"response"];
            
            
            
            if ([[result valueForKey:@"IsSuccess"] integerValue]==1) {
                
                FileName=[NSString stringWithFormat:@"%@",[result valueForKey:@"ResultInfo"]];
                [self SubmitDocUrl];
               
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
                [self checkLoader];
                UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"Error" message:@"Unsucessful...." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [aler show];
            }
            
        }];
    }
    else{
        [self checkLoader];
        UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"No Network Connection." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [aler show];
    }
    
    
}
-(NSString*) encodeToPercentEscapeString:(NSString *)string {
    return (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,
                                                              (CFStringRef) string,
                                                              NULL,
                                                              (CFStringRef) @"!*'();:@&=+$,/?%#[]",
                                                              kCFStringEncodingUTF8));
}
-(void)SubmitDocUrl
{
    
 tempDict = [[NSDictionary alloc] initWithObjectsAndKeys:@"0",@"PortfolioDocCode",txtDocName.text , @"DocName",DocType1, @"DocTypeCode",txtvwDescription.text,@"Description",FileName,@"FileName",nil];
    NSLog(@"tempdic=%@",tempDict);
  
        NSString *loginstring = [NSString stringWithFormat:@"%@InsertPortfolioDoc/%@?PortfolioCode=%@",URL_LINK,AuthToken,PortfolioCode];
    
    NSLog(@"--- %@",loginstring);
    
    NSError *localErr;
    
    NSData *jsonData2 = [NSJSONSerialization dataWithJSONObject:(NSDictionary *) tempDict options:NSJSONWritingPrettyPrinted error:&localErr];
    
    NSString *jsonString = [[NSString alloc] initWithData:jsonData2 encoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:loginstring]];
    
    NSString *params = jsonString; //[jsonString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [request setHTTPMethod:@"POST"];
    
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    
    [request setHTTPShouldHandleCookies:NO];
    
    [request setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    BOOL net=[urlobj connectedToNetwork];
    if (net==YES)
    {
        
        [urlobj globalPost:request typerequest:@"array" withblock:^(id result, NSError *error,BOOL completed) {
            
            NSLog(@"event result----- %@", result);
            //    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
            //    dic=[result valueForKey:@"response"];
            
            
            
            if ([[result valueForKey:@"IsSuccess"] integerValue]==1) {
                
                
                   [self checkLoader];
                UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"Success" message:@"Document Added Successfully." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [aler show];
                [self.navigationController popViewControllerAnimated:YES];
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
                  [self checkLoader];
                UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"Error" message:@"Unsucessful...." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [aler show];
            }
            
        }];
    }
    else{
        [self checkLoader];
        UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"No Network Connection." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [aler show];
    }
    
    
}
-(void)checkLoader
{
    
    if([self.view.subviews containsObject:loader_shadow_View])
    {
        
        [loader_shadow_View removeFromSuperview];
        [self.view setUserInteractionEnabled:YES];
    }
    else
    {
        loader_shadow_View = [[UIView alloc] initWithFrame:self.view.frame];
        [loader_shadow_View setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.56f]];
        [loader_shadow_View setUserInteractionEnabled:NO];
        [[loader_shadow_View layer] setZPosition:2];
        [self.view setUserInteractionEnabled:NO];
        UIActivityIndicatorView *loader =[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        
        [loader setCenter:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2)];
        
        [loader startAnimating];
        
        
        [loader_shadow_View addSubview:loader];
        [self.view addSubview:loader_shadow_View];
    }
}
@end
