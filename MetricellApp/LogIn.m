//
//  LogIn.m
//  MetricellApp
//
//  Created by Faris Zaman on 24/08/2017.
//  Copyright © 2017 Faris Zaman. All rights reserved.
//

#import "LogIn.h"

@interface LogIn ()

@end

@implementation LogIn
//Image properties
NSString *urlString;
NSURL *url;

@synthesize logoImage, userNameTextField = _userNameTextField, passwordTextField = _passwordTextField;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Download logo
    urlString = @"http://www.metricell.it/wp-content/uploads/2017/02/metricell_logo.png";
    url = [[NSURL alloc]initWithString:urlString];
    logoImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
    
    //Delegate Textfields
    self.userNameTextField.delegate = self;
    self.passwordTextField.delegate = self;
}


- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)emptyUserNameTextField:(id)sender{
        self.userNameTextField.text = nil;
}

- (IBAction)emptyPasswordNameTextField:(id)sender{
    self.passwordTextField.text = nil;
    self.passwordTextField.secureTextEntry = true;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)logInPressed:(id)sender {
    [PFUser logInWithUsernameInBackground:self.userNameTextField.text password:self.passwordTextField.text block:^(PFUser *user, NSError *error) {
        if (user) {
            [self performSegueWithIdentifier:@"LoginSuccessful" sender:self];
        }
        else {
            NSString *errorString = [[error userInfo] objectForKey:@"error"];
            UIAlertController *errorAlertView = [UIAlertController alertControllerWithTitle:@"Error" message:errorString preferredStyle:UIAlertControllerStyleAlert];
            [errorAlertView addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:errorAlertView animated:YES completion:nil];
        }
    }];
    
}
@end
