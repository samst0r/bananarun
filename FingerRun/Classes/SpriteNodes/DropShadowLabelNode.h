//
//  DropShadowLabelNode.h
//  Banana Run
//
//  Created by Samuel Ward on 27/03/2014.
//  Copyright (c) 2014 Samuel Ward. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface DropShadowLabelNode : SKLabelNode

- (instancetype)initWithDropShadowString:(NSString *)myString
                                fontSize:(CGFloat)fontSize
                                   color:(SKColor *)color
                             shadowColor:(SKColor *)shadowColor;

@end
