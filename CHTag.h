//
//  CHTag.h
//  ChaiOneUI
//
//  Created by Ben Scheirman on 5/20/11.
//  Copyright 2011 ChaiONE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CHTag : UILabel {

}

@property (nonatomic, assign) BOOL selected;
@property (nonatomic, retain) UIColor *highlightColor;

- (void)toggle;

@end
