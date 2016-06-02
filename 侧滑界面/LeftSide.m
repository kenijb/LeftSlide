//
//  LeftSide.m
//  侧滑界面
//
//  Created by jim Yao on 16/4/23.
//  Copyright © 2016年 aaaaaa. All rights reserved.
//

#import "LeftSide.h"
#define kSCR [UIScreen mainScreen]
@interface LeftSide()<UIGestureRecognizerDelegate,UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *menu;
@property (weak, nonatomic) IBOutlet UIView *panView;
@property (weak, nonatomic) IBOutlet UIView *menuView;
@property (nonatomic,strong) UIView *shadeView;
@property (nonatomic,strong) UIPanGestureRecognizer *pan;
@property (nonatomic,assign) CGFloat xp;
@property (nonatomic,strong) NSArray *slideArr ;
@end
@implementation LeftSide

-(NSArray *)slideArr{
    if (_slideArr==nil) {
        _slideArr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Setting.plist" ofType:nil]];
    
    }
    return _slideArr;
    
    
    }
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.slideArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self.slideArr[section] valueForKey:@"item"] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell ==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    NSDictionary *dic = [NSDictionary dictionaryWithDictionary:self.slideArr[indexPath.section]];
    
    NSArray *dicArr =  [NSArray arrayWithArray:dic[@"item"]];
    for (NSDictionary *dic in dicArr) {
        cell.textLabel.text = dic[@"title"];
        cell.textLabel.font = [UIFont systemFontOfSize:13.0];
        
        cell.backgroundColor = [UIColor clearColor];
        
        if (indexPath.row==0&&indexPath.section==0) {
            cell.textLabel.textColor = [UIColor colorWithRed:244 / 255.0 green:89 / 255.0 blue:163 / 255.0 alpha:1];
        }

        

    }
    
    
    return cell;
    

}
+ (instancetype)shareLeftside
{
    
    return [[[NSBundle mainBundle] loadNibNamed:@"LeftSide" owner:nil options:nil] lastObject];
}

-(void)awakeFromNib{
    UIPanGestureRecognizer *pan =[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGes:)];
    [self.panView addGestureRecognizer:pan];
    UIPanGestureRecognizer *pan1 =[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGes:)];
    
    [self.menuView addGestureRecognizer:pan1];
    pan.delegate =self;
//    self.menu.delegate = self;
//    self.menu.dataSource = self;
//    self.setTbaleView.rowHeight = 54;
//    self.setTbaleView.bounces = NO;
//    self.setTbaleView.sectionHeaderHeight = 2;
    self.menu.rowHeight = 54;
    self.menu.bounces = NO;
    self.menu.sectionHeaderHeight = 2;


}

-(void)panGes:(UIPanGestureRecognizer*)pan{
    
    CGPoint point  = [pan translationInView:pan.view];
    self.xp = self.xp+point.x;
    self.transform =CGAffineTransformMakeTranslation(self.xp, 0);
    [pan setTranslation:CGPointZero inView:self];
    if (self.frame.origin.x<-kSCR.bounds.size.height/2.5+20) {
        self.transform = CGAffineTransformMakeTranslation(0, 0);
    }
    if (self.frame.origin.x >=0){
        self.transform  =CGAffineTransformMakeTranslation(kSCR.bounds.size.height/2.5-20,0);
    }
    if (self.frame.origin.x>=-kSCR.bounds.size.height/2.5+20&&self.frame.origin.x<-kSCR.bounds.size.height/4&&pan.state ==UIGestureRecognizerStateEnded) {
        [UIView animateWithDuration:0.3 animations:^{
            self.transform =CGAffineTransformMakeTranslation(0, 0);
        }];
        
    }if (self.frame.origin.x<0&&self.frame.origin.x>=-kSCR.bounds.size.height/4&&pan.state ==UIGestureRecognizerStateEnded) {
        
        [UIView animateWithDuration:0.3 animations:^{
            self.transform  =CGAffineTransformMakeTranslation(kSCR.bounds.size.height/2.5-20,0);
        }];
        
    }
    
 }
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    
    return NO;
}

-(void)dealloc{
    NSLog(@"dead");
}
@end
