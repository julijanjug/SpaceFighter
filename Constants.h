//
//  Constants.h
//  Wall
//
//  Created by Matej Jan on 16.11.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Constants : NSObject {
}

@property (nonatomic, readonly) float minimumBallVerticalVelocity;
@property (nonatomic, readonly) float maximumBallAngle;

@property (nonatomic, readonly) int startLives;
@property (nonatomic, readonly) int startUfos;
@property (nonatomic, readonly) int multiballNumber;
@property (nonatomic, readonly) float initialBallSpeed, initialBall2Speed;
@property (nonatomic, readonly) float levelUpBallSpeedIncrease;
@property (nonatomic, readonly) float initialBallDuration, initialBall2Duration;
@property (nonatomic, readonly) float powerUpChance, powerUpSpeed;
@property (nonatomic, readonly) NSTimeInterval powerUpDuration;


+ (Constants*) getInstance;

@end
