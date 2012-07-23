//
//  WebViewController.m
//  AppSales
//
//  Created by Kevin Bowes on 6/27/12.
//  Copyright (c) 2012 Home. All rights reserved.
//

#import "WebViewController.h"
#import "ASAccount.h"

@implementation WebViewController 

@synthesize webView = _webView;
@synthesize account = _account;

- (id)initWithAccount:(ASAccount *)account {
    self = [super init];
    if (self) {
        _account = [account retain];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://iad.apple.com/itcportal/#app_homepage"]]];
    
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh:)] autorelease];
    
    self.title = @"iAd Network";
}

- (void)refresh:(id)sender {
    [_webView reload];
}

- (UIView*)view {
    return self.webView;
}

- (UIWebView*)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] init];
        _webView.delegate = self;
        _webView.scalesPageToFit = YES;
    }
    
    return _webView;
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSString * text = [_webView stringByEvaluatingJavaScriptFromString:@"document.forms['appleConnectForm'].name"];
    if ([text isEqualToString:@"appleConnectForm"]) {
        [_webView stringByEvaluatingJavaScriptFromString:
         [NSString stringWithFormat:@"document.getElementById('accountname').value='%@'", _account.username]
         ];
        [_webView stringByEvaluatingJavaScriptFromString:
         [NSString stringWithFormat:@"document.getElementById('accountpassword').value='%@'", _account.password]
         ];
        [_webView stringByEvaluatingJavaScriptFromString:@"document.forms['appleConnectForm'].submit()"];
    }
    self.title = [_webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}

@end
