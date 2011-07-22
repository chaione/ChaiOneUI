//
//  UITableView+CHAdditions.h
//  ChaiOneUtils
//
//  Created by Ben Scheirman on 5/26/11.
//  Copyright 2011 ChaiONE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UITableView (CHAdditions)

- (void)reloadRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)reloadRowAtIndexPath:(NSIndexPath *)indexPath withRowAnimation:(UITableViewRowAnimation)animation;

@end
