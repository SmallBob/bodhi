//
//  ViewController.m
//  bodhiWord
//
//  Created by apple on 14/11/28.
//  Copyright (c) 2014年 apple. All rights reserved.
//



#import "ViewController.h"
#import "SecondViewController.h"
#import "UserInfo.h"

#import "JsonPostModel.h"

@interface ViewController ()<UIScrollViewDelegate>



@property(nonatomic,strong)UIView*firstView;
@property(nonatomic,strong)UIView*secondView;
@property(nonatomic,strong)UIView*thirdView;
@property(nonatomic,strong)UIView*fourView;
@property(nonatomic,strong)UIScrollView*fourSV;
@property(nonatomic,strong)UIPageControl*pageCtrl;
@property(nonatomic,strong)UIImageView*iv;



@property(nonatomic,strong)NSMutableArray*ary;




@property(nonatomic,strong)UIView*fiveView;

@property(nonatomic,strong)UIScrollView*mainSV;

@property(nonatomic,strong)UIView*loginView;

@property(nonatomic,strong)UIButton*friendBtn;

@property(nonatomic)NSInteger num;


@property(nonatomic,strong)UIImage*image;


@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (!self.ary) {
        self.ary  = [NSMutableArray array];
        
    }
    
    [[JsonPostModel shareJsonPostModel]  requestMainviewRoleImage:^(id obj) {
        self.ary = obj;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            [self updataUI];
            
  
        });
        
    }];
    
}

-(void)updataUI
{
    
    
//主界面底层是 UIScrollVIew
    self.mainSV=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 224, self.view.frame.size.width, self.view.frame.size.height-224)];
    
//显示垂直方向滚动条
    self.mainSV.showsVerticalScrollIndicator=YES;
    
//弹簧效果
    self.mainSV.bounces=NO;
    
    CGFloat viewWidth=self.view.frame.size.width;
   
    
//创建5个view 加载导sv上
    
//firstView
    self.firstView=[[UIView alloc]initWithFrame:CGRectMake(0, 24,  viewWidth,80)];
   
    UIButton*loginBtn=[[UIButton alloc]initWithFrame:CGRectMake(10, 10, 60, 60)];
    
     [loginBtn setImage:[UIImage imageNamed:@"loginBtn.png"] forState:UIControlStateNormal];
    
    [loginBtn addTarget:self action:@selector(loginBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    
   self.friendBtn=[[UIButton alloc]initWithFrame:CGRectMake(viewWidth-70, 10, 60, 60)];
     
    [self.friendBtn setImage:[UIImage imageNamed:@"newFriendBtn.png"] forState:UIControlStateNormal];
    
   // [ self.friendBtn addTarget:self action:@selector(newFriendBtnView:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIImageView*logoIV=[[UIImageView alloc]initWithFrame:CGRectMake(viewWidth/2-45, 5, 90, 70)];
    logoIV.image=[UIImage imageNamed:@"screenTitle.png"];
    //logoIV.backgroundColor=[UIColor grayColor];
    
    
    [self.firstView addSubview:loginBtn];
    [self.firstView addSubview: self.friendBtn];
    [self.firstView addSubview:logoIV];
    
    
//secondView
    self.secondView=[[UIView alloc]initWithFrame:CGRectMake(0, 104,  viewWidth,120)];
    
//play watch learn create 按钮
    
    for (int i = 0; i<4; i++) {
        //左边 10  右边 5 间距 5
        CGFloat btnWidth= (viewWidth-10-5-20)/4;
        
        UIButton*studyBtn=[[UIButton alloc]initWithFrame:CGRectMake(10+i*(btnWidth+5), 10, btnWidth, 100)];
        [studyBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"btn0%d.png",(i+1)]] forState:UIControlStateNormal];
        
        studyBtn.tag=i;
        
        [studyBtn addTarget:self action:@selector(goSecondView:) forControlEvents:UIControlEventTouchUpInside];
        
        studyBtn.tag=i;//  为添加背景图片
        
        [self.secondView addSubview:studyBtn];
        
    }
    
    
 //mianSV
//thirdView
    self.thirdView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,  viewWidth,450)];
    
    UIButton*ABbtn=[[UIButton alloc]initWithFrame:CGRectMake(10, 0, viewWidth-20, 210)];
    
    [ABbtn addTarget:self action:@selector(toLearn:) forControlEvents:UIControlEventTouchUpInside];
    
    [ABbtn setImage:[UIImage imageNamed:@"AB.png"] forState:UIControlStateNormal];
    
    UIButton*playBtn=[[UIButton alloc]initWithFrame:CGRectMake(10, ABbtn.frame.size.height, viewWidth-20, 210)];
    
    [playBtn addTarget: self  action:@selector(toPlay:) forControlEvents:UIControlEventTouchUpInside];
    
    [playBtn setImage:[UIImage imageNamed:@"Bodhiword-learn.png"] forState:UIControlStateNormal];

    UIImageView*thirdIV=[[UIImageView alloc]initWithFrame:CGRectMake(self.thirdView.frame.size.width/2-60, self.thirdView.frame.size.height-15, 120, 13)];
    thirdIV.image=[UIImage imageNamed:@"MeetOur.png"];
    [self.thirdView addSubview:thirdIV];
    
    [self.thirdView addSubview:ABbtn];
    [self.thirdView addSubview:playBtn];
    
