//
//  MyScene.m
//  FingerRun
//
//  Created by Samuel Ward on 22/03/2014.
//  Copyright (c) 2014 Samuel Ward. All rights reserved.
//

#import "Scene.h"

#import "BackgroundSpriteNode.h"

@interface Scene ()

@property (nonatomic) BackgroundSpriteNode *background;

@end

@implementation Scene

- (void)setupAndAddBackground {
    
    _background = [[BackgroundSpriteNode alloc] init];
    
    _background.position = CGPointMake(CGRectGetMidX(self.frame),
                                      CGRectGetMidY(self.frame));
    _background.xScale = 0.5;
    _background.yScale = 0.5;
    
    _background.size = self.size;
    
    [self addChild:_background];
}

-(id)initWithSize:(CGSize)size {
    
    if (self = [super initWithSize:size]) {
    
        [self setupAndAddBackground];
    }
    
    return self;
}

@end
