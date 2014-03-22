//
//  FootPrintSpriteNode.m
//  FingerRun
//
//  Created by Samuel Ward on 22/03/2014.
//  Copyright (c) 2014 Samuel Ward. All rights reserved.
//

#import "FootPrintSpriteNode.h"

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
}

- (void)hideAfterOneSecondsWithCompletion:(void (^)(void))completion {
    
    SKAction *moveBackAndFade = [SKAction group:@[[SKAction moveByX:0.0f y:-30 duration:0.1],
                                                  [SKAction fadeOutWithDuration:0.1]]];
    
    SKAction *fadeOut = [SKAction sequence:@[[SKAction waitForDuration:0.25],
                                             moveBackAndFade,
                                             [SKAction runBlock:completion]]];
    
    [self runAction:fadeOut];

}

@end
