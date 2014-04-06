//
//  GCHelper.m
//  FingerRun
//
//  Created by Samuel Ward on 26/03/2014.
//  Copyright (c) 2014 Samuel Ward. All rights reserved.
//

#import "GCHelper.h"

@implementation GCHelper

#pragma mark Initialization

static GCHelper *sharedHelper = nil;

+ (GCHelper *) sharedInstance {
    if (!sharedHelper) {
        sharedHelper = [[GCHelper alloc] init];
    }
    return sharedHelper;
}

- (BOOL)isGameCenterAvailable {
    return YES;
}

- (id)init {
    
    self = [super init];
    
    if (self) {
        
        self.gameCenterAvailable = [self isGameCenterAvailable];

        if (self.gameCenterAvailable) {
            
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(authenticationChanged)
                                                         name:GKPlayerAuthenticationDidChangeNotificationName
                                                       object:nil];
        }
    }
    return self;
}

- (void)authenticationChanged {
    
    if ([GKLocalPlayer localPlayer].isAuthenticated && !self.userAuthenticated) {
        
        NSLog(@"Authentication changed: player authenticated.");
        self.userAuthenticated = YES;
    } else if (![GKLocalPlayer localPlayer].isAuthenticated && self.userAuthenticated) {
        
        NSLog(@"Authentication changed: player not authenticated");
        self.userAuthenticated = NO;
    }
    
}

#pragma mark User functions

- (void)authenticateLocalUser {
    
    [GKLocalPlayer localPlayer].authenticateHandler = ^(UIViewController *viewController, NSError *error){
        
    };
    
    NSLog(@"Authenticating local user...");
    if (![GKLocalPlayer localPlayer].authenticated) {
        
        [[GKLocalPlayer localPlayer] authenticateHandler];
    } else {
        
        NSLog(@"Already authenticated!");
    }
}

@end
