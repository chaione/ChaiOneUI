//
//  CHUIMacros.m
//  ChaiOneUI
//
//  Created by Ben Scheirman on 7/28/11.
//  Copyright 2011 ChaiONE. All rights reserved.
//

#import <UIKit/UIKit.h>

static inline bool IsRetinaDisplay() {
    return [[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] == 2;
}
