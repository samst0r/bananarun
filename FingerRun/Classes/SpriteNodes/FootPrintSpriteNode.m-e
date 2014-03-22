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
    
    
    SKAction *completionAction = [SKAction runBlock:completion];
    
    SKAction *fadeOut = [SKAction sequence:@[
                                           [SKAction waitForDuration:1.0],
                                           [SKAction fadeOutWithDuration:0.25],
                                           completionAction]];
    
    [self runAction:fadeOut];

}

@end
