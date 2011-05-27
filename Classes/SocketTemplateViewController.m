//
//  SocketTemplateViewController.m
//  SocketTemplate
//
//  Created by Jaye on 5/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <Foundation/NSFileHandle.h>
#import <Foundation/NSAutoreleasePool.h>
#import <Foundation/NSString.h>
#import <Foundation/NSData.h>
#import <Foundation/NSArray.h>
#import "Cst420Socket.h"

#import <stdio.h>
#include <string.h>
#include <stdlib.h>

#define HOST "pc2.cs.purdue.edu"
#define PORT "4242"
#define MAXDATASIZE 4096
#import "SocketTemplateViewController.h"

@implementation SocketTemplateViewController
@synthesize label;

+ (void)getStreamsToHostNamed:(NSString *)hostName 
						 port:(NSInteger)port 
				  inputStream:(NSInputStream **)inputStreamPtr 
				 outputStream:(NSOutputStream **)outputStreamPtr
{
    CFReadStreamRef     readStream;
    CFWriteStreamRef    writeStream;
	
    assert(hostName != nil);
    assert( (port > 0) && (port < 65536) );
    assert( (inputStreamPtr != NULL) || (outputStreamPtr != NULL) );
	
    readStream = NULL;
    writeStream = NULL;
	
    CFStreamCreatePairWithSocketToHost(
									   NULL, 
									   (CFStringRef) hostName, 
									   port, 
									   ((inputStreamPtr  != nil) ? &readStream : NULL),
									   ((outputStreamPtr != nil) ? &writeStream : NULL)
									   );
	
    if (inputStreamPtr != NULL) {
        *inputStreamPtr  = [NSMakeCollectable(readStream) autorelease];
    }
    if (outputStreamPtr != NULL) {
        *outputStreamPtr = [NSMakeCollectable(writeStream) autorelease];
    }
}

-(void) connect {
	sent = NO;
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	NSString *address = [defaults stringForKey:@"Address"];
	if(!address) address = @"pc2.cs.purdue.edu";
	
    [SocketTemplateViewController getStreamsToHostNamed: address port:4242 
						inputStream:&iStream 
					   outputStream:&oStream];
    [iStream retain];
    [oStream retain];
    [iStream setDelegate:self];
    [oStream setDelegate:self];
    [iStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [oStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [iStream open];
    [oStream open];
	NSLog(@"connected");
}

-(void) disconnect {
    [iStream close];
    [oStream close];
    [iStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [oStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [iStream setDelegate:nil];
    [oStream setDelegate:nil];
    [iStream release];
    [oStream release];
    iStream = nil;
    oStream = nil;
	NSLog(@"disconnect");

}

- (IBAction)connectCommand:(id)sender {
	if( iStream != nil) return;
	[self connect];
}

- (IBAction) disconnectCommand: (id) sender {
	if(iStream == nil) return;
	[self disconnect];
}

- (IBAction)sendText:(id)sender {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    char * buf = malloc(MAXDATASIZE);
    NSString* endText = @"END";
    NSString* portNum = @PORT;
    NSString* hostName = @HOST;
	
	Cst420ClientSocket* cs = [[Cst420ClientSocket alloc] initWithHost: hostName
                                                           portNumber: portNum];
    [cs retain];
    if([cs connect]){
		NSString* inputString;
		NSString* returnStr = @"start";
		printf("Connected to the server. Enter string to send or end to exit\n");
		NSString* get = @"GET\r\n";
		NSString* end = @"END\r\n";
		[cs sendBytes:[get UTF8String] OfLength:[get length]
				Index:0];
		[cs sendBytes:[end UTF8String] OfLength:[end length]
				Index:0];
		returnStr = [cs receiveBytes: buf maxBytes:MAXDATASIZE beginAt:0];
		returnStr = [cs receiveBytes: buf maxBytes:MAXDATASIZE beginAt:0];
		label.text=returnStr;
	}
		[cs release];
		[pool release];		
}

- (void)stream:(NSStream *)theStream handleEvent:(NSStreamEvent)streamEvent
{
	NSString *io;
	if (theStream == iStream) io = @">>";
	else io = @"<<";
	
	NSString *event;
	switch (streamEvent)
	{
		case NSStreamEventHasBytesAvailable:
			event = @"NSStreamEventHasBytesAvailable";
			if (theStream == iStream) {		//read data
				uint8_t buffer[1024];
				int len;
				while ([iStream hasBytesAvailable]) {
					len = [iStream read:buffer maxLength:sizeof(buffer)];
					if (len > 0) {
						NSString *input = [[NSString alloc] initWithBytes:buffer 
																   length:len 
																 encoding:NSASCIIStringEncoding];
						//NSLog(@"%@",input);
						label.text = input;
						if (nil != input){ 		//do something with data
							NSLog(@"%@",input);
							label.text=input;
						}
					}
				}
			}
			break;
     	case NSStreamEventNone:
			event = @"NSStreamEventNone - Can not connect to the host!";
			break;
		case NSStreamEventOpenCompleted:
			event = @"NSStreamEventOpenCompleted";
			break;
		case NSStreamEventHasSpaceAvailable:
			event = @"NSStreamEventHasSpaceAvailable";
			break;
		case NSStreamEventErrorOccurred:
			event = @"NSStreamEventErrorOccurred";
			break;
		case NSStreamEventEndEncountered:
			event = @"NSStreamEventEndEncountered";
			[self disconnect];
			break;
		default:
			event = @"** Unknown";
	}	
	NSLog(@"%@ : %@", io, event);
}

-(void) viewDidLoad {
	iStream = nil;
	oStream=nil;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)dealloc {
    [super dealloc];
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

- (IBAction) update: (id) sender{
	label.text = @"we have connected";
}


@end
