//
//  MenuScene.m
//  FingerRun
//
//  Created by Samuel Ward on 24/03/2014.
//  Copyright (c) 2014 Samuel Ward. All rights reserved.
//

#import "MenuScene.h"
#import "GameScene.h"
#import "BananaObsticleSpriteNode.h"
#import "SKLabelNode+DropShadow.h"
#import "RoadMarkerSpriteNode.h"

@interface MenuScene ()

@property BOOL contentCreated;
@property (nonatomic) RoadMarkerSpriteNode *roadMarkerNode;

@end

@implementation MenuScene

- (void)didMoveToView:(SKView *)view {
    
    if (!self.contentCreated) {
        
        [self createContent];
        
        self.contentCreated = YES;
    }
}

- (void)setupAndBananaRunLabel {
    
    SKLabelNode *bananaRun = [SKLabelNode makeDropShadowString:@"BANANA RUN"
                                               fontSize:50.0f
                                                  color:[SKColor blackColor]
                                            shadowColor:[SKColor yellowColor]];
    
    bananaRun.position = CGPointMake(CGRectGetMidX(self.frame), self.size.height / 2 + 20.0f);
    [self addChild:bananaRun];
}

- (void)setupAndAddStartGameLabel {
    
    SKLabelNode *gameOverLabel =  [SKLabelNode makeDropShadowString:@"TAP TO START!"
                                                    fontSize:30.0f
                                                       color:[SKColor whiteColor]
                                                 shadowColor:[SKColor blackColor]];
    
    gameOverLabel.position = CGPointMake(self.size.width/2, self.size.height / 2 - 20);
    [self addChild:gameOverLabel];
}

- (void)setupAndAddWhatToDoLabel {
    
    SKLabelNode *goAsFastAsPossibleLabel = [SKLabelNode makeDropShadowString:@"GO AS FAST AS POSSIBLE "
                                                                    fontSize:15.0f
                                                                       color:[SKColor yellowColor]
                                                                 shadowColor:[SKColor blackColor]];
    
    goAsFastAsPossibleLabel.position = CGPointMake(CGRectGetMidX(self.frame), self.size.height / 2 - 50.0f);
    [self addChild:goAsFastAsPossibleLabel];
    
    SKLabelNode *forLongAsPossibleLabel = [SKLabelNode makeDropShadowString:@"FOR LONG AS POSSIBLE!"
                                                                   fontSize:15.0f
                                                                      color:[SKColor yellowColor]
                                                                shadowColor:[SKColor blackColor]];
    
    forLongAsPossibleLabel.position = CGPointMake(CGRectGetMidX(self.frame), self.size.height / 2 - 70.0f);
    [self addChild:forLongAsPossibleLabel];
}

- (void)createContent {
    
    SKSpriteNode *background = [[SKSpriteNode alloc] initWithTexture:[SKTexture textureWithImageNamed:@"background"]];
    background.position = CGPointMake(CGRectGetMidX(self.frame),
                                      CGRectGetMidY(self.frame));
    background.xScale = 0.5;
    background.yScale = 0.5;
    background.size = self.size;
    [self addChild:background];
    
    [self setupAndAddStartGameLabel];
    [self setupAndAddWhatToDoLabel];
    [self setupAndBananaRunLabel];
    [self setupAndAddRoadMarker];
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

    _roadMarkerNode.zPosition = -1;
    [self addChild:_roadMarkerNode];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // Intentional no-op
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    // Intentional no-op
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    // Intentional no-op
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    GameScene *gameScene = [[GameScene alloc] initWithSize:self.size];
    gameScene.scaleMode = SKSceneScaleModeAspectFill;
    [self.view presentScene:gameScene transition:[SKTransition doorsCloseHorizontalWithDuration:.25]];
}


- (void)addBanana {
    
    BananaObsticleSpriteNode *banana = [[BananaObsticleSpriteNode alloc] init];
    banana.position = CGPointMake(arc4random_uniform(CGRectGetWidth(self.frame)), CGRectGetHeight(self.frame) + 50.0f);
    
    banana.physicsBody.affectedByGravity = YES;
    [self addChild:banana];
}

- (void)moveBananaObsticles:(NSTimeInterval)currentTime {
    
    [self enumerateChildNodesWithName:@"Banana" usingBlock:^(SKNode *node, BOOL *stop) {
        
        if (node.position.y < 0) {
            
            [node removeFromParent];
        }
    }];
}

- (void)moveRoadMarker {
    
    self.roadMarkerNode.position = CGPointMake(self.roadMarkerNode.position.x,
                                               self.roadMarkerNode.position.y - 10);
    
    if (self.roadMarkerNode.position.y <= 300) {
        
        self.roadMarkerNode.position = CGPointMake(self.roadMarkerNode.position.x,
                                                   CGRectGetHeight(self.frame) + self.roadMarkerNode.position.y + -30);
    }
}

#pragma mark - Scene Update
- (void)update:(NSTimeInterval)currentTime {
    
    [self moveBananaObsticles:currentTime];
    [self moveRoadMarker];
    
    if (self.children.count <= 13) {
        
        [self addBanana];
    }
}

@end
