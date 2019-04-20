//
//  ViewController.m
//  ShakeScreenShot
//
//  Created by 周朗睿 on 2019/4/19.
//  Copyright © 2019 周朗睿. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *showView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[UIApplication sharedApplication]setApplicationSupportsShakeToEdit:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [self becomeFirstResponder];
}

- (void)viewDidAppear:(BOOL)animated{
    [self becomeFirstResponder];
}
- (void)viewWillDisappear:(BOOL)animated{
    [self becomeFirstResponder];
}

#pragma mark - ShakeToEdit
-(void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    //手机震动
//    dispatch_queue_t queue = dispatch_queue_create("shake", NULL);
//    dispatch_async(queue, ^{
//        [self shake];
//    });
    NSLog(@"begin");
    
}

-(void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    NSLog(@"cancel");
    
}

-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    UIImage *image = [self screenshot];
    if(image){
        _showView.image = [self screenshot];
        
    }
    NSLog(@"end");
}

#pragma mark - ScreenShot
-(UIImage *)screenshot{
    
    UIView *view = self.view;
    //  float scale = [[UIScreenmainScreen] scale];//得到设备的分辨率
    //  scale = 1; 的时候是代表当前设备是320*480的分辨率（就是iphone4之前的设备）
    //  scale = 2; 的时候是代表分辨率为640*960的分辨率
    
    //绘图
    //第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了，关键就是第三个参数。
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, [UIScreen mainScreen].scale);
    //渲染
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    //生产图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSLog(@"shot");
    return image;
}
@end
