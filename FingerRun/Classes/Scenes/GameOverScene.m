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
#import "SKLabelNode+DropShadow.h"
#import "ScoreCalculator.h"
#import "DropShadowLabelNode.h"

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
    
    SKLabelNode *gameOverLabel = [SKLabelNode makeDropShadowString:@"GAME OVER"
                                                          fontSize:50.0f
                                                             color:[SKColor blackColor]
                                                       shadowColor:[SKColor yellowColor]];
    gameOverLabel.text = @"GAME OVER";
    gameOverLabel.position = CGPointMake(self.size.width/2, self.size.height / 2 + 10);
    [self addChild:gameOverLabel];
}

- (void)setupAndAddTapLabel {
    
    SKLabelNode *tapLabel = [SKLabelNode makeDropShadowString:@"TAP TO PLAY AGAIN"
                                                     fontSize:20.0f
                                                        color:[SKColor yellowColor]
                                                  shadowColor:[SKColor blackColor]];
    tapLabel.position = CGPointMake(CGRectGetMidX(self.frame), self.size.height / 2 - 100.0f);
    [self addChild:tapLabel];
}

- (void)addScoreLabel {
    
    NSString *scoreString = [NSString stringWithFormat:@"%07ld", [ScoreCalculator sharedInstance].gameOverScore.integerValue];
    
    DropShadowLabelNode *scoreLabel = [[DropShadowLabelNode alloc] initWithDropShadowString:scoreString
                                                                   fontSize:40.0f
                                                                      color:[SKColor whiteColor]
                                                                shadowColor:[SKColor blackColor]];

    
    scoreLabel.position = CGPointMake(CGRectGetMidX(self.frame), self.size.height / 2 + 70.0f);
    
    [self addChild:scoreLabel];
}

- (void)addHighestScoreLabel {
    
    NSString *scoreString = [NSString stringWithFormat:@"%07ld", [ScoreCalculator sharedInstance].highestScore.integerValue];
    
    DropShadowLabelNode *highestScoreLabel = [[DropShadowLabelNode alloc] initWithDropShadowString:@"HIGHEST"
                                                                                  fontSize:30.0f
                                                                                     color:[SKColor whiteColor]
                                                                               shadowColor:[SKColor blackColor]];
    
    DropShadowLabelNode *highestScore = [[DropShadowLabelNode alloc] initWithDropShadowString:scoreString
                                                                                   fontSize:30.0f
                                                                                      color:[SKColor blackColor]
                                                                                shadowColor:[SKColor yellowColor]];
    
    
    highestScoreLabel.position = CGPointMake(CGRectGetMidX(self.frame), self.size.height / 2 + 230.0f);
    highestScore.position = CGPointMake(CGRectGetMidX(self.frame), self.size.height / 2 + 200.0f);
    
    
    [self addChild:highestScoreLabel];
    [self addChild:highestScore];
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
    
    [self addScoreLabel];
    [self addHighestScoreLabel];
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
