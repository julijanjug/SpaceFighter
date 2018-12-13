//
//  SoundEngine.h
//  SpaceFighter
//
//  Created by Julijan Jug on 29/11/2018.
//

#import <Foundation/Foundation.h>

#import "Retronator.Xni.Framework.Audio.h"
#import "Retronator.SF.classes.h"

@interface SoundEngine : GameComponent {
    SoundEffect *soundEffects[SoundEffectTypes];
}

+ (void) initializeWithGame:(Game*)game;
+ (void) play:(SoundEffectType)type;

@end
