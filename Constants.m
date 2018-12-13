//
//  Constants.m
//  Wall
//
//  Created by Matej Jan on 16.11.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import "Constants.h"

@implementation Constants

static Constants *instance;

+ (void) initialize {
	instance = [[Constants alloc] init];
}

+ (Constants *) getInstance {
	return instance;
}

- (float) minimumBallVerticalVelocity {
	return 100;
}

- (float) maximumBallAngle {
	return M_PI / 2;
}

- (int) startLives {
	return 3;
}

- (int) startUfos {
    return 4;
}

- (float) initialBallSpeed {
	return 400;
}

- (float) initialBall2Speed {
    return 200;
}

- (float) levelUpBallSpeedIncrease {
	return 100;
}

- (float) initialSpaceshipHeight {
    return 100;
}

- (float) initialBallDuration {
    return 0.8;
}

- (float) initialBall2Duration {
    return 2;
}

- (float) powerUpChance {
    return 1.0f; //0.5f
}

- (float) powerUpSpeed {
    return 100;
}

- (int) multiballNumber {
    return 3;
}

- (NSTimeInterval) powerUpDuration {
    return 5;
}

@end
