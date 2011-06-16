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

@synthesize selected, highlightColor, normalColor;

- (id) init {
	self = [super init];
	if (self != nil) {
		self.backgroundColor = [UIColor clearColor];
	}
	return self;
}

- (id) initWithFrame:(CGRect)rect {
	self = [super initWithFrame:rect];
	if (self != nil) {
		self.backgroundColor = [UIColor clearColor];
	}
	return self;
}

- (void)setBackgroundColor:(UIColor *)color {
	[super setBackgroundColor:[UIColor clearColor]];
	self.layer.backgroundColor = color.CGColor;
	
	//take first background color set as the normal color
	if (!self.normalColor) {
		self.normalColor = color;		
	}
}

- (void)setSelected:(BOOL)selected_ {
    selected = selected_;
    UIColor *targetColor = self.selected ? self.highlightColor : self.normalColor;
    self.layer.backgroundColor = targetColor.CGColor;
}

- (void)toggle {
	self.selected = !self.selected;
}

@end
