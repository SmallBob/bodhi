//
//  SecondViewController.m
//  bodhiWord
//
//  Created by apple on 14/11/28.
//  Copyright (c) 2014年 apple. All rights reserved.
//



#import "JsonPostModel.h"

#import "playUserInfo.h"
#import "playEdAppDetailAppUserInfo.h"
#import "playEdAppDetailAppImgUserInfo.h"
#import "playSocialDetailSocial.h"
#import "playSocialDetailSocialImg.h"
#import "playSocialUserInfo.h"
#import "SecondViewController.h"

#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"




#import "ViewController.h"
@interface SecondViewController ()<UIScrollViewDelegate>


@property(nonatomic,strong)UIScrollView*firstSV;
@property(nonatomic,strong)UIView*changeView;
@property(nonatomic,strong)UIView*viewFirst;
@property(nonatomic,strong)UIView*viewRight;
@property(nonatomic,strong)UIView*clickView;

@property(nonatomic,strong)UIView*rightClickView;
@property(nonatomic,strong)UIPageControl*pageCtrl;


@property(nonatomic,strong)UIButton*contentBtn;


@property(nonatomic,strong)NSMutableArray*ary;
//@property(nonatomic,strong)NSMutableArray*rightSegmentAry;

@property(nonatomic,strong)UISegmentedControl *segmentedControl ;
@property(nonatomic,strong)JsonPostModel*jpm;

@property(nonatomic,strong)NSMutableArray*playEdAppDetailAppAry;
@property(nonatomic,strong)NSMutableArray*playEdAppDetailAppImgAry;
@property(nonatomic,strong)NSMutableArray*playSocialAry;

@property(nonatomic,strong)NSMutableArray*playSocialDetailSocialAry;
@property(nonatomic,strong)NSMutableArray*playSocialDetailSocialImgAry;



@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.hidden = YES;
    //  添加主界面点击按钮
    [self creatBackBtn];
//    NSLog(@"%d",self.view.subviews.count);
    
    
 }


-(void)UIUpdate
{
    [self creatLeftView];
    [self creatRightView];
    
    self.viewRight.hidden= YES;
    self.clickView.hidden = YES;
    self.rightClickView .hidden = YES;
    self.viewFirst.hidden = NO;
    
    UIImage*image1=[UIImage imageNamed:@"leftRight.png"] ;
    self.segmentedControl = [[UISegmentedControl alloc]initWithItems:@[@"",@""]];
    [self.segmentedControl addTarget:self action:@selector(changedSegment:) forControlEvents:UIControlEventValueChanged];
    
    [self.segmentedControl setSelectedSegmentIndex:0];
    
    
    self.segmentedControl.frame = CGRectMake(0, 95, self.view.frame.size.width, 30);
    
    [self.segmentedControl setBackgroundImage:image1 forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [self.view addSubview:self.segmentedControl];

}



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   
    
    if (!self.jpm) {
        
        self.jpm = [JsonPostModel shareJsonPostModel];
        self.ary = [NSMutableArray array];
        self.playSocialAry =[NSMutableArray array];
    

  
        
//界面显示时 点击刷新重载数据   segment==0
    [self.jpm requestPlayViewData:^(id obj) {

        NSArray*appAry = obj;

        
        if (![appAry isMemberOfClass:[NSNull class]]) {
            
            for (NSDictionary*dicApp  in appAry) {
                playUserInfo*pui = [[playUserInfo alloc]init];
                pui.playLeftViewIconUrl = [dicApp objectForKey:@"iconUrl"];
                pui.leftSegmenttitle = [dicApp objectForKey:@"title"];
                pui.leftSegmenttype = [dicApp objectForKey:@"type"];
                pui.leftSegmentId = [dicApp objectForKey:@"id"];
//                NSLog(@"puiID::::%@",pui.leftSegmentId);
                [self.ary addObject:pui];

            }
        }
       
        dispatch_async(dispatch_get_main_queue(), ^{
           
           [self UIUpdate];
        });
    }];
//    segment==1 右边试图
        [self.jpm requestPlayViewSegmentRightView:^(id obj) {
            NSArray*socialAry = obj;
            
            if (![socialAry isMemberOfClass:[NSNull class]]) {
                
                for (NSDictionary*dicSocial in socialAry) {
                    playSocialUserInfo*psUser=[[playSocialUserInfo alloc]init];
                    psUser.describes = [dicSocial objectForKey:@"describes"];
                    psUser.iconUrl = [dicSocial objectForKey:@"iconUrl"];
                    psUser.playSociaID = [dicSocial objectForKey:@"id"];
                    psUser.keywords = [dicSocial objectForKey:@"keywords"];
                    psUser.title = [dicSocial objectForKey:@"title"];
                    
                    [self.playSocialAry addObject:psUser];
                }
            }
            
        }];
        
        
        
        
        
    }else {
        if (!self.viewFirst) {

            [self UIUpdate];
            
        }else {
            
            self.viewFirst.hidden =NO;
        [self.segmentedControl setSelectedSegmentIndex:0];
        [self changedSegment:self.segmentedControl];
            
            
        }

        
    }

}



