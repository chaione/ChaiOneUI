//
//  ColorPickerViewController.h
//  ChaiOneUISamples
//
//  Created by Ben Scheirman on 1/10/12.
//  Copyright (c) 2012 ChaiONE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ColorPickerViewController : UIViewController {
    NSString *_lastKey;
}

@property (nonatomic, retain) NSDictionary *colors;

- (IBAction)colorChangeTapped:(id)sender;

@end
