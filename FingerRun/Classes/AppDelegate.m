//
//  AppDelegate.m
//  FingerRun
//
//  Created by Samuel Ward on 22/03/2014.
//  Copyright (c) 2014 Samuel Ward. All rights reserved.
//

#import "AppDelegate.h"
#import "GCHelper.h"

#import <Crashlytics/Crashlytics.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [Crashlytics startWithAPIKey:@"crashlytics-password"];
    
    return YES;
}

@end