//创建返回按钮
-(void)creatBackBtn
{
    
    UIButton*backBtn=[[UIButton alloc]initWithFrame:CGRectMake(10, 34, 80, 60)];
    [backBtn setImage:[UIImage imageNamed:@"screenTitle.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backMainView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    
    
    UIButton*studyBtn;
    for (int i = 0; i<4; i++) {
        //左边 10  右边 5 间距 5
        CGFloat btnWidth= (self.view.frame.size.width-100-5-20)/4;
        
        studyBtn=[[UIButton alloc]initWithFrame:CGRectMake(90+i*(btnWidth+5), 34, btnWidth, 55)];
        studyBtn.tag=i;
        [studyBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"play_0%d.png",i]] forState:UIControlStateNormal];
        [studyBtn addTarget:self action:@selector(goSecondView:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:studyBtn];
        
        
    }


}

//返回主界面方法
-(void)backMainView:(UIButton*)sender
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
   
    
}


#pragma secondeView

-(void)goSecondView:(UIButton*)btn
{
//     NSLog(@"%d",self.view.subviews.count);
    [self.tabBarController setSelectedIndex:btn.tag];
    
    if (btn.tag==0) {
        
      // 在当前界面 点击 当前显示界面按钮  就行界面刷新
        [self.viewFirst removeFromSuperview];
        [self.clickView removeFromSuperview];
        [self.rightClickView removeFromSuperview];
        [self.viewRight removeFromSuperview];
        
        [self.segmentedControl removeFromSuperview];
        

//      清除图片缓存
        
//        [[SDImageCache sharedImageCache] cleanDisk];
//       [[SDImageCache sharedImageCache] clearDisk];
//       [[SDImageCache sharedImageCache] clearMemory];
//        NSLog(@"%@",NSHomeDirectory());
        
        
        [self.jpm requestPlayViewData:^(id obj) {
            NSArray*appAry = obj;
            
            self.ary = [NSMutableArray array];
            
            if (![appAry isMemberOfClass:[NSNull class]]) {
                
                for (NSDictionary*dicApp  in appAry) {
                    playUserInfo*pui = [[playUserInfo alloc]init];
                    pui.playLeftViewIconUrl = [dicApp objectForKey:@"iconUrl"];
                    pui.leftSegmenttitle = [dicApp objectForKey:@"title"];
                    pui.leftSegmenttype = [dicApp objectForKey:@"type"];
                    pui.leftSegmentId = [dicApp objectForKey:@"id"];
                    
                    [self.ary addObject:pui];
                                   }
                
            }
            
            
            
            
            dispatch_async(dispatch_get_main_queue(), ^{

                
                [self UIUpdate];
            });
        }];

        //    segment==1 右边试图
        [self.jpm requestPlayViewSegmentRightView:^(id obj) {
            NSArray*socialAry = obj;
            self.playSocialAry = [NSMutableArray array ];
            if (![socialAry isMemberOfClass:[NSNull class]]) {
                
                for (NSDictionary*dicSocial in socialAry) {
                    playSocialUserInfo*psUser=[[playSocialUserInfo alloc]init];
                    psUser.describes = [dicSocial objectForKey:@"describes"];
                    psUser.iconUrl = [dicSocial objectForKey:@"iconUrl"];
                    psUser.playSociaID = [dicSocial objectForKey:@"id"];
                    psUser.keywords = [dicSocial objectForKey:@"keywords"];
                    psUser.title = [dicSocial objectForKey:@"title"];
                    
                    [self.playSocialAry addObject:psUser];
                }
            }
            
        }];
    }
    
//    NSLog(@"%d",self.view.subviews.count);
}




