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

- (void)setOriginX:(CGFloat)x {
    [self setOrigin:CGPointMake(x, self.frame.origin.y)];
}

- (void)setOriginY:(CGFloat)y {
    [self setOrigin:CGPointMake(self.frame.origin.x, y)];
}

- (void)setSize:(CGSize)size {
    CGRect rect = self.frame;
    rect.size = size;
    self.frame = rect;
}

- (void)setSizeWidth:(CGFloat)w {
    [self setSize:CGSizeMake(w, self.frame.size.height)];    
}

- (void)setSizeHeight:(CGFloat)h {
    [self setSize:CGSizeMake(self.frame.size.width, h)];
}


- (void)translate:(CGPoint)offset {
    CGRect rect = self.frame;
    rect.origin.x += offset.x;
    rect.origin.y += offset.y;
    self.frame = rect;
}

- (void)translateX:(CGFloat)deltaX {
    [self translate:CGPointMake(deltaX, 0)];
}

- (void)translateY:(CGFloat)deltaY {
    [self translate:CGPointMake(0, deltaY)];
}


@end