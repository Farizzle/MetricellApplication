//
//  ReportLists.h
//  MetricellApp
//
//  Created by Faris Zaman on 25/08/2017.
//  Copyright © 2017 Faris Zaman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface ReportLists : UIViewController

@property (strong, nonatomic) IBOutlet UIScrollView *reportsScroll;

- (IBAction)logoutPressed:(id)sender;
- (IBAction)uploadPage:(id)sender;

@end
