//
//  Created by ben on 9/28/11.
//
//  To change this template use File | Settings | File Templates.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface UIView (CHRectManipulation)

- (void)setOrigin:(CGPoint)origin;
- (void)setOriginX:(CGFloat)x;
- (void)setOriginY:(CGFloat)y;
- (void)setSize:(CGSize)size;
- (void)setSizeWidth:(CGFloat)w;
- (void)setSizeHeight:(CGFloat)h;

- (void)translate:(CGPoint)offset;
- (void)translateX:(CGFloat)deltaX;
- (void)translateY:(CGFloat)deltaY;

@end