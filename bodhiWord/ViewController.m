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
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "RoleViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"

#import "JsonPostModel.h"

@interface ViewController ()<UIScrollViewDelegate>



@property(nonatomic,strong)UIView*firstView;
@property(nonatomic,strong)UIView*secondView;
@property(nonatomic,strong)UIView*thirdView;
@property(nonatomic,strong)UIView*fourView;
@property(nonatomic,strong)UIScrollView*fourSV;
@property(nonatomic,strong)UIPageControl*pageCtrl;

@property(nonatomic,strong)UIButton*scrollRoleBtn;



@property(nonatomic,strong)NSMutableArray*ary;




@property(nonatomic,strong)UIView*fiveView;

@property(nonatomic,strong)UIScrollView*mainSV;

@property(nonatomic,strong)UIView*loginView;

@property(nonatomic,strong)UIButton*friendBtn;

@property(nonatomic)NSInteger num;


@property(nonatomic,strong)UIImage*image;

@property(nonatomic,strong)UserInfo*userInfo;


@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.ary  = [NSMutableArray array];
        
    
    [[JsonPostModel shareJsonPostModel]  requestMainviewRoleImage:^(id obj) {
        NSArray*resultAry = obj;
#pragma 解析
        if (![self.ary isMemberOfClass:[NSNull class]]) {
            
            for (NSDictionary*dicResult in resultAry) {
                
                self.userInfo = [[UserInfo alloc]init];
                self.userInfo.iconUrl = [dicResult objectForKey:@"iconUrl" ];
                self.userInfo.androidLink = [dicResult objectForKey:@"androidLink"];
                self.userInfo.advId = [dicResult objectForKey:@"id"];
                self.userInfo.imgSize = [dicResult objectForKey:@"imgSize"];
                self.userInfo.imgType = [dicResult objectForKey:@"imgType"];
                self.userInfo.iosLink = [dicResult objectForKey:@"iosLink"];
                self.userInfo.adressIP = [dicResult objectForKey:@"ip"];
                self.userInfo.isnew =[dicResult objectForKey:@"isnew"];
                self.userInfo.language = [dicResult objectForKey:@"language"];
                self.userInfo.name = [dicResult objectForKey:@"name"];
                self.userInfo.postion = [dicResult objectForKey:@"postion"];
                self.userInfo.sorting = [dicResult objectForKey:@"sorting"];
                self.userInfo.webLink = [dicResult objectForKey:@"webLink"];
                
                
                [self.ary addObject:self.userInfo];
                
            }
            
        }else{
            NSLog(@"adv  json == nil");
            
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            [self updataUI];
            
  
        });
        
    }];
    
}

-(void)updataUI
{
    
    
//主界面底层是 UIScrollVIew
    self.mainSV=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, self.view.frame.size.height-200)];
    
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
    
    
    
    UIImageView*logoIV=[[UIImageView alloc]initWithFrame:CGRectMake(viewWidth/2-45, 5, 90, 70)];
    logoIV.image=[UIImage imageNamed:@"logo"];
    //logoIV.backgroundColor=[UIColor grayColor];
    
    
    [self.firstView addSubview:loginBtn];
    [self.firstView addSubview: self.friendBtn];
    [self.firstView addSubview:logoIV];
    
    
//secondView
    self.secondView=[[UIView alloc]initWithFrame:CGRectMake(0, 104,  viewWidth,100)];
    
//    self.secondView.backgroundColor = [UIColor redColor];
    
//play watch learn create 按钮
    
    for (int i = 0; i<4; i++) {
        //左边 10  右边 5 间距 5
        CGFloat btnWidth= (viewWidth-10-5-20)/4;
        
        UIView*btnView = [[UIView alloc]initWithFrame:CGRectMake(10+i*(btnWidth+5), 10, btnWidth, btnWidth)];
        UIImageView*iv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, btnView.frame.size.width, btnView.frame.size.height)];
        iv.image = [UIImage imageNamed:[NSString stringWithFormat:@"btn_bg_0%d",i+1]];
        
        [btnView addSubview:iv];
        
        
        
        
        
        UIButton*studyBtn=[[UIButton alloc]initWithFrame:CGRectMake(5, 0, btnView.frame.size.width-10, btnView.frame.size.height-10)];
        
        
     
        [studyBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"icon_0%d",i+1]] forState:UIControlStateNormal];
        
        studyBtn.tag=i;
        
        [studyBtn addTarget:self action:@selector(goSecondView:) forControlEvents:UIControlEventTouchUpInside];
        
        studyBtn.tag=i;//  为添加背景图片
        
        [btnView addSubview:studyBtn];
        
        UIImageView*textIv =[[ UIImageView alloc]initWithFrame:CGRectMake(5, btnView.frame.size.height-15, btnView.frame.size.width-10, 15)];
        textIv.image = [UIImage imageNamed:[NSString stringWithFormat:@"text_0%d",i+1]];
        
        [btnView addSubview:textIv];
        
        
        
        [self.secondView addSubview:btnView];
        
        
        
    }
    
    UIView*dView =[[UIView alloc]initWithFrame:CGRectMake(0, self.secondView.frame.size.height-10, self.secondView.frame.size.width, 10)];
    
    UIImageView*dIV1=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, dView.frame.size.width, 10)];
    dIV1.image = [UIImage imageNamed:@"top_shadow.jpg"];
    [dView addSubview:dIV1];
    UIImageView*dIV2=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, dView.frame.size.width, 5)];
    dIV2.image = [UIImage imageNamed:@"top_shadow2.jpg"];
    [dView addSubview:dIV2];
    
    [self.secondView addSubview:dView];
    
    
 //mianSV
