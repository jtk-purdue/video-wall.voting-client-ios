//
//  FirstViewController.m
//  VideoWall
//
//  Created by Jaye on 3/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FirstViewController.h"
#include <ifaddrs.h> 
#include <arpa/inet.h>

@implementation FirstViewController

@synthesize TylerH_Button;


	
- (IBAction) doTylerH_Button {
		
 		/*
	UIAlertView *alert =
	[[UIAlertView alloc] initWithTitle: @"Some T"
							   message: @"life"
							  delegate: self
					 cancelButtonTitle: @"OK"
					 otherButtonTitles: nil];
		
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, 100, 100)];
	
    NSString *path = [[NSString alloc] initWithString:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"icon3.png"]];
    UIImage *bkgImg = [[UIImage alloc] initWithContentsOfFile:path];
    [imageView setImage:bkgImg];
    [bkgImg release];
    [path release];
	
    [alert addSubview:imageView];
    [imageView release];
	
	
	//UIImageView splashView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Default.png"]];
	
	//splashView.image = [UIImage imageNamed:@"Default.png"];

	//[alert addSubview:splashView];
    [alert show];
    [alert release];
	*/
	
	
}

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end
