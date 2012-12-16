//
//  nnuhspeedViewController.m
//  NNUH Speedial
//
//  Created by Kenrick Turner on 06/03/2012.
//  Copyright (c) 2012 Kenrick Turner. All rights reserved.
//

#import "nnuhspeedViewController.h"
#import "TestFlight.h"
#import <AudioToolbox/AudioToolbox.h>


#define kNnuhspeedViewControllerDelay 0.3

@interface nnuhspeedViewController ()

// Array of digit entry labels
@property (copy, nonatomic) NSArray *labels;

// Make the digit entry labels match the input text
- (void)updateDigitDisplay;

// Dial the extension
- (void)dial;

// Reset user input after a set delay
- (void)resetInput;

// Signal that the extension is incorrect
- (void)wrong;

// Dismiss the view after a set delay
- (void)dismiss;

@end


@implementation nnuhspeedViewController

@synthesize phoneNumberLabel1 = __phoneNumberLabel1;
@synthesize phoneNumberLabel2 = __phoneNumberLabel2;
@synthesize phoneNumberLabel3 = __phoneNumberLabel3;
@synthesize phoneNumberLabel4 = __phoneNumberLabel4;
@synthesize labels = __labels;
@synthesize inputField = __inputField;
@synthesize phoneNumberString = __phoneNumberString;


- (id)init {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
    __dismiss = NO;
    return self;
}

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
    
    // Setup labels list
    self.labels = [NSArray arrayWithObjects:
                   self.phoneNumberLabel1,
                   self.phoneNumberLabel2,
                   self.phoneNumberLabel3,
                   self.phoneNumberLabel4,
                   nil];
	[self updateDigitDisplay];
    
    // Setup numbers stuff
    self.phoneNumberString = @"01603";
    
    // Setup input field
    self.inputField.hidden = NO;
    self.inputField.keyboardType = UIKeyboardTypeNumberPad;
    self.inputField.delegate = self;
    self.inputField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.inputField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [self.inputField becomeFirstResponder];
}

- (void)viewDidUnload
{
    [self setPhoneNumberLabel1:nil];
    [self setPhoneNumberLabel2:nil];
    [self setPhoneNumberLabel3:nil];
    [self setPhoneNumberLabel4:nil];
    [self setPhoneNumberString:nil];
    [self setInputField:nil];
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
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)updateDigitDisplay {
    //NSUInteger length = [self.inputField.text length];
    for (NSUInteger i = 0; i < 4; i++) {
        UILabel *label = [self.labels objectAtIndex:i];
        label.text = self.inputField.text;
    }
}

- (void)resetInput {
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, kNnuhspeedViewControllerDelay * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^(void){
        self.inputField.text = @"";
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    });
}

- (void)wrong {
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    self.inputField = nil;
    [self resetInput];
}

- (void)dismiss {
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    __dismiss = YES;
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, kNnuhspeedViewControllerDelay * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^(void){
        [self dismissModalViewControllerAnimated:YES];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    });
}

-(void)dial {
    NSString *phoneLinkString = [NSString stringWithFormat:@"tel:%@", self.phoneNumberString];
    NSURL *phoneLinkURL = [NSURL URLWithString:phoneLinkString];
    UIWebView *webview = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    [webview loadRequest:[NSURLRequest requestWithURL:phoneLinkURL]];
    webview.hidden = YES;
    //[self resetInput];
    [self.view addSubview:webview];
    [TestFlight passCheckpoint:@"Dialled extension"];
}

#pragma mark - text field methods
- (void)textDidChange:(NSNotification *)notif {
    if ([notif object] == self.inputField) {
        [self updateDigitDisplay];
        if ([self.inputField.text length] == 4) {
            // Do dialling action here...
            
            // Check we're not doing anything silly...
            if ([self.inputField.text isEqualToString:@"2222"]){
                [TestFlight passCheckpoint:@"Attempted to dial 2222"];
                [self wrong];
            }
            
            // Check that first digit of extension is valid
            if ([self.inputField.text hasPrefix:@"2"] || [self.inputField.text hasPrefix:@"3"] || [self.inputField.text hasPrefix:@"4"] || [self.inputField.text hasPrefix:@"5"] || [self.inputField.text hasPrefix:@"6"])
            {
                // First digit of extension is valid
                if ([self.inputField.text hasPrefix:@"2"]){
                    self.phoneNumberString = [self.phoneNumberString stringByAppendingString:@"286"];
                    self.phoneNumberString = [self.phoneNumberString stringByAppendingString:[self.inputField.text substringFromIndex:[self.inputField.text length]-3]];
                } else if ([self.inputField.text hasPrefix:@"3"]){
                    self.phoneNumberString = [self.phoneNumberString stringByAppendingString:@"287"];
                    self.phoneNumberString = [self.phoneNumberString stringByAppendingString:[self.inputField.text substringFromIndex:[self.inputField.text length]-3]];
                } else if ([self.inputField.text hasPrefix:@"4"]){
                    self.phoneNumberString = [self.phoneNumberString stringByAppendingString:@"288"];
                    self.phoneNumberString = [self.phoneNumberString stringByAppendingString:[self.inputField.text substringFromIndex:[self.inputField.text length]-3]];
                } else if ([self.inputField.text hasPrefix:@"5"]){
                    self.phoneNumberString = [self.phoneNumberString stringByAppendingString:@"289"];
                    self.phoneNumberString = [self.phoneNumberString stringByAppendingString:[self.inputField.text substringFromIndex:[self.inputField.text length]-3]];
                } else if ([self.inputField.text hasPrefix:@"6"]){
                    self.phoneNumberString = [self.phoneNumberString stringByAppendingString:@"64"];
                    self.phoneNumberString = [self.phoneNumberString stringByAppendingString:self.inputField.text];
                }
             // Everything checks out ok, so let's dial!
                //[self dial];
                NSString *phoneLinkString = [NSString stringWithFormat:@"tel:%@", self.phoneNumberString];
                NSURL *phoneLinkURL = [NSURL URLWithString:phoneLinkString];
                UIWebView *webview = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
                [webview loadRequest:[NSURLRequest requestWithURL:phoneLinkURL]];
                webview.hidden = YES;
                //[self resetInput];
                [self.view addSubview:webview];
                [TestFlight passCheckpoint:@"Dialled extension"];
                
            } else {
                // First digit of extension is invalid
                [TestFlight passCheckpoint:@"Invalid extension"];
                [self wrong];
            }
        }
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([textField.text length] == 4 && [string length] > 0) {
        return NO;
    }
    else {
        return YES;
    }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    return __dismiss;
}

@end
