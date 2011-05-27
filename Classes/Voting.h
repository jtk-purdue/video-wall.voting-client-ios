//
//  Voting.h
//  VideoWall
//
//  Created by Jaye on 3/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "ServerHandler.h"

@interface Voting : UITableViewController {
	ServerHandler* handler;
}

@property (nonatomic, retain) ServerHandler *handler;

@end
