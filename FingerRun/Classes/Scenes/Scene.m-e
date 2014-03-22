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

@property (nonatomic) SKLabelNode *speedLabel;
@property (nonatomic) SKLabelNode *topSpeedLabel;

@property (nonatomic) NSInteger topSpeed;

@end

@implementation Scene

#pragma mark - Initialisation

- (void)setupAndAddSpeedLabel {
    
    _speedLabel = [[SKLabelNode alloc] initWithFontNamed:@"Helvetica"];
    _speedLabel.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetHeight(self.frame) - 80);
    _speedLabel.text = @"";
    _speedLabel.fontColor = [UIColor yellowColor];
    _speedLabel.alpha = 0.85f;
    
    [self addChild:_speedLabel];
}

- (void)setupAndAddTopSpeedLabel {
    
    _topSpeedLabel = [[SKLabelNode alloc] initWithFontNamed:@"Helvetica"];
    _topSpeedLabel.fontSize = 8.0f;
    _topSpeedLabel.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetHeight(self.frame) - 96);
    _topSpeedLabel.text = @"";
    _topSpeedLabel.fontColor = [UIColor yellowColor];
    _topSpeedLabel.alpha = 0.85f;
    
    [self addChild:_topSpeedLabel];
}

-(id)initWithSize:(CGSize)size {
    
    if (self = [super initWithSize:size]) {
    
        [self setupAndAddBackground];
        [self setupAndAddRoadMarker];
        [self setupAndAddSpeedLabel];
        [self setupAndAddTopSpeedLabel];
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

- (void)setupAndAddRoadMarker {
    
    _roadMarkerNode = [[RoadMarkerSpriteNode alloc] init];
    _roadMarkerNode.position = CGPointMake(CGRectGetMidX(self.frame), 0);
    _roadMarkerNode.size = CGSizeMake(20, 80);
    _roadMarkerNode.speed = 0.0f;
    
    [self addChild:_roadMarkerNode];
}
- (void)recordTopSpeed {
    if (self.roadMarkerNode.speed > self.topSpeed) {
        
        self.topSpeed = self.roadMarkerNode.speed;
        self.topSpeedLabel.text = [NSString stringWithFormat:@"Top Speed %.02f MPH", self.roadMarkerNode.speed];
    }
}

- (void)recordSpeed {
    self.speedLabel.text = [NSString stringWithFormat:@"%.02f MPH", self.roadMarkerNode.speed];
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
    
    self.roadMarkerNode.position = CGPointMake(self.roadMarkerNode.position.x,
                                               self.roadMarkerNode.position.y + self.roadMarkerNode.speed);
    
    if (self.roadMarkerNode.position.y >= self.background.size.height) {
        
        self.roadMarkerNode.position = CGPointMake(self.roadMarkerNode.position.x,
                                                   0);
    }
    
    [self recordSpeed];
    [self recordTopSpeed];
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
    
    self.roadMarkerNode.speed++;
    
    double delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        if (self.roadMarkerNode.speed > 0) {
            
            self.roadMarkerNode.speed -= 1.0;
        }
    });
}

@end
