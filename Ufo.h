//
//  Ufo.h
//  Wall
//
//  Created by Matej Jan on 15.11.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Express.Scene.Objects.h"

#import "Retronator.SF.classes.h"

@interface Ufo : NSObject <IAARectangleCollider, ICustomCollider, ISceneUser, ICustomUpdate, ILifetime> {
	Vector2 *position;
	float width;
	float height;
    Lifetime *lifetime; //zato da avtomatsko strelja metke
    id<IScene> scene;
    int power;

}

- (void) addBall2WithSpeed:(float)speed;

@property (nonatomic, readonly) BOOL destroyed;
@property (nonatomic) int power;


@end
