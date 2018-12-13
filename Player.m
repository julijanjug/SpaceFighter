//
//  Player.m
//  Wall
//
//  Created by Matej Jan on 15.11.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import "Player.h"
#import "Retronator.Xni.Framework.Input.Touch.h"

#import "Retronator.SF.h"

@implementation Player

- (id) initWithGame:(Game*)theGame Spaceship:(Spaceship *)theSpaceship
{
	self = [super initWithGame:theGame];
	if (self != nil) {
		spaceship = theSpaceship;
        inputArea = [[Rectangle alloc] initWithRectangle:self.game.gameWindow.clientBounds];
        inputArea.width = self.game.gameWindow.clientBounds.height - 130;
        inputArea.y=50;
        inputArea.x=30;
        inputArea.height= self.game.gameWindow.clientBounds.width-100;
        touchOffset = [[Vector2 alloc] initWithX:60 y:0];
	}
	return self;
}

- (void) setCamera:(Matrix *)camera {
	[inverseView release];
	inverseView = [[Matrix invert:camera] retain];
}

- (void) updateWithGameTime:(GameTime *)gameTime {
    TouchCollection *touches = [[TouchPanel getInstance] getState];
    
    BOOL touchesInInputArea = NO;
    for (TouchLocation *touch in touches) {
        if ([inputArea containsVector:touch.position]) {
            touchesInInputArea = YES;
            if (!grabbed) {
                float distanceToSpaceship = [[[Vector2 subtract:touch.position by:spaceship.position] add:touchOffset] length];
                if (distanceToSpaceship < 100) {
                    grabbed = YES;
                }
            }
            if (grabbed) {
                [[spaceship.position set:touch.position] add:touchOffset];
            }
        }
    }
    if (!touchesInInputArea) {
        grabbed = NO;
    }
}

- (void) dealloc
{
	[inverseView release];
	[super dealloc];
}


@end
