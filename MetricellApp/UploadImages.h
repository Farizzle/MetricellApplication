//
//  UploadImages.h
//  MetricellApp
//
//  Created by Faris Zaman on 25/08/2017.
//  Copyright © 2017 Faris Zaman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface UploadImages : UIViewController <UIPickerViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *imageToUpload;
@property (strong, nonatomic) IBOutlet UITextField *descriptionTextField;
@property (strong, nonatomic) NSString *username;

- (IBAction)selectPicturePressed:(id)sender;

@end
