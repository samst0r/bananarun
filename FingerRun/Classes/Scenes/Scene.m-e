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
#import "RoadMarkerSpriteNode.h"

@interface Scene ()

@property (nonatomic) BackgroundSpriteNode *background;
@property (nonatomic) RoadMarkerSpriteNode *roadMarkerNode;

@property (nonatomic) NSArray *roadMarkerArray;

@end

@implementation Scene

#pragma mark - Initialisation
-(id)initWithSize:(CGSize)size {
    
    if (self = [super initWithSize:size]) {
    
        [self setupAndAddBackground];
        
        
        _roadMarkerNode = [[RoadMarkerSpriteNode alloc] init];
        _roadMarkerNode.position = CGPointMake(CGRectGetMidX(self.frame), 0);
        
        [self addChild:_roadMarkerNode];
        
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

//- (void)setupRoadMarker {
//    
//    //1
//    NSArray *parallaxBackgroundNames = @[@"bg_galaxy.png", @"bg_planetsunrise.png",
//                                         @"bg_spacialanomaly.png", @"bg_spacialanomaly2.png"];
//    CGSize planetSizes = CGSizeMake(200.0, 200.0);
//    //2
//    _parallaxNodeBackgrounds = [[ alloc] initWithBackgrounds:parallaxBackgroundNames
//                                                                       size:planetSizes
//                                                       pointsPerSecondSpeed:10.0];
//    //3
//    _parallaxNodeBackgrounds.position = CGPointMake(size.width/2.0, size.height/2.0);
//    //4
//    [_parallaxNodeBackgrounds randomizeNodesPositions];
//    
//    //5
//    [self addChild:_parallaxNodeBackgrounds];
//    
//    //6
//    NSArray *parallaxBackground2Names = @[@"bg_front_spacedust.png",@"bg_front_spacedust.png"];
//    _parallaxSpaceDust = [[FMMParallaxNode alloc] initWithBackgrounds:parallaxBackground2Names
//                                                                 size:size
//                                                 pointsPerSecondSpeed:25.0];
//    _parallaxSpaceDust.position = CGPointMake(0, 0);
//    [self addChild:_parallaxSpaceDust];
//    
//}

- (void)update:(NSTimeInterval)currentTime {
    
    self.roadMarkerNode.size = CGSizeMake(20, 60);
    self.roadMarkerNode.position = CGPointMake(self.roadMarkerNode.position.x,
                                               self.roadMarkerNode.position.y + 1.5);
    
    if (self.roadMarkerNode.position.y >= self.background.size.height + self.roadMarkerNode.size.height) {
        
        self.roadMarkerNode.position = CGPointMake(self.roadMarkerNode.position.x,
                                                   0);
    } else {
        
//        self.roadMarkerNode.position = CGPointMake(100, -self.roadMarkerNode.size.height);
    }
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
