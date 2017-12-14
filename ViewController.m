//
//  ViewController.m
//  Bell
//
//  Created by Lun.X on 2017/12/14.
//  Copyright © 2017年 Lun.X. All rights reserved.
//

#import "ViewController.h"
#import <AudioToolbox/AudioToolbox.h>

@interface ViewController ()

@property (nonatomic, strong) UIButton *bellBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor grayColor]];
    [self createBell];
}

- (void)createBell {
    _bellBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _bellBtn.frame = CGRectMake((self.view.frame.size.width-63/2)/2,(self.view.frame.size.height-65/2)/2 , 63/2, 65/2);
    [_bellBtn setImage:[[UIImage imageNamed:@"homepage_message"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [_bellBtn addTarget:self action:@selector(bellButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_bellBtn];
}

- (void)bellButtonClicked:(id)sender {
    SystemSoundID soundID = 0;
    // 加载文件
    NSURL *url=[[NSBundle mainBundle] URLForResource:@"music_dingdong.wav" withExtension:nil];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(url), &soundID);
    // 播放短频音效
    AudioServicesPlayAlertSound(soundID);
    // 增加震动效果，如果手机处于静音状态，提醒音将自动触发震动
    AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
    
    //创建基础动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    //动画执行时间
    animation.repeatDuration = 0.8f;
    // 动画结束时执行逆动画
    animation.autoreverses = YES;
    // 设置动画完成，返回到原点
    animation.fillMode = kCAFillModeForwards;
    
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(-0.2, 0.0, 0.0, 1.0)];
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(0.2, 0.0, 0.0, 1.0)];
    
    // 设置动画效果为快入快出
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    // 添加动画到图层上
    _bellBtn.layer.anchorPoint = CGPointMake(0.5, 0.0);
    [_bellBtn.layer addAnimation:animation forKey:@"Animation"];
    _bellBtn.frame = CGRectMake((self.view.frame.size.width-63/2)/2,(self.view.frame.size.height-65/2)/2 , 63/2, 65/2);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
