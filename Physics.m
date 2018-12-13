//
//  Physics.m
//  Wall
//
//  Created by Matej Jan on 15.11.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import "Physics.h"

#import "Express.Physics.h"

#import "Retronator.SF.h"

@implementation Physics

- (id) initWithGame:(Game *)theGame level:(Level *)theLevel {
	if (self = [super initWithGame:theGame]) {
		level = theLevel;
	}
	return self;
}

- (void) updateWithGameTime:(GameTime *)gameTime {
    // Movement
    for (id item in level.scene) {
        [MovementPhysics simulateMovementOn:item withElapsed:gameTime.elapsedGameTime];
    }
    
    for (id item1 in level.scene) {
        // Only balls and paddles should check Collisions.
        if ([item1 isKindOfClass:[Ball class]] || [item1 isKindOfClass:[Spaceship class]] || [item1 isKindOfClass:[Ball2 class]]) {
            for (id item2 in level.scene) {
                if (item1 != item2) {
                    [Collision collisionBetween:item1 and:item2];
                }
            }
        }
    }
}

@end
