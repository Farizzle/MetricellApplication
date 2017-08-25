//
//  Register.m
//  MetricellApp
//
//  Created by Faris Zaman on 24/08/2017.
//  Copyright © 2017 Faris Zaman. All rights reserved.
//

#import "Register.h"
#define kOFFSET_FOR_KEYBOARD 80.0

@interface Register ()

@end

@implementation Register

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.topItem.title = @"Registration";
    
    //Delegate Textfields
    self.userNameRegisterTextField.delegate = self;
    self.passwordRegisterTextField.delegate = self;
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
    self.userNameRegisterTextField.text = nil;
}

- (IBAction)emptyPasswordNameTextField:(id)sender{
    self.passwordRegisterTextField.text = nil;
    self.passwordRegisterTextField.secureTextEntry = true;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


- (IBAction)registerAccountPressed:(id)sender {
    PFUser *user = [PFUser user];
    
    user.username = self.userNameRegisterTextField.text;
    user.password = self.passwordRegisterTextField.text;
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (!error) {
            [self performSegueWithIdentifier:@"RegistrationSuccessful" sender:self];
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
