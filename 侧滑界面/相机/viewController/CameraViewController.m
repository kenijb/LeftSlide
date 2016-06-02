//
//  CameraViewController.m
//  侧滑界面
//
//  Created by jim Yao on 16/4/28.
//  Copyright © 2016年 aaaaaa. All rights reserved.
//

#import "CameraViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface CameraViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (nonatomic,strong)AVCaptureVideoPreviewLayer *previewLayer ;
@property (nonatomic,strong)AVCaptureSession *session;
@property (strong,nonatomic) CAShapeLayer *mask;
@property (nonatomic,assign)int count;

@end

@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mask = [CAShapeLayer layer];
    self.mask.fillRule = kCALineJoinBevel;
    AVCaptureSession *session = [[AVCaptureSession alloc] init];
    
    //session
    self.session = session;
    //device
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *error = nil;
    //input
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    if(input) {
        [self.session addInput:input];
    } else {
        NSLog(@"%@", error);
        return;
    }
    //output
    //    [self.session addInput:input];
    
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc]init];
    [self.session addOutput:output];
    
    self.previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    
    
    [self.preview.layer addSublayer:self.previewLayer];
    [self.session startRunning];
    
    
}
-(void)viewDidLayoutSubviews{
    
    self.previewLayer.bounds = self.preview.bounds;
    self.previewLayer.position = CGPointMake(CGRectGetMidX(self.preview.bounds), CGRectGetMidY(self.preview.bounds));
    [super viewDidLayoutSubviews];
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    dispatch_queue_t queue = dispatch_queue_create("a", DISPATCH_QUEUE_SERIAL);
        dispatch_async(queue, ^{
            self.count++;
            NSString *str  = [NSString stringWithFormat:@"%d",self.count];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.label.text = str;
        });
            
        });
}
@end
