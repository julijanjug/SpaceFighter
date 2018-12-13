//
//  Renderer.m
//  Wall
//
//  Created by Matej Jan on 15.11.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import "Renderer.h"

#import "Retronator.SF.h"

@implementation Renderer

- (id) initWithGame:(Game *)theGame gameplay:(Gameplay*)theGameplay {
	if (self = [super initWithGame:theGame]) {
		gameplay = theGameplay;
	}
	return self;
}

@synthesize camera;

- (void) initialize {
//    float scaleX = (float)self.game.gameWindow.clientBounds.width / (float)gameplay.level.bounds.width;
//    float scaleY = (float)self.game.gameWindow.clientBounds.height / (float)gameplay.level.bounds.height;
	camera = [[Matrix createScale:[Vector3 vectorWithX:1 y:1 z:1]] retain];

	[super initialize];
}

- (void) loadContent {
	spriteBatch = [[SpriteBatch alloc] initWithGraphicsDevice:self.graphicsDevice];
	SFTexture = [self.game.content load:@"vsebine"];
    background = [self.game.content load:@"background"];
    
	spaceshipSprite = [[Sprite alloc] init];
	spaceshipSprite.texture = SFTexture;
	spaceshipSprite.sourceRectangle = [Rectangle rectangleWithX:64 y:0 width:64 height:64];
	spaceshipSprite.origin = [Vector2 vectorWithX:32 y:32];

	lifeSprite = [[Sprite alloc] init];
	lifeSprite.texture = SFTexture;
	lifeSprite.sourceRectangle = [Rectangle rectangleWithX:64 y:320 width:64 height:64];
	
	ballSprite = [[Sprite alloc] init];
	ballSprite.texture = SFTexture;
	ballSprite.sourceRectangle = [Rectangle rectangleWithX:254 y:192 width:64 height:64];
	ballSprite.origin = [Vector2 vectorWithX:32 y:32];
    
    ball2Sprite = [[Sprite alloc] init];
    ball2Sprite.texture = SFTexture;
    ball2Sprite.sourceRectangle = [Rectangle rectangleWithX:128 y:64 width:64 height:64];
    ball2Sprite.origin = [Vector2 vectorWithX:32 y:32];
    
    shieldSprite = [[Sprite alloc] init];
    shieldSprite.texture = SFTexture;
    shieldSprite.sourceRectangle = [Rectangle rectangleWithX:256 y:0 width:64 height:64];
    shieldSprite.origin = [Vector2 vectorWithX:32 y:32];
    
    //PowerUp sprites
    for (int i = 0; i < PowerUpTypes; i++) {
        powerUpSprite[i] = [[Sprite alloc] init];
        powerUpSprite[i].texture = SFTexture;
        int x=0;
        int y=0;
        if(i==0){
            x=192;
            y=64;
        }else if(i==1){
            x=256;
            y=64;
        }else if(i==2){
            x=0;
            y=128;
        }else if(i==3){
            x=64;
            y=64;
        }
        powerUpSprite[i].sourceRectangle = [Rectangle rectangleWithX:x y:y width:64 height:64];
        powerUpSprite[i].origin = [Vector2 vectorWithX:32 y:32];
    }
    
    //Animation sprites
    ufoSpriteAnimation = [[AnimatedSprite alloc] initWithDuration:0.6];
    ufoSpriteAnimation.looping = NO;
    int j = 0;
    for (int i = 0; i < 29; i++) {
        if (i==14 || i==20 || i==26){
            int row = i % 6;
            int column = i / 6;
            Sprite *sprite = [[[Sprite alloc] init] autorelease];
            sprite.texture = SFTexture;
            sprite.sourceRectangle = [Rectangle rectangleWithX:column * 64 y:row * 64 width:64 height:64];
            sprite.origin = [Vector2 vectorWithX:32 y:32];
            
            AnimatedSpriteFrame *frame = [AnimatedSpriteFrame frameWithSprite:sprite start:ufoSpriteAnimation.duration * (float)j / 3];
            [ufoSpriteAnimation addFrame:frame];
            j++;
        }
    }
    ufoSpriteAnimation.looping=YES;
    
    flameSpriteAnimation = [[AnimatedSprite alloc] initWithDuration:0.5];
    flameSpriteAnimation.looping = NO;
    j = 0;
    for (int i = 0; i < 29; i++) {
        if (i==12 || i==18){
            int row = i % 6;
            int column = i / 6;
            Sprite *sprite = [[[Sprite alloc] init] autorelease];
            sprite.texture = SFTexture;
            sprite.sourceRectangle = [Rectangle rectangleWithX:column * 64 y:row * 64 width:64 height:64];
            sprite.origin = [Vector2 vectorWithX:32 y:32];
            
            AnimatedSpriteFrame *frame = [AnimatedSpriteFrame frameWithSprite:sprite start:flameSpriteAnimation.duration * (float)j / 2];
            [flameSpriteAnimation addFrame:frame];
            j++;
        }
    }
    flameSpriteAnimation.looping=YES;
}

