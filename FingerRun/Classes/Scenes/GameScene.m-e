//
//  GameScene.m
//  FingerRun
//
//  Created by Samuel Ward on 22/03/2014.
//  Copyright (c) 2014 Samuel Ward. All rights reserved.
//

#import "GameScene.h"

#import "GameOverScene.h"

#import "BackgroundSpriteNode.h"
#import "FootPrintSpriteNode.h"
#import "RoadMarkerSpriteNode.h"
#import "BananaObsticleSpriteNode.h"

#import "SKLabelNode+DropShadow.h"
#import "DropShadowLabelNode.h"
#import "ScoreCalculator.h"

@import GameKit;

@interface GameScene () <SKPhysicsContactDelegate>

@property (nonatomic) BackgroundSpriteNode *background;
@property (nonatomic) RoadMarkerSpriteNode *roadMarkerNode;
@property (nonatomic) DropShadowLabelNode *scoreLabel;

@property (nonatomic) CGFloat topSpeed;

// calculate speed
@property (nonatomic) CGFloat movementSpeed;
@property NSDate *timeWithoutHittingABanana;

@property NSTimeInterval timeOfLastMove;
@property NSTimeInterval timePerMove;


@property (nonatomic) CGFloat highScore;
@property (nonatomic) CGFloat topScore;

@property BOOL startTimer;

@property BOOL gameEnding;

@end

@implementation GameScene

#pragma mark - Initialisation

- (id)initWithSize:(CGSize)size {
    
    if (self = [super initWithSize:size]) {
    
        self.timeOfLastMove = 0.0;
        self.movementSpeed = 0.0;
    }
    
    return self;
}

- (void)addScoreLabel {
    
    NSInteger score = [ScoreCalculator sharedInstance].score.integerValue;
    
    if (score < 1) {
        score = 0;
    }
    
    NSString *scoreString = [NSString stringWithFormat:@"%07ld", score];
    
    self.scoreLabel = [[DropShadowLabelNode alloc] initWithDropShadowString:scoreString
                                                                   fontSize:30.0f
                                                                      color:[SKColor blackColor]
                                                                shadowColor:[SKColor yellowColor]];
    
    self.scoreLabel.position = CGPointMake(CGRectGetMidX(self.frame), self.size.height - 50.0f);
    [self addChild:self.scoreLabel];
}

- (void)addBanana {
    
    BananaObsticleSpriteNode *banana = [[BananaObsticleSpriteNode alloc] init];
    banana.position = CGPointMake(arc4random_uniform(CGRectGetWidth(self.frame)), CGRectGetHeight(self.frame) + 50.0f);
    [self addChild:banana];
}

- (void)didMoveToView:(SKView *)view {
 
    [self setupAndAddBackground];
    [self setupAndAddRoadMarker];
    [self addScoreLabel];
    
    self.physicsWorld.contactDelegate = self;

    [self addBanana];
    
    [ScoreCalculator sharedInstance].score = 0;
    
    self.startTimer = YES;
    self.timePerMove = 1.0;
}

- (void)setupAndAddBackground {
    
    _background = [[BackgroundSpriteNode alloc] init];
    
    _background.position = CGPointMake(CGRectGetMidX(self.frame),
                                       CGRectGetMidY(self.frame));
    _background.xScale = 0.5;
    _background.yScale = 0.5;
    _background.size = self.size;
    
    [self addChild:_background];
}

- (void)setupAndAddRoadMarker {
    
    _roadMarkerNode = [[RoadMarkerSpriteNode alloc] init];
    _roadMarkerNode.position = CGPointMake(CGRectGetMidX(self.frame), 0);
    _roadMarkerNode.size = CGSizeMake(40, CGRectGetHeight(self.frame));
    
    RoadMarkerSpriteNode *roadMarkerNode2 = [[RoadMarkerSpriteNode alloc] init];
    roadMarkerNode2.position = CGPointMake(0, CGRectGetHeight(self.frame) + 35);
    roadMarkerNode2.size = CGSizeMake(40, CGRectGetHeight(self.frame));
    
    RoadMarkerSpriteNode *roadMarkerNode3 = [[RoadMarkerSpriteNode alloc] init];
    roadMarkerNode3.position = CGPointMake(0, -CGRectGetHeight(self.frame) + 35);
    roadMarkerNode3.size = CGSizeMake(40, CGRectGetHeight(self.frame));
    
    [_roadMarkerNode addChild:roadMarkerNode2];
    [_roadMarkerNode addChild:roadMarkerNode3];
    [self addChild:_roadMarkerNode];
}

