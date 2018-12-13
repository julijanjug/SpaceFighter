//
//  Renderer.h
//  Wall
//
//  Created by Matej Jan on 15.11.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Retronator.Xni.Framework.Graphics.h"
#import "Retronator.Xni.Framework.Content.h"
#import "Express.Graphics.h"

#import "Retronator.SF.classes.h"

@interface Renderer : DrawableGameComponent {
	SpriteBatch *spriteBatch;
	Texture2D *SFTexture;
	
	Sprite *ballSprite, *ball2Sprite, *spaceshipSprite, *lifeSprite, *shieldSprite;
    Texture2D *background;
    AnimatedSprite *ufoSpriteAnimation;
    AnimatedSprite *flameSpriteAnimation;
    Sprite *powerUpSprite[PowerUpTypes];


		
	Gameplay *gameplay;
	Matrix *camera;
}

- (id) initWithGame:(Game*)theGame gameplay:(Gameplay*)theGameplay;

@property (nonatomic, readonly) Matrix *camera;

@end
