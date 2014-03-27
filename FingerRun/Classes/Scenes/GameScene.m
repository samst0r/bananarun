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

@property (nonatomic, getter=hasExtraLife) BOOL extraLife;

@property (nonatomic) CGFloat topSpeed;

// calculate speed
@property (nonatomic) CGFloat movementSpeed;
@property NSDate *timeWithoutHittingABanana;

@property NSTimeInterval timeOfLastMove;

@property (nonatomic) CGFloat highScore;
@property (nonatomic) CGFloat topScore;

@property BOOL startTimer;

@property BOOL gameEnding;
@property BOOL pausedGame;

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
    
    NSInteger score = [ScoreCalculator sharedInstance].score;
    
    NSString *scoreString = [NSString stringWithFormat:@"%07ld", score];
    
    self.scoreLabel = [[DropShadowLabelNode alloc] initWithDropShadowString:scoreString
                                                                   fontSize:30.0f
                                                                      color:[SKColor blackColor]
                                                                shadowColor:[SKColor whiteColor]];
    
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
    self.gameEnding = NO;
    self.pausedGame = NO;
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
    
    if (self.gameEnding) return;
    
    if (self.pausedGame) {
        
    } else {
    
        [self moveRoadMarker];
        [self moveBananaObsticles:currentTime];
        
        if (self.children.count <= 13) {
            
            [self addBanana];
        }
        
        NSInteger score = [ScoreCalculator sharedInstance].score;
        
        self.scoreLabel.text = [NSString stringWithFormat:@"%07ld", score];
    }
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
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];

    if (self.pausedGame) {
        
        if ([node.name isEqualToString:@"purchaseButton"] ||
            [node.name isEqualToString:@"purchaseLabel"] ||
            [node.name isEqualToString:@"extraLifeLabel"]) {
            
            NSLog(@"Touched");
        } else {
            
            NSLog(@"Continue");
            [self endGame];
        }
    } else {
    
        if (self.startTimer) {
            
            self.timeWithoutHittingABanana = [NSDate date];
            self.startTimer = NO;
        }
        
        self.timeOfLastMove = event.timestamp;
        
        FootPrintSpriteNode *footprint = [[FootPrintSpriteNode alloc] init];
        footprint.position = location;
        
        [footprint hideAfterOneSecondsWithCompletion:^{
            
            [self removeChildrenInArray:@[footprint]];
            
        }];
        
        [self addChild:footprint];
        [ScoreCalculator sharedInstance].score += [ScoreCalculator calculateScore:self.movementSpeed];
        
        self.movementSpeed++;
    }
}

#pragma mark - HUD Helpers

- (SKSpriteNode *)purchaseExtraLife {
    
    SKSpriteNode *fireNode = [SKSpriteNode spriteNodeWithColor:[UIColor yellowColor] size:CGSizeMake(190, 110)];
    
    fireNode.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) - 10);
    fireNode.name = @"purchaseButton";
    fireNode.zPosition = 1.0f;
    
    DropShadowLabelNode *purchaseLabel = [[DropShadowLabelNode alloc] initWithDropShadowString:@"PURCHASE"
                                                                                          fontSize:30.0f
                                                                                             color:[SKColor blackColor]
                                                                                       shadowColor:[SKColor yellowColor]];
    
    DropShadowLabelNode *extraLifeLabel = [[DropShadowLabelNode alloc] initWithDropShadowString:@"EXTRA LIFE?"
                                                                                          fontSize:30.0f
                                                                                             color:[SKColor blackColor]
                                                                                       shadowColor:[SKColor yellowColor]];
    
    purchaseLabel.position = CGPointMake(0.0f, 0.0f);
    purchaseLabel.name = @"purchaseLabel";
    
    extraLifeLabel.position = CGPointMake(0.0f, -30.0f);
    extraLifeLabel.name = @"extraLifeLabel";
    extraLifeLabel.zPosition = 0.0f;
    
    purchaseLabel.zPosition = 0.0f;
    
    [fireNode addChild:purchaseLabel];
    [purchaseLabel addChild:extraLifeLabel];
    
    return fireNode;
}

- (void)addContinueWithoutExtraLifeSignPosting {
    
    DropShadowLabelNode *purchaseExtraLife = [[DropShadowLabelNode alloc] initWithDropShadowString:@"TAP TO END"
                                                                                          fontSize:30.0f
                                                                                             color:[SKColor whiteColor]
                                                                                       shadowColor:[SKColor blackColor]];
    
    purchaseExtraLife.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) - 110.0f);
    purchaseExtraLife.zPosition = 1.0;
    [self addChild:purchaseExtraLife];
}

- (void)addTooBad {
    
    DropShadowLabelNode *purchaseExtraLife = [[DropShadowLabelNode alloc] initWithDropShadowString:@"TOO BAD!"
                                                                                          fontSize:30.0f
                                                                                             color:[SKColor whiteColor]
                                                                                       shadowColor:[SKColor blackColor]];
    
    purchaseExtraLife.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) + 65.0f);
    purchaseExtraLife.zPosition = 1.0;
    [self addChild:purchaseExtraLife];
}



#pragma mark - Physics Contact Helpers

- (void)endGame:(BananaObsticleSpriteNode *)node {
    
    [ScoreCalculator sharedInstance].gameOverScore = [ScoreCalculator sharedInstance].score;
    
    if ([ScoreCalculator sharedInstance].gameOverScore > [ScoreCalculator sharedInstance].highestScore) {
        
        [ScoreCalculator sharedInstance].highestScore = [ScoreCalculator sharedInstance].gameOverScore;
    }
    
    node.size = CGSizeMake(150.0f, 150.0f);
    self.movementSpeed = 0;
    self.timeWithoutHittingABanana = [NSDate date];
    [node hideAfterOneSecondsWithCompletion:^{
        
        [node removeFromParent];
        
        [self endGame];
    }];
}

- (void)purchaseAnotherLifeOffer {
    
    [self addChild:[self purchaseExtraLife]];
    [self addContinueWithoutExtraLifeSignPosting];
    [self addTooBad];
}

- (void)didBeginContact:(SKPhysicsContact *)contact {
    
    BananaObsticleSpriteNode *node = (BananaObsticleSpriteNode *)contact.bodyA.node;
    
    if ([node isKindOfClass:[BananaObsticleSpriteNode class]]) {
        
        FootPrintSpriteNode *footPrint = (FootPrintSpriteNode *)contact.bodyB.node;

        
        if (footPrint.alpha == 1.0f) {

            self.pausedGame = YES;

            [self purchaseAnotherLifeOffer];
            
            
            if (!self.hasExtraLife && !self.pausedGame) {
                
                self.gameEnding = YES;
                [self endGame:node];
            } else {
                
                self.background.alpha = 0.1f;
                self.roadMarkerNode.alpha = 0.1f;
                self.scoreLabel.alpha = 0.1f;
                
                [node hideAfterOneSecondsWithCompletion:^{
                    
                    [node removeFromParent];
                }];
            }
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

