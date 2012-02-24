//
//  UIAlertView+CHSimpleAlerts.h
//  ChaiOneUI
//
//  Created by Ben Scheirman on 7/21/11.
//  Copyright 2011 ChaiONE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertView  (CHSimpleAlerts)

+ (void)simpleAlertWithTitle:(NSString *)title message:(NSString *)message;
+ (void)simpleAlertWithTitle:(NSString *)title format:(NSString *)formatString, ...;

@end
