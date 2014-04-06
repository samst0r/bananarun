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


+ (NSInteger)calculateScore:(NSInteger)speed {
    
    NSInteger score = (speed * 2);

    return score;
}

#pragma mark Singleton Methods

+ (id)sharedInstance {
    
    static ScoreCalculator *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (id)init {
    
    if (self = [super init]) {
        _score = 0;
        
    }
    return self;
}

@end
