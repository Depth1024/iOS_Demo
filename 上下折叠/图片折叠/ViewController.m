//
//  ViewController.m
//  图片折叠
//
//  Created by zlr on 2018/4/12.
//  Copyright © 2018年 zlr. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *topImage;
@property (weak, nonatomic) IBOutlet UIImageView *bottomImage;
@property (weak, nonatomic) CAGradientLayer *gradientLayer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 让图片只显示上半部分
    self.topImage.layer.contentsRect = CGRectMake(0, 0, 1, 0.5);
    // 让图片只显示下半部分
    self.bottomImage.layer.contentsRect = CGRectMake(0, 0.5, 1, 0.5);
    
    // 设置锚点
    self.topImage.layer.anchorPoint = CGPointMake(0.5, 1);
    self.bottomImage.layer.anchorPoint = CGPointMake(0.5, 0);
    
    // 渐变层
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    // 将阴影覆盖bottomImage
    gradientLayer.frame = self.bottomImage.bounds;
    // 设置渐变层的颜色
    gradientLayer.colors = @[(id)[UIColor clearColor].CGColor,(id)[UIColor blackColor].CGColor,];
   // 设置渐变为透明 opacity为不透明度
    gradientLayer.opacity = 0;
    
    self.gradientLayer = gradientLayer;
    
    [self.bottomImage.layer addSublayer:gradientLayer];
}

//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [UIView animateWithDuration:0.5 animations:^{
//        self.topImage.layer.transform = CATransform3DMakeRotation(M_PI, 1, 0, 0);
//    }];
//}

// 渐变层方法
/*
-(void)gradientLayer{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    // 将阴影覆盖bottomImage
    gradientLayer.frame = self.bottomImage.bounds;
    // 设置渐变层的颜色
    gradientLayer.colors = @[(id)[UIColor redColor].CGColor,(id)[UIColor greenColor].CGColor,(id)[UIColor blueColor].CGColor];
    // 设置渐变的方向
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    // 设置一个渐变到另一个渐变的起始位置
    gradientLayer.locations = @[@0.2,@0.6];
}
 */

- (IBAction)pan:(UIPanGestureRecognizer *)pan {
    // 获取移动的偏移量
    CGPoint transP = [pan translationInView:pan.view];
    //  让上部图片开始旋转
    CGFloat angle = transP.y*M_PI / 200;
    
    // 添加近大远小的透视效果（修改transform的m34的值）
    CATransform3D transform = CATransform3DIdentity;
    // 眼睛离屏幕的距离
    transform.m34 = -1 / 300.0;
    
    // 设置渐变层的不透明度
    self.gradientLayer.opacity = transP.y * 1/200.0;
    
//    self.topImage.layer.transform = CATransform3DMakeRotation(-angle, 1, 0, 0);
    self.topImage.layer.transform = CATransform3DRotate(transform, -angle, 1, 0, 0);
    
    // 监听用户的手势
    if (pan.state == UIGestureRecognizerStateEnded){
        if (transP.y <= 50){
            self.gradientLayer.opacity = NO;
            // 上部图片的复位
            [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.2 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
                self.topImage.layer.transform = CATransform3DIdentity;
            } completion:nil];
        }else {
            self.gradientLayer.opacity = NO;
                self.topImage.layer.transform = CATransform3DMakeTranslation(0, 100, 0);
                self.topImage.layer.transform = CATransform3DMakeRotation(180 * M_PI/180, 1, 0, 0);
        }
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
