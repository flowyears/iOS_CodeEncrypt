//
//  AppDelegate.m
//  Test003
//
//  Created by 沈佳雄 on 2018/8/2.
//  Copyright © 2018年 沈佳雄. All rights reserved.
//

#import "AppDelegate.h"
#import "AngelCheckTool.h"



@interface AppDelegate ()
@property(nonatomic,strong)UIVisualEffectView *effectView;
@end

@implementation AppDelegate

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [self.window addSubview:self.effectView];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [self.effectView removeFromSuperview];
}

-(UIVisualEffectView *)effectView
{
    if (!_effectView)
    {
        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        _effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
        _effectView.frame = self.window.bounds;
    }
    return _effectView;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [AngelCheckTool check001];
    [AngelCheckTool check002];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}





- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
