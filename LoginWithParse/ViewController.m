//
//  ViewController.m
//  LoginWithParse
//
//  Created by yasser jennani on 01/04/14.
//  Copyright (c) 2014 ensa. All rights reserved.
//

#import "ViewController.h"
#import "Comms.h"

@interface ViewController () <CommsDelegate>

@end

@implementation ViewController
@synthesize usernameField=_usernameField;
@synthesize emailField=_emailField;
@synthesize reEnterPasswordField=_reEnterPasswordField;
@synthesize passwordField=_passwordField;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _activityLogin.hidden=true;
    [PFUser logOut];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)registerAction:(id)sender {
    [_usernameField resignFirstResponder];
    [_emailField resignFirstResponder];
    [_passwordField resignFirstResponder];
    [_reEnterPasswordField resignFirstResponder];
    [self checkFieldsComplete];
}

- (IBAction)connectWithFacebook:(id)sender {
    
    // Disable the Login button to prevent multiple touches
    _activityLogin.hidden=false;
    
    // Show an activity indicator
    [_activityLogin startAnimating];
    
    
    // Do the login
    [Comms login:self];
}


- (void) checkFieldsComplete {
    if ([_usernameField.text isEqualToString:@""] || [_emailField.text isEqualToString:@""] || [_passwordField.text isEqualToString:@""] || [_reEnterPasswordField.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oooopss!" message:@"You need to complete all fields" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else {
        [self checkPasswordsMatch];
    }
}

- (void) checkPasswordsMatch {
    if (![_passwordField.text isEqualToString:_reEnterPasswordField.text]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oooopss!" message:@"Passwords don't match" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else {
        [self registerNewUser];
    }
}
-(void) registerNewUser {
    NSLog(@"registering....");
    PFUser *newUser = [PFUser user];
    newUser.username = _usernameField.text;
    newUser.email = _emailField.text;
    newUser.password = _passwordField.text;
    
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            NSLog(@"Registration success!");
            _usernameField.text = nil;
            _passwordField.text = nil;
            _reEnterPasswordField.text = nil;
            _emailField.text = nil;
            [self performSegueWithIdentifier:@"login" sender:self];
        }
        else {
            NSLog(@"There was an error in registration");
        }
    }];
}
- (void) commsDidLogin:(BOOL)loggedIn {
	// Re-enable the Login button
	
    
	// Stop the activity indicator
	[_activityLogin stopAnimating];
    
	// Did we login successfully ?
	if (loggedIn) {
		// Seque to the Image Wall
		[self performSegueWithIdentifier:@"login" sender:self];
	} else {
		// Show error alert
		[[[UIAlertView alloc] initWithTitle:@"Login Failed"
                                    message:@"Facebook Login failed. Please try again"
                                   delegate:nil
                          cancelButtonTitle:@"Ok"
                          otherButtonTitles:nil] show];
	}
}

#pragma mark - UITextField Delegate methods

//Méthodes pour libérer le Keyboard lors d'un tape dans le background ou la touche return
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if(textField){
        [textField resignFirstResponder];
    }
    return NO;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_emailField resignFirstResponder];
    [_passwordField resignFirstResponder];
    [_usernameField resignFirstResponder];
    [_reEnterPasswordField resignFirstResponder];
}


@end
