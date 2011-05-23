//
//  CHTagSelectorView.m
//  ChaiOneUI
//
//  Created by Ben Scheirman on 5/20/11.
//  Copyright 2011 ChaiONE. All rights reserved.
//

#import "CHTagSelectorView.h"
#import "NSArray+CHFunctionalAdditions.h"
#import <QuartzCore/QuartzCore.h>

@interface CHTagSelectorView ()
- (void)setupViews;
- (void)closeAndNotifyOfSelection:(BOOL)notify;
@end


@implementation CHTagSelectorView

@synthesize delegate, datasource, panelView, panelHeaderView, titleLabel;

- (id)init {
	self = [super init];
	if (self != nil) {
		[self setupViews];
	}
	return self;
}


- (id)initWithFrame:(CGRect)frame {    
    self = [super initWithFrame:frame];
    if (self) {
		[self setupViews];
    }
    return self;
}

- (void)setupViews {
	if(self.panelView) {
		return;
	}
	
	self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8];
	
	UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[closeButton setFrame:self.bounds];
	[closeButton setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
	[closeButton addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
	
	[self addSubview:closeButton];
	
	self.panelView = [[[UIView alloc] initWithFrame:CGRectMake(20, 20, 280, 280)] autorelease];
	self.panelView.backgroundColor = [UIColor darkGrayColor];
	self.panelView.layer.cornerRadius = 10;
	self.panelView.autoresizesSubviews = YES;
	self.panelView.clipsToBounds = YES;
	
	self.panelHeaderView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 280, 60)] autorelease];
	self.panelHeaderView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	self.panelHeaderView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:1];
	[self.panelView addSubview:panelHeaderView];
	
	UIButton *allButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[allButton setTitle:@"All" forState:UIControlStateNormal];
	[allButton addTarget:self action:@selector(selectAll:) forControlEvents:UIControlEventTouchUpInside];
	allButton.titleLabel.font = [UIFont systemFontOfSize:14];
	allButton.frame = CGRectMake(168, 15, 40, 30);
	[self.panelHeaderView addSubview:allButton];

	UIButton *noneButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[noneButton setTitle:@"None" forState:UIControlStateNormal];
	[noneButton addTarget:self action:@selector(selectNone:) forControlEvents:UIControlEventTouchUpInside];
	noneButton.titleLabel.font = [UIFont systemFontOfSize:14];
	noneButton.frame = CGRectMake(210, 15, 40, 30);
	[self.panelHeaderView addSubview:noneButton];
	
	self.titleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(10, 0, 160, 60)] autorelease];
	self.titleLabel.font = [UIFont boldSystemFontOfSize:18];
	self.titleLabel.backgroundColor = self.panelHeaderView.backgroundColor;
	self.titleLabel.textColor = [UIColor whiteColor];
	self.titleLabel.shadowColor = [UIColor blackColor];
	self.titleLabel.shadowOffset = CGSizeMake(0, 1);
	[self.panelHeaderView addSubview:self.titleLabel];
	
	UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[doneButton setTitle:@"Done" forState:UIControlStateNormal];
	[doneButton addTarget:self action:@selector(done:) forControlEvents:UIControlEventTouchUpInside];
	doneButton.frame = CGRectMake(190, self.panelView.frame.size.height - 25, 80, 30);
	doneButton.backgroundColor = [UIColor colorWithWhite:.2 alpha:1.0];
	doneButton.layer.shadowColor = [[UIColor blackColor] CGColor];
	doneButton.layer.shadowOffset = CGSizeMake(0, 1);
	doneButton.layer.shadowOpacity = 0.5;
	doneButton.layer.borderColor = [[UIColor darkGrayColor] CGColor];
	doneButton.layer.cornerRadius = 6;
	
	[self.panelView addSubview:doneButton];
}

- (NSArray *)selectedTags {
	return [tags ch_select:^(id obj) {
		return [obj selected];
	}];
}

