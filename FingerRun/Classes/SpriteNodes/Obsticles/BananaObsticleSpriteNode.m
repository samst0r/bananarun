//
//  BananaObsticleSpriteNode.m
//  FingerRun
//
//  Created by Samuel Ward on 22/03/2014.
//  Copyright (c) 2014 Samuel Ward. All rights reserved.
//

#import "BananaObsticleSpriteNode.h"
#import "CollisionCategories.h"

@implementation BananaObsticleSpriteNode

- (id)init {
    
    self = [super init];
    if (self) {
        
        [self setup];
    }
    
    return self;
}

- (void)setup {
    
    self.color = [UIColor yellowColor];
    self.size = CGSizeMake(100, 100);
    self.name = @"Banana";
    self.xScale = 0.5f;
    self.yScale = 0.5f;
    self.texture = [SKTexture textureWithImageNamed:@"banana"];
    
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.size];
    self.physicsBody.dynamic = YES;
    self.physicsBody.affectedByGravity = NO;
    
    self.physicsBody.categoryBitMask = ColliderTypeBanana;
    self.physicsBody.collisionBitMask = ColliderTypeBanana;
}

- (void)hideAfterOneSecondsWithCompletion:(void (^)(void))completion {
    
    SKAction *moveBackAndFade = [SKAction group:@[[SKAction rotateByAngle:degreesToRadians(720) duration:1],
                                                  [SKAction fadeOutWithDuration:1]]];
    
    SKAction *fadeOut = [SKAction sequence:@[[SKAction waitForDuration:0.10],
                                             moveBackAndFade,
                                             [SKAction runBlock:completion]]];
    
    [self runAction:fadeOut];
}

CGFloat degreesToRadians(CGFloat degrees) {
    
    return degrees * M_PI / 180;
};

@end
