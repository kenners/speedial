//
//  nnuhspeedViewController.h
//  NNUH Speedial
//
//  Created by Kenrick Turner on 06/03/2012.
//  Copyright (c) 2012 Norfolk & Norwich University Hospital. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface nnuhspeedViewController : UIViewController {
    
}

// Four individual digit labels
@property(nonatomic, retain) IBOutlet UILabel *phoneNumberLabel1;
@property(nonatomic, retain) IBOutlet UILabel *phoneNumberLabel2;
@property(nonatomic, retain) IBOutlet UILabel *phoneNumberLabel3;
@property(nonatomic, retain) IBOutlet UILabel *phoneNumberLabel4;

@property(nonatomic, retain) NSString *phoneNumberString;

-(IBAction)numberButtonPressed:(UIButton *)pressedButton;
-(IBAction)deleteButtonPressed:(UIButton *)pressedButton;
-(IBAction)dialButtonPressed:(UIButton *)pressedButton;
-(IBAction)launchFeedback:(UIButton *)pressedButton;


@end
