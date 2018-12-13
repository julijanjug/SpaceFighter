//
//  spaceship.m
//  Wall
//
//  Created by Matej Jan on 15.11.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import "Spaceship.h"

#import "Retronator.SF.h"

@implementation Spaceship

- (id) init
{
	self = [super init];
	if (self != nil) {
		position = [[Vector2 alloc] init];
		width = 40;
		height = 40;
        powerUps = [[NSMutableArray alloc] init];
        lifetime = [[Lifetime alloc] initWithStart:0 duration:[Constants getInstance].initialBallDuration];
        hitsCount = 0;
	}
	return self;
}

@synthesize position, width, height, lifetime, scene, multiballPowerUp, hitsCount, shieldPowerUp;

- (void) addPowerUp:(PowerUp*)powerUp {
    [powerUps addObject:powerUp];
    [powerUp activateWithParent:self];
}

- (void) removeAllPowerUps {
    for (PowerUp *powerUp in powerUps) {
        [powerUp deactivate];
    }
    [powerUps removeAllObjects];
}

- (BOOL) collidingWithItem:(id)item {
    if ([item isKindOfClass:[Ball2 class]] && shieldPowerUp <= 0) {
        hitsCount++;
        [scene removeItem:item];
        [SoundEngine play:SoundEffectTypeHit];
        return NO;
    }if ([item isKindOfClass:[Ball2 class]] && shieldPowerUp > 0) {
        [scene removeItem:item];
        [SoundEngine play:SoundEffectTypeShieldHit];
        return NO;
    }else if([item isKindOfClass:[PowerUp class]]){
        // Pick up power-ups.
        [self addPowerUp:item];
        [scene removeItem:item];
        [SoundEngine play:SoundEffectTypePowerUp];
        return NO;
    }
    
    return YES;
}

- (void) collidedWithItem:(id)item {
	// Calculate horizontal velocity depending on where the spaceship was hit.
	Ball *ball = [item isKindOfClass:[Ball class]] ? item : nil;
    if (ball) {
        float minY = [Constants getInstance].minimumBallVerticalVelocity;
        if (fabsf(ball.velocity.y) < minY) {
            ball.velocity.y = ball.velocity.y < 0 ? -minY : minY;
        }
    }
}

- (void) updateWithGameTime:(GameTime *)gameTime {
    for (PowerUp *powerUp in powerUps) {
        [powerUp updateWithGameTime:gameTime];
    }
    //generiranje metkov
    if (lifetime) {
        [lifetime updateWithGameTime:gameTime];
        if (!lifetime.isAlive) {
            [lifetime release];
            lifetime = nil;
            
            float speed = [Constants getInstance].initialBallSpeed + 2 * [Constants getInstance].levelUpBallSpeedIncrease; //KAKO TO REŠIT DA KLIČEM KR FUNKCIJO IZ LEVEL ZA DODAJANJE
            [self addBallWithSpeed:speed];
            if(multiballPowerUp>0){ //če je uklopljen power up
                [self addBallWithYSpeed:100 speed:speed];
                [self addBallWithYSpeed:-100 speed:speed];
            }
            [SoundEngine play:SoundEffectTypeLaser];
            lifetime = [[Lifetime alloc] initWithStart:0 duration:[Constants getInstance].initialBallDuration];
        }
    }
}

- (void) addBallWithSpeed:(float)speed {
    Ball *ball = [[[Ball alloc] init] autorelease];
    ball.position.x = position.x +30;
    ball.position.y = position.y;
    ball.velocity.x = speed;
    ball.velocity.y = 0;
    [scene addItem:ball];
}

- (void) addBallWithYSpeed:(float)ySpeed speed:(float)speed {
    Ball *ball = [[[Ball alloc] init] autorelease];
    ball.position.x = position.x +30;
    ball.position.y = position.y;
    ball.velocity.x = speed;
    ball.velocity.y = ySpeed;
    [scene addItem:ball];
}

- (void) dealloc
{
    [powerUps release];
    [scene release];
    [lifetime release];
	[position release];
	[super dealloc];
}

@end
