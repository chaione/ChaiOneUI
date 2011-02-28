//
//  AlertViewTestAppAppDelegate.h
//  AlertViewTestApp
//
//  Created by Michael Gile on 2/28/11.
//  Copyright 2011 ChaiOne Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AlertViewTestAppViewController;

@interface AlertViewTestAppAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    AlertViewTestAppViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet AlertViewTestAppViewController *viewController;

@end

