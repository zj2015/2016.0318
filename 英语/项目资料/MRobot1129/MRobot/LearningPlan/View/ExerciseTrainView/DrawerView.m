//
//  DrawerView.m
//  DrawerDemo
//
//  Created by Zhouhaifeng on 12-3-27.
//  Copyright (c) 2012年 CJLU. All rights reserved.
//

#import "DrawerView.h"

@implementation DrawerView
@synthesize contentView,parentView,drawState;
@synthesize arrow;

- (id)initWithView:(UIView *) contentview parentView :(UIView *) parentview withBlock:(DrawerViewBlock)block
{
    self = [super initWithFrame:CGRectMake(0,0,contentview.frame.size.width, contentview.frame.size.height+40)];
    if (self) {
        
        _block = block;
        
        // Initialization code        
        contentView = contentview;
        parentView = parentview;
        
        //一定要开启
        [parentView setUserInteractionEnabled:YES];
        
        //嵌入内容区域的背景
//        UIImage *drawer_bg = [UIImage imageNamed:@"drawer_content.png"];
//        UIImageView *view_bg = [[UIImageView alloc]initWithImage:drawer_bg];
//        [view_bg setFrame:CGRectMake(0,40,contentview.frame.size.width, contentview.bounds.size.height+40)];
//        [self addSubview:view_bg];
    
        //箭头的图片
        UIImage *drawer_handle = [UIImage imageNamed:@"drawer"];
        UIImageView *view_handle = [[UIImageView alloc]initWithImage:drawer_handle];
        [view_handle setFrame:CGRectMake(0,20,60*SIZE_TIMES,20)];
         view_handle.center = CGPointMake(contentview.frame.size.width/2, 25);
        [self addSubview:view_handle];
        
        
        UIButton *drawer_arrow = [UIButton buttonWithType:UIButtonTypeCustom];
//        drawer_arrow.backgroundColor = [UIColor yellowColor];
        [drawer_arrow setFrame:CGRectMake(0,20,MainScreenSize_W,45)];
        drawer_arrow.center = CGPointMake(contentview.frame.size.width/2, 20);
        [self addSubview:drawer_arrow];
        
        //嵌入内容的UIView
        [contentView setFrame:CGRectMake(0,35,contentview.frame.size.width, contentview.bounds.size.height+40)];
        [self addSubview:contentview];
        
        //移动的手势
        UIPanGestureRecognizer *panRcognize=[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];  
        panRcognize.delegate=self;  
        [panRcognize setEnabled:YES];  
        [panRcognize delaysTouchesEnded];  
        [panRcognize cancelsTouchesInView]; 
        
        [drawer_arrow addGestureRecognizer:panRcognize];
        
        //单击的手势
//        UITapGestureRecognizer *tapRecognize = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];  
//        tapRecognize.numberOfTapsRequired = 1;  
//        tapRecognize.delegate = self;  
//        [tapRecognize setEnabled :YES];  
//        [tapRecognize delaysTouchesBegan];  
//        [tapRecognize cancelsTouchesInView];  
//        
//        [drawer_arrow addGestureRecognizer:tapRecognize];
        
        //设置两个位置的坐标
        downPoint = CGPointMake(parentview.frame.size.width/2, parentview.frame.size.height+contentview.frame.size.height/2-80);
        upPoint = CGPointMake(parentview.frame.size.width/2, parentview.frame.size.height-contentview.frame.size.height/2+154);
        self.center =  downPoint;
        
        //设置起始状态
        drawState = DrawerViewStateDown;
    }
    return self;
}


#pragma UIGestureRecognizer Handles  
/*    
 *  移动图片处理的函数 
 *  @recognizer 移动手势 
 */  
- (void)handlePan:(UIPanGestureRecognizer *)recognizer {  
    
   
    CGPoint translation = [recognizer translationInView:parentView];
    self.center = CGPointMake(self.center.x,self.center.y + translation.y);
    [recognizer setTranslation:CGPointMake(0, 0) inView:parentView];
    
    _block(self.center.y + translation.y - 155*SIZE_TIMES);
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        [UIView animateWithDuration:0.75 delay:0.15 options:UIViewAnimationOptionCurveEaseOut animations:^{
                if (self.center.y < upPoint.y) {
                    self.center = upPoint;
                    _block(upPoint.y - 155*SIZE_TIMES);
                    [self transformArrow:DrawerViewStateUp];
                }else if (self.center.y > downPoint.y)
                {
                    self.center = downPoint;
                    _block(downPoint.y - 155*SIZE_TIMES);
                    [self transformArrow:DrawerViewStateDown];
                }else{
                    if (translation.y > 0) {
                        [self transformArrow:DrawerViewStateDown];
                    }else{
                        [self transformArrow:DrawerViewStateUp];
                    }
                }

        } completion:nil];  
 
    }    
}  

/* 
 *  handleTap 触摸函数 
 *  @recognizer  UITapGestureRecognizer 触摸识别器 
 */  
-(void) handleTap:(UITapGestureRecognizer *)recognizer  
{  
        [UIView animateWithDuration:0.75 delay:0.15 options:UIViewAnimationOptionTransitionCurlUp animations:^{  
            if (drawState == DrawerViewStateDown) {
                self.center = upPoint;
                [self transformArrow:DrawerViewStateUp];
            }else
            {
                self.center = downPoint;
                [self transformArrow:DrawerViewStateDown];
            }
        } completion:nil];  
 
} 

/* 
 *  transformArrow 改变箭头方向
 *  state  DrawerViewState 抽屉当前状态 
 */ 
-(void)transformArrow:(DrawerViewState) state
{
        //NSLog(@"DRAWERSTATE :%d  STATE:%d",drawState,state);
    
//        [UIView animateWithDuration:0.3 delay:0.35 options:UIViewAnimationOptionCurveEaseOut animations:^{  
//           if (state == DrawerViewStateUp){   
//                    arrow.transform = CGAffineTransformMakeRotation(M_PI);
//                }else
//                {
//                     arrow.transform = CGAffineTransformMakeRotation(0);
//                }
//        } completion:^(BOOL finish){
//               drawState = state;
//        }];  
        drawState = state;
   
}


@end
