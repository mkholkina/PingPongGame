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
@property (nonatomic, strong) UILabel *gameCount;
@property NSInteger computerCount;
@property NSInteger userCount;
@property NSString *currentCount;
@property (nonatomic, strong) UIButton *startAgainButton;
@property (nonatomic, strong) UILabel *gameStatus;
@property NSInteger randomSlide;
@property NSInteger flag;

@end

static const NSInteger maxBallSpeed = 5;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.computerCount = 0;
    self.userCount = 0;
    self.flag = 0;
    self.currentCount = [NSString stringWithFormat:@"%ld : %ld", (long)self.computerCount, (long)self.userCount];
    self.randomSlide = 0;
    
    self.gameCount = [[UILabel alloc] initWithFrame:CGRectMake(self.view.center.x - 100, self.view.center.y - 50, 200, 100)];
    self.gameCount.backgroundColor = [UIColor clearColor];
    self.gameCount.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    self.gameCount.layer.borderWidth = 1.0f;
    [self.gameCount setText:self.currentCount];
    self.gameCount.textColor = [UIColor lightGrayColor];
    self.gameCount.textAlignment = NSTextAlignmentCenter;
    self.gameCount.font = [UIFont fontWithName:@"Verdana" size:60];
    [self.view addSubview:self.gameCount];
    
    self.pingpongBall = [[Ball alloc] initWithFrame:CGRectMake(30, 30, 50, 50)];
    self.pingpongBall.backgroundColor = [UIColor redColor];
    self.pingpongBall.speedHorisontal = maxBallSpeed;
    self.pingpongBall.speedVertical = maxBallSpeed;
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

- (void) stopTimer
{
    [self.timer invalidate];
    self.timer = nil;
}

-(void)ballAnimation
{
    if (self.pingpongBall.frame.origin.x <= 0)
    {
        self.pingpongBall.speedHorisontal = arc4random_uniform(maxBallSpeed)+1;
    }
    
    if (CGRectGetMaxX(self.pingpongBall.frame) >= CGRectGetWidth(self.view.frame))
    {
        self.pingpongBall.speedHorisontal = arc4random_uniform(maxBallSpeed)+1;
        self.pingpongBall.speedHorisontal = - self.pingpongBall.speedHorisontal;
    }
    
    //top and bottom----------------------------
    
    //NSLog(@"\n Current position \n ball: %3.3f, %3.3f, %3.3f, %3.3f \n computerside: %3.3f, %3.3f, %3.3f \n userside: %3.3f, %3.3f, %3.3f",self.pingpongBall.frame.origin.x,CGRectGetMaxX(self.pingpongBall.frame), self.pingpongBall.frame.origin.y,CGRectGetMaxY(self.pingpongBall.frame), self.gamerCompupter.frame.origin.x,CGRectGetMaxX(self.gamerCompupter.frame), CGRectGetMaxY(self.gamerCompupter.frame),self.gamerUser.frame.origin.x, CGRectGetMaxX(self.gamerUser.frame), self.gamerUser.frame.origin.y);
    
    if (self.flag == 1)
    {
        if (self.pingpongBall.frame.origin.y > CGRectGetMaxY(self.gamerCompupter.frame))
        {
            self.flag = 0;
        }
    }
    else if (self.pingpongBall.frame.origin.y <= CGRectGetMaxY(self.gamerCompupter.frame))
    {
        if ((CGRectGetMaxX(self.pingpongBall.frame) >= self.gamerCompupter.frame.origin.x) && (self.pingpongBall.frame.origin.x <= CGRectGetMaxX(self.gamerCompupter.frame)))
        {
            self.pingpongBall.speedVertical = arc4random_uniform(maxBallSpeed)+1;
            self.computerCount = self.computerCount + 1;
//            self.randomSlide = [self getRandomSlide];
//            [self slideAnimation:self.randomSlide];
            NSLog(@"\n -------------------------------- \n Contact with computer side, %ld : %ld", (long)self.computerCount, (long)self.userCount);
            NSLog(@"\n Current position \n ball: %3.3f, %3.3f, %3.3f \n side: %3.3f, %3.3f, %3.3f",self.pingpongBall.frame.origin.x,CGRectGetMaxX(self.pingpongBall.frame), self.pingpongBall.frame.origin.y, self.gamerCompupter.frame.origin.x,CGRectGetMaxX(self.gamerCompupter.frame), CGRectGetMaxY(self.gamerCompupter.frame));
            self.flag = 1;
        }
        else if (self.pingpongBall.frame.origin.y <= self.view.frame.origin.y)
        {
            self.pingpongBall.speedVertical = arc4random_uniform(maxBallSpeed)+1;
//            self.randomSlide = [self getRandomSlide];
//            [self slideAnimation:self.randomSlide];
            NSLog(@"\n -------------------------------- \n Contact with top side, %ld : %ld", (long)self.computerCount, (long)self.userCount);
            NSLog(@"\n Current position \n ball: %3.3f, %3.3f, %3.3f \n side: %3.3f, %3.3f, %3.3f",self.pingpongBall.frame.origin.x,CGRectGetMaxX(self.pingpongBall.frame), self.pingpongBall.frame.origin.y, self.gamerCompupter.frame.origin.x,CGRectGetMaxX(self.gamerCompupter.frame), CGRectGetMaxY(self.gamerCompupter.frame));
            self.flag = 1;
        }
    }
    
    if (self.flag == 2)
    {
        if (CGRectGetMaxY(self.pingpongBall.frame) < self.gamerUser.frame.origin.y)
        {
            self.flag = 0;
        }
    }
    else if (CGRectGetMaxY(self.pingpongBall.frame) >= self.gamerUser.frame.origin.y)
    {
        if ((CGRectGetMaxX(self.pingpongBall.frame) >= self.gamerUser.frame.origin.x) && (self.pingpongBall.frame.origin.x <= CGRectGetMaxX(self.gamerUser.frame)))
        {
            self.pingpongBall.speedVertical = arc4random_uniform(maxBallSpeed)+1;
            self.pingpongBall.speedVertical = - self.pingpongBall.speedVertical;
            self.userCount = self.userCount + 1;
            self.randomSlide = [self getRandomSlide];
            [self slideAnimation:self.randomSlide];
            NSLog(@"\n -------------------------------- \n Contact with user side, %ld : %ld", (long)self.computerCount, (long)self.userCount);
            NSLog(@"\n Current position \n ball: %3.3f, %3.3f, %3.3f \n side: %3.3f, %3.3f, %3.3f", self.pingpongBall.frame.origin.x, CGRectGetMaxX(self.pingpongBall.frame), CGRectGetMaxY(self.pingpongBall.frame), self.gamerUser.frame.origin.x, CGRectGetMaxX(self.gamerUser.frame), self.gamerUser.frame.origin.y);
            self.flag = 2;
        }
        else if (CGRectGetMaxY(self.pingpongBall.frame) >= CGRectGetHeight(self.view.frame))
        {
            self.pingpongBall.speedVertical = arc4random_uniform(maxBallSpeed)+1;
            self.pingpongBall.speedVertical = - self.pingpongBall.speedVertical;
            self.randomSlide = [self getRandomSlide];
            [self slideAnimation:self.randomSlide];
            NSLog(@"\n -------------------------------- \n Contact with bottom side, %ld : %ld", (long)self.computerCount, (long)self.userCount);
            NSLog(@"\n Current position \n ball: %3.3f, %3.3f, %3.3f \n side: %3.3f, %3.3f, %3.3f", self.pingpongBall.frame.origin.x, CGRectGetMaxX(self.pingpongBall.frame), CGRectGetMaxY(self.pingpongBall.frame), self.gamerUser.frame.origin.x, CGRectGetMaxX(self.gamerUser.frame), self.gamerUser.frame.origin.y);
            self.flag = 2;
        }
    }
    
    self.pingpongBall.center = CGPointMake(self.pingpongBall.center.x + self.pingpongBall.speedHorisontal, self.pingpongBall.center.y + self.pingpongBall.speedVertical);
    
    self.gamerCompupter.center = CGPointMake(self.pingpongBall.center.x + self.randomSlide, self.gamerCompupter.center.y);
    
    //self.gamerCompupter.center = CGPointMake(self.pingpongBall.center.x, self.gamerCompupter.center.y);
    
    self.currentCount = [NSString stringWithFormat:@"%ld : %ld", (long)self.computerCount, (long)self.userCount];
    [self.gameCount setText:self.currentCount];
    
    
    if ((self.computerCount >= 10) || (self.userCount >= 10))
    {
        [self waitForNewGame];
    }
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSSet *allTouches = [event allTouches];
    UITouch *touch = [[allTouches allObjects] objectAtIndex:0];
    CGPoint touchLocation = [touch locationInView:self.view];
    self.gamerUser.center = CGPointMake(touchLocation.x, self.gamerUser.center.y);
}

