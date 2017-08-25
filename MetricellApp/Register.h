//
//  Register.h
//  MetricellApp
//
//  Created by Faris Zaman on 24/08/2017.
//  Copyright © 2017 Faris Zaman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface Register : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *userNameRegisterTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordRegisterTextField;

- (IBAction)registerAccountPressed:(id)sender;


@end
