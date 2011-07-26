//
//  UIAlertView+CHSimpleAlerts.m
//  ChaiOneUI
//
//  Created by Ben Scheirman on 7/21/11.
//  Copyright 2011 ChaiONE. All rights reserved.
//

#import "UIAlertView+CHSimpleAlerts.h"

@implementation UIAlertView (CHSimpleAlerts)

+ (void)simpleAlertWithTitle:(NSString *)title message:(NSString *)message {
    [[[[UIAlertView alloc] initWithTitle:title
                                 message:message
                                delegate:nil 
                       cancelButtonTitle:@"OK"
                       otherButtonTitles:nil] autorelease] show];
}

+ (void)simpleAlertWithTitle:(NSString *)title format:(NSString *)formatString, ...  {
    va_list args;
    va_start(args, formatString);
    NSString *message = [[[NSString alloc] initWithFormat:formatString arguments:args] autorelease];
    va_end(args);
    [UIAlertView simpleAlertWithTitle:title message:message];
}

@end
