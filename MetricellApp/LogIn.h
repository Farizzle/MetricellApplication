//
//  LogIn.h
//  MetricellApp
//
//  Created by Faris Zaman on 24/08/2017.
//  Copyright © 2017 Faris Zaman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface LogIn : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *logoImage;
@property (strong, nonatomic) IBOutlet UITextField *userNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;

- (IBAction)logInPressed:(id)sender;

@end