-(void)waitForNewGame
{
    [self stopTimer];
    NSLog(@"\n Do you want to start new game?");
    
    self.gameStatus = [[UILabel alloc] initWithFrame:CGRectMake(self.view.center.x - 100, self.gameCount.frame.origin.y-100, 200, 50)];
    if (self.userCount >= 5)
    {
        self.gameStatus.backgroundColor = [UIColor greenColor];
        self.gameStatus.text = @"You are win!";
    }
    else
    {
        self.gameStatus.backgroundColor = [UIColor redColor];
        self.gameStatus.text = @"You are looser";
    }
    self.gameStatus.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.gameStatus];
    
    self.startAgainButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.center.x - 50, CGRectGetMaxY(self.gameCount.frame)+20, 100, 50)];
    self.startAgainButton.backgroundColor = [UIColor cyanColor];
    [self.startAgainButton setTitle:@"Play again" forState:UIControlStateNormal];
    [self.startAgainButton addTarget:self action:@selector(startNewGame) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: self.startAgainButton];
}

-(void)startNewGame
{
    self.userCount = 0;
    self.computerCount = 0;
    [self.startAgainButton removeFromSuperview];
    [self.gameStatus removeFromSuperview];
    [self startTimer];
}

-(NSInteger)getRandomSlide
{
    NSInteger random1 = arc4random_uniform(11);
    NSInteger random2 = arc4random_uniform(11);
    random1 = 20*(random1 - random2);
    NSLog(@"\n slide %ld", random1);
    return random1;
}

- (void)slideAnimation: (NSInteger) slide
{
    CABasicAnimation *theAnimation;
    theAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    theAnimation.duration = 1.0;
    //theAnimation.repeatCount = 2;
    //theAnimation.autoreverses = YES;
    theAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(self.gamerCompupter.center.x, self.gamerCompupter.center.y)];
    
    theAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(self.gamerCompupter.center.x + slide, self.gamerCompupter.center.y)];
    
    [self.gamerCompupter.layer addAnimation:theAnimation forKey:@"animatePosition"];
}

@end
