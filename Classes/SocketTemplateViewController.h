//
//  SocketTemplateViewController.h
//  SocketTemplate
//
//  Created by Jaye on 5/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SocketTemplateViewController : UIViewController {
	NSInputStream *iStream;
	NSOutputStream *oStream;
	UILabel* label;
	BOOL sent;
}

@property (nonatomic, retain) IBOutlet UILabel* label;

+ (void)getStreamsToHostNamed:(NSString *)hostName 
						 port:(NSInteger)port 
				  inputStream:(NSInputStream **)inputStreamPtr 
				 outputStream:(NSOutputStream **)outputStreamPtr;
- (IBAction) connectCommand: (id)sender;
- (IBAction)sendText:(id)sender;	
- (IBAction) disconnectCommand: (id) sender;
- (IBAction) update: (id) sender;

@end

