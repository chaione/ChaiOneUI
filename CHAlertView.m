//
//  CHAlertView.m
//  ChaiOneUI
//
//  Created by Ben Scheirman on 1/5/12.
//  Copyright (c) 2012 ChaiONE. All rights reserved.
//

#import "CHAlertView.h"

@implementation CHAlertView

+ (void)alertWithTitle:(NSString *)title message:(NSString *)message cancelButtonText:(NSString *)cancelButtonText actionButtonText:(NSString *)actionButtonText completionBlock:(AlertViewBlock)block {   
    [[CHAlertView alloc] initWithTitle:title
                                message:message
                       cancelButtonText:cancelButtonText
                       actionButtonText:actionButtonText
                        completionBlock:block];
}

- (id)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonText:(NSString *)cancelButtonText actionButtonText:(NSString *)actionButtonText completionBlock:(AlertViewBlock)block {
    self = [super init];
    if (self) {
        _alertView = [[UIAlertView alloc] initWithTitle:title
                                                 message:message
                                                delegate:self
                                       cancelButtonTitle:cancelButtonText
                                       otherButtonTitles:actionButtonText, nil];
        _block = Block_copy(block);
    }
    
    [_alertView show];
    
    return self;
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    _block(alertView, buttonIndex);
    [self autorelease];
}

- (void)dealloc {
    [_alertView release];
    Block_release(_block);
    [super dealloc];
}

@end
