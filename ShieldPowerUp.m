//
//  ShieldPowerUp.m
//  SpaceFighter
//
//  Created by Julijan Jug on 24/11/2018.
//
#import "ShieldPowerUp.h"

#import "Express.Scene.h"
#import "Retronator.SF.h"

@implementation ShieldPowerUp

- (id) init
{
    self = [super initWithType:PowerUpTypeShield duration:[Constants getInstance].powerUpDuration];
    if (self != nil) {
        
    }
    return self;
}

- (void) activateWithParent:(Spaceship *)theParent {
    [super activateWithParent:theParent];
    
    // Add shield
    for (id item in scene) {
        if ([item isKindOfClass:[Spaceship class]]) {
            Spaceship *spaceship = (Spaceship*)item;
            spaceship.shieldPowerUp++;
        }
    }
    savedScene = [scene retain];
}

- (void) deactivate {
    [super deactivate];
    
    for (id item in savedScene) {
        if ([item isKindOfClass:[Spaceship class]]) {
            Spaceship *spaceship = (Spaceship*)item;
            spaceship.shieldPowerUp--;
            if(spaceship.shieldPowerUp==0){
                [SoundEngine play:SoundEffectTypeShieldDown];
            }
        }
    }
    [savedScene release];
}

@end
