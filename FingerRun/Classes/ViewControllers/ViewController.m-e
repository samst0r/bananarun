//
//  ViewController.m
//  FingerRun
//
//  Created by Samuel Ward on 22/03/2014.
//  Copyright (c) 2014 Samuel Ward. All rights reserved.
//

#import "ViewController.h"
#import "MenuScene.h"

@import iAd;

@interface ViewController () <ADBannerViewDelegate>

@property (nonatomic) SKView *skView;
@property (nonatomic) ADBannerView *bannerView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Configure the view.
    self.skView = (SKView *)self.view;
    
    if ([ADBannerView instancesRespondToSelector:@selector(initWithAdType:)]) {
        
        self.bannerView = [[ADBannerView alloc] initWithAdType:ADAdTypeBanner];
    } else {
        
        self.bannerView = [[ADBannerView alloc] init];
    }
    
    self.bannerView.delegate = self;
    [self.view addSubview:self.bannerView];
    
    MenuScene *scene = [MenuScene sceneWithSize:self.skView.bounds.size];
    
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    [self.skView presentScene:scene];
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark iAd


- (void)viewDidLayoutSubviews {
    
    [self layoutAnimated:[UIView areAnimationsEnabled]];
}

- (void)bannerViewDidLoadAd:(ADBannerView *)banner {
    
    [self layoutAnimated:YES];
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error {
    
    [self layoutAnimated:YES];
}

- (BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave {
    
    self.skView.paused = YES;
    self.skView.alpha = 0.2f;
    
    return YES;
}

- (void)bannerViewActionDidFinish:(ADBannerView *)banner {
    
    double delayInSeconds = 0.25;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        [UIView animateWithDuration:0.25 animations:^{
            
            self.skView.alpha = 1.0f;
        } completion:^(BOOL finished) {
            
            self.skView.paused = NO;
        }];

    });
}

- (void)layoutAnimated:(BOOL)animated {
    
    CGRect contentFrame = self.skView.bounds;
    CGRect bannerFrame = self.bannerView.frame;
    
    if (self.bannerView.bannerLoaded) {
        bannerFrame.origin.y = contentFrame.size.height - self.bannerView.bounds.size.height;
    } else {
        
        bannerFrame.origin.y = contentFrame.size.height;
    }
    
    [UIView animateWithDuration:animated ? 0.05 : 0.0 animations:^{
        self.bannerView.frame = bannerFrame;
    }];
}


@end
