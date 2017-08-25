//
//  UploadImages.m
//  MetricellApp
//
//  Created by Faris Zaman on 25/08/2017.
//  Copyright © 2017 Faris Zaman. All rights reserved.
//

#import "UploadImages.h"

@interface UploadImages ()

@end

@implementation UploadImages

@synthesize imageToUpload = _imageToUpload, username = _username, descriptionTextField = _descriptionTextField;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *sendButton = [[UIBarButtonItem alloc] initWithTitle:@"Send" style:UIBarButtonItemStyleDone target:self action:@selector(sendPressed:)];
    self.navigationItem.rightBarButtonItem = sendButton;
    
    //Delegate Textfield
    self.descriptionTextField.delegate = self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)selectPicturePressed:(id)sender{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self.navigationController presentViewController:imagePicker animated:YES completion:nil];
}

- (IBAction)emptyDescriptionTextField:(id)sender{
    self.descriptionTextField.text = nil;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)sendPressed:(id)sender{
    [self.descriptionTextField resignFirstResponder];
    
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    UIActivityIndicatorView *loadingSpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    [loadingSpinner setCenter:CGPointMake(self.view.frame.size.width/2.0, self.view.frame.size.height/2.0)];
    [loadingSpinner startAnimating];
    
    [self.view addSubview:loadingSpinner];
    
    //Upload a new picture if not currently uploaded.
    NSData *pictureData = UIImagePNGRepresentation(self.imageToUpload.image);
    
    PFFile *file = [PFFile fileWithName:@"image" data:pictureData];
    [file saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            PFObject *imageObject = [PFObject objectWithClassName:@"ReportImageObject"];
            [imageObject setObject:file forKey:@"image"];
            [imageObject setObject:[PFUser currentUser] forKey:@"user"];
            [imageObject setObject:self.descriptionTextField.text forKey:@"comment"];
            
            [imageObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                if (succeeded) {
                    [self.navigationController popViewControllerAnimated:YES];
                }
                else {
                    NSString *errorString = [[error userInfo] objectForKey:@"error"];
                    UIAlertController *errorAlertView = [UIAlertController alertControllerWithTitle:@"Error" message:errorString preferredStyle:UIAlertControllerStyleAlert];
                    [errorAlertView addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
                    [self presentViewController:errorAlertView animated:YES completion:nil];
                }
            }];
        }
        else{
            NSString *errorString = [[error userInfo] objectForKey:@"error"];
            UIAlertController *errorAlertView = [UIAlertController alertControllerWithTitle:@"Error" message:errorString preferredStyle:UIAlertControllerStyleAlert];
            [errorAlertView addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:errorAlertView animated:YES completion:nil];
        }
    }progressBlock:^(int percentDone) {
        NSLog(@"Uploaded: %d %%", percentDone);
    }];
}

#pragma mark UIImagePicker delegate

- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary*)info{
    [picker dismissViewControllerAnimated:YES completion:nil];
    self.imageToUpload.image = [info objectForKey:UIImagePickerControllerOriginalImage];
}

-(void)showErrorView:(id)errorString{
    UIAlertController *errorAlertView = [UIAlertController alertControllerWithTitle:@"Error" message:errorString preferredStyle:UIAlertControllerStyleAlert];
    [errorAlertView addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:errorAlertView animated:YES completion:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



@end