-(void)creatLeftView;
{

    
            self.viewFirst  =[[UIView alloc]initWithFrame:CGRectMake(0, 95, self.view.frame.size.width, self.view.frame.size.height-95)];
    
            self.firstSV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 30, self.view.frame.size.width , self.view.frame.size.height-95)];
            self.firstSV.showsHorizontalScrollIndicator=YES;
            
            //弹簧效果
            self.firstSV.bounces=NO;

            
            UIScrollView*leftRightSV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,170)];
            
            UIImageView*iv = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"play_01mainpage_20141105_21.png"]];
            iv.frame=leftRightSV.frame;
            [leftRightSV addSubview:iv];
#pragma 左右滚动
            
            [self.firstSV addSubview:leftRightSV];
            
            
            
#pragma people
            CGFloat peopleWidth = (self.view.frame.size.width-60)/2;
    
            for (int i = 0; i<self.ary.count; i++) {
                
                UIView*view=[[UIView alloc]initWithFrame:CGRectMake(20+i%2*(peopleWidth+20),
                                                                   190+i/2*150,
                                                                   peopleWidth,
                                                                   140)];
                
                
                UIButton*btn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height-30)];
                
                btn.tag = i;
                
                
                
                
               // self.ary[i]   peopleAll.png
                playUserInfo*userInfo = self.ary[i];
        
              
                
                
                [btn sd_setImageWithURL:[NSURL URLWithString:userInfo.playLeftViewIconUrl] forState:UIControlStateNormal];

//                NSLog(@"%@",userInfo.leftSegmentId);
                
                [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
                
               
                [view addSubview:btn];
                
                UIImageView*iv=[[UIImageView alloc]initWithFrame:CGRectMake(0, view.frame.size.height-30, 30, 30)];
                iv.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:userInfo.leftSegmenttype]]];
                [view addSubview:iv];
                
                UILabel*label = [[UILabel alloc]initWithFrame:CGRectMake(30, view.frame.size.height-30, view.frame.size.width-30, 30)];
                label.text = userInfo.leftSegmenttitle;
                label.font = [UIFont systemFontOfSize:10];
                label.textColor = [UIColor blueColor];
                [view addSubview:label];
                
               // view.backgroundColor = [UIColor clearColor];
                
                [self.firstSV addSubview:view];
                 
            }
            
           
                        
    
    
    
    
    UIView*fiveIVdown=[[UIView alloc]initWithFrame:CGRectMake(0,
                                                              10+leftRightSV.frame.size.height+
                                                              (self.ary.count%2 == 0 ?  20+self.ary.count/2*150 :  20+(self.ary.count/2+1)*150) , self.firstSV.frame.size.width, 80)];
    UIImageView*oneIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
    oneIV.image = [UIImage imageNamed:@"Bodhiword_76"];
    [fiveIVdown addSubview:oneIV];
    
    UIImageView*twoIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height-20)];
    twoIV.image = [UIImage imageNamed:@"Bodhiword_77"];
    [fiveIVdown addSubview:twoIV];
    
    UIButton*fiveBtnLeft=[[UIButton alloc]initWithFrame:CGRectMake(10 , 0, 60, 30)];
    
    
    UIButton*fiveBtnRight=[[UIButton alloc]initWithFrame:CGRectMake(fiveIVdown.frame.size.width-70, 0, 60, 30)];
    
    [oneIV addSubview:fiveBtnLeft];
    [oneIV addSubview:fiveBtnRight];
    
    [self.firstSV addSubview:fiveIVdown];

 
            CGFloat btnHeght = self.ary.count%2 == 0 ?  20+self.ary.count/2*150 :  20+(self.ary.count/2+1)*150;
            
            CGFloat height  =leftRightSV.frame.size.height+
                              btnHeght+110;
            
    
            [self.firstSV setContentSize:CGSizeMake(self.firstSV.frame.size.width, height)];
            
           
            [self.viewFirst addSubview:self.firstSV];
            
            [self.view addSubview: self.viewFirst];
    
    

}


