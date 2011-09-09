//
//  CHHTMLContentViewController.h
//  ChaiOneUI
//
//  Created by Ben Scheirman on 9/8/11.
//  Copyright 2011 ChaiONE. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
    CHHTMLContentViewController - A view controller that makes it easy to provide
    HTML content in your app.
 
    Can supply an HTML string or resource file name to load up the HTML.
 
    Can provide an optional backgroundView to be placed behind the web content.
 */

@interface CHHTMLContentViewController : UIViewController {
    
}

@property (nonatomic, retain) UIWebView *webView;
@property (nonatomic, retain) UIView *backgroundView;

- (void)setHTMLContent:(NSString *)html;
- (void)setHTMLResourceName:(NSString *)htmlResource;

@end
