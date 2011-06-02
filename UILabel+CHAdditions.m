//
//  UILabel+CHAdditions.m
//  ChaiOneUI
//
//  Created by Anthony Broussard on 5/27/11.
//  Copyright 2011 ChaiONE. All rights reserved.
//

#import "UILabel+CHAdditions.h"


@implementation UILabel (CHAdditions)

-(void)resizeToFitText:(NSString *)text maxSize:(CGSize)maxSize {
	self.numberOfLines = 0;
	self.lineBreakMode = UILineBreakModeWordWrap;
    
	CGSize expectedLabelSize = [text sizeWithFont:self.font
                                constrainedToSize:maxSize 
                                    lineBreakMode:self.lineBreakMode]; 
	
	//adjust the label the the new height.
	CGRect newFrame = self.frame;
	newFrame.size.height = expectedLabelSize.height;
    newFrame.size.width = expectedLabelSize.width;
	self.frame = newFrame;
	
	self.text = text;	
}


@end
