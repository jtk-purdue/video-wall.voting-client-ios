//
//  FirstViewController.h
//  VideoWall
//
//  Created by Jaye on 3/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FirstViewController : UIViewController {
	UIButton *TylerH_Button;
}

@property (nonatomic, retain) IBOutlet UIButton *TylerH_Button;


- (IBAction)doTylerH_Button;
- (NSString *)getIPAddress;

@end
