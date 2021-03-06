//
//  EditPortfolioViewController.h
//  CONGUA
//
//  Created by Priyanka ghosh on 17/06/15.
//  Copyright (c) 2015 Sandeep Dutta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UrlconnectionObject.h"
#import "login.h"
@interface EditPortfolioViewController : UIViewController
{
    NSString *portType,*CustomerCode,*AuthToken,*Isinsured,*PortfolioCode,*IsPriviouslyInsured;
    UIView *loader_shadow_View;
    UrlconnectionObject *urlobj;
    NSDictionary *tempDict;
    UIDatePicker *picker;
    UIBarButtonItem *rightBtn;
    UIView *myview;
    NSMutableArray *ArrPortDetail,*ArrInsureDetail;
    UIPickerView *mypicker;
}
@property (weak, nonatomic) IBOutlet UIScrollView *mainscroll;
@property (weak, nonatomic) IBOutlet UITextField *txtPortfolioName;
@property (weak, nonatomic) IBOutlet UITextView *txtvwAddress;
@property (weak, nonatomic) IBOutlet UITextField *txtPostCode;
@property (weak, nonatomic) IBOutlet UIButton *btnPortfolioType;
@property (weak, nonatomic) IBOutlet UILabel *lblPortfolioType;
@property (weak, nonatomic) IBOutlet UIButton *btnHasInsure;
@property (weak, nonatomic) IBOutlet UIImageView *HasInsureImg;
@property (weak, nonatomic) IBOutlet UITextField *txtInsureName;
@property (weak, nonatomic) IBOutlet UITextView *txtvwInsureDetail;
@property (weak, nonatomic) IBOutlet UILabel *lblInsureDetail;
@property (weak, nonatomic) IBOutlet UILabel *lblStartDate;
@property (weak, nonatomic) IBOutlet UIButton *btnStartDate;
@property (weak, nonatomic) IBOutlet UILabel *lblEndDate;
@property (weak, nonatomic) IBOutlet UIButton *btnEndDate;
@property (weak, nonatomic) IBOutlet UITextField *txtValueCovered;
@property (weak, nonatomic) IBOutlet UILabel *lblAddress;
@property (weak, nonatomic) IBOutlet UIView *InsuranceView;
@property (weak, nonatomic) IBOutlet UIButton *btnSubmit;

- (IBAction)PortfolioTypeClk:(id)sender;
- (IBAction)HasInsureClk:(id)sender;
- (IBAction)StartDateClk:(id)sender;
- (IBAction)EndDateClk:(id)sender;

- (IBAction)SubmitClk:(id)sender;




- (IBAction)BackClk:(id)sender;

@end
