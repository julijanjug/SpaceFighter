//
//  Player.h
//  Wall
//
//  Created by Matej Jan on 15.11.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Retronator.Xni.Framework.Input.Touch.h"

#import "Retronator.SF.classes.h"

@interface Player : GameComponent {
	Spaceship *spaceship;
	Matrix *inverseView;
    Rectangle *inputArea;
    BOOL grabbed;
    Vector2 *touchOffset;
}

- (id) initWithGame:(Game*)theGame Spaceship:(Spaceship*)theSpaceship;

- (void) setCamera:(Matrix *)camera;

- (void) updateWithGameTime:(GameTime*)gameTime;

@end
