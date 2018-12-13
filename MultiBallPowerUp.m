//
//  MultiBallPowerUp.m
//  SpaceFighter
//
//  Created by Julijan Jug on 24/11/2018.
//

#import "MultiBallPowerUp.h"

#import "Express.Scene.h"
#import "Retronator.SF.h"

@implementation MultiBallPowerUp

- (id) init
{
    self = [super initWithType:PowerUpTypeMultiBall duration:[Constants getInstance].powerUpDuration];
    if (self != nil) {
        
    }
    return self;
}

- (void) activateWithParent:(Spaceship *)theParent {
    [super activateWithParent:theParent];
    
    for (id item in scene) {
        if ([item isKindOfClass:[Spaceship class]]) {
            Spaceship *spaceship = (Spaceship*)item;
            spaceship.multiballPowerUp++;
        }
    }
    savedScene = [scene retain];
}

- (void) deactivate {
    [super deactivate];
    
    for (id item in savedScene) {
        if ([item isKindOfClass:[Spaceship class]]) {
            Spaceship *spaceship = (Spaceship*)item;
            spaceship.multiballPowerUp--;
        }
    }
    [savedScene release];
}

@end
