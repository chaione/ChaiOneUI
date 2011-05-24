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

@interface CHTagSelectorView : UIView <UIGestureRecognizerDelegate> {
	NSMutableArray *tags;
}

@property (nonatomic, retain) UIView *panelView;
@property (nonatomic, retain) UIView *panelHeaderView;
@property (nonatomic, retain) UILabel *titleLabel;

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

- (void)customizeTag:(CHTag *)tag atIndex:(NSInteger)index;

@end

@protocol CHTagSelectorDelegate <NSObject>

@optional

- (void)tagSelector:(CHTagSelectorView *)tagSelector didToggleTag:(CHTag *)tag;
- (void)tagSelector:(CHTagSelectorView *)tagSelector didCloseWithTags:(NSArray *)tags;

@end


