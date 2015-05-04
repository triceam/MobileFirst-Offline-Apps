//
//  AppDelegate.m
//  GeoPix
//
//  Created by Andrew Trice on 3/12/15.
//  Copyright (c) 2015 Andrew Trice. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate



//TODO: Initialize Facebook Auth callback
/*
- (BOOL)application: (UIApplication *)application
            openURL: (NSURL *)url
  sourceApplication: (NSString *)sourceApplication
         annotation: (id)annotation {
    //handle Facebook login
    return [FBAppCall handleOpenURL:url sourceApplication:sourceApplication];
}*/

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //TODO: connect with MobileFirst/Bluemix backend
    
    /*
    IMFClient *imfClient = [IMFClient sharedInstance];
    [imfClient initializeWithBackendRoute:BLUEMIX_ROUTE
                              backendGUID:BLUEMIX_GUID];
    
    // capture and record uncaught exceptions (crashes)
    [IMFLogger captureUncaughtExceptions];
    [IMFLogger setLogLevel:IMFLogLevelTrace];
    
    logger = [IMFLogger loggerForName:NSStringFromClass([self class])];
    [logger logDebugWithMessages:@"initializing bluemix client..."];
    
    [IMFLogger send];
    
    
    //TODO: Initialize Facebook Auth
    
    [[IMFFacebookAuthenticationHandler sharedInstance] registerWithDefaultDelegate];
    */
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    
    //TODO: Initialize Facebook activity monitoring
    //[FBAppEvents activateApp];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
