//
//  PowerUp.m
//  SpaceFighter
//
//  Created by Julijan Jug on 24/11/2018.
//

#import "PowerUp.h"

#import "Retronator.SF.h"

@implementation PowerUp

- (id) initWithType:(PowerUpType)theType {
    return [self initWithType:theType duration:0];
}

- (id) initWithType:(PowerUpType)theType duration:(NSTimeInterval)theDuration;
{
    self = [super init];
    if (self != nil) {
        position = [[Vector2 alloc] init];
        velocity = [[Vector2 alloc] init];
        width = 30;
        height = 30;
        type = theType;
        duration = theDuration;
    }
    return self;
}

@synthesize position, velocity, width, height, type, lifetime, scene;

- (BOOL) collidingWithItem:(id)item {
    return [item isKindOfClass:[Spaceship class]];
}

- (void) activateWithParent:(Spaceship *)theParent {
    active = YES;
    parent = [theParent retain];
    if (duration) {
        lifetime = [[Lifetime alloc] initWithStart:0 duration:duration];
    }
}

- (void) deactivate {
    active = NO;
}

- (void) updateWithGameTime:(GameTime *)gameTime {
    if (lifetime) {
        [lifetime updateWithGameTime:gameTime];
        if (!lifetime.isAlive) {
            [lifetime release];
            lifetime = nil;
            [self deactivate];
        }
    }
}

- (void) dealloc
{
    [scene release];
    [lifetime release];
    [parent release];
    [position release];
    [velocity release];
    [super dealloc];
}

@end

