//
//  SKLabelNode+DropShadow.h
//  FingerRun
//
//  Created by Samuel Ward on 26/03/2014.
//  Copyright (c) 2014 Samuel Ward. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface SKLabelNode (DropShadow)

+ (SKLabelNode *)makeDropShadowString:(NSString *)myString
                             fontSize:(CGFloat)fontSize
                                color:(SKColor *)color
                          shadowColor:(SKColor *)shadowColor;
@end
