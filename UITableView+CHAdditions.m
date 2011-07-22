//
//  UITableView+CHAdditions.m
//  ChaiOneUtils
//
//  Created by Ben Scheirman on 5/26/11.
//  Copyright 2011 ChaiONE. All rights reserved.
//

#import "UITableView+CHAdditions.h"


@implementation UITableView (CHAdditions)

- (void)reloadRowAtIndexPath:(NSIndexPath *)indexPath {
    [self reloadRowAtIndexPath:indexPath withRowAnimation:UITableViewRowAnimationNone];
}

- (void)reloadRowAtIndexPath:(NSIndexPath *)indexPath withRowAnimation:(UITableViewRowAnimation)animation {
    [self reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                withRowAnimation:animation];
}

@end
