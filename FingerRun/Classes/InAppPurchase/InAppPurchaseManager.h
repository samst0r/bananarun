//
//  InAppPurchaseManager.h
//  Banana Run
//
//  Created by Samuel Ward on 02/04/2014.
//  Copyright (c) 2014 Samuel Ward. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SKProduct;

@interface InAppPurchaseManager : NSObject

- (void)beginPurchaseOfExtraLife;

@property (strong, nonatomic) SKProduct *product;

@end
