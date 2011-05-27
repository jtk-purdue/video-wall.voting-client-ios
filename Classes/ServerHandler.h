//
//  ServerHandler.h
//  ServerClient
//
//  Created by Jaye on 5/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ServerHandler : NSObject {
	NSMutableArray* items;
}

-(id)init;
-(void)print;
-(NSMutableArray*)items;

@end
