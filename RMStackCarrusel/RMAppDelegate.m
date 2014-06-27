//
//  RMAppDelegate.m
//  RMStackCarrusel
//
//  Created by Ruben on 26/06/14.
//  Copyright (c) 2014 minube. All rights reserved.
//

#import "RMAppDelegate.h"
#import "RMMainViewController.h"

@implementation RMAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    RMMainViewController *mainViewController = [[RMMainViewController alloc] init];
    self.window.rootViewController = mainViewController;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