#pragma segment
-(void)changedSegment :(UISegmentedControl*)sender
{


    switch (sender.selectedSegmentIndex) {
        case 0:
        {
            self.firstSV.hidden = NO;
            self.viewRight.hidden = YES;
            self.clickView.hidden = YES;
            self.rightClickView.hidden = YES;
        }
            break;
        case 1:
        {
            
            self.firstSV.hidden =YES;
            self.viewRight.hidden = NO;
            self.clickView.hidden = YES;
            
            
                }
            break;
            
        default:
            break;
    }



}




#pragma click
-(void)click:(UIButton*)sender
{
    self.playEdAppDetailAppAry =[NSMutableArray array];
    self.playEdAppDetailAppImgAry = [NSMutableArray array];
    
    
    self.viewFirst.hidden = YES;
    self.clickView = [[UIView alloc]initWithFrame:CGRectMake(0, 95, self.view.frame.size.width, self.view.frame.size.height-95)];
        UIView*viewF=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    
    UIImageView*imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    imageView.image =[UIImage imageNamed:@"play_03bodhirace_20141105_02"];
    
    
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 30)];
    [btn setImage:[UIImage imageNamed:@"play_03bodhirace_20141105_03.png"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(backLeftView:) forControlEvents:UIControlEventTouchUpInside];
    
    [viewF addSubview:imageView];
    [viewF addSubview:btn];
    
    
    playUserInfo*userInfo = self.ary[sender.tag];
    
    [self.jpm requestPlayViewedAppDetailWithParams:userInfo.leftSegmentId and:^(id obj) {
        
        
        NSDictionary*dic = obj;
        //        app
        NSArray*appAry= [dic objectForKey:@"app"];
        
        for (NSDictionary*dic in appAry)
        {
            playEdAppDetailAppUserInfo*playEdappDetail =[[playEdAppDetailAppUserInfo alloc]init];
            playEdappDetail.iconUrl = [dic objectForKey:@"iconUrl"];
            playEdappDetail.type = [dic objectForKey:@"type"];
            playEdappDetail.title = [dic objectForKey:@"title"];
            playEdappDetail.appID = [dic objectForKey:@"id"];
            
            
            [self.playEdAppDetailAppAry addObject:playEdappDetail];
            
        }
        //   appImg
        NSArray*appImgAry = [dic objectForKey:@"appImg"];
        for (NSDictionary*dicAppImg in appImgAry) {
            playEdAppDetailAppImgUserInfo*playAppImg = [[playEdAppDetailAppImgUserInfo alloc]init];
            playAppImg.imgUrl = [dicAppImg objectForKey:@"imgUrl"];
            playAppImg.appImgID = [dicAppImg objectForKey: @"appId"];
            
            [self.playEdAppDetailAppImgAry addObject:playAppImg];
            
            
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            playEdAppDetailAppUserInfo*appUserInfo = [self.playEdAppDetailAppAry lastObject];
            
            
            UIImageView*peopleIV = [[UIImageView alloc]initWithFrame:CGRectMake(20, 50, 80, 80)];
            
            peopleIV.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:appUserInfo.iconUrl]]];
            
            UIImageView*smallIV=[[UIImageView alloc]initWithFrame:CGRectMake(105, 60, 30, 30)];
            
            smallIV.image =[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:appUserInfo.type]]];
            
            
            
            UILabel*label = [[UILabel alloc]initWithFrame:CGRectMake(135, 60, 100, 30)];
            label.text = appUserInfo.title;
            label.font = [UIFont systemFontOfSize:10];
            label.textColor = [UIColor blueColor];
            
            
            UIButton*playBtn=[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-20-100, 100, 100, 30)];
            [playBtn setImage:[UIImage imageNamed:@"play_03bodhirace_20141105_15.png"] forState:UIControlStateNormal];
            
            
            [self.clickView addSubview:peopleIV];
            [self.clickView addSubview:smallIV];
            [self.clickView addSubview:label];
            [self.clickView addSubview:playBtn];
            
            
            
            UIView*fiveIVdown=[[UIView alloc]initWithFrame:CGRectMake(0, self.clickView.frame.size.height-50, self.clickView.frame.size.width, 80)];
            UIImageView*oneIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
            oneIV.image = [UIImage imageNamed:@"Bodhiword_76"];
            [fiveIVdown addSubview:oneIV];
            
            UIImageView*twoIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height-20)];
            twoIV.image = [UIImage imageNamed:@"Bodhiword_77"];
            [fiveIVdown addSubview:twoIV];
            
            UIButton*fiveBtnLeft=[[UIButton alloc]initWithFrame:CGRectMake(10 , 0, 60, 20)];
            
            
            UIButton*fiveBtnRight=[[UIButton alloc]initWithFrame:CGRectMake(fiveIVdown.frame.size.width-70, 0, 60, 20)];
            
            
            
            [oneIV addSubview:fiveBtnLeft];
            [oneIV addSubview:fiveBtnRight];
            
            [self.clickView addSubview:fiveIVdown];
            
            
            CGFloat height =self.clickView.frame.size.height - fiveIVdown.frame.size.height - 10 - 220;
            
            
            UIView*svView =[[UIView alloc]initWithFrame:CGRectMake(10, self.clickView.frame.size.height - fiveIVdown.frame.size.height - 10 - 220, self.view.frame.size.width-20, 220)];
            
            UIScrollView*sv  =[[UIScrollView alloc]initWithFrame:CGRectMake(0,0,svView.bounds.size.width,svView.bounds.size.height)];
            sv.pagingEnabled = YES;
            sv.bounces = NO;
            sv.showsHorizontalScrollIndicator= NO;
            sv.delegate = self;
            
            
            for (int i= 0; i<self.playEdAppDetailAppImgAry.count; i++) {
                
                
                playEdAppDetailAppImgUserInfo*playImg = self.playEdAppDetailAppImgAry[i];
                
                
                
                UIImageView*svView=[[UIImageView alloc]initWithFrame:CGRectMake(sv.bounds.size.width*i, 0, sv.frame.size.width, sv.frame.size.height)];
                

                
                svView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:playImg.imgUrl]]];
                
                
                [sv addSubview:svView];
            }
            
            
            
            
            
