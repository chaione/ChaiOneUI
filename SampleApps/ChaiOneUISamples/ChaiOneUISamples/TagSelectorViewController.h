//
//  TagSelectorViewController.h
//  ChaiOneUISamples
//
//  Created by Ben Scheirman on 5/20/11.
//  Copyright 2011 ChaiONE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHTagSelectorView.h"

@interface TagSelectorViewController : UIViewController <CHTagSelectorDataSource, CHTagSelectorDelegate> {
    UILabel *tagsLabel;
	NSArray *tags;
}

@property (nonatomic, retain) IBOutlet UILabel *tagsLabel;

- (IBAction)onSelectTags:(id)sender;

@end
