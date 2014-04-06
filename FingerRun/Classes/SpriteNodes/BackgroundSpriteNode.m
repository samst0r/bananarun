//
//  BackgroundSpriteNode.m
//  FingerRun
//
//  Created by Samuel Ward on 22/03/2014.
//  Copyright (c) 2014 Samuel Ward. All rights reserved.
//

#import "BackgroundSpriteNode.h"

@implementation BackgroundSpriteNode

- (id)init
{
    self = [super init];
    if (self) {
        
        [self setup];
    }
    return self;
}

- (void)setup {
    
    self.texture = [SKTexture textureWithImageNamed:@"background"];
    self.name = @"Background";
}

@end
