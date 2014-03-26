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

@interface GameScene () <SKPhysicsContactDelegate>

@property (nonatomic) BackgroundSpriteNode *background;
@property (nonatomic) RoadMarkerSpriteNode *roadMarkerNode;

@property (nonatomic) SKLabelNode *speedLabel;
@property (nonatomic) SKLabelNode *topSpeedLabel;
@property (nonatomic) SKLabelNode *highestAllTimeSpeedLabel;

@property (nonatomic) CGFloat topSpeed;
@property (nonatomic) CGFloat highestAllTimeSpeed;
@property (nonatomic) CGFloat movementSpeed;

@property NSTimeInterval timeOfLastMove;
@property NSTimeInterval timePerMove;
@property BOOL gameEnding;

@end

@implementation GameScene

#pragma mark - Initialisation

- (void)setupAndAddHighestSpeedLabel {
    
    _highestAllTimeSpeedLabel = [[SKLabelNode alloc] initWithFontNamed:@"ChalkboardSE-Bold"];
    _highestAllTimeSpeedLabel.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetHeight(self.frame) - 40.0f);
    _highestAllTimeSpeedLabel.fontSize = 14.0f;
    _highestAllTimeSpeedLabel.text = @"";
    _highestAllTimeSpeedLabel.fontColor = [UIColor greenColor];
    _highestAllTimeSpeedLabel.alpha = 0.85f;
    
    [self addChild:_highestAllTimeSpeedLabel];
}

- (void)setupAndAddTopSpeedLabel {
    
    _topSpeedLabel = [[SKLabelNode alloc] initWithFontNamed:@"ChalkboardSE-Bold"];
    _topSpeedLabel.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetHeight(self.frame) - 50.0f);
    _topSpeedLabel.fontSize = 14.0f;
    _topSpeedLabel.text = @"";
    _topSpeedLabel.fontColor = [UIColor yellowColor];
    _topSpeedLabel.alpha = 1.0f;
    
    [self addChild:_topSpeedLabel];
}

- (void)setupAndAddSpeedLabel {
    
    _speedLabel = [[SKLabelNode alloc] initWithFontNamed:@"ChalkboardSE-Bold"];
    _speedLabel.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetHeight(self.frame) - 80.0f);
    _speedLabel.fontSize = 24.0f;
    _speedLabel.text = @"";
    _speedLabel.fontColor = [UIColor purpleColor];
    _speedLabel.alpha = 1.0f;
    
    [self addChild:_speedLabel];
}


- (id)initWithSize:(CGSize)size {
    
    if (self = [super initWithSize:size]) {
    
        self.timeOfLastMove = 0.0;
        self.movementSpeed = 0.0;
    }
    
    return self;
}

- (void)addBanana {
    
    BananaObsticleSpriteNode *banana = [[BananaObsticleSpriteNode alloc] init];
    banana.position = CGPointMake(arc4random_uniform(CGRectGetWidth(self.frame)), CGRectGetHeight(self.frame) + 50.0f);
    [self addChild:banana];
}

- (void) didMoveToView:(SKView *)view {
 
    [self setupAndAddBackground];
    [self setupAndAddRoadMarker];
    [self setupAndAddSpeedLabel];
    [self setupAndAddTopSpeedLabel];
    
    self.physicsWorld.contactDelegate = self;

    [self addBanana];
    
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
- (void)update:(NSTimeInterval)currentTime {
    
    [self moveRoadMarker];
    [self moveBananaObsticles:currentTime];
    
    [self recordSpeed];
    [self recordCurrentTopSpeed];
    [self recordHighestAllTimeSpeed];
    
    if (self.children.count <= 13) {
        
        [self addBanana];
    }
    
    if ((currentTime - self.timeOfLastMove > 0.00001) && self.movementSpeed > 0) {
        
        if (self.movementSpeed - 0.0001 < 0.00001) {
            self.movementSpeed = 0;
        } else {
            self.movementSpeed -= 0.01;
        }
        self.timeOfLastMove = currentTime;
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
    CGPoint positionInScene = [touch locationInNode:self];
    
    FootPrintSpriteNode *footprint = [[FootPrintSpriteNode alloc] init];
    footprint.position = positionInScene;
    
    [footprint hideAfterOneSecondsWithCompletion:^{
        
        [self removeChildrenInArray:@[footprint]];
        
    }];
    
    [self addChild:footprint];
    
    self.movementSpeed++;
    
    self.timeOfLastMove = event.timestamp;
}

#pragma mark - HUD Helpers

- (void)recordCurrentTopSpeed {
    
    if (self.movementSpeed >= self.topSpeed) {
        
        self.topSpeed = self.movementSpeed;
        self.topSpeedLabel.text = [NSString stringWithFormat:@"%.02f MPH", self.topSpeed];
    }
}

- (void)recordHighestAllTimeSpeed {
    
    if (self.topSpeed >= self.highestAllTimeSpeed) {
        
        self.highestAllTimeSpeed = self.topSpeed;
        self.highestAllTimeSpeedLabel.text = [NSString stringWithFormat:@"%.02f MPH (All Time)", self.highestAllTimeSpeed];
    }
}

- (void)recordSpeed {
    
    self.speedLabel.text = [NSString stringWithFormat:@"%.02f MPH", self.movementSpeed];
}

#pragma mark - Physics Contact Helpers

- (void)didBeginContact:(SKPhysicsContact *)contact {
    
    BananaObsticleSpriteNode *node = (BananaObsticleSpriteNode *)contact.bodyA.node;
    
    if ([node isKindOfClass:[BananaObsticleSpriteNode class]]) {
        
        node.size = CGSizeMake(150.0f, 150.0f);
        self.movementSpeed = 0;
        
        [node hideAfterOneSecondsWithCompletion:^{
            
            [node removeFromParent];
            
            [self endGame];
        }];
    }
}

#pragma mark - Game Ending

- (void)endGame {
    
    GameOverScene *gameOverScene = [[GameOverScene alloc] initWithSize:self.size];
    gameOverScene.topSpeed = self.topSpeed;
    gameOverScene.highestAllTimeSpeed = self.highestAllTimeSpeed;
    
    [self.view presentScene:gameOverScene transition:[SKTransition doorsOpenHorizontalWithDuration:0.25]];
    
    self.topSpeed = 0;
}

@end
