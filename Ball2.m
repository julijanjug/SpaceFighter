//
//  Ball2.m
//  SpaceFighter
//
//  Created by Julijan Jug on 24/11/2018.
//

#import "Ball2.h"

#import "Retronator.SF.h"

@implementation Ball2

- (id) init
{
    self = [super init];
    if (self != nil) {
        position = [[Vector2 alloc] init];
        velocity = [[Vector2 alloc] init];
        radius = 8;
        mass = 1;
    }
    return self;
}

- (BOOL) collidingWithItem:(id)item {
    // Don't collide with balls.
    if ([item isKindOfClass:[Ball class]] || [item isKindOfClass:[Ball2 class]]) {
        return NO;
    }
    // Don't Collide with bricks when the ball has breakthrough power.
    if ([item isKindOfClass:[Spaceship class]] || [item isKindOfClass:[Ufo class]]) {
        return NO;
    }
    
    return YES;
}

- (void) collidedWithItem:(id)item {
    // Make sure the vertical velocity is big enough after collision,
    // so we don't have to endlesly wait for the ball to come down.
    float minY = [Constants getInstance].minimumBallVerticalVelocity;
    if (fabsf(velocity.y) < minY) {
        float speed = [velocity length];
        float x = sqrtf(speed * speed - minY * minY);
        velocity.y = velocity.y < 0 ? -minY : minY;
        velocity.x = velocity.x < 0 ? -x : x;
    }
}

@synthesize position, velocity, mass, radius;

- (void) dealloc
{
    [velocity release];
    [position release];
    [super dealloc];
}

@end
