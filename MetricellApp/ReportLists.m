//
//  ReportLists.m
//  MetricellApp
//
//  Created by Faris Zaman on 25/08/2017.
//  Copyright © 2017 Faris Zaman. All rights reserved.
//

#import "ReportLists.h"
#import "UploadImages.h"
#import "Constants.h"

@interface ReportLists (){
    
}
@property (nonatomic, retain) NSArray *reportsObjectArray;
@property (nonatomic, retain) UIActivityIndicatorView *activityIndicator;

-(void)getReportImages;
-(void)loadReportViews;
-(void)showErrorView:errorString;

@end

@implementation ReportLists

@synthesize reportsScroll = _reportsScroll, activityIndicator = _loadingSpinner, reportsObjectArray = _reportsObjectArray;


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.topItem.title = @"Report Collection";
    UIBarButtonItem *uploadButton = [[UIBarButtonItem alloc] initWithTitle:@"Upload" style:UIBarButtonItemStyleDone target:self action:@selector(uploadPage:)];
    UIBarButtonItem *logOutButton = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStyleDone target:self action:@selector(logoutPressed:)];
    
    self.navigationItem.rightBarButtonItem = uploadButton;
    self.navigationItem.leftBarButtonItem = logOutButton;
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    for (id viewToRemove in [self.reportsScroll subviews]) {
        if ([viewToRemove isMemberOfClass:[UIView class]]) {
            [viewToRemove removeFromSuperview];
        }
    }
    [self getReportImages];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)logoutPressed:(id)sender{
    [PFUser logOut];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)uploadPage:(id)sender{
    [self performSegueWithIdentifier:@"ShowUploadPage" sender:self];
}

-(void)getReportImages{
    //Fetch images
    PFQuery *query = [PFQuery queryWithClassName:@"ReportImageObject"];
    
    [query orderByDescending:KEY_CREATION_DATE];
    [query whereKey:@"user" equalTo:[PFUser currentUser]];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (!error) {
            self.reportsObjectArray = nil;
            self.reportsObjectArray = [[NSArray alloc] initWithArray:objects];
            [self loadReportViews];
        } else {
            [self showErrorView:error];
        }
    }];
}

-(void)loadReportViews{
    for (id viewToRemove in [self.reportsScroll subviews]) {
        if ([viewToRemove isMemberOfClass:[UIView class]])
            [viewToRemove removeFromSuperview];
    }
    
    int originY = 10;
    
    for (PFObject *reportObject in self.reportsObjectArray){
        UIView *reportImageView = [[UIView alloc] initWithFrame:CGRectMake(10, originY-40, self.view.frame.size.width -20, 300)];
        
        //Adds image
        PFFile *image = (PFFile*)[reportObject objectForKey:KEY_IMAGE];
        UIImageView *userImage = [[UIImageView alloc] initWithImage:[UIImage imageWithData:image.getData]];
        userImage.frame = CGRectMake(0, 0, reportImageView.frame.size.width, 300);
        [reportImageView addSubview:userImage];
        
        //Adds image info
        NSDate *creationDate = reportObject.createdAt;
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"HH:mm dd/MM yyyy"];
        
        UILabel *infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, reportImageView.frame.size.height+10, reportImageView.frame.size.width, 15)];
        infoLabel.text = [NSString stringWithFormat:@"Uploaded by: %@ - %@", [PFUser currentUser].username, [df stringFromDate:creationDate]];
        infoLabel.textAlignment = NSTextAlignmentCenter;
        infoLabel.font = [UIFont fontWithName:@"Arial-ItalicMT" size:9];
        infoLabel.textColor = [UIColor blueColor];
        infoLabel.backgroundColor = [UIColor clearColor];
        [reportImageView addSubview:infoLabel];
        
        //Adds image description
        
        UILabel *descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, -20, reportImageView.frame.size.width, 15)];
        descriptionLabel.text = [reportObject objectForKey:KEY_COMMENT];
        descriptionLabel.textAlignment = NSTextAlignmentCenter;
        descriptionLabel.font = [UIFont fontWithName:@"ArialMT" size:13];
        descriptionLabel.textColor = [UIColor whiteColor];
        descriptionLabel.backgroundColor = [UIColor clearColor];
        [reportImageView addSubview:descriptionLabel];
        
        [self.reportsScroll addSubview:reportImageView];
        
        originY = originY + reportImageView.frame.size.width + 50;
        
        /* Test Logs
        NSLog(@"Test of description%@",descriptionLabel);
        NSLog(@"The content of infolabel %@", infoLabel);*/
    }
    
    self.reportsScroll.contentSize = CGSizeMake(self.reportsScroll.frame.size.width, originY);
}

-(void)showErrorView:(id)errorString{
    UIAlertController *errorAlertView = [UIAlertController alertControllerWithTitle:@"Error" message:errorString preferredStyle:UIAlertControllerStyleAlert];
    [errorAlertView addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:errorAlertView animated:YES completion:nil];
}

@end
