//
//  ViewController.m
//  ShakeScreenShot2
//
//  Created by 周朗睿 on 2019/4/20.
//  Copyright © 2019 周朗睿. All rights reserved.
//

#import "ViewController.h"
#import <CoreMotion/CoreMotion.h>

@interface ViewController ()

@property (strong,nonatomic) CMMotionManager *motionManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.motionManager = [[CMMotionManager alloc] init];//一般在viewDidLoad中进行
    self.motionManager.accelerometerUpdateInterval = .1;//加速仪更新频率，以秒为单位

}

-(void)viewDidAppear:(BOOL)animated
{
    [self startAccelerometer];
}
-(void)startAccelerometer
{
    //以push的方式更新并在block中接收加速度
    [self.motionManager startAccelerometerUpdatesToQueue:[[NSOperationQueue alloc]init]
                                             withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {
                                                 [self outputAccelertionData:accelerometerData.acceleration];
                                                 if (error) {
                                                     NSLog(@"motion error:%@",error);
                                                 }
                                             }];
}
-(void)outputAccelertionData:(CMAcceleration)acceleration
{
    //综合3个方向的加速度
    double accelerameter =sqrt( pow( acceleration.x , 2 ) + pow( acceleration.y , 2 )
                               + pow( acceleration.z , 2) );
    //当综合加速度大于2.3时，就激活效果（此数值根据需求可以调整，数据越小，用户摇动的动作就越小，越容易激活，反之加大难度，但不容易误触发）
    if (accelerameter>2.3f) {
        //立即停止更新加速仪（很重要！）
        [self.motionManager stopAccelerometerUpdates];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //UI线程必须在此block内执行，例如摇一摇动画、UIAlertView之类
            
        });
    }
}
-(void)viewDidDisappear:(BOOL)animated
{
    //停止加速仪更新（很重要！）
    [self.motionManager stopAccelerometerUpdates];
}
@end