#pragma gundong
            
            [sv setContentSize:CGSizeMake(sv.frame.size.width*self.playEdAppDetailAppImgAry.count, sv.frame.size.height)];
            
            [svView addSubview:sv];
            
            //创建UIPageControl
            self. pageCtrl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, svView.frame.size.height-20, svView.bounds.size.width-20, 20)];  //创建UIPageControl，位置在屏幕最下方。
            
            self.pageCtrl.numberOfPages = self.playEdAppDetailAppImgAry.count;
            self.pageCtrl.currentPage = 0;

            self.pageCtrl.pageIndicatorTintColor = [UIColor blueColor];
            self.pageCtrl.currentPageIndicatorTintColor = [UIColor redColor];
            
            
            
//            [self.changeView addSubview:self.pageCtrl];
            
            [svView addSubview:self.pageCtrl];
            
            
            
            [self.clickView addSubview:svView];
            
            [self.clickView addSubview:viewF];
            [self.view addSubview:self.clickView];

            
        });
        
    }];
    
   
}
//???????
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGPoint offset = scrollView.contentOffset;
    CGRect bounds =scrollView.frame;
    [self.pageCtrl setCurrentPage:offset.x/(bounds.size.width)];
    
    
}

#pragma backLeftView

-(void)backLeftView:(UIButton *)sender
{
   
    self.clickView.hidden = YES;
    self.viewFirst.hidden = NO;
}



