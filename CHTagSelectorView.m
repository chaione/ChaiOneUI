//
//  CHTagSelectorView.m
//  ChaiOneUI
//
//  Created by Ben Scheirman on 5/20/11.
//  Copyright 2011 ChaiONE. All rights reserved.
//

#import "CHTagSelectorView.h"
#import <QuartzCore/QuartzCore.h>

@interface CHTagSelectorView ()
- (void)setupViews;
@end


@implementation CHTagSelectorView

@synthesize delegate, datasource;

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
	if(panelView) {
		return;
	}
	
	self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8];
	
	UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[closeButton setFrame:self.bounds];
	[closeButton setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
	[closeButton addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
	
	[self addSubview:closeButton];
	
	panelView = [[UIView alloc] initWithFrame:CGRectMake(20, 20, 280, 280)];
	panelView.backgroundColor = [UIColor darkGrayColor];
	panelView.layer.cornerRadius = 10;
	panelView.autoresizesSubviews = YES;
	panelView.clipsToBounds = YES;
	
	UIView *panelHeader = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 280, 60)] autorelease];
	panelHeader.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	panelHeader.backgroundColor = [UIColor colorWithWhite:0.3 alpha:1];
	[panelView addSubview:panelHeader];
}

- (void)close:(id)sender {
	if (self.delegate && [self.delegate respondsToSelector:@selector(tagSelector:didCloseWithTags:)]) {
		[self.delegate tagSelector:self didCloseWithTags:nil];
	}
	
	[UIView animateWithDuration:.1
					 animations:^ {
						 self.alpha = 0;
					 } 
					 completion:^(BOOL didFinish) {
						 [self removeFromSuperview]; 
					 }];
}

- (void)addTags {
	NSInteger tagCount = [self.datasource numberOfTagsInTagSelector:self];
	
	const int LeftRightMargin = 10;
	const int LabelMargin = 5;
	const int LabelPadding = 10;
	int startX = LeftRightMargin;
	int startY = 70;
	
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

- (void)dealloc {
	[panelView release];
	datasource = nil;
	delegate = nil;
	
    [super dealloc];
}


@end
