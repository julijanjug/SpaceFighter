//
//  Level.m
//  Wall
//
//  Created by Matej Jan on 15.11.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import "Level.h"

#import "Retronator.SF.h"


@implementation Level

- (id) initWithGame:(Game *)theGame
{
	self = [super initWithGame:theGame];
	if (self != nil) {
		scene = [[SimpleScene alloc] initWithGame:self.game];
        scene.updateOrder = 3;
		[self.game.components addComponent:scene];
        
        [scene.itemAdded subscribeDelegate:[Delegate delegateWithTarget:self Method:@selector(itemAddedToScene:eventArgs:)]];
        [scene.itemRemoved subscribeDelegate:[Delegate delegateWithTarget:self Method:@selector(itemRemovedFromScene:eventArgs:)]];
		
		spaceship = [[Spaceship alloc] init];
        ufo = [[Ufo alloc] init];
	}
	return self;
}

@synthesize scene, spaceship, bounds, ufosCount, ballsCount;

- (void) initialize {
	//float aspectRatio = (float)self.game.gameWindow.clientBounds.width / (float)self.game.gameWindow.clientBounds.height;
    int width = self.game.gameWindow.clientBounds.width;
    int height = self.game.gameWindow.clientBounds.height;
	bounds = [[Rectangle alloc] initWithX:0 y:0 width:width height:height];
	spaceship.position.y = bounds.height / 2;
	spaceship.position.x = 100;
}

- (void) resetLevelWithBallSpeed:(float)speed {
	// Remove everything from the scene.
	[scene clear];
	ufosCount = 0;
    ballsCount = 0;
	
	// Add ball and spaceship.
	[scene addItem:spaceship];
	
	// Add level limits.
    [scene addItem:[[[LevelLimit alloc] initWithLimit:
                     [AAHalfPlane aaHalfPlaneWithDirection:AxisDirectionPositiveX distance:bounds.x] isDeadly:YES] autorelease]];
    [scene addItem:[[[LevelLimit alloc] initWithLimit:
                     [AAHalfPlane aaHalfPlaneWithDirection:AxisDirectionNegativeX distance:-bounds.width-50] isDeadly:YES] autorelease]];
    [scene addItem:[[[LevelLimit alloc] initWithLimit:
                     [AAHalfPlane aaHalfPlaneWithDirection:AxisDirectionPositiveY distance:bounds.y] isDeadly:NO] autorelease]];
    [scene addItem:[[[LevelLimit alloc] initWithLimit:
                     [AAHalfPlane aaHalfPlaneWithDirection:AxisDirectionNegativeY distance:-bounds.height] isDeadly:NO] autorelease]];
    
	// Add ufos.
	for (int i = 0; i < [Constants getInstance].startUfos; i++) {
        Ufo *ufo = [[[Ufo alloc] init] autorelease];
        ufo.position.x = 800;
        ufo.position.y = 150 + i * 120;
        [scene addItem:ufo];
	}
    //add delefate for spaceship hits
    }


- (void) addBallWithSpeed:(float)speed {
    Ball *ball = [[[Ball alloc] init] autorelease];
    ball.position.x = spaceship.position.x +30;//bounds.width / 2;
    ball.position.y = spaceship.position.y;//bounds.height / 2;
    ball.velocity.x = speed;
    ball.velocity.y = 0;
    [scene addItem:ball];
}



- (void) resetSpaceship {
    spaceship.hitsCount = 0;
//    [spaceship removeAllPowerUps];
//    spaceship.magnetPower = 1;
//    spaceship.width = [Constants getInstance].initialSpaceshipHeight;
}

- (void) itemAddedToScene:(id)sender eventArgs:(SceneEventArgs*)e {
    if ([e.item isKindOfClass:[Ufo class]]) {
        ufosCount++;
    } else if ([e.item isKindOfClass:[Ball class]]) {
        ballsCount++;
    }
}

- (void) itemRemovedFromScene:(id)sender eventArgs:(SceneEventArgs*)e {
    if ([e.item isKindOfClass:[Ufo class]]) {
        ufosCount--;
    } else if ([e.item isKindOfClass:[Ball class]]) {
        ballsCount--;
    }
}

- (void) updateWithGameTime:(GameTime *)gameTime {
    // Update all items with custom update.
    for (id item in scene) {
        id<ICustomUpdate> updatable = [item conformsToProtocol:@protocol(ICustomUpdate)] ? item : nil;
        
        if (updatable) {
            [updatable updateWithGameTime:gameTime];
        }
    }
}

- (void) dealloc
{
	[spaceship release];
	[scene release];
	[bounds release];
	[super dealloc];
}


@end
