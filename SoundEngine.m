//
//  SoundEngine.m
//  SpaceFighter
//
//  Created by Julijan Jug on 29/11/2018.
//

#import "SoundEngine.h"

#import "Retronator.Xni.Framework.Content.h"

SoundEngine *instance;

@implementation SoundEngine

+ (void) initializeWithGame:(Game*)game {
    instance = [[SoundEngine alloc] initWithGame:game];
    [game.components addComponent:instance];
}

- (void) initialize {
    soundEffects[SoundEffectTypeLaser] = [self.game.content load:@"laser" ];
    soundEffects[SoundEffectTypeHit] = [self.game.content load:@"hit"];
    soundEffects[SoundEffectTypePowerUp] = [self.game.content load:@"power-up"];
    soundEffects[SoundEffectTypeShieldDown] = [self.game.content load:@"shield-down"];
    soundEffects[SoundEffectTypeShieldHit] = [self.game.content load:@"shield-hit"];
    
}

- (void) play:(SoundEffectType)type {
    [soundEffects[type] play];
    
}

+ (void) play:(SoundEffectType)type {
    [instance play:type];
}

- (void) dealloc
{
    for (int i = 0; i < SoundEffectTypes; i++) {
        [soundEffects[i] release];
    }
    [super dealloc];
}


@end
