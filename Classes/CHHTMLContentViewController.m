//
//  CHHTMLContentViewController.m
//  ChaiOneUI
//
//  Created by Ben Scheirman on 9/8/11.
//  Copyright 2011 ChaiONE. All rights reserved.
//

#import "CHHTMLContentViewController.h"

@implementation CHHTMLContentViewController

@synthesize backgroundView, webView;

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.backgroundView) {
        [self.view addSubview:self.backgroundView];
    }
    
    self.webView = [[[UIWebView alloc] initWithFrame:self.view.bounds] autorelease];
    [self.view addSubview:self.webView];
}

- (void)setBackgroundView:(UIView *)bgView {
    if (backgroundView == bgView) {
        return; //nothing to do
    }
    
    if (backgroundView) {
        if (backgroundView.superview) {
            [backgroundView removeFromSuperview];
        }
        [backgroundView release];
    }
    
    backgroundView = [bgView retain];
    
    if (self.webView) {
        //view has already been loaded, just insert below
        [self.view insertSubview:backgroundView belowSubview:self.webView];
    } else {
        //view will be added in the right order later
    }
}

- (void)setHTMLContent:(NSString *)html {
    [self.webView loadHTMLString:html baseURL:[NSURL URLWithString:@"http://local"]];
}

- (void)setHTMLResourceName:(NSString *)htmlResourceName {
    NSString *resourcePath = [[NSBundle mainBundle] pathForResource:htmlResourceName ofType:@"html"];
    NSData *htmlData = [NSData dataWithContentsOfFile:resourcePath];
    NSString *content = [[[NSString alloc] initWithData:htmlData encoding:NSUTF8StringEncoding] autorelease];
    [self setHTMLContent:content];
}

@end