//fourView
    self.fourView=[[UIView alloc]initWithFrame:CGRectMake(0, 450,  viewWidth,40)];
    
    //self.fourView.backgroundColor = [UIColor grayColor];
    
    UIButton*leftBtn=[[UIButton alloc]initWithFrame:CGRectMake(10, 0, 10, 40)];
    [leftBtn setImage:[UIImage imageNamed:@"fourViewBtnLeft.png"] forState:UIControlStateNormal];
    
    UIButton*rightBtn=[[UIButton alloc]initWithFrame:CGRectMake(self.fourView.frame.size.width-20, 0, 10, 40)];
    [rightBtn setImage:[UIImage imageNamed:@"fourViewBtnRight.png"] forState:UIControlStateNormal];
    
    CGRect bounds = self.fourView.frame;
    
    self.fourSV=[[UIScrollView alloc]initWithFrame:CGRectMake(30, 0, bounds.size.width-60, 40)];
    self.fourSV.pagingEnabled = YES;
    self.fourSV.bounces = NO;
    [self.fourSV setDelegate:self];
    self.fourSV.showsVerticalScrollIndicator = NO;
    
    CGFloat m = self.fourSV.frame.size.width/4;
    
    for (int i=0; i<self.ary.count; i++) {
        
        UserInfo*userInfo = self.ary[i];
        
        
        
        
        self.iv=[[UIImageView alloc]initWithFrame:CGRectMake(i*m, 0, m, self.fourSV.frame.size.height)];
        self.iv.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:userInfo.iconUrl]]];
        
        
        
        //[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:roleImage.iconUrl]]];
        
        [self.fourSV  addSubview:self.iv];
               
    }

    //NSInteger n = (self.ary.count%4 == 0)?(self.ary.count/4) : (self.ary.count/4+1);
    [self.fourSV  setContentSize:CGSizeMake(self.ary.count*m, self.fourSV.frame.size.height)];
    [self.fourSV addSubview:self.iv];
    
#pragma pageControl
/*
    //创建UIPageControl
    self.pageCtrl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, bounds.size.height - 40, bounds.size.width, 40)];  //创建UIPageControl，位置在屏幕最下方。
    
    //self.pageCtrl.backgroundColor=[UIColor redColor];
    self.pageCtrl.numberOfPages = n;
    self.pageCtrl.currentPage = 0;
   
    
    //[self.fourSV addSubview:self.pageCtrl];

    */
    [self.fourView addSubview:leftBtn];
    [self.fourView addSubview:rightBtn];

    [self.fourView addSubview: self.fourSV];
    
   
    
    

//fiveView
    self.fiveView=[[UIView alloc]initWithFrame:CGRectMake(0, 520,  viewWidth,160)];
    
    //self.fiveView.backgroundColor = [UIColor redColor];
    
    UIView*fview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.fiveView.frame.size.width, self.fiveView.frame.size.height)];
    UIImageView*iv1=[[UIImageView alloc]initWithFrame:CGRectMake(self.fiveView.frame.size.width/2-30, 0, 60, 15)];
    
    iv1.image =[UIImage imageNamed:@"Bodhiword-mainpage_49 11-27-48-003"];
    
    [fview addSubview:iv1];
    
    UIImageView*iv2 = [[UIImageView alloc]initWithFrame:CGRectMake(20, 20, self.fiveView.frame.size.width-40, 2)];
    iv2.image = [UIImage imageNamed:@"Bodhiword_59"];
    
    [fview addSubview:iv2];
    
    for (int i = 0; i<4; i++) {
        UIButton*btn = [[UIButton alloc]initWithFrame:CGRectMake(self.fiveView.frame.size.width/2-15-2*25+i*35, 30, 25, 25)];
        [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"share0%02d",i+1]] forState:UIControlStateNormal];
        
        [fview addSubview:btn];
        
    }
    
    
    
    
    [self.fiveView addSubview: fview];
    
    
    
    UIView*fiveIVdown=[[UIView alloc]initWithFrame:CGRectMake(0,  80, self.fiveView.frame.size.width, 110)];
    UIImageView*oneIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.fiveView.frame.size.width, 20)];
    oneIV.image = [UIImage imageNamed:@"Bodhiword_76"];
    [fiveIVdown addSubview:oneIV];
    
    UIImageView*twoIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 20, self.fiveView.frame.size.width, self.fiveView.frame.size.height-20)];
    twoIV.image = [UIImage imageNamed:@"Bodhiword_77"];
    [fiveIVdown addSubview:twoIV];
    
    UIButton*fiveBtnLeft=[[UIButton alloc]initWithFrame:CGRectMake(10 , 0, 60, 30)];
    
    
    UIButton*fiveBtnRight=[[UIButton alloc]initWithFrame:CGRectMake(fiveIVdown.frame.size.width-70, 0, 60, 30)];
    
    
    [oneIV addSubview:fiveBtnLeft];
    
    [oneIV addSubview:fiveBtnRight];
    
    [self.fiveView addSubview:fiveIVdown];
    
    [self.view addSubview:self.firstView];
    [self.view addSubview:self.secondView];
    [self.mainSV addSubview:self.thirdView];
    [self.mainSV addSubview:self.fourView];
    [self.mainSV addSubview:self.fiveView];
    

    
    
    CGFloat sizeH = self.thirdView.frame.size.height+
                    self.fourView.frame.size.height+
                    self.fiveView.frame.size.height+30;
    
    CGSize size=CGSizeMake(self.view.frame.size.width, sizeH);
    
    [self.mainSV setContentSize:size];
    
    
    
    
    [self.view addSubview:self.mainSV];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}


