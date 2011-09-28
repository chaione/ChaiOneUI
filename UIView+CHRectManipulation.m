//
//  Created by ben on 9/28/11.
//
//  To change this template use File | Settings | File Templates.
//


#import "UIView+CHRectManipulation.h"


@implementation UIView (CHRectManipulation)

- (void)setOrigin:(CGPoint)origin {
    CGRect rect = self.frame;
    rect.origin = origin;
    self.frame = rect;
}

- (void)setSize:(CGSize)size {
    CGRect rect = self.frame;
    rect.size = size;
    self.frame = rect;
}


@end