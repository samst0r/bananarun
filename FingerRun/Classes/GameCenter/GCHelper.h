//
//  GCHelper.h
//  FingerRun
//
//  Created by Samuel Ward on 26/03/2014.
//  Copyright (c) 2014 Samuel Ward. All rights reserved.
//

#import <GameKit/GameKit.h>

@interface GCHelper : NSObject

@property (nonatomic) BOOL gameCenterAvailable;
@property (nonatomic) BOOL userAuthenticated;

+ (GCHelper *)sharedInstance;
- (void)authenticateLocalUser;

@end