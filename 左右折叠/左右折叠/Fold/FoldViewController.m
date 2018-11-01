//
//  FoldViewController.m
//  左右折叠
//
//  Created by zlr on 2018/4/30.
//  Copyright © 2018年 zlr. All rights reserved.
//

#import "FoldViewController.h"

@interface FoldViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *bottomImage;
@property (weak, nonatomic) IBOutlet UIImageView *topImage;
@property (weak, nonatomic) CAGradientLayer *gradientLayer;

@end

@implementation FoldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 让左图只显示左半部分
    self.topImage.layer.contentsRect = CGRectMake(0, 0, 0.5, 1);
    // 让右图只显示右半部分
    self.bottomImage.layer.contentsRect = CGRectMake(0.5, 0, 0.5, 1);
    
    // 设置锚点
    self.topImage.layer.anchorPoint = CGPointMake(0.7, 0.5);
    self.bottomImage.layer.anchorPoint = CGPointMake(0.3, 0.5);
    // 渐变层
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    // 将阴影覆盖bottomImage（取消阴影覆盖，效果不佳）
//    gradientLayer.frame = self.bottomImage.bounds;
    // 设置渐变层的颜色
    gradientLayer.colors = @[(id)[UIColor clearColor].CGColor,(id)[UIColor blackColor].CGColor,];
    // 设置渐变为透明 opacity为不透明度
    gradientLayer.opacity = 0;
    
    self.gradientLayer = gradientLayer;
    
    [self.bottomImage.layer addSublayer:gradientLayer];
}
- (IBAction)pan:(UIPanGestureRecognizer *)pan {
    // 获取移动的偏移量
    CGPoint transP = [pan translationInView:pan.view];
    //  让左部图片开始旋转
    CGFloat angle = transP.x*M_PI / 200;
    // 让左边图片开始旋转
    self.topImage.layer.transform = CATransform3DMakeRotation(angle, 0, 1, 0);
    // 添加近大远小的透视效果（修改transform的m34的值）
    CATransform3D transform = CATransform3DIdentity;
    // 眼睛离屏幕的距离
    transform.m34 = -1 / 300.0;
    
    // 设置渐变层的不透明度
    self.gradientLayer.opacity = transP.x * 1/200.0;
    
    self.topImage.layer.transform = CATransform3DRotate(transform, angle, 0, 1, 0);
    if (pan.state == UIGestureRecognizerStateEnded){
        if (transP.x <= 100){
            self.gradientLayer.opacity = NO;
            // 左部图片的复位
            [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.2 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
                self.topImage.layer.transform = CATransform3DIdentity;
            } completion:nil];
        }else {
            self.gradientLayer.opacity = NO;
            self.topImage.layer.transform = CATransform3DMakeTranslation(0, 100, 0);
            self.topImage.layer.transform = CATransform3DMakeRotation(180 * M_PI/180, 0, 1, 0);
        }
    }
}
//- (IBAction)pan:(UIScreenEdgePanGestureRecognizer *)pan {

//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
