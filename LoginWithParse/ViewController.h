//
//  ViewController.h
//  LoginWithParse
//
//  Created by yasser jennani on 01/04/14.
//  Copyright (c) 2014 ensa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface ViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *reEnterPasswordField;

- (IBAction)registerAction:(id)sender;
- (IBAction)connectWithFacebook:(id)sender;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityLogin;



@end
