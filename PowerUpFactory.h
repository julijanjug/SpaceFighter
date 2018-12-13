//
//  PowerUpFactory.h
//  SpaceFighter
//
//  Created by Julijan Jug on 24/11/2018.
//

#import <Foundation/Foundation.h>

#import "Retronator.SF.classes.h"

@interface PowerUpFactory : NSObject {
    
}

+ (PowerUp*) createPowerUp:(PowerUpType)type;

+ (PowerUp*) createRandomPowerUp;

@end