//登录 后页面 颜色渐变
-(void)alphaSmall:(CGFloat)newAlpha;
{
    self.firstView.alpha=newAlpha;
    self.secondView.alpha=newAlpha;
    self.thirdView.alpha=newAlpha;
    self.fourView.alpha=newAlpha;
    

}

//loginBtn
-(void)loginBtn:(UIButton *)sender
{
    [self alphaSmall:0.5];
    self.friendBtn.hidden = YES;
    
    
    CGFloat height=self.firstView.frame.size.height+
    self.secondView.frame.size.height+
    self.thirdView.frame.size.height+
    self.fourView.frame.size.height-150;
 
    self.loginView=[[UIView alloc]initWithFrame:CGRectMake(20, 10,  self.view.frame.size.width-40, height)];
    self.loginView.backgroundColor=[UIColor redColor];
    
    //界面
    
    
    UIButton*loginViewBtn=[[UIButton alloc]initWithFrame:CGRectMake(10, self.loginView.frame.size.height-50, 50, 50)];
    loginViewBtn.backgroundColor=[UIColor blueColor];
    [loginViewBtn addTarget:self action:@selector(loginViewBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.loginView addSubview:loginViewBtn];
    
    
    //[self.view addSubview:self.loginView];
    
    


}

#pragma thirdView
-(void)toLearn:(UIButton *)btn
{
    
    self.num  = 2;
    
    [self performSegueWithIdentifier:@"go" sender:nil];


}


-(void)toPlay:(UIButton *)btn
{
    self.num  = 0;
    
    [self performSegueWithIdentifier:@"go" sender:nil];


}





#pragma 注册按钮事件
-(void)loginViewBtn:(UIButton*)sender
{
    [self.loginView removeFromSuperview];
    [self alphaSmall:1.0];
    self.friendBtn.hidden=NO;
    
}


//newFriendBtnView
-(void)newFriendBtnView:(UIButton *)sender
{

    [self alphaSmall:0.5];
    
    CGFloat height=self.firstView.frame.size.height+
    self.secondView.frame.size.height+
    self.thirdView.frame.size.height+
    self.fourView.frame.size.height-150;
    
    self.loginView=[[UIView alloc]initWithFrame:CGRectMake(20, 10,  self.view.frame.size.width-40, height)];
    self.loginView.backgroundColor=[UIColor redColor];
    
    UIButton*loginViewBtn=[[UIButton alloc]initWithFrame:CGRectMake(10, self.loginView.frame.size.height-50, 50, 50)];
    loginViewBtn.backgroundColor=[UIColor blueColor];
    [loginViewBtn addTarget:self action:@selector(loginViewBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.loginView addSubview:loginViewBtn];
    
    
    [self.mainSV addSubview:self.loginView];
    


}

#pragma scrollview

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //更新UIPageControl的当前页
    CGPoint offset = scrollView.contentOffset;
    CGRect bounds = scrollView.frame;
    [self.pageCtrl setCurrentPage:offset.x / bounds.size.width/4];
}









-(void)goSecondView:(UIButton*)btn
{
    self.num  = btn.tag;
    
      [self performSegueWithIdentifier:@"go" sender:nil];
    
 }


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UITabBarController*tbc = segue.destinationViewController;
    [tbc setSelectedIndex:self.num];
    

}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
