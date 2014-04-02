//
//  InAppPurchaseManager.m
//  Banana Run
//
//  Created by Samuel Ward on 02/04/2014.
//  Copyright (c) 2014 Samuel Ward. All rights reserved.
//

#import "InAppPurchaseManager.h"

@implementation InAppPurchaseManager

/*

#pragma mark - In App Purchase
- (void)beginPurchaseOfExtraLife {
    
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    [self purchaseExtraLife];
}

- (void)purchaseExtraLife {
    
    static NSString *extraContinue = @"OneExtraContinue";
    
    if ([SKPaymentQueue canMakePayments])
    {
        SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithObject:extraContinue]];
        request.delegate = self;
        
        [request start];
    }
    else {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please enable In App Purchase in Settings" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        [alert show];
    }
}

#pragma mark -
#pragma mark SKProductsRequestDelegate

-(void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
    
    NSArray *products = response.products;
    
    if (products.count != 0) {
        
        self.product = products[0];
    } else {
        
        NSLog(@"No item found");
    }
    
    products = response.invalidProductIdentifiers;
    
    for (SKProduct *product in products)
    {
        NSLog(@"Product not found: %@", product);
    }
}

#pragma mark -
#pragma mark SKPaymentTransactionObserver

-(void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
    for (SKPaymentTransaction *transaction in transactions)
    {
        switch (transaction.transactionState) {
            case SKPaymentTransactionStatePurchased:
                
                self.pausedGame = NO;
                self.extraLife = YES;
                
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                break;
                
            case SKPaymentTransactionStateFailed:
                
                NSLog(@"Transaction Failed");
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                break;
                
            default:
                break;
        }
    }
}
 

@end
