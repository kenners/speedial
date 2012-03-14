//
//  nnuhspeedViewController.m
//  NNUH Speedial
//
//  Created by Kenrick Turner on 06/03/2012.
//  Copyright (c) 2012 Kenrick Turner. All rights reserved.
//

#import "nnuhspeedViewController.h"
#import "TestFlight.h"

@implementation nnuhspeedViewController

@synthesize phoneNumberLabel1, phoneNumberLabel2, phoneNumberLabel3, phoneNumberLabel4;
@synthesize phoneNumberString;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setPhoneNumberLabel1:nil];
    [self setPhoneNumberLabel2:nil];
    [self setPhoneNumberLabel3:nil];
    [self setPhoneNumberLabel4:nil];
    [self setPhoneNumberString:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

-(IBAction)launchFeedback:(UIButton *)pressedButton {
    [TestFlight openFeedbackView];
}

-(IBAction)numberButtonPressed:(UIButton *)pressedButton
{
    if ([phoneNumberLabel1.text length] == 0) {
        self.phoneNumberLabel1.text = [self.phoneNumberLabel1.text stringByAppendingString: pressedButton.titleLabel.text];
    } else if ([phoneNumberLabel2.text length] == 0) {
        self.phoneNumberLabel2.text = [self.phoneNumberLabel2.text stringByAppendingString: pressedButton.titleLabel.text];
    } else if ([phoneNumberLabel3.text length] == 0) {
        self.phoneNumberLabel3.text = [self.phoneNumberLabel3.text stringByAppendingString: pressedButton.titleLabel.text];
    } else if ([phoneNumberLabel4.text length] == 0) {
        self.phoneNumberLabel4.text = [self.phoneNumberLabel4.text stringByAppendingString: pressedButton.titleLabel.text];
    } else {
        // All 4 digit labels are full.
        // TODO: Make Call button active at this point.
    }
}

-(IBAction)deleteButtonPressed:(UIButton *)pressedButton
{
    if ([self.phoneNumberLabel4.text length] > 0) {
        self.phoneNumberLabel4.text = [self.phoneNumberLabel4.text substringToIndex:([self.phoneNumberLabel4.text length] - 1)];
    } else if ([self.phoneNumberLabel3.text length] > 0) {
        self.phoneNumberLabel3.text = [self.phoneNumberLabel3.text substringToIndex:([self.phoneNumberLabel3.text length] - 1)];
    } else if ([self.phoneNumberLabel2.text length] > 0) {
        self.phoneNumberLabel2.text = [self.phoneNumberLabel2.text substringToIndex:([self.phoneNumberLabel2.text length] - 1)];
    } else if ([self.phoneNumberLabel1.text length] > 0) {
        self.phoneNumberLabel1.text = [self.phoneNumberLabel1.text substringToIndex:([self.phoneNumberLabel1.text length] - 1)];
    } else {
        // Nothing else left to delete.
    }
}

-(IBAction)dialButtonPressed:(UIButton *)pressedButton
{
    // First check all 4 digits completed by seeing if the last digit is completed
    if ([self.phoneNumberLabel4.text length] > 0) {
        // Check that first digit is valid (i.e. 2,3,4,5, or 6)
        if ([self.phoneNumberLabel1.text isEqualToString:@"2"] || [self.phoneNumberLabel1.text isEqualToString:@"3"] || [self.phoneNumberLabel1.text isEqualToString:@"4"] || [self.phoneNumberLabel1.text isEqualToString:@"5"] || [self.phoneNumberLabel1.text isEqualToString:@"6"]) {
            // We have a valid extension so let's work out which direct dial we need to do.
            // Begin NNUH specific stuff
            self.phoneNumberString = @"01603";
            if ([self.phoneNumberLabel1.text isEqualToString:@"2"]) {
                self.phoneNumberString = [self.phoneNumberString stringByAppendingString:@"286"];
                self.phoneNumberString = [self.phoneNumberString stringByAppendingString:self.phoneNumberLabel2.text];
                self.phoneNumberString = [self.phoneNumberString stringByAppendingString:self.phoneNumberLabel3.text];
                self.phoneNumberString = [self.phoneNumberString stringByAppendingString:self.phoneNumberLabel4.text];
            } else if ([self.phoneNumberLabel1.text isEqualToString:@"3"]) {
                self.phoneNumberString = [self.phoneNumberString stringByAppendingString:@"287"];
                self.phoneNumberString = [self.phoneNumberString stringByAppendingString:self.phoneNumberLabel2.text];
                self.phoneNumberString = [self.phoneNumberString stringByAppendingString:self.phoneNumberLabel3.text];
                self.phoneNumberString = [self.phoneNumberString stringByAppendingString:self.phoneNumberLabel4.text];
            } else if ([self.phoneNumberLabel1.text isEqualToString:@"4"]) {
                self.phoneNumberString = [self.phoneNumberString stringByAppendingString:@"288"];
                self.phoneNumberString = [self.phoneNumberString stringByAppendingString:self.phoneNumberLabel2.text];
                self.phoneNumberString = [self.phoneNumberString stringByAppendingString:self.phoneNumberLabel3.text];
                self.phoneNumberString = [self.phoneNumberString stringByAppendingString:self.phoneNumberLabel4.text];
            } else if ([self.phoneNumberLabel1.text isEqualToString:@"5"]) {
                self.phoneNumberString = [self.phoneNumberString stringByAppendingString:@"289"];
                self.phoneNumberString = [self.phoneNumberString stringByAppendingString:self.phoneNumberLabel2.text];
                self.phoneNumberString = [self.phoneNumberString stringByAppendingString:self.phoneNumberLabel3.text];
                self.phoneNumberString = [self.phoneNumberString stringByAppendingString:self.phoneNumberLabel4.text];
            } else if ([self.phoneNumberLabel1.text isEqualToString:@"6"]) {
                self.phoneNumberString = [self.phoneNumberString stringByAppendingString:@"64"];
                self.phoneNumberString = [self.phoneNumberString stringByAppendingString:self.phoneNumberLabel1.text];
                self.phoneNumberString = [self.phoneNumberString stringByAppendingString:self.phoneNumberLabel2.text];
                self.phoneNumberString = [self.phoneNumberString stringByAppendingString:self.phoneNumberLabel3.text];
                self.phoneNumberString = [self.phoneNumberString stringByAppendingString:self.phoneNumberLabel4.text];
            }
            // End NNUH specific stuff
            // Lets stop users from dialling 2222.
            if ([self.phoneNumberLabel1.text isEqualToString:@"2"] && [self.phoneNumberLabel2.text isEqualToString:@"2"] && [self.phoneNumberLabel3.text isEqualToString:@"2"] && [self.phoneNumberLabel4.text isEqualToString:@"2"]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Cannot call 2222!" 
                                                                message:@"Start CPR and delegate someone to call 2222 from a landline." 
                                                               delegate:nil 
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
            } else{
                // Dial the calculated direct dial number!
                NSString *phoneLinkString = [NSString stringWithFormat:@"tel:%@", self.phoneNumberString];
                NSURL *phoneLinkURL = [NSURL URLWithString:phoneLinkString];
                UIWebView *webview = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame]; 
                [webview loadRequest:[NSURLRequest requestWithURL:phoneLinkURL]]; 
            webview.hidden = YES;
                [self.view addSubview:webview];
                [TestFlight passCheckpoint:@"Dialled extension"];
            }
        } else {
            // Display some kind of error/alert as extension is not valid
            UIAlertView *invalidExtensionAlert = [[UIAlertView alloc] initWithTitle:@"Invalid extension" 
                                                            message:@"The extension number you entered is not valid." 
                                                           delegate:nil 
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [invalidExtensionAlert show];
        }
    } else {
        // Display something to indicate that not all digits of the extension are completed
        UIAlertView *incompleteExtensionAlert = [[UIAlertView alloc] initWithTitle:@"Incomplete extension" 
                                                                        message:@"You have not supplied all 4 digits of the extension." 
                                                                       delegate:nil 
                                                              cancelButtonTitle:@"OK"
                                                              otherButtonTitles:nil];
        [incompleteExtensionAlert show];
    }
}



@end