-(void)creatRightView
{
     self.viewRight  =[[UIView alloc]initWithFrame:CGRectMake(0, 125, self.view.frame.size.width, self.view.frame.size.height-95)];
  
    
#pragma 右试图
 
    
    for (int i = 0; i<self.playSocialAry.count; i++) {
        
        playSocialUserInfo*psUser = self.playSocialAry[i];
        
        UIView*view = [[UIView alloc]initWithFrame:CGRectMake(0, i*100, self.view.frame.size.width, 100)];
        CGFloat height = view.frame.size.height - 20;
        
        UIButton*iv1 = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, height, height)];
        
        UIImage* image =[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:psUser.iconUrl]]];
        iv1.tag = i;
        [iv1 setImage:image forState:UIControlStateNormal];
        
        [iv1 addTarget:self action:@selector(rightBtnView:) forControlEvents:UIControlEventTouchUpInside];
        
        [view addSubview:iv1];
        
        UILabel*label = [[UILabel alloc]initWithFrame:CGRectMake(height+20, 30, view.frame.size.width-height-30, height)];
        label.text = psUser.describes;
        label.font = [UIFont systemFontOfSize:12];
        label.textColor = [UIColor blueColor];
        CGSize labelSize = {0,0};
        labelSize = [label.text sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(view.frame.size.width-height-30, height) lineBreakMode: UILineBreakModeWordWrap];
        label.numberOfLines = 3;
        
        
        [view addSubview:label];

        UILabel*label2 =[[UILabel alloc]initWithFrame:CGRectMake(height+30, 10, view.bounds.size.width-height-20, 20)];
        label2.text = psUser.title;
        label2.font = [UIFont systemFontOfSize:12];
        label2.textColor = [UIColor blueColor];
        
        CGSize labelSize2 = {0.0};
        labelSize2 = [label2.text sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(150, 60) lineBreakMode:UILineBreakModeWordWrap];
        label2.numberOfLines = 2;
        label2.frame = CGRectMake(label2.frame.origin.x, label2.frame.origin.y, labelSize2.width, labelSize2.height);
        
        
        
        
        [view addSubview:label2];
        
        [self.viewRight addSubview:view];
        
        
    }
    
    
    UIView*fiveIVdown=[[UIView alloc]initWithFrame:CGRectMake(0,
                                                                   self.viewRight.frame.size.height-100, self.viewRight.frame.size.width, 80)];
    UIImageView*oneIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
    oneIV.image = [UIImage imageNamed:@"Bodhiword_76"];
    [fiveIVdown addSubview:oneIV];
    
    UIImageView*twoIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height-20)];
    twoIV.image = [UIImage imageNamed:@"Bodhiword_77"];
    [fiveIVdown addSubview:twoIV];
    
    UIButton*fiveBtnLeft=[[UIButton alloc]initWithFrame:CGRectMake(10 , 0, 60, 30)];
    
    
    UIButton*fiveBtnRight=[[UIButton alloc]initWithFrame:CGRectMake(fiveIVdown.frame.size.width-70, 0, 60, 30)];
    
    [oneIV addSubview:fiveBtnLeft];
    [oneIV addSubview:fiveBtnRight];
    
    
    
    [self.viewRight addSubview:fiveIVdown];

    
    [self.view addSubview:self.viewRight];
    
    
    


    



}

    



