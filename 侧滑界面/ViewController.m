//
//  ViewController.m
//  侧滑界面
//
//  Created by jim Yao on 16/4/23.
//  Copyright © 2016年 aaaaaa. All rights reserved.
//

#import "ViewController.h"
#import "LeftSide.h"
#import "CameraViewController.h"
#import <AVFoundation/AVFoundation.h>
#define kSCR [UIScreen mainScreen]

@interface ViewController ()<AVCaptureMetadataOutputObjectsDelegate>
@property (weak, nonatomic) IBOutlet UIView *move;

@property (nonatomic,strong)CameraViewController *Mycamera ;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftNav];
    [self leftSide];
    
    UIPanGestureRecognizer *pan =[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGes:)];
//
    [self.move addGestureRecognizer:pan];
    
    
    
    
}
-(void)panGes:(UIPanGestureRecognizer*)pan{
    CGPoint point  = [pan translationInView:pan.view];
    

    self.move.transform  =CGAffineTransformMake(0.5, 0, 0, 0.5, point.x, point.y);
    
    
//    NSLog(@"%@",NSStringFromCGPoint(point));
    
    NSLog(@"%f,%f",self.move.transform.tx,point.x);
        
    
}

-(void)leftSide{
    LeftSide * left  =[LeftSide shareLeftside];
    left.frame = CGRectMake(-kSCR.bounds.size.height/2.5+20, 0, kSCR.bounds.size.height/2.5, kSCR.bounds.size.height);
    [self.navigationController.view addSubview:left];
    
    
    
    
}
-(void)setLeftNav{
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"左边粗来" style:UIBarButtonItemStyleDone target:self action:@selector(click)];

    
}


- (void)click{
    NSLog(@"ninin");
    CameraViewController *Mycamera = [[CameraViewController alloc] init];
    
    
    [self presentViewController:Mycamera animated:YES completion:nil];
    
    
}
@end
