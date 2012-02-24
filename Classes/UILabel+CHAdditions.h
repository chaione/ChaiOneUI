//
//  UILabel+CHAdditions.h
//  ChaiOneUI
//
//  Created by Anthony Broussard on 5/27/11.
//  Copyright 2011 ChaiONE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UILabel (CHAdditions)

-(void)resizeToFitText:(NSString *)text maxSize:(CGSize)size;

@end
