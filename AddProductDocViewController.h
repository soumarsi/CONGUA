//
//  AddProductDocViewController.h
//  CONGUA
//
//  Created by Priyanka ghosh on 16/06/15.
//  Copyright (c) 2015 Sandeep Dutta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UrlconnectionObject.h"
#import "login.h"
#import "AFHTTPClient.h"
#import "AFHTTPRequestOperation.h"
@interface AddProductDocViewController : UIViewController
{
    UIView *loader_shadow_View,*Doctypeview;
    UrlconnectionObject *urlobj;
    NSDictionary *tempDict;
    NSString *CustomerCode,*AuthToken,*ProductCode,*DocType,*DocType1,*FileName;
    NSMutableArray *ArrDocType;
    UIPickerView *Doctypepicker;
    UIButton *btnDoctypesave,*btnDoctypeCancel;
    UIActionSheet *actionsheet;
}
@property (weak, nonatomic) IBOutlet UITextField *txtDocName;
@property (weak, nonatomic) IBOutlet UIButton *btnDocType;
@property (weak, nonatomic) IBOutlet UILabel *lblDocType;
@property (weak, nonatomic) IBOutlet UILabel *lblDesc;
@property (weak, nonatomic) IBOutlet UITextView *txtvwDescription;
@property (weak, nonatomic) IBOutlet UIImageView *DocImage;
@property (weak, nonatomic) IBOutlet UIScrollView *mainscroll;
@property (weak, nonatomic) IBOutlet UIButton *btnAddDoc;

@property (weak, nonatomic) IBOutlet UIButton *btnsubmit;

- (IBAction)DocTypeClk:(id)sender;
- (IBAction)AddDocClk:(id)sender;
- (IBAction)SubmitClk:(id)sender;
- (IBAction)BackClk:(id)sender;


@end
