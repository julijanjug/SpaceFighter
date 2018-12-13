//
//  spaceship.h
//  Wall
//
//  Created by Matej Jan on 15.11.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Express.Scene.Objects.h"
#import "Retronator.SF.classes.h"

@interface Spaceship : NSObject <IAARectangleCollider, ICustomCollider, ICustomUpdate, ILifetime, ISceneUser> {
	Vector2 *position;
	float width;
	float height;
    Lifetime *lifetime;
    id<IScene> scene;
    NSMutableArray *powerUps;
}

- (void) addBallWithSpeed:(float)speed;

- (void) addPowerUp:(PowerUp*)powerUp;
- (void) removeAllPowerUps;

@property (nonatomic) int multiballPowerUp;
@property (nonatomic) int shieldPowerUp;
@property (nonatomic) int hitsCount;


@end
