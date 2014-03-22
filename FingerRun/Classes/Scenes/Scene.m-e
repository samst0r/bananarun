//
//  MyScene.m
//  FingerRun
//
//  Created by Samuel Ward on 22/03/2014.
//  Copyright (c) 2014 Samuel Ward. All rights reserved.
//

#import "Scene.h"

#import "BackgroundSpriteNode.h"
#import "FootPrintSpriteNode.h"

@interface Scene ()

@property (nonatomic) BackgroundSpriteNode *background;

@end

@implementation Scene

#pragma mark - Initialisation
-(id)initWithSize:(CGSize)size {
    
    if (self = [super initWithSize:size]) {
    
        [self setupAndAddBackground];
    }
    
    return self;
}

- (void)setupAndAddBackground {
    
    _background = [[BackgroundSpriteNode alloc] init];
    
    _background.position = CGPointMake(CGRectGetMidX(self.frame),
                                       CGRectGetMidY(self.frame));
    _background.xScale = 0.5;
    _background.yScale = 0.5;
    
    _background.size = self.size;
    
    [self addChild:_background];
}

#pragma mark - Touch
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint positionInScene = [touch locationInNode:self];
 
    FootPrintSpriteNode *footprint = [[FootPrintSpriteNode alloc] init];
    footprint.position = positionInScene;
    
    footprint.size = CGSizeMake(50, 90);
    footprint.xScale = 0.5;
    footprint.yScale = 0.5;
    
    [footprint hideAfterOneSecondsWithCompletion:^{
       
        [self removeChildrenInArray:@[footprint]];
    }];
    
    [self addChild:footprint];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint positionInScene = [touch locationInNode:self];
    
    // Determine speed
    int minDuration = 2.0;
    int maxDuration = 4.0;
    int rangeDuration = maxDuration - minDuration;
    int actualDuration = (arc4random() % rangeDuration) + minDuration;
}

@end
