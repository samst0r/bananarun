//
//  FootPrintSpriteNode.m
//  FingerRun
//
//  Created by Samuel Ward on 22/03/2014.
//  Copyright (c) 2014 Samuel Ward. All rights reserved.
//

#import "FootPrintShapeNode.h"

@implementation FootPrintShapeNode

- (id)init
{
    self = [super init];
    if (self) {
        
        [self setup];
    }
    return self;
}

- (void)setup {
    
    CGMutablePathRef myPath = CGPathCreateMutable();
    CGPathAddArc(myPath, NULL, 0,0, 15, 0, M_PI*2, YES);
    self.path = myPath;
    
    self.lineWidth = 1.0;
    self.fillColor = [SKColor blueColor];
    self.strokeColor = [SKColor whiteColor];
    self.glowWidth = 0.5;
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
