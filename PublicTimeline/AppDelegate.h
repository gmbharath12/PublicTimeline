//
//  AppDelegate.h
//  PublicTimeline
//
//  Created by Bharath G M on 3/19/13.
//  Copyright (c) 2013 Bharath G M. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;

@property (strong, nonatomic) UINavigationController *navController;

@end
