//
//  ScoreCalculator.m
//  FingerRun
//
//  Created by Samuel Ward on 26/03/2014.
//  Copyright (c) 2014 Samuel Ward. All rights reserved.
//

#import "ScoreCalculator.h"

@implementation ScoreCalculator

+ (NSNumber *)calculateScoreWithSpeed:(CGFloat)speed
                                 time:(NSTimeInterval)time {
    
    return [NSNumber numberWithFloat:speed * time];
}

static ScoreCalculator *sharedHelper = nil;

+ (ScoreCalculator *) sharedInstance {
    
    if (!sharedHelper) {
        sharedHelper = [[ScoreCalculator alloc] init];
    }
    return sharedHelper;
}

@end
