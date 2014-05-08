//
//  AppDelegate.m
//  GitUsersSeeker
//
//  Created by amayoral on 5/7/14.
//  Copyright (c) 2014 mayorallabs. All rights reserved.
//

#import "AppDelegate.h"
#import "UIColor+Hex.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self initViewAppearance];
    
    // Override point for customization after application launch.
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)initViewAppearance {
    
    //------------------//------------------
    // Navigation Controller
    //------------------//------------------
    UIImage *gradientImage;
    gradientImage = [[self imageFromLayer:[self gradientLayerGrades:0 withFrame:CGRectMake(0, 0, SCREEN_WIDTH, GLOBAL_HEIGHT_NAV)]]
                     resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    // Set the background image for *all* UINavigationBars
    [[UINavigationBar appearance] setBackgroundImage:gradientImage
                                       forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setBackgroundImage:gradientImage
                                       forBarMetrics:UIBarMetricsLandscapePhone];
    
    NSDictionary* attr = @{NSForegroundColorAttributeName : [UIColor whiteColor],
                           NSFontAttributeName      : [UIFont fontWithName:FONT_NAME_LIGHT size:20.0]};
    
    [[UINavigationBar appearance] setTitleTextAttributes:attr];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
}

- (UIImage *)imageFromLayer:(CALayer *)layer
{
    UIGraphicsBeginImageContext([layer frame].size);
    
    [layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return outputImage;
}

- (CALayer *)gradientLayerGrades:(int)angle withFrame:(CGRect)bounds
{
    //0xff7c1648 centerColor:0xffd0187d endColor:0xffea188d
    CAGradientLayer * gradientBG = [CAGradientLayer layer];
    gradientBG.frame = bounds;
    gradientBG.colors = @[ (id)[[UIColor UIColorFromHex:0x4bc1d2] CGColor], (id)[[UIColor UIColorFromHex:0x4bc1d2] CGColor], (id)[[UIColor UIColorFromHex:0xffffff] CGColor] ];
    
    switch (angle) {
            
        case 0:
            // 0 degrees - inverted
            [gradientBG setStartPoint:CGPointMake(0.0, 0.5)];
            [gradientBG setEndPoint:CGPointMake(1.0, 0.5)];
            break;
            
        case 90:
            // 90 degrees - inverted
            [gradientBG setStartPoint:CGPointMake(0.5, 1.0)];
            [gradientBG setEndPoint:CGPointMake(0.5, 0.0)];
            break;
        case 270:
            // 270 degrees - inverted
            [gradientBG setStartPoint:CGPointMake(0.5, 0.0)];
            [gradientBG setEndPoint:CGPointMake(0.5, 1.0)];
            break;
        default:
            // X degrees - normal
            [gradientBG setStartPoint:CGPointMake(0.5, 0.0)];
            [gradientBG setEndPoint:CGPointMake(0.5, 1.0)];
            break;
    }
    
    return gradientBG;
}

@end
