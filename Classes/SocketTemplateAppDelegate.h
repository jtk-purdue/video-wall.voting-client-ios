//
//  SocketTemplateAppDelegate.h
//  SocketTemplate
//
//  Created by Jaye on 5/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SocketTemplateViewController;

@interface SocketTemplateAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    SocketTemplateViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet SocketTemplateViewController *viewController;

@end

