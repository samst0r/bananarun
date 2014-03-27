//
//  DropShadowLabelNode.m
//  Banana Run
//
//  Created by Samuel Ward on 27/03/2014.
//  Copyright (c) 2014 Samuel Ward. All rights reserved.
//

#import "DropShadowLabelNode.h"

@interface DropShadowLabelNode ()

@property (nonatomic) SKLabelNode *dropShadowString;

@end

@implementation DropShadowLabelNode

- (instancetype)initWithDropShadowString:(NSString *)myString
                                fontSize:(CGFloat)fontSize
                                   color:(SKColor *)color
                             shadowColor:(SKColor *)shadowColor
{
    self = [super initWithFontNamed:@"04b19"];
    
    if (self) {
        
        int offSetX = 1;
        int offSetY = 1;
        
        self.fontSize = fontSize;
        self.fontColor = shadowColor;
        self.text = myString;
        
        _dropShadowString = [SKLabelNode labelNodeWithFontNamed:@"04b19"];
        _dropShadowString.fontSize = fontSize;
        _dropShadowString.fontColor = color;
        _dropShadowString.text = myString;
        _dropShadowString.zPosition = self.zPosition;
        _dropShadowString.position = CGPointMake(_dropShadowString.position.x - offSetX, _dropShadowString.position.y - offSetY);
        
        [self addChild:_dropShadowString];
    }
    return self;
}

- (void)setText:(NSString *)text {
    
    [super setText:text];
    
    self.dropShadowString.text = text;
}

@end
