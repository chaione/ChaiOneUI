//
//  CHPickerViewSensitiveScrollView.m
//  ChaiOneUI
//
//  Created by Longyi Qi on 7/26/11.
//  Copyright 2011 ChaiONE. All rights reserved.
//

#import "CHPickerViewSensitiveScrollView.h"

@implementation CHPickerViewSensitiveScrollView

- (BOOL)touchesShouldCancelInContentView:(UIView *)view {
    if ([view isKindOfClass:[UIPickerView class]] || [@"UIPickerTable" isEqualToString:[[view class] description]] ) {
        return NO;
    }
    return [super touchesShouldCancelInContentView:view];
}

@end
