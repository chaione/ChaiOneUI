//
//  UIDevice+CHUniqueIdentifier.m
//  
//
//  Created by Anthony Broussard on 12/2/11.
//  Copyright (c) 2011 ChaiONE. All rights reserved.
//

#import "UIDevice+CHUniqueIdentifier.h"

#define CH_UNIQUE_DEVICE_IDENTIFIER_KEY @"CH_UNIQUE_DEVICE_IDENTIFIER_KEY"

@implementation UIDevice (CHUniqueIdentifier)

+ (NSString *)ch_uniqueIdentifier {
    //[UIDevice deviceIdentifier] is deprecated in 5.0
    //So we're using this new method and persisting its results to NSUserDefaults
    NSString *deviceIdentifier = [[NSUserDefaults standardUserDefaults] valueForKey:CH_UNIQUE_DEVICE_IDENTIFIER_KEY];
    
    if (deviceIdentifier) {
        return deviceIdentifier;
    }
    
    NSString *uuidString = nil;
    CFUUIDRef uuid = CFUUIDCreate(NULL);
    if (uuid) {
        uuidString = (NSString *)CFUUIDCreateString(NULL, uuid);
        CFRelease(uuid);
    }
    
    [[NSUserDefaults standardUserDefaults] setValue:uuidString forKey:CH_UNIQUE_DEVICE_IDENTIFIER_KEY];
    
    return [uuidString autorelease];
}

@end
