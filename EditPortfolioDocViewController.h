//
//  EditPortfolioDocViewController.h
//  CONGUA
//
//  Created by Priyanka ghosh on 24/06/15.
//  Copyright (c) 2015 Sandeep Dutta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UrlconnectionObject.h"
#import "login.h"
@interface EditPortfolioDocViewController : UIViewController
{
    UIView *loader_shadow_View,*Doctypeview;
    UrlconnectionObject *urlobj;
    NSDictionary *tempDict;
    NSString *CustomerCode,*AuthToken,*PortfolioCode,*DocType,*DocType1,*FileName,*PortfolioDocCode;
    NSMutableArray *ArrDocType;
    UIPickerView *Doctypepicker;
    UIButton *btnDoctypesave,*btnDoctypeCancel;
    UIActionSheet *actionsheet;
}
@property (weak, nonatomic) IBOutlet UITextField *txtDocName;
@property (weak, nonatomic) IBOutlet UILabel *lblDocType;
@property (weak, nonatomic) IBOutlet UILabel *lblDesc;
@property (weak, nonatomic) IBOutlet UITextView *txtVwDesc;
@property (weak, nonatomic) IBOutlet UIImageView *DocImage;
@property (weak, nonatomic) IBOutlet UIButton *btnDocType;
@property (weak, nonatomic) IBOutlet UIButton *btnsubmit;
@property (weak, nonatomic) IBOutlet UIButton *btnAddDoc;

@property (weak, nonatomic) IBOutlet UIScrollView *mainscroll;

- (IBAction)DocTypeClick:(id)sender;
- (IBAction)AddDocumentClick:(id)sender;
- (IBAction)SubmitClick:(id)sender;
- (IBAction)BackClick:(id)sender;




@end
