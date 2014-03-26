//
//  GameOverScene.m
//  FingerRun
//
//  Created by Samuel Ward on 23/03/2014.
//  Copyright (c) 2014 Samuel Ward. All rights reserved.
//

#import "GameOverScene.h"
#import "GameScene.h"
#import "BananaObsticleSpriteNode.h"

@interface GameOverScene ()

@property BOOL contentCreated;
@property (nonatomic) SKLabelNode *topSpeedLabel;
@property (nonatomic) SKLabelNode *highestAllTimeSpeedLabel;

@end

@implementation GameOverScene

- (void)didMoveToView:(SKView *)view {
    
    if (!self.contentCreated) {
        
        [self createContent];
        
        self.contentCreated = YES;
    }
}

- (void)setupAndAddGameOverLabel {
    
    SKLabelNode *gameOverLabel = [SKLabelNode labelNodeWithFontNamed:@"Courier"];
    gameOverLabel.fontSize = 36;
    gameOverLabel.fontColor = [SKColor whiteColor];
    gameOverLabel.text = @"Game Over!";
    gameOverLabel.position = CGPointMake(self.size.width/2, 2.0 / 3.5 * self.size.height);
    [self addChild:gameOverLabel];
}

- (void)setupAndAddTapLabel {
    
    SKLabelNode *tapLabel = [SKLabelNode labelNodeWithFontNamed:@"Courier"];
    tapLabel.fontSize = 18;
    tapLabel.fontColor = [SKColor whiteColor];
    tapLabel.text = @"(Tap to Play Again)";
    tapLabel.position = CGPointMake(CGRectGetMidX(self.frame), 2.0 / 3.5 * self.size.height - 30.0f);
    [self addChild:tapLabel];
}

- (void)createContent {
    
    SKSpriteNode *background = [[SKSpriteNode alloc] initWithTexture:[SKTexture textureWithImageNamed:@"background"]];
    background.position = CGPointMake(CGRectGetMidX(self.frame),
                                      CGRectGetMidY(self.frame));
    background.xScale = 0.5;
    background.yScale = 0.5;
    background.size = self.size;
    [self addChild:background];
    
    [self setupAndAddGameOverLabel];
    [self setupAndAddTapLabel];
    
    [self setupAndAddHighestSpeedLabel];
    [self setupAndAddTopSpeedLabel];
}

- (void)setupAndAddHighestSpeedLabel {
    
    _highestAllTimeSpeedLabel = [[SKLabelNode alloc] initWithFontNamed:@"Courier"];
    _highestAllTimeSpeedLabel.position = CGPointMake(CGRectGetMidX(self.frame), 2.0 / 3.5 * self.size.height - 100.0f);
    _highestAllTimeSpeedLabel.fontSize = 16.0f;
    _highestAllTimeSpeedLabel.text = [NSString stringWithFormat:@"%.02f MPH (All Time)", self.highestAllTimeSpeed];
    _highestAllTimeSpeedLabel.fontColor = [UIColor greenColor];
    _highestAllTimeSpeedLabel.alpha = 0.85f;
    
    [self addChild:_highestAllTimeSpeedLabel];
}

- (void)setupAndAddTopSpeedLabel {
    
    _topSpeedLabel = [[SKLabelNode alloc] initWithFontNamed:@"Courier"];
    _topSpeedLabel.position = CGPointMake(CGRectGetMidX(self.frame), 2.0 / 3.5 * self.size.height - 130.0f);
    _topSpeedLabel.fontSize = 16.0f;
    _topSpeedLabel.text = [NSString stringWithFormat:@"%.02f MPH (Top Speed)", self.topSpeed];
    _topSpeedLabel.fontColor = [UIColor yellowColor];
    _topSpeedLabel.alpha = 0.85f;
    
    [self addChild:_topSpeedLabel];
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
    GameScene* gameScene = [[GameScene alloc] initWithSize:self.size];
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

#pragma mark - Scene Update
- (void)update:(NSTimeInterval)currentTime {
    
    [self moveBananaObsticles:currentTime];
        
    if (self.children.count <= 13) {
        
        [self addBanana];
    }
}

@end
