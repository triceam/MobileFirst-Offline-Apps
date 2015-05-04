//
//  AppDelegate.h
//  GeoPix
//
//  Created by Andrew Trice on 3/12/15.
//  Copyright (c) 2015 Andrew Trice. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <IMFCore/IMFCore.h>
#import <CloudantToolkit/CloudantToolkit.h>
#import <FacebookSDK/FacebookSDK.h>
#import <IMFFacebookAuthenticationHandler.h>
#import "IMFDefaultFacebookAuthenticationDelegate.h"
#import "Configuration.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    
    IMFLogger *logger;
}

@property (strong, nonatomic) UIWindow *window;


@end