#pragma mark - Scene Update
- (void)decreaseSpeed:(NSTimeInterval)currentTime {
    
    if ((currentTime - self.timeOfLastMove > 0.00001) && self.movementSpeed > 0) {
        
        if (self.movementSpeed - 0.0001 < 0.00001) {
            self.movementSpeed = 0;
        } else {
            self.movementSpeed -= 0.07;
        }
        self.timeOfLastMove = currentTime;
    }
}

- (void)update:(NSTimeInterval)currentTime {
    
    [self moveRoadMarker];
    [self moveBananaObsticles:currentTime];
    
    if (self.children.count <= 13) {
        
        [self addBanana];
    }
    
    NSTimeInterval timeWithoutSlipping = [[NSDate date] timeIntervalSinceDate:self.timeWithoutHittingABanana];
    
    [ScoreCalculator sharedInstance].score = [ScoreCalculator calculateScoreWithSpeed:self.movementSpeed
                                                                                 time:timeWithoutSlipping];
    
    NSInteger score = [ScoreCalculator sharedInstance].score.integerValue;
    
    if (score < 1) {
        score = 0;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"%07ld", score];
    [self decreaseSpeed:currentTime];
    
}

#pragma mark - Scene Update Helpers
- (void)moveRoadMarker {
    
    self.roadMarkerNode.position = CGPointMake(self.roadMarkerNode.position.x,
                                               self.roadMarkerNode.position.y - self.movementSpeed);
    
    if (self.roadMarkerNode.position.y <= 300) {
        
        self.roadMarkerNode.position = CGPointMake(self.roadMarkerNode.position.x,
                                                   CGRectGetHeight(self.frame) + self.roadMarkerNode.position.y + -30);
    }
}

#pragma mark - Obsticle Movement Helpers

- (void)moveBananaObsticles:(NSTimeInterval)currentTime {
    
    [self enumerateChildNodesWithName:@"Banana" usingBlock:^(SKNode *node, BOOL *stop) {
        
        if (node.position.y < 0) {
            
            [node removeFromParent];
        }
        
        node.position = CGPointMake(node.position.x, node.position.y - self.movementSpeed);
    }];
}

#pragma mark - User Tap Helpers

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if (self.startTimer) {
     
        self.timeWithoutHittingABanana = [NSDate date];
        self.startTimer = NO;
    }
    
    self.timeOfLastMove = event.timestamp;
    
    UITouch *touch = [touches anyObject];
    CGPoint positionInScene = [touch locationInNode:self];
    
    FootPrintSpriteNode *footprint = [[FootPrintSpriteNode alloc] init];
    footprint.position = positionInScene;
    
    [footprint hideAfterOneSecondsWithCompletion:^{
        
        [self removeChildrenInArray:@[footprint]];
        
    }];
    
    [self addChild:footprint];
    
    self.movementSpeed++;
    
}

#pragma mark - HUD Helpers

#pragma mark - Physics Contact Helpers

- (void)didBeginContact:(SKPhysicsContact *)contact {
    
    BananaObsticleSpriteNode *node = (BananaObsticleSpriteNode *)contact.bodyA.node;
    
    if ([node isKindOfClass:[BananaObsticleSpriteNode class]]) {
        
        FootPrintSpriteNode *footPrint = (FootPrintSpriteNode *)contact.bodyB.node;

        
        if (footPrint.alpha == 1.0f) {
            
            [ScoreCalculator sharedInstance].gameOverScore = [ScoreCalculator sharedInstance].score;
            
            if ([ScoreCalculator sharedInstance].gameOverScore > [ScoreCalculator sharedInstance].highestScore) {
                
                [ScoreCalculator sharedInstance].highestScore = [ScoreCalculator sharedInstance].gameOverScore;
                
                GKScore *score = [[GKScore alloc] initWithLeaderboardIdentifier:@"highscore"];
                score.value = [ScoreCalculator sharedInstance].highestScore.integerValue;
                [GKScore reportScores:@[score] withCompletionHandler:^(NSError *error) {
                    
                }];
            }
            
            node.size = CGSizeMake(150.0f, 150.0f);
            self.movementSpeed = 0;
            self.timeWithoutHittingABanana = [NSDate date];
            [node hideAfterOneSecondsWithCompletion:^{
                
                [node removeFromParent];
                
                [self endGame];
            }];
        }
    }
}

#pragma mark - Game Ending
    
- (void)endGame {
    
    GameOverScene *gameOverScene = [[GameOverScene alloc] initWithSize:self.size];
    gameOverScene.topSpeed = self.topSpeed;
    
    [self.view presentScene:gameOverScene transition:[SKTransition doorsOpenHorizontalWithDuration:0.25]];
    
    self.topSpeed = 0;
}

@end
