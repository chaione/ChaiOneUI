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
- (void)setupTags;

@property (nonatomic, readonly) NSMutableArray *tags;

@end


@implementation CHTagSelectorView

@synthesize delegate, datasource, panelView, panelHeaderView, titleLabel, transitionStyle;

- (id)init {
	self = [super init];
	if (self) {
		[self setupViews];
	}
	return self;
}

- (NSMutableArray *)tags {
    if (!tags) {
		tags = [[NSMutableArray alloc] init];
        [self setupTags];
	}
    return tags;
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
	
	self.transitionStyle = CHTagSelectorTransitionStyleZoomIn;
	self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8];
	
	UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[closeButton setFrame:self.bounds];
	[closeButton setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
	[closeButton addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
	
	[self addSubview:closeButton];
	
	self.panelView = [[[UIView alloc] initWithFrame:CGRectMake(20, 20, 280, 320)] autorelease];
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
	allButton.frame = CGRectMake(160, 15, 40, 30);
	[self.panelHeaderView addSubview:allButton];

	UIButton *noneButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[noneButton setTitle:@"None" forState:UIControlStateNormal];
	[noneButton addTarget:self action:@selector(selectNone:) forControlEvents:UIControlEventTouchUpInside];
	noneButton.titleLabel.font = [UIFont systemFontOfSize:14];
	noneButton.frame = CGRectMake(220, 15, 40, 30);
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
	doneButton.frame = CGRectMake(205, self.panelView.frame.size.height - 15, 80, 30);
	doneButton.backgroundColor = [UIColor colorWithWhite:.2 alpha:1.0];
	
	[self.panelView addSubview:doneButton];
}

- (NSArray *)selectedTags {
	return [self.tags ch_select:^(id obj) {
		return [obj selected];
	}];
}

- (void)closeAndNotifyOfSelection:(BOOL)notify {
	
	if (notify) {		
		if (self.delegate && [self.delegate respondsToSelector:@selector(tagSelector:didCloseWithTags:)]) {
			[self.delegate tagSelector:self didCloseWithTags:[self selectedTags]];
		}
	}

	[UIView animateWithDuration:.2
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
	for(CHTag *tag in self.tags) {
		if (!tag.selected) {
			[tag toggle];
		}
	}
}

- (void)selectNone:(id)sender {
	for(CHTag *tag in self.tags) {
		if (tag.selected) {
			[tag toggle];
		}
	}	
}

- (void)setupTags {
    NSInteger tagCount = [self.datasource numberOfTagsInTagSelector:self];

    for (int i=0; i<tagCount; i++) {
		NSString *tagText = [self.datasource tagSelector:self tagForIndex:i];
		CHTag *tag = [[CHTag alloc] init];
		
		tag.font = [UIFont systemFontOfSize:14];
		tag.textColor = [UIColor whiteColor];
		tag.shadowColor = [UIColor darkGrayColor];
		tag.shadowOffset = CGSizeMake(0, 1);
		tag.textAlignment = UITextAlignmentCenter;
		tag.backgroundColor = [UIColor lightGrayColor];
		tag.text = tagText;
		tag.tag = i;
		tag.userInteractionEnabled = YES;
		tag.layer.shouldRasterize = YES;
		tag.normalColor = [UIColor lightGrayColor];
		tag.highlightColor = [UIColor redColor];
        
		if ([self.datasource respondsToSelector:@selector(tagSelector:customizeTag:atIndex:)]) {
            [self.datasource tagSelector:self customizeTag:tag atIndex:i];
        }		
		
		[self.tags addObject:tag];
        
        UIGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toggleTag:)];
		[tag addGestureRecognizer:tapRecognizer];
		[tapRecognizer release];
        [panelView addSubview:tag];
        
   		[tag release];
	}

    NSLog(@"Selected tags: %@",[self selectedTags]);
}

- (void)layoutTags {
	const int LeftRightMargin = 10;
	const int LabelMargin = 5;
	const int LabelPadding = 15;
	int startX = LeftRightMargin;
	int startY = 70;
		
	for (int i=0; i < [self.tags count]; i++) {
		CHTag *tag = [self.tags objectAtIndex:i];

		CGSize size = [tag.text sizeWithFont:tag.font];
		
		tag.frame = CGRectMake(startX, startY, size.width + LabelPadding, 30);
		startX += tag.frame.size.width + LabelMargin;
		if (startX + tag.frame.size.width >= panelView.frame.size.width - (2 * LeftRightMargin)) {
			startX = LeftRightMargin;
			startY += tag.frame.size.height + LabelMargin;
		}
        
	}
}

- (void)toggleTag:(id)sender {
	UIGestureRecognizer *gestureRecognizer = sender;
	CHTag *tag = (CHTag *)[gestureRecognizer view];
	[tag toggle];	
	
	if ([self.delegate respondsToSelector:@selector(tagSelector:didToggleTag:)]) {
		[self.delegate tagSelector:self didToggleTag:tag];		
	}
}

- (void)presentInContainerView:(UIView *)view {
	self.frame = view.bounds;
	panelView.frame = CGRectInset(self.bounds, 10, 30);

	[self layoutTags];	
	[self addSubview:panelView];
	[view addSubview:self];	
	
	
	BOOL scaleTransition = YES;
	panelView.center = self.center;
	
	if (scaleTransition) {
		panelView.transform = CGAffineTransformMakeScale(.3, .3);
		[UIView animateWithDuration:.25 animations:^{
			self.alpha = 1;
			panelView.transform = CGAffineTransformIdentity;
		}];
	} else {
		panelView.center = CGPointMake(self.center.x, self.center.y + self.frame.size.height / 2);
		[UIView animateWithDuration:.25 animations:^{
			self.alpha = 1;
			panelView.center = self.center;
		}];
	}	
}

- (BOOL)allSelected {
	return [[self selectedTags] count] == [self.tags count];
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
