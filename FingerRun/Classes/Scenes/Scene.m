//
//  MyScene.m
//  FingerRun
//
//  Created by Samuel Ward on 22/03/2014.
//  Copyright (c) 2014 Samuel Ward. All rights reserved.
//

#import "Scene.h"

#import "BackgroundSpriteNode.h"
#import "FootPrintSpriteNode.h"
#import "RoadMarkerSpriteNode.h"
#import "BananaObsticleSpriteNode.h"

@interface Scene () <SKPhysicsContactDelegate>

@property (nonatomic) BackgroundSpriteNode *background;
@property (nonatomic) RoadMarkerSpriteNode *roadMarkerNode;

@property (nonatomic) SKLabelNode *speedLabel;
@property (nonatomic) SKLabelNode *topSpeedLabel;
@property (nonatomic) SKLabelNode *highestAllTimeSpeedLabel;

@property (nonatomic) NSInteger topSpeed;
@property (nonatomic) NSInteger highestAllTimeSpeed;
@property (nonatomic) NSInteger movementSpeed;

@property NSTimeInterval timeOfLastMove;
@property NSTimeInterval timePerMove;

@end

@implementation Scene

#pragma mark - Initialisation

- (void)setupAndAddHighestSpeedLabel {
    
    _highestAllTimeSpeedLabel = [[SKLabelNode alloc] initWithFontNamed:@"Courier"];
    _highestAllTimeSpeedLabel.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetHeight(self.frame) - 40.0f);
    _highestAllTimeSpeedLabel.fontSize = 14.0f;
    _highestAllTimeSpeedLabel.text = @"";
    _highestAllTimeSpeedLabel.fontColor = [UIColor redColor];
    _highestAllTimeSpeedLabel.alpha = 0.85f;
    
    [self addChild:_highestAllTimeSpeedLabel];
}

- (void)setupAndAddSpeedLabel {
    
    _speedLabel = [[SKLabelNode alloc] initWithFontNamed:@"Courier"];
    _speedLabel.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetHeight(self.frame) - 80.0f);
    _speedLabel.fontSize = 18.0f;
    _speedLabel.text = @"";
    _speedLabel.fontColor = [UIColor yellowColor];
    _speedLabel.alpha = 0.85f;
    
    [self addChild:_speedLabel];
}

- (void)setupAndAddTopSpeedLabel {
    
    _topSpeedLabel = [[SKLabelNode alloc] initWithFontNamed:@"Courier"];
    _topSpeedLabel.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetHeight(self.frame) - 100.0f);
    _topSpeedLabel.fontSize = 14.0f;
    _topSpeedLabel.text = @"";
    _topSpeedLabel.fontColor = [UIColor greenColor];
    _topSpeedLabel.alpha = 0.85f;
    
    [self addChild:_topSpeedLabel];
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
    [self setupAndAddHighestSpeedLabel];
    
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
    _roadMarkerNode.size = CGSizeMake(20, 80);
    
    [self addChild:_roadMarkerNode];
}

#pragma mark - Scene Update
- (void)update:(NSTimeInterval)currentTime {
    
    [self moveRoadMarker];
    [self moveBananaObsticles:currentTime];
    
    [self recordSpeed];
    [self recordCurrentTopSpeed];
    [self recordHighestAllTimeSpeed];
    
    if (self.children.count < 13) {
        
        [self addBanana];
    }
    
    if ((currentTime - self.timeOfLastMove > 1.0) && self.movementSpeed > 0) {
        
        self.movementSpeed -= 1;
        self.timeOfLastMove = currentTime;
    }
    
}

#pragma mark - Scene Update Helpers
- (void)moveRoadMarker {
    
    self.roadMarkerNode.position = CGPointMake(self.roadMarkerNode.position.x,
                                               self.roadMarkerNode.position.y - self.movementSpeed);
    
    if (self.roadMarkerNode.position.y <= 0) {
        
        self.roadMarkerNode.position = CGPointMake(self.roadMarkerNode.position.x, CGRectGetHeight(self.frame) + self.roadMarkerNode.position.y);
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
    
    if (self.movementSpeed > self.topSpeed) {
        
        self.topSpeed = self.movementSpeed;
        self.topSpeedLabel.text = [NSString stringWithFormat:@"Top Speed: %li MPH", self.movementSpeed];
    }
}

- (void)recordHighestAllTimeSpeed {
    
    if (self.topSpeed > self.highestAllTimeSpeed) {
        
        self.highestAllTimeSpeed = self.topSpeed;
        self.highestAllTimeSpeedLabel.text = [NSString stringWithFormat:@"BEST SPEED %li MPH", self.highestAllTimeSpeed];
    }
}

- (void)recordSpeed {
    
    self.speedLabel.text = [NSString stringWithFormat:@"%li MPH", self.movementSpeed];
}

#pragma mark - Physics Contact Helpers
- (void)didBeginContact:(SKPhysicsContact *)contact {
    
    BananaObsticleSpriteNode *node = (BananaObsticleSpriteNode *)contact.bodyA.node;
    FootPrintSpriteNode *footPrint = (FootPrintSpriteNode *)contact.bodyA.node;

    if (footPrint.alpha == 1.0f) {
        
        node.size = CGSizeMake(100.0f, 100.0f);
        self.topSpeed = 0;
        self.movementSpeed = 0;
        
        [node hideAfterOneSecondsWithCompletion:^{
            
            [node removeFromParent];
        }];
    }
}

#pragma mark - Game End Helpers
- (void)gameOver {
    
}

@end
