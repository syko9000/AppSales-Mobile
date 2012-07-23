//
//  WebViewController.h
//  AppSales
//
//  Created by Kevin Bowes on 6/27/12.
//  Copyright (c) 2012 Home. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ASAccount;

@interface WebViewController : UIViewController <UIWebViewDelegate> {

}

@property (nonatomic, retain) UIWebView * webView;
@property (nonatomic, retain) ASAccount *account;

- (id)initWithAccount:(ASAccount *)account;

@end
