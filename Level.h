//
//  Level.h
//  Wall
//
//  Created by Matej Jan on 15.11.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Express.Scene.h"

#import "Retronator.SF.classes.h"

@interface Level : GameComponent {
	SimpleScene *scene;
	
	Spaceship *spaceship;
    Ufo *ufo;
	int ballsCount;
	int ufosCount;
	
	Rectangle *bounds;
}

@property (nonatomic, readonly) id<IScene> scene;
@property (nonatomic, readonly) Spaceship *spaceship;
@property (nonatomic, readonly) int ballsCount, ufosCount;

@property (nonatomic, readonly) Rectangle *bounds;

- (void) addBallWithSpeed:(float)speed;
- (void) resetLevelWithBallSpeed:(float)speed;

@end
