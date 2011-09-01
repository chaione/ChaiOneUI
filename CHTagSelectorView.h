//
//  CHTagSelectorView.h
//  ChaiOneUI
//
//  Created by Ben Scheirman on 5/20/11.
//  Copyright 2011 ChaiONE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHTag.h"

@protocol CHTagSelectorDataSource;
@protocol CHTagSelectorDelegate;

typedef enum {
	CHTagSelectorTransitionStyleZoomIn,
	CHTagSelectorTransitionStyleSlideIn
} CHTagSelectorTransitionStyle;

@interface CHTagSelectorView : UIView <UIGestureRecognizerDelegate> {
	NSMutableArray *tags;
}

@property (nonatomic, assign) CGFloat horizontalMargin;
@property (nonatomic, assign) CGFloat tagPadding;
@property (nonatomic, assign) CGFloat tagMargin;
@property (nonatomic, retain) UIView *panelView;
@property (nonatomic, retain) UIView *panelHeaderView;
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, assign) CHTagSelectorTransitionStyle transitionStyle;
@property (nonatomic, assign) id<CHTagSelectorDataSource>	datasource;
@property (nonatomic, assign) id<CHTagSelectorDelegate>		delegate;

- (NSArray *)selectedTags;
- (BOOL)allSelected;
- (BOOL)noneSelected;
- (void)presentInContainerView:(UIView *)view;

@end

@protocol CHTagSelectorDataSource <NSObject>

- (NSInteger)numberOfTagsInTagSelector:(CHTagSelectorView *)tagSelector;
- (NSString *)tagSelector:(CHTagSelectorView *)tagSelector tagForIndex:(NSInteger)index;

@optional

//useful if you want to change the look & feel of individual tags
- (void)tagSelector:(CHTagSelectorView *)tagSelector customizeTag:(CHTag *)tag atIndex:(NSInteger)index;

@end

@protocol CHTagSelectorDelegate <NSObject>

@optional

//called when a tag is tapped
- (void)tagSelector:(CHTagSelectorView *)tagSelector didToggleTag:(CHTag *)tag;

//called when the panel closes.  Passes an array of CHTag instances.
- (void)tagSelector:(CHTagSelectorView *)tagSelector didCloseWithTags:(NSArray *)tags;

@end


