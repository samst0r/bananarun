//
//  MenuScene.m
//  FingerRun
//
//  Created by Samuel Ward on 24/03/2014.
//  Copyright (c) 2014 Samuel Ward. All rights reserved.
//

#import "MenuScene.h"
#import "GameScene.h"

@interface MenuScene ()

@property BOOL contentCreated;

@end

@implementation MenuScene

- (void)didMoveToView:(SKView *)view {
    
    if (!self.contentCreated) {
        
        [self createContent];
        
        self.contentCreated = YES;
    }
}

- (void)setupAndAddGameOverLabel {
    
    SKLabelNode *gameOverLabel = [SKLabelNode labelNodeWithFontNamed:@"Courier"];
    gameOverLabel.fontSize = 30;
    gameOverLabel.fontColor = [SKColor whiteColor];
    gameOverLabel.text = @"Start Game!";
    gameOverLabel.position = CGPointMake(self.size.width/2, 2.0 / 3.5 * self.size.height);
    [self addChild:gameOverLabel];
}

- (void)setupAndAddTapLabel {
    
    SKLabelNode *tapLabel = [SKLabelNode labelNodeWithFontNamed:@"Courier"];
    tapLabel.fontSize = 15;
    tapLabel.fontColor = [SKColor whiteColor];
    tapLabel.text = @"(Tap to start)";
    tapLabel.position = CGPointMake(CGRectGetMidX(self.frame), 2.0 / 3.5 * self.size.height - 30.0f);
    [self addChild:tapLabel];
}

- (void)setupAndAddWhatToDoLabel {
    
    SKLabelNode *whatToDo = [SKLabelNode labelNodeWithFontNamed:@"Courier"];
    whatToDo.fontSize = 15;
    whatToDo.fontColor = [SKColor whiteColor];
    whatToDo.text = @"Tap the screen to go faster!";
    whatToDo.position = CGPointMake(CGRectGetMidX(self.frame), 2.0 / 3.5 * self.size.height - 80.0f);
    [self addChild:whatToDo];
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
    [self setupAndAddWhatToDoLabel];
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

@end
