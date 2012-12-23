//
//  NnSpeedialViewController.h
//  NNUH Speedial
//
//  Created by Kenrick Turner on 22/12/2012.
//  Copyright (c) 2012 Kenrick Turner. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NnSpeedialViewController : UIViewController <UITextFieldDelegate>
@property (copy, nonatomic) NSString *extensionNumber;
@property (copy, nonatomic) NSString *extensionPrefix;
@property (copy, nonatomic) NSSet *forbiddenExtensions; //Extensions that shouldn't be dialled.
@property (copy, nonatomic) NSDictionary *prefixes;
@property (copy, nonatomic) NSString *phoneNumberString;
@end