//thirdView
    self.thirdView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,  viewWidth,450)];
//    self.thirdView.backgroundColor = [UIColor grayColor];
    
    
    
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
        
        
        
        
        self.scrollRoleBtn=[[UIButton alloc]initWithFrame:CGRectMake(i*m, 0, m, self.fourSV.frame.size.height)];
        
        self.scrollRoleBtn.tag = i;
 
        [self.scrollRoleBtn sd_setImageWithURL:[NSURL URLWithString:userInfo.iconUrl] forState:UIControlStateNormal];
        [self.scrollRoleBtn addTarget:self action:@selector(scrollRoleBtnToRole:) forControlEvents:UIControlEventTouchUpInside];

        
        
        [self.fourSV  addSubview:self.scrollRoleBtn];
               
    }

    //NSInteger n = (self.ary.count%4 == 0)?(self.ary.count/4) : (self.ary.count/4+1);
    [self.fourSV  setContentSize:CGSizeMake(self.ary.count*m, self.fourSV.frame.size.height)];
//    [self.fourSV addSubview:self.iv];
    
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
    self.fiveView=[[UIView alloc]initWithFrame:CGRectMake(0, 520,  viewWidth,130)];
    
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
    
    
    
    
    UIView*fiveIVdown=[[UIView alloc]initWithFrame:CGRectMake(0,  80, self.fiveView.frame.size.width, 50)];
    
    
    UIImageView*oneIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.fiveView.frame.size.width, 20)];
    oneIV.image = [UIImage imageNamed:@"Bodhiword_76"];
    [fiveIVdown addSubview:oneIV];
    
    UIImageView*twoIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 20, self.fiveView.frame.size.width, 30)];
    twoIV.image = [UIImage imageNamed:@"Bodhiword_77"];
    [fiveIVdown addSubview:twoIV];
    
    UIButton*fiveBtnLeft=[[UIButton alloc]initWithFrame:CGRectMake(5 , 0, 60, 20)];
//    fiveBtnLeft.backgroundColor = [UIColor blackColor];
    [fiveBtnLeft addTarget:self action:@selector(fiveBtnLeft:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    
    
    UIButton*fiveBtnRight=[[UIButton alloc]initWithFrame:CGRectMake(fiveIVdown.frame.size.width-70, 0, 65, 20)];
    
//    fiveBtnRight.backgroundColor = [UIColor blackColor];
    [fiveBtnRight addTarget:self action:@selector(fiveBtnRight:) forControlEvents:UIControlEventTouchUpInside];
    
    [fiveIVdown addSubview:fiveBtnLeft];
    
    [fiveIVdown addSubview:fiveBtnRight];
    
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


#pragma 关于我们
-(void)fiveBtnLeft:(UIButton*)sender{
    
    UIAlertView*av = [[UIAlertView alloc]initWithTitle:@"CITSZ" message:@"功能确定中..." delegate:self cancelButtonTitle:nil otherButtonTitles:@"ok", nil];

    [av show];

}

-(void)fiveBtnRight:(UIButton*)sender{
    UIAlertView*av = [[UIAlertView alloc]initWithTitle:@"Contact US" message:@"功能确定中..." delegate:self cancelButtonTitle:nil otherButtonTitles:@"ok", nil];
    
    [av show];

}





#pragma scrollRoleBtnToRole
-(void)scrollRoleBtnToRole:(UIButton*)sender
{
    NSLog(@"%ld",(long)sender.tag);
    self.num = 4;
    [self performSegueWithIdentifier:@"go" sender:nil];
    ((AppDelegate*)[UIApplication sharedApplication].delegate).roleNum = sender.tag;
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
    
    
    
    
    [self performSegueWithIdentifier:@"login" sender:nil];
    


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
    
    if ([segue.identifier isEqualToString:@"go"]) {
        
    
    UITabBarController*tbc = segue.destinationViewController;
    [tbc setSelectedIndex:self.num];
    }else if([segue.identifier isEqualToString:@"login"]){
    
        LoginViewController*lvc = segue.destinationViewController;
        
        
    
    }
    
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
