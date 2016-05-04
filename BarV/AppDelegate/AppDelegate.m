//
//  AppDelegate.m
//  BarV
//
//  Created by lanouhn on 15/9/10.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "AppDelegate.h"
#import "ItemViewController.h"
#import "LikeTableViewController.h"
#import "MMDrawerController.h"
#import <AVFoundation/AVFoundation.h>



@interface AppDelegate ()

@property(nonatomic,retain)MMDrawerController *drawer;
@property (nonatomic,assign)NSInteger *count;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.count = 0;
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

    UIStoryboard *storyItem = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
    ItemViewController *item = [storyItem instantiateViewControllerWithIdentifier:@"item"];
    UINavigationController *naviItem = [[UINavigationController alloc]initWithRootViewController:item];
    UIStoryboard *storyLike = [UIStoryboard storyboardWithName:@"LikeStoryboard" bundle:nil];
    
    LikeTableViewController *like = [storyLike instantiateViewControllerWithIdentifier:@"likeB"];
    UINavigationController *naviLike = [[UINavigationController alloc]initWithRootViewController:like];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 35, 35);
    button.titleLabel.font = [UIFont fontWithName:@"iconfont" size:25];
    [button setTitle:@"\U0000e607" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(openOrClose:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    item.navigationItem.leftBarButtonItem = leftItem;
    
    self.drawer = [[MMDrawerController alloc]initWithCenterViewController:naviItem leftDrawerViewController:naviLike];
    [self.drawer setShowsShadow:YES];
    [self.drawer setMaximumLeftDrawerWidth:270];
    [self.drawer setOpenDrawerGestureModeMask:(MMOpenDrawerGestureModeAll)];
    [self.drawer setCloseDrawerGestureModeMask:(1|2|3|4|5|7)];
    self.window.rootViewController = self.drawer;
        return YES;
}



-(void)openOrClose:(UIButton *)sender{
    
    
    if (self.drawer.openSide == MMDrawerSideLeft) {
        [self.drawer closeDrawerAnimated:YES completion:nil];
    }else{
        [self.drawer openDrawerSide:(MMDrawerSideLeft) animated:YES completion:nil];
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    //PlayerView *player = [PlayerView shareWithPlayerView:CGRectZero];
       
    
    
    
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
//    AVAudioSession *session = [AVAudioSession sharedInstance];
//    [session setActive:YES error:nil];
//    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
//
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
