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
	UIView *panelView;
}

@property (nonatomic, assign) id<CHTagSelectorDataSource>	datasource;
@property (nonatomic, assign) id<CHTagSelectorDelegate>		delegate;

- (void)presentInContainerView:(UIView *)view;

@end

@protocol CHTagSelectorDataSource <NSObject>

- (NSInteger)numberOfTagsInTagSelector:(CHTagSelectorView *)tagSelector;
- (NSString *)tagSelector:(CHTagSelectorView *)tagSelector tagForIndex:(NSInteger)index;

@end

@protocol CHTagSelectorDelegate <NSObject>

@optional;

- (void)tagSelector:(CHTagSelectorView *)tagSelector didToggleTag:(CHTag *)tag;
- (void)tagSelector:(CHTagSelectorView *)tagSelector didCloseWithTags:(NSArray *)tags;
- (void)tagSelectorDidCancel:(CHTagSelectorView *)tagSelector;

@end


