//
//  UIDevice+CHUniqueIdentifier.h
//  
//
//  Created by Anthony Broussard on 12/2/11.
//  Copyright (c) 2011 ChaiONE. All rights reserved.
//

#import <UIKit/UIKit.h>

/* Generates a UDID-esque string that you can use (and save to the device)
 for use in distinguishing a device from others. */

@interface UIDevice (CHUniqueIdentifier)

+ (NSString *)ch_uniqueIdentifier;

@end
