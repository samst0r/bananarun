//
//  FootPrintSpriteNode.m
//  FingerRun
//
//  Created by Samuel Ward on 22/03/2014.
//  Copyright (c) 2014 Samuel Ward. All rights reserved.
//

#import "FootPrintSpriteNode.h"
#import "CollisionCategories.h"

@implementation FootPrintSpriteNode

- (id)init
{
    self = [super init];
    if (self) {
        
        [self setup];
    }
    return self;
}

- (void)setup {
    
    self.texture = [SKTexture textureWithImageNamed:@"footprint"];
    self.name = @"Footprint";
    self.size = CGSizeMake(30, 70);
    
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.size];
    self.physicsBody.dynamic = NO;
    self.physicsBody.affectedByGravity = NO;
    self.physicsBody.mass = 0.1;
    
    self.physicsBody.categoryBitMask = ColliderTypeFootprint;
    self.physicsBody.contactTestBitMask = ColliderTypeBanana;
}

- (void)hideAfterOneSecondsWithCompletion:(void (^)(void))completion {
    
    SKAction *moveBackAndFade = [SKAction group:@[[SKAction moveByX:0.0f y:-50 duration:0.4],
                                                  [SKAction fadeOutWithDuration:0.4]]];
    
    SKAction *fadeOut = [SKAction sequence:@[moveBackAndFade,
                                             [SKAction runBlock:completion]]];
    
    [self runAction:fadeOut];

}

@end
