//
//  Ufo.m
//  Wall
//
//  Created by Matej Jan on 15.11.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import "Ufo.h"

#import "Retronator.SF.h"

@implementation Ufo

- (id) init
{
	self = [super init];
	if (self != nil) {
		position = [[Vector2 alloc] init];
		width = 50;
		height = 24;
        power = 1;
        lifetime = [[Lifetime alloc] initWithStart:0 duration:[Constants getInstance].initialBall2Duration];

	}
	return self;
}

@synthesize position, width, height, lifetime, scene, power;

//- (BOOL) collidingWithItem:(id)item {
//    return YES;
//}

- (BOOL) collidingWithItem:(id)item {
    if ([item isKindOfClass:[Ball class]]) {
        [scene removeItem:self];
        [scene removeItem:item];
        power--;
        if (power==0) {            
            // Create power up randomly, but only if ball is not in breakthrough mode.
            if ([Random float] < [Constants getInstance].powerUpChance) {
                PowerUp *powerUp = [PowerUpFactory createRandomPowerUp];
                [powerUp.position set:position];
                powerUp.velocity.x = -[Constants getInstance].powerUpSpeed;
                [scene addItem:powerUp];
            }
        }
        return NO;
    }
    return YES;
}

- (void) addBall2WithSpeed:(float)speed {
    Ball2 *ball2 = [[[Ball2 alloc] init] autorelease];
    ball2.position.x = position.x -30;
    ball2.position.y = position.y;
    ball2.velocity.x = -speed;
    ball2.velocity.y = 0;
    [scene addItem:ball2];
}

- (void) updateWithGameTime:(GameTime *)gameTime {
    if (lifetime) {
        [lifetime updateWithGameTime:gameTime];
        if (!lifetime.isAlive) {
            [lifetime release];
            lifetime = nil;
            
            float speed = [Constants getInstance].initialBall2Speed; //+ 2 * [Constants getInstance].levelUpBallSpeedIncrease;
            //KAKO TO REŠIT DA KLIČEM KR FUNKCIJO IZ LEVEL ZA DODAJANJE
            //[self addBall2WithSpeed:speed];  //disabled streli metkov
            lifetime = [[Lifetime alloc] initWithStart:0 duration:[Constants getInstance].initialBall2Duration];
        }
    }
}

- (void) dealloc
{
    [scene release];
	[position release];
	[super dealloc];
}

@end
