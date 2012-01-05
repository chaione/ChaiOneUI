//
//  CHAlertView.h
//  ChaiOneUI
//
//  Created by Ben Scheirman on 1/5/12.
//  Copyright (c) 2012 ChaiONE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^ AlertViewBlock)(UIAlertView *alertView, int buttonIndex);

@interface CHAlertView : NSObject <UIAlertViewDelegate> {
    UIAlertView *_alertView;
    AlertViewBlock _block;
}

+ (void)alertWithTitle:(NSString *)title message:(NSString *)message cancelButtonText:(NSString *)cancelButtonText actionButtonText:(NSString *)actionButtonText completionBlock:(AlertViewBlock)block;

- (id)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonText:(NSString *)cancelButtonText actionButtonText:(NSString *)actionButtonText completionBlock:(AlertViewBlock)block;


@end
