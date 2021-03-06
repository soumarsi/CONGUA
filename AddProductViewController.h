//
//  AddProductViewController.h
//  CONGUA
//
//  Created by Priyanka ghosh on 12/06/15.
//  Copyright (c) 2015 Sandeep Dutta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UrlconnectionObject.h"
#import "login.h"
@interface AddProductViewController : UIViewController
{
    UIView *loader_shadow_View,*Producttypeview,*PurchaseDateview;
    UrlconnectionObject *urlobj;
    NSDictionary *tempDict;
    NSString *CustomerCode,*AuthToken,*PortfolioCode,*ProductType,*Isinsured,*Isotherinsured;
    NSMutableArray *ArrProductType;
    UIPickerView *producttypepicker;
    UIDatePicker *datepicker;
    UIButton *btnProducttypesave,*btnproducttypeCancel;
}
@property (weak, nonatomic) IBOutlet UIScrollView *mainscroll;
@property (weak, nonatomic) IBOutlet UITextField *txtproductName;
@property (weak, nonatomic) IBOutlet UIButton *btnproductType;
@property (weak, nonatomic) IBOutlet UILabel *lblProductType;
@property (weak, nonatomic) IBOutlet UILabel *lblPurchaseDt;
@property (weak, nonatomic) IBOutlet UIButton *btnPurchaseDt;
@property (weak, nonatomic) IBOutlet UITextField *txtPurchaseValue;
@property (weak, nonatomic) IBOutlet UIButton *btnIsInsuredPort;
@property (weak, nonatomic) IBOutlet UIImageView *IsInsuredPortToggleImg;
@property (weak, nonatomic) IBOutlet UIButton *btnIsOtherInsured;
@property (weak, nonatomic) IBOutlet UIImageView *IsOtherInsuredToggleImg;

@property (weak, nonatomic) IBOutlet UITextView *txtVwDescription;

@property (weak, nonatomic) IBOutlet UILabel *lblDescription;
@property (strong, nonatomic) NSString *CategoryCode;
@property (weak, nonatomic) IBOutlet UIButton *btnSubmit;
@property (weak, nonatomic) IBOutlet UIImageView *DescImgView;

- (IBAction)IsInsuredPortClk:(id)sender;


- (IBAction)ProductTypeClk:(id)sender;
- (IBAction)IsOtherInsuredClk:(id)sender;

- (IBAction)SubmitClk:(id)sender;
- (IBAction)BackClk:(id)sender;
- (IBAction)PurchaseDateClk:(id)sender;


@end
