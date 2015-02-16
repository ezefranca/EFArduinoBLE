//
//  AppDelegate.h
//  kit-iot-wearable-ios
//
//  Created by Ezequiel on 04/02/15.
//  Copyright (c) 2015 Ezequiel França. All rights reserved.
//

#import <UIKit/UIKit.h>


@class DevicesVC;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) DevicesVC *devicesViewController;
@property (strong, nonatomic) UINavigationController *navController;

@end

