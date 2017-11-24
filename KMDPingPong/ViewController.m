//
//  ViewController.m
//  KMDPingPong
//
//  Created by admin on 21.11.17.
//  Copyright © 2017 admin. All rights reserved.
//

#import "ViewController.h"
#import "Ball.h"

@interface ViewController ()

@property (nonatomic, strong) Ball *pingpongBall;
@property (nonatomic, weak) NSTimer *timer;
@property (nonatomic, strong) UIView *gamerCompupter;
@property (nonatomic, strong) UIView *gamerUser;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.pingpongBall = [[Ball alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
    self.pingpongBall.backgroundColor = [UIColor redColor];
    self.pingpongBall.speedHorisontal = 5;
    self.pingpongBall.speedVertical = 1;
    [self.view addSubview:self.pingpongBall];
    
    self.gamerCompupter = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 150, 10)];
    self.gamerCompupter.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.gamerCompupter];
    
    self.gamerUser = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.view.frame)-10, 150, 10)];
    self.gamerUser.backgroundColor = [UIColor magentaColor];
    [self.view addSubview:self.gamerUser];
    
    [self startTimer];
}

- (void)startTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(ballAnimation) userInfo:nil repeats:YES];
    self.timer.tolerance = 0.1;
    [self.timer fire];
}

-(void)ballAnimation
{
//    if ((self.pingpongBall.frame.origin.x <= 0) || (CGRectGetMaxX(self.pingpongBall.frame) >= CGRectGetWidth(self.view.frame)))
//    {
//        self.pingpongBall.speedHorisontal = - self.pingpongBall.speedHorisontal;
//    }
//
    if (self.pingpongBall.frame.origin.x <= 0)
    {
        NSLog(@"left border");
        self.pingpongBall.speedHorisontal = arc4random_uniform(5)+1;
    }
    
    if (CGRectGetMaxX(self.pingpongBall.frame) >= CGRectGetWidth(self.view.frame))
    {
        NSLog(@"right border %ld", (long)self.pingpongBall.speedHorisontal);
        self.pingpongBall.speedHorisontal = arc4random_uniform(5)+1;
        self.pingpongBall.speedHorisontal = - self.pingpongBall.speedHorisontal;
    }
    
    if (self.pingpongBall.frame.origin.y <= CGRectGetMaxY(self.gamerCompupter.frame))
    {
        NSLog(@"top border");
        self.pingpongBall.speedVertical = arc4random_uniform(5)+1;
    }
    
    if (CGRectGetMaxY(self.pingpongBall.frame) >= CGRectGetHeight(self.view.frame))
    {
        NSLog(@"bottom border");
        self.pingpongBall.speedVertical = arc4random_uniform(5)+1;
        self.pingpongBall.speedVertical = - self.pingpongBall.speedVertical;
    }
//    self.viewForAction.center = CGPointMake(self.viewForAction.center.x + 10, self.viewForAction.center.y);
    self.pingpongBall.center = CGPointMake(self.pingpongBall.center.x + self.pingpongBall.speedHorisontal, self.pingpongBall.center.y + self.pingpongBall.speedVertical);
    self.gamerCompupter.center = CGPointMake(self.pingpongBall.center.x, self.gamerCompupter.center.y);
}
@end
