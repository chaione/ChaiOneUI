//
//  CHTag.m
//  ChaiOneUI
//
//  Created by Ben Scheirman on 5/20/11.
//  Copyright 2011 ChaiONE. All rights reserved.
//

#import "CHTag.h"
#import <QuartzCore/QuartzCore.h>

@implementation CHTag

@synthesize selected, highlightColor;

- (void)toggle {
	
	self.selected != self.selected;
	
	UIColor *targetColor = self.selected ? self.highlightColor : self.highlightColor;
	self.backgroundColor = [UIColor clearColor];
	[UIView animateWithDuration:.3
					 animations:^ {
						 self.layer.backgroundColor = targetColor.CGColor;
					 }];
}

@end
