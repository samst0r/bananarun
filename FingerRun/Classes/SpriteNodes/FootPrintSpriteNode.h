//
//  FootPrintSpriteNode.h
//  FingerRun
//
//  Created by Samuel Ward on 22/03/2014.
//  Copyright (c) 2014 Samuel Ward. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface FootPrintSpriteNode : SKSpriteNode

- (void)hideAfterOneSecondsWithCompletion:(void (^)(void))completion;

@end
