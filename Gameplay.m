//
//  Gameplay.m
//  Wall
//
//  Created by Matej Jan on 15.11.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import "Gameplay.h"

#import "Retronator.SF.h"

@implementation Gameplay

- (id) initWithGame:(Game *)theGame aiClass:(Class)aiClass
{
	self = [super initWithGame:theGame];
	if (self != nil) {
		level = [[Level alloc] initWithGame:self.game];
		
		player = [[Player alloc] initWithGame:self.game Spaceship:level.spaceship];
        aiPlayer = [[aiClass alloc] initWithGame:self.game ufo:level.ufo level:level];
		physics = [[Physics alloc] initWithGame:self.game level:level];
		renderer = [[Renderer alloc] initWithGame:self.game gameplay:self];
		debugRenderer = [[DebugRenderer alloc] initWithGame:self.game scene:level.scene];
        

		player.updateOrder = 0;		// First the game should process input.		
		physics.updateOrder = 1;	// Then the physics engine updates the world.
		level.updateOrder = 2;		// Level updates the scene.
		self.updateOrder = 3;		// At last gameplay rules are executed.
		
		[self.game.components addComponent:level];
		[self.game.components addComponent:player];
		[self.game.components addComponent:physics];
		[self.game.components addComponent:renderer];
		
		//[self.game.components addComponent:debugRenderer];
	}
	return self;
}

@synthesize level, lives, livesShow;

- (void) initialize {
	debugRenderer.colliderColor = [Color black];
	debugRenderer.movementColor = [Color blue];
	debugRenderer.itemColor = [Color red];
	debugRenderer.transformMatrix = renderer.camera;
	
	[player setCamera:renderer.camera];
	
	[self reset];

	[super initialize];
}

- (void) updateWithGameTime:(GameTime *)gameTime {
    int manualUfoCount = 0;
    for(id item in level.scene){
        if([item isKindOfClass:[Ufo class]]) {
            manualUfoCount ++;
        }
    }
    
	// Check life lose condition.
        // Check game lost condition.
    livesShow = lives-level.spaceship.hitsCount/2;
    
    if(livesShow <= 0){
        [level resetSpaceship];
        [level resetLevelWithBallSpeed:[self calculateCrrentBallSpeed]];
    }

	// Check level won condition
	if (manualUfoCount == 0) {
		difficultyLevel++;
		//lives++;
		[level resetLevelWithBallSpeed:[self calculateCrrentBallSpeed]];
	}
}

- (void) reset {
	lives = [Constants getInstance].startLives;
    livesShow = lives;
	difficultyLevel = 0;
	[level resetLevelWithBallSpeed:[self calculateCrrentBallSpeed]];
}

- (float) calculateCrrentBallSpeed {
	return [Constants getInstance].initialBallSpeed + difficultyLevel * [Constants getInstance].levelUpBallSpeedIncrease;
}


- (void) dealloc
{
	[self.game.components removeComponent:level];
	[self.game.components removeComponent:player];
	[self.game.components removeComponent:physics];
	[self.game.components removeComponent:renderer];
	[self.game.components removeComponent:debugRenderer];

	[level release];
	[player release];
	[physics release];
	[renderer release];
	[debugRenderer release];
	[super dealloc];
}


@end
