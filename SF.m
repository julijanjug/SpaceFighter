//
//  Wall.m
//  Wall
//
//  Created by Matej Jan on 15.11.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import "SF.h"

#import "Retronator.SF.h"

@implementation SF

- (id) init
{
	self = [super init];
	if (self != nil) {
		graphics = [[GraphicsDeviceManager alloc] initWithGame:self];
				
		[self.components addComponent:[[[Gameplay alloc] initWithGame:self] autorelease]];
		[self.components addComponent:[[[FpsComponent alloc] initWithGame:self] autorelease]];
        
        [SoundEngine initializeWithGame:self];

	}
	return self;
}



- (void) dealloc
{
	[graphics release];
	[super dealloc];
}


@end
