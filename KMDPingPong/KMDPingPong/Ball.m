//
//  Ball.m
//  KMDPingPong
//
//  Created by admin on 21.11.17.
//  Copyright © 2017 admin. All rights reserved.
//

#import "Ball.h"

//@interface Ball ()
//
//@end

//static const NSInteger maxBallSpeed = 5;

@implementation Ball

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.layer.cornerRadius = CGRectGetHeight(frame)/2;
    }
    return self;
}

@end
