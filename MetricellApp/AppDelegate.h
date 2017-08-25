//
//  AppDelegate.h
//  MetricellApp
//
//  Created by Faris Zaman on 24/08/2017.
//  Copyright © 2017 Faris Zaman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <Parse/Parse.h>
#import <Bolts/Bolts.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

