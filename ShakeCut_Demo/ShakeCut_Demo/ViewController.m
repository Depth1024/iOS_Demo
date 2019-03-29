//
//  ViewController.m
//  ShakeCut_Demo
//
//  Created by zlr on 2019/3/29.
//  Copyright © 2019 Zhou Langrui. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [UIApplication sharedApplication].applicationSupportsShakeToEdit = YES;
    
    //在这里设置当前vc 为第一响应者。
    [self becomeFirstResponder];
    
}

// 开始摇一摇
-(void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    NSLog(@"开始摇一摇");
}

//取消摇一摇
- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    NSLog(@"取消摇一摇");
}

//结束摇一摇
-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if(event.subtype == UIEventSubtypeMotionShake)
    {
        NSLog(@"摇动结束");
        //这里实现屏幕截图
        if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)])
        {
            UIGraphicsBeginImageContextWithOptions(self.view.window.bounds.size, NO, [UIScreen mainScreen].scale);
        }
        else
        {
            UIGraphicsBeginImageContext(self.view.window.bounds.size);
        }
        
        [self.view.window.layer renderInContext:UIGraphicsGetCurrentContext()];
        
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        

    }
}






@end
