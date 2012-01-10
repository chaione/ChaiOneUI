//
//  TagSelectorViewController.m
//  ChaiOneUISamples
//
//  Created by Ben Scheirman on 5/20/11.
//  Copyright 2011 ChaiONE. All rights reserved.
//

#import "TagSelectorViewController.h"
//#import "CHTagSelectorView.h"
#import "NSArray+CHFunctionalAdditions.h"

@implementation TagSelectorViewController

@synthesize tagsLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc {
    [tagsLabel release];
	[tags release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


#pragma mark -
#pragma mark CGTagSelector methods
//
//- (NSInteger)numberOfTagsInTagSelector:(CHTagSelectorView *)tagSelector {
//	return tags.count;
//}
//
//- (NSString *)tagSelector:(CHTagSelectorView *)tagSelector tagForIndex:(NSInteger)index {	
//	return [tags objectAtIndex:index];
//}
//
//- (void)tagSelectorDidCancel:(CHTagSelectorView *)tagSelector {
//}
//
//- (void)tagSelector:(CHTagSelectorView *)tagSelector didCloseWithTags:(NSArray *)selectedTags {
//	NSArray *tagNames = [selectedTags ch_collect:^(id obj) {
//		return (id)[obj text];
//	}];
//	
//	self.tagsLabel.text = [tagNames componentsJoinedByString:@", "];
//}
//
//- (void)tagSelector:(CHTagSelectorView *)tagSelector didToggleTag:(CHTag *)tag {
//}


#pragma mark -
#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
		
	tags = [[NSArray arrayWithObjects:@"Rock", //@"Blues", @"Jazz", @"Rap", @"Bluegrass", @"Folk", @"Alternative", @"Country", 
//			 @"Hip-Hop", @"Dance", @"Electronic", @"Funk", @"Metal", @"Pop", @"Punk", @"Bluegrass", @"Folk", @"Alternative", @"Country", 
			 @"Hip-Hop", @"Dance", @"Electronic", @"Funk", @"Metal", @"Pop", @"Punk",
			 nil] retain];
}

- (void)viewDidUnload {
    [self setTagsLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)onSelectTags:(id)sender {
//    CHTagSelectorView *tagSelector = [[CHTagSelectorView alloc] init];
//	tagSelector.titleLabel.text = @"Select Genre";
//    tagSelector.delegate = self;
//    tagSelector.datasource = self;
//	[tagSelector presentInContainerView:self.view];
}

@end