- (void)closeAndNotifyOfSelection:(BOOL)notify {
	
	if (notify) {		
		if (self.delegate && [self.delegate respondsToSelector:@selector(tagSelector:didCloseWithTags:)]) {
			[self.delegate tagSelector:self didCloseWithTags:[self selectedTags]];
		}
	}

	[UIView animateWithDuration:.1
					 animations:^ {
						 self.alpha = 0;
					 } 
					 completion:^(BOOL didFinish) {
						 [self removeFromSuperview]; 
					 }];	
}

- (void)done:(id)sender {
	[self closeAndNotifyOfSelection:YES];
}

- (void)close:(id)sender {	
	[self closeAndNotifyOfSelection:YES];
}

- (void)selectAll:(id)sender {
	for(CHTag *tag in tags) {
		if (!tag.selected) {
			[tag toggle];
		}
	}
}

- (void)selectNone:(id)sender {
	for(CHTag *tag in tags) {
		if (tag.selected) {
			[tag toggle];
		}
	}	
}

- (void)addTags {
	NSInteger tagCount = [self.datasource numberOfTagsInTagSelector:self];
	
	const int LeftRightMargin = 10;
	const int LabelMargin = 5;
	const int LabelPadding = 10;
	int startX = LeftRightMargin;
	int startY = 70;
	
	if (!tags) {
		tags = [[NSMutableArray alloc] init];
	} else {
		[tags removeAllObjects];
	}
	
	for (int i=0; i<tagCount; i++) {
		NSString *tagText = [self.datasource tagSelector:self tagForIndex:i];
		CHTag *label = [[CHTag alloc] init];
		
		label.font = [UIFont systemFontOfSize:12];
		label.shadowColor = [UIColor darkGrayColor];
		label.textColor = [UIColor whiteColor];
		label.shadowOffset = CGSizeMake(0, 1);
		label.textAlignment = UITextAlignmentCenter;
		label.backgroundColor = [UIColor lightGrayColor];
		label.layer.cornerRadius = 6;
		label.text = tagText;
		label.tag = i;
		label.layer.shadowColor = [UIColor blackColor].CGColor;
		label.layer.shadowRadius = 10;
		label.userInteractionEnabled = YES;
		label.normalColor = [UIColor lightGrayColor];
		label.highlightColor = [UIColor redColor];
		
		UIGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toggleTag:)];
		[label addGestureRecognizer:tapRecognizer];
		[tapRecognizer release];
		
		CGSize size = [tagText sizeWithFont:label.font];
		
		label.frame = CGRectMake(startX, startY, size.width + LabelPadding, 30);
		startX += label.frame.size.width + LabelMargin;
		if (startX + label.frame.size.width >= panelView.frame.size.width - (2 * LeftRightMargin)) {
			startX = LeftRightMargin;
			startY += label.frame.size.height + LabelMargin;
		}
		[panelView addSubview:label];
		[tags addObject:label];
		[label release];
	}
}

- (void)toggleTag:(id)sender {
	NSLog(@"Sender: %@", sender);
	UIGestureRecognizer *gestureRecognizer = sender;
	CHTag *tag = (CHTag *)[gestureRecognizer view];
	[tag toggle];	
	
	if ([self.delegate respondsToSelector:@selector(tagSelector:didToggleTag:)]) {
		[self.delegate tagSelector:self didToggleTag:tag];		
	}
}

- (void)presentInContainerView:(UIView *)view {
	self.frame = view.bounds;
	panelView.frame = CGRectInset(self.bounds, 20, 60);
	
	
	
	self.alpha = 0;
	panelView.center = CGPointMake(self.center.x, self.center.y + self.frame.size.height / 2);
	
	[self addTags];
	
	[self addSubview:panelView];
	

	[view addSubview:self];	
	
	
	[UIView animateWithDuration:.25 animations:^{
		self.alpha = 1;
		panelView.center = self.center;
	}];
	
}

- (BOOL)allSelected {
	return [[self selectedTags] count] == [tags count];
}

- (BOOL)noneSelected {
	return [[self selectedTags] count] == 0;
}


- (void)dealloc {
	[tags release];
	[panelView release];
	[panelHeaderView release];
	[titleLabel release];
	datasource = nil;
	delegate = nil;
	
    [super dealloc];
}


@end