- (void) drawWithGameTime:(GameTime *)gameTime {
	[self.graphicsDevice clearWithColor:[Color black]];
	
    [spriteBatch beginWithSortMode:SpriteSortModeDeffered BlendState:nil SamplerState:nil
                 DepthStencilState:nil RasterizerState:nil Effect:nil TransformMatrix:camera];
    //[spriteBatch beginWithSortMode:SpriteSortModeBackToFront BlendState:nil];

    
    //Draw background
    [spriteBatch draw:background to:[Vector2 vectorWithX:0 y:0] fromRectangle:nil tintWithColor:[Color white]
             rotation:0 origin:[Vector2 vectorWithX:0 y:0] scaleUniform:1 effects:SpriteEffectsNone layerDepth:1];

	// Draw scene.
	for (id item in gameplay.level.scene) {
		
		id <IPosition> itemWithPosition = [item conformsToProtocol:@protocol(IPosition)] ? item : nil;
		
		Sprite *sprite = nil;
		Color *color = nil;
        float scale = 1.0;
		
		if ([item isKindOfClass:[Ufo class]]) {
            sprite = [ufoSpriteAnimation spriteAtTime:gameTime.totalGameTime];
            color = [Color white];
            scale = 1.2;
		} else if ([item isKindOfClass:[Ball class]]) {
			sprite = ballSprite;
			color = [Color white];
        } else if ([item isKindOfClass:[Ball2 class]]) {
            sprite = ball2Sprite;
            color = [Color white];
		} else if ([item isKindOfClass:[Spaceship class]]) {
			sprite = spaceshipSprite;
			color = [Color white];
            scale = 1.2;
        } else if ([item isKindOfClass:[PowerUp class]]) {
            PowerUp *powerUp = (PowerUp*)item;
            sprite = powerUpSprite[powerUp.type];
            color = [Color white];
            scale = 2;
        }
		
		if (itemWithPosition && sprite && color) {
			[spriteBatch draw:sprite.texture to:itemWithPosition.position fromRectangle:sprite.sourceRectangle tintWithColor:color
					 rotation:0 origin:sprite.origin scaleUniform:scale effects:SpriteEffectsNone layerDepth:0];
            //izrisem se flame če je treba
            if([item isKindOfClass:[Spaceship class]]){
                Vector2 *lokacija = [Vector2 vectorWithX:itemWithPosition.position.x-26 y:itemWithPosition.position.y];
                Sprite *flameSprite = [flameSpriteAnimation spriteAtTime:gameTime.totalGameTime];
                [spriteBatch draw:flameSprite.texture to:lokacija fromRectangle:flameSprite.sourceRectangle tintWithColor:color
                         rotation:0 origin:flameSprite.origin scaleUniform:scale effects:SpriteEffectsNone layerDepth:0];
            }
            //izrišemo še shield če je treba
            if([item isKindOfClass:[Spaceship class]] ){
                Spaceship *spaceship = (Spaceship*)item;
                if(spaceship.shieldPowerUp > 0){
                    sprite = shieldSprite;
                    Vector2 *lokacija = [Vector2 vectorWithX:itemWithPosition.position.x+28 y:itemWithPosition.position.y];
                    [spriteBatch draw:sprite.texture to:lokacija fromRectangle:sprite.sourceRectangle tintWithColor:color
                             rotation:0 origin:sprite.origin scaleUniform:scale effects:SpriteEffectsNone layerDepth:0];
                }
                
            }
		}
	}
	
	// Draw life.
	for (int i = 0; i < gameplay.livesShow; i++) {
		[spriteBatch draw:lifeSprite.texture to:[Vector2 vectorWithX:gameplay.level.bounds.width - (i+1) * 15 y:-0]
            fromRectangle:lifeSprite.sourceRectangle tintWithColor:[Color green] rotation:0 origin:[Vector2 vectorWithX:30 y:20] scaleUniform:2 effects:SpriteEffectsNone layerDepth:0 ];
	}
	
	[spriteBatch end];
}

- (void) unloadContent {
	[spriteBatch release];
	[SFTexture release];
	[spaceshipSprite release];
	[ballSprite release];
	[ufoSpriteAnimation release];
    [ufoSpriteAnimation release];
	[lifeSprite release];
    for (int i = 0; i < PowerUpTypes; i++) {
        [powerUpSprite[i] release];
    }
}

- (void) dealloc
{
	[camera release];
	[super dealloc];
}


@end
