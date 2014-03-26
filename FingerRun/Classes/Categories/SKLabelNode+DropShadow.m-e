//
//  SKLabelNode+DropShadow.m
//  FingerRun
//
//  Created by Samuel Ward on 26/03/2014.
//  Copyright (c) 2014 Samuel Ward. All rights reserved.
//

#import "SKLabelNode+DropShadow.h"

@implementation SKLabelNode (DropShadow)

+ (SKLabelNode *)makeDropShadowString:(NSString *)myString
                             fontSize:(CGFloat)fontSize
                                color:(SKColor *)color
                          shadowColor:(SKColor *)shadowColor {
    
    int offSetX = 1;
    int offSetY = 1;
    
    SKLabelNode *completedString = [SKLabelNode labelNodeWithFontNamed:@"04b19"];
    completedString.fontSize = fontSize;
    completedString.fontColor = shadowColor;
    completedString.text = myString;
    
    SKLabelNode *dropShadow = [SKLabelNode labelNodeWithFontNamed:@"04b19"];
    dropShadow.fontSize = fontSize;
    dropShadow.fontColor = color;
    dropShadow.text = myString;
    dropShadow.zPosition = completedString.zPosition;
    dropShadow.position = CGPointMake(dropShadow.position.x - offSetX, dropShadow.position.y - offSetY);
    
    [completedString addChild:dropShadow];
    
    return completedString;
}

@end