#pragma 右视图点击试图
-(void)rightBtnView:(UIButton*)sender
{
    self.viewRight.hidden = YES;
    self.playSocialDetailSocialImgAry = [NSMutableArray array];
    self.playSocialDetailSocialAry =[NSMutableArray array];
    
    playSocialUserInfo*psUser = self.playSocialAry[sender.tag];
    
    [self.jpm requestPlayViewSocialWithParams:psUser.playSociaID andCallBack:^(id obj) {
        
        NSDictionary*dic = obj;
        //        social
        NSArray*socialAry= [dic objectForKey:@"social"];
        
        for (NSDictionary*dic in socialAry)
        {
            playSocialDetailSocial*psds =[[playSocialDetailSocial alloc]init];
            psds.iconUrl = [dic objectForKey:@"iconUrl"];
            psds.describes = [dic objectForKey:@"describes"];
            psds.title = [dic objectForKey:@"title"];
            psds.socialDetailSocialID = [dic objectForKey:@"id"];
            psds.age =[dic objectForKey:@"age"];
            
            
            [self.playSocialDetailSocialAry addObject:psds];
            
        }
        //   socialImg
        NSArray*socialImgAry = [dic objectForKey:@"socialImg"];
        for (NSDictionary*dicAppImg in socialImgAry) {
            playSocialDetailSocialImg*playAppImg = [[playSocialDetailSocialImg alloc]init];
            playAppImg.imgUrl = [dicAppImg objectForKey:@"imgUrl"];
            playAppImg.appID = [dicAppImg objectForKey: @"appId"];
            
            [self.playSocialDetailSocialImgAry addObject:playAppImg];
            
            
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            self.rightClickView = [[UIView alloc]initWithFrame:CGRectMake(0, 65, self.view.frame.size.width, self.view.frame.size.height-95)];
            
            UIView*view = [[UIView alloc]initWithFrame:CGRectMake(0, 30, self.view.frame.size.width, 30)];
            UIImageView*imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
            imageView.image =[UIImage imageNamed:@"play_03bodhirace_20141105_02"];
            
            
            
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 30)];
            [btn setImage:[UIImage imageNamed:@"play_03bodhirace_20141105_03.png"] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(backRightView:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:imageView];
            [view addSubview:btn];
            [self.rightClickView addSubview:view];
            
            
            
            playSocialDetailSocial*psds = [self.playSocialDetailSocialAry lastObject];
            
            UIImageView*peopleIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 70, 80, 80)];
            
            

            peopleIV.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:psds.iconUrl]]];
        
            UILabel*labelName = [[UILabel alloc]initWithFrame:CGRectMake(105, 70, self.rightClickView.frame.size.width-115, 50)];
            
            labelName.text = psds.title;
            labelName.font = [UIFont systemFontOfSize:12];
            labelName.textColor = [UIColor blueColor];
            CGSize labelSize = {0,0};
            labelSize = [labelName.text sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(self.rightClickView.frame.size.width-115, 50) lineBreakMode: UILineBreakModeWordWrap];
            labelName.numberOfLines = 2;
            
            [self.rightClickView addSubview:labelName];
            UILabel*labelAge = [[UILabel alloc]initWithFrame:CGRectMake(105, 120, self.rightClickView.frame.size.width-115, 30)];
            labelAge.text = [NSString stringWithFormat:@"Target age:%@",psds.age];
            labelAge.textColor = [UIColor greenColor];
            CGSize labelAgeSize = {0,0};
            labelAgeSize = [labelAge.text sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(self.rightClickView.frame.size.width-115, 50) lineBreakMode: UILineBreakModeWordWrap];
            labelName.numberOfLines = 2;
            
            [self.rightClickView addSubview:labelAge];
            
            

            UITextView*textView = [[UITextView alloc]initWithFrame:CGRectMake(10, 150, self.rightClickView.frame.size.width-20, 100)];
            textView.text = psds.describes;
            textView.textColor = [UIColor blackColor];
            textView.editable = NO;
            textView.selectable= NO;
            
            
            [self.rightClickView addSubview:textView];
            
            
            UIView*svView =[[UIView alloc]initWithFrame:CGRectMake(10, 260, self.rightClickView.frame.size.width-20, 150)];
            
            UIScrollView*sv = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, svView.frame.size.width, svView.frame.size.height)];
            
            sv.pagingEnabled = YES;
            sv.bounces = NO;
            sv.showsHorizontalScrollIndicator= NO;
            sv.delegate = self;
            
            
            for (int i = 0; i<self.playSocialDetailSocialImgAry.count; i++) {
                playSocialDetailSocialImg*imgUser = self.playSocialDetailSocialImgAry[i];
                
                UIImageView*iv =[[UIImageView alloc]initWithFrame:CGRectMake(i*sv.frame.size.width, 0, sv.bounds.size.width, sv.bounds.size.height)];
                [iv sd_setImageWithURL:[NSURL URLWithString:imgUser.imgUrl]];
                
                
                [sv addSubview:iv];
            }
            
            [sv setContentSize:CGSizeMake(self.playEdAppDetailAppImgAry.count * sv.frame.size.width, 150)];
            
            [svView addSubview:sv];
            
            [self.rightClickView addSubview:svView];

            [self.rightClickView addSubview:peopleIV];
            
            
            
            //创建UIPageControl
            self. pageCtrl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, svView.frame.size.height-20, svView.bounds.size.width-20, 20)];  //创建UIPageControl，位置在屏幕最下方。
            
            self.pageCtrl.numberOfPages = self.playEdAppDetailAppImgAry.count;
            self.pageCtrl.currentPage = 0;
            
            self.pageCtrl.pageIndicatorTintColor = [UIColor blueColor];
            self.pageCtrl.currentPageIndicatorTintColor = [UIColor redColor];
            
            
            

            
            [svView addSubview:self.pageCtrl];

            [self.rightClickView addSubview:svView];
            
            
            
            
            
            
            
            
            
            
            
            UIImageView*fiveIVdown=[[UIImageView alloc]initWithFrame:CGRectMake(0,
                                                                                self.self.rightClickView.frame.size.height-50, self.rightClickView.frame.size.width, 80)];
            fiveIVdown.image=[UIImage imageNamed:@"Bodhiword_.png"];
            
            
            
            UIButton*fiveBtnLeft=[[UIButton alloc]initWithFrame:CGRectMake(10 , 0, 60, 30)];
            [fiveBtnLeft setImage:[UIImage imageNamed:@"Bodhiword_35.png"] forState:UIControlStateNormal];
            
            
            UIButton*fiveBtnRight=[[UIButton alloc]initWithFrame:CGRectMake(fiveIVdown.frame.size.width-70, 0, 60, 30)];
            [fiveBtnRight setImage:[UIImage imageNamed:@"Bodhiword_37.png"] forState:UIControlStateNormal];
            
            
            
            [fiveIVdown addSubview:fiveBtnLeft];
            
            [fiveIVdown addSubview:fiveBtnRight];
            
            
            [self.rightClickView addSubview:fiveIVdown];
            
            [self.view addSubview:self.rightClickView];

            
            
        });
        
        
    }];
    
    
    
   
}


-(void)backRightView:(UIButton*)sender
{
    self.rightClickView.hidden = YES;
    self.viewRight.hidden = NO;
    

}


    







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
