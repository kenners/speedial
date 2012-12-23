//
//  NnSpeedialViewController.m
//  NNUH Speedial
//
//  Created by Kenrick Turner on 22/12/2012.
//  Copyright (c) 2012 Kenrick Turner. All rights reserved.
//

#import "NnSpeedialViewController.h"

@interface NnSpeedialViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberLabel1;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberLabel2;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberLabel3;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberLabel4;
@property (copy, nonatomic) NSArray *digitLabels;

- (IBAction)updateDigitLabels:(id)sender;
- (BOOL)dial; // Dial the extension
- (void)reset; // Resets all the labels
- (BOOL)checkValid:(NSString*)ext; // Checks to see whether an extension is valid
- (NSString*)buildDirectNumber:(NSString*)ext;
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
@end

@implementation NnSpeedialViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    // Setup labels list
    [self reset];
    self.extensionPrefix = @"01603";
    self.digitLabels = [NSArray arrayWithObjects:
                   self.phoneNumberLabel1,
                   self.phoneNumberLabel2,
                   self.phoneNumberLabel3,
                   self.phoneNumberLabel4,
                   nil];
    self.forbiddenExtensions = [NSSet setWithObjects:
                                @"2222",
                                @"3333",
                                nil];
    self.prefixes = [[NSDictionary alloc] initWithObjectsAndKeys:
                     @"286", @"2",
                     @"287", @"3",
                     @"288", @"4",
                     @"289", @"5",
                     @"64", @"6",
                     nil];
    [self.textField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)updateDigitLabels:(id)sender {
    self.extensionNumber = self.textField.text;
    NSUInteger arrayLength = [self.digitLabels count];
    NSUInteger stringLength = [self.extensionNumber length];
    for (NSUInteger i = 0; i < arrayLength; i++) {
        UILabel *label = [self.digitLabels objectAtIndex:i];
        if (i >= stringLength) {
            label.text = @"";
        } else {
            label.text = [self.extensionNumber substringWithRange: NSMakeRange (i, 1)];
        }
    }

    if ([self.extensionNumber length] >= 4)
    {
        [self dial];
    }
}

- (BOOL)dial{
    // Check to see the extension is valid
    if ([self checkValid:([self extensionNumber])]){
        NSString *phoneLinkString = [NSString stringWithFormat:@"tel:%@", [self buildDirectNumber:([self extensionNumber])]];
        NSURL *phoneLinkURL = [NSURL URLWithString:phoneLinkString];
        UIWebView *webview = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
        [webview loadRequest:[NSURLRequest requestWithURL:phoneLinkURL]];
        webview.hidden = YES;
        [self.view addSubview:webview];
        //[[UIApplication sharedApplication] openURL:phoneLinkURL];
    } else {
        UIAlertView *invalidExtensionAlert = [[UIAlertView alloc]initWithTitle:@"Invalid Extension" message:@"You have attempted to dial an invalid extension number." delegate:nil cancelButtonTitle:@"Done" otherButtonTitles:nil, nil];
        [invalidExtensionAlert show];
        return false;
    }
    return true;
}

- (void)reset{
    self.textField.text = nil;
    self.extensionNumber = nil;
    self.phoneNumberLabel1.text = nil;
    self.phoneNumberLabel2.text = nil;
    self.phoneNumberLabel3.text = nil;
    self.phoneNumberLabel4.text = nil;
    self.phoneNumberString = nil;
}

- (BOOL)checkValid:(NSString*)ext{
    if (![self.forbiddenExtensions member:ext] && [ext length] == 4 && [self.prefixes valueForKey:[ext substringWithRange: NSMakeRange(0,1)]] != nil) {
        return TRUE;
    } else {
        return FALSE;
    }
}

- (NSString*)buildDirectNumber:(NSString*)ext{
    self.phoneNumberString = self.extensionPrefix;
    NSString *stem = [self.prefixes valueForKey:[ext substringWithRange: NSMakeRange(0,1)]];
    self.phoneNumberString = [self.phoneNumberString stringByAppendingString:stem];
    if ([ext substringWithRange: NSMakeRange(0,1)] == @"6") {
        // To handle deck phones we want all 4 digits of the extension
        self.phoneNumberString = [self.phoneNumberString stringByAppendingString:ext];
    } else {
        // Otherwise for all the other extensions, we just want the last 3 digits
        self.phoneNumberString = [self.phoneNumberString stringByAppendingString:[ext substringWithRange:NSMakeRange(1, 3)]];
    }
    return self.phoneNumberString;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    return (newLength > 4) ? NO : YES;
}

@end
