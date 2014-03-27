//
//  ScoreCalculator.h
//  FingerRun
//
//  Created by Samuel Ward on 26/03/2014.
//  Copyright (c) 2014 Samuel Ward. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScoreCalculator : NSObject

@property (nonatomic) NSNumber *score;
@property (nonatomic) NSNumber *gameOverScore;
@property (nonatomic) NSNumber *highestScore;

+ (ScoreCalculator *)sharedInstance;

+ (NSNumber *)calculateScoreWithSpeed:(CGFloat)speed time:(NSTimeInterval)time;

@end
