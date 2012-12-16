//
//  nnuhspeedViewController.h
//  NNUH Speedial
//
//  Created by Kenrick Turner on 06/03/2012.
//  Copyright (c) 2012 Kenrick Turner. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface nnuhspeedViewController : UIViewController <UITextFieldDelegate> {
@private
    BOOL __dismiss;
}

@property(nonatomic, retain) IBOutlet UILabel *phoneNumberLabel1;
@property(nonatomic, retain) IBOutlet UILabel *phoneNumberLabel2;
@property(nonatomic, retain) IBOutlet UILabel *phoneNumberLabel3;
@property(nonatomic, retain) IBOutlet UILabel *phoneNumberLabel4;
@property(nonatomic, retain) NSString *phoneNumberString;
@property(nonatomic, retain) IBOutlet UITextField *inputField;
@end
