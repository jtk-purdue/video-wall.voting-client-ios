//
//  ServerHandler.m
//  ServerClient
//
//  Created by Jaye on 5/22/11.
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
#import "ServerHandler.h"


@implementation ServerHandler

-(id)init{
	items = [[NSMutableArray alloc] init];

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
		printf("%s",[returnStr UTF8String]);
		int start = 0;
		int count = 0;
		for (int i = 0; i < [returnStr length]; i++) {
			char k =[returnStr characterAtIndex:i];
			count++;
			if(k=='\n'){
				NSRange range = {start, count};
				NSString* temp = [returnStr substringWithRange:range];
				if([temp isEqualToString:@"END\r"]) break;
				[items addObject:temp];
				start=i+1;
				count=0;
			}
			printf("count = %d\n",count);
			//Person* p = [myArray objectAtIndex: i];
			// Do something with p
		}
		
	}
	[cs release];
	[pool dealloc];
	return self;
}

-(void)print{
	for (int i = 0; i < [items count]; i++) {
		NSString* p = [items objectAtIndex: i];
		printf("%s",[p UTF8String]);
	}
	
}

-(NSMutableArray*)items{
	return items;
}


@end
