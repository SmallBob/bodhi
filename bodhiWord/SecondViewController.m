//
//  SecondViewController.m
//  bodhiWord
//
//  Created by apple on 14/11/28.
//  Copyright (c) 2014年 apple. All rights reserved.
//



#import "JsonPostModel.h"

#import "playUserInfo.h"
#import "playEdAppListAdvUserInfo.h"
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


@property(nonatomic,strong)UISegmentedControl *segmentedControl ;
@property(nonatomic,strong)JsonPostModel*jpm;

@property(nonatomic,strong)UIButton*advBtn;
@property(nonatomic,strong)NSMutableArray*playEdAppListAdvAry;
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

    
    
 }


-(void)UIUpdate
{
    
//    [self creatRightView];
    
    [self creatLeftView];
    
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
        self.playEdAppListAdvAry = [NSMutableArray array ];

  
        
//界面显示时 点击刷新重载数据   segment==0
    [self.jpm requestPlayViewData:^(id obj) {

        NSDictionary*dic = obj;
        
        NSArray*appAry = [dic objectForKey:@"app"];
        
        NSArray*advAry = [dic objectForKey:@"adv"];
//        NSLog(@"%@",advAry);
        
        if (![advAry isMemberOfClass:[NSNull class]]) {
            for (NSDictionary*dicAdv in advAry) {
                
                playEdAppListAdvUserInfo*advUserInfo = [[playEdAppListAdvUserInfo alloc]init];
                advUserInfo.iconUrl = [dicAdv objectForKey:@"iconUrl"];
                advUserInfo.advID = [dicAdv objectForKey:@"id"];
                advUserInfo.imgSize = [dicAdv objectForKey:@"imgSize"];
                advUserInfo.imgType = [dicAdv objectForKey:@"imgType"];
                advUserInfo.iosLink = [dicAdv objectForKey:@"iosLink"];
                advUserInfo.ip = [dicAdv objectForKey:@"ip"];
                advUserInfo.language =[dicAdv objectForKey:@"language"];
                advUserInfo.name = [dicAdv objectForKey:@"name"];
                advUserInfo.postion = [dicAdv objectForKey:@"postion"];
                advUserInfo.webLink = [dicAdv objectForKey:@"webLink"];
                
                
                
                [self.playEdAppListAdvAry addObject:advUserInfo];
                
                
            }
        }
        
        
        
        if (![appAry isMemberOfClass:[NSNull class]]) {
            
            for (NSDictionary*dicApp  in appAry) {
                playUserInfo*pui = [[playUserInfo alloc]init];
                pui.leftSegmentconUrl = [dicApp objectForKey:@"iconUrl"];
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
        
     
        
    }else {
        if (!self.viewFirst) {

            [self UIUpdate];
            
        }else {
            
            self.viewFirst.hidden = NO;
        [self.segmentedControl setSelectedSegmentIndex:0];
        [self changedSegment:self.segmentedControl];
            
            
        }

        
    }

}



//创建返回按钮
-(void)creatBackBtn
{
    
    UIButton*backBtn=[[UIButton alloc]initWithFrame:CGRectMake(10, 34, 75, 55)];
    [backBtn setImage:[UIImage imageNamed:@"ingame_logo.png"] forState:UIControlStateNormal];
//    backBtn.backgroundColor = [UIColor redColor];
    
//    backBtn.backgroundColor = [UIColor redColor];
    [backBtn addTarget:self action:@selector(backMainView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    
    
    UIButton*studyBtn;
    for (int i = 0; i<4; i++) {
        //左边 10  右边 5 间距 5
        CGFloat btnWidth= (self.view.frame.size.width-100-5-20)/4;
        
        studyBtn=[[UIButton alloc]initWithFrame:CGRectMake(105+i*(btnWidth+5), 34, btnWidth, btnWidth)];
        studyBtn.tag=i;
        [studyBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"play_0%d.png",i]] forState:UIControlStateNormal];
        [studyBtn addTarget:self action:@selector(goSecondView:) forControlEvents:UIControlEventTouchUpInside];
//        NSLog(@"%.2f---%.2f",studyBtn.frame.size.width,studyBtn.frame.size.height);
        
        
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

    [self.tabBarController setSelectedIndex:btn.tag];
    
    if (btn.tag==0) {
        
      // 在当前界面 点击 当前显示界面按钮  就行界面刷新
        [self.viewFirst removeFromSuperview];
        self.viewFirst = nil;
        [self.clickView removeFromSuperview];
        self.clickView = nil;
        [self.rightClickView removeFromSuperview];
        self.rightClickView = nil;
        
        [self.viewRight removeFromSuperview];
        self.viewRight = nil;
        
        [self.segmentedControl removeFromSuperview];
        self.segmentedControl = nil;

//      清除图片缓存
        
//        [[SDImageCache sharedImageCache] cleanDisk];
//       [[SDImageCache sharedImageCache] clearDisk];
//       [[SDImageCache sharedImageCache] clearMemory];
//        NSLog(@"%@",NSHomeDirectory());
        
        self.ary = [NSMutableArray array];
        self.playEdAppListAdvAry = [NSMutableArray array ];

        [self.jpm requestPlayViewData:^(id obj) {
            
            NSDictionary*dic = obj;
            
            NSArray*appAry = [dic objectForKey:@"app"];
            
            NSArray*advAry = [dic objectForKey:@"adv"];
            //        NSLog(@"%@",advAry);
            
            
#pragma 广告
            
            if (![advAry isMemberOfClass:[NSNull class]]) {
                for (NSDictionary*dicAdv in advAry) {
                    playEdAppListAdvUserInfo*advUserInfo = [[playEdAppListAdvUserInfo alloc]init];
                    advUserInfo.iconUrl = [dicAdv objectForKey:@"iconUrl"];
                    advUserInfo.advID = [dicAdv objectForKey:@"id"];
                    advUserInfo.imgSize = [dicAdv objectForKey:@"imgSize"];
                    advUserInfo.imgType = [dicAdv objectForKey:@"imgType"];
                    advUserInfo.ip = [dicAdv objectForKey:@"ip"];
                    advUserInfo.language =[dicAdv objectForKey:@"language"];
                    advUserInfo.name = [dicAdv objectForKey:@"name"];
                    advUserInfo.postion = [dicAdv objectForKey:@"postion"];
                    advUserInfo.webLink = [dicAdv objectForKey:@"webLink"];
                    advUserInfo.iosLink = [dicAdv objectForKey:@"iosLink"];
                    
                    
                    [self.playEdAppListAdvAry addObject:advUserInfo];
                    
                    
                }
            }
            
            
            
            if (![appAry isMemberOfClass:[NSNull class]]) {
                
                for (NSDictionary*dicApp  in appAry) {
                    playUserInfo*pui = [[playUserInfo alloc]init];
                    pui.leftSegmentconUrl = [dicApp objectForKey:@"iconUrl"];
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

        
    }
    
}




-(void)creatLeftView;
{

    
            self.viewFirst  =[[UIView alloc]initWithFrame:CGRectMake(0, 95, self.view.frame.size.width, self.view.frame.size.height-95)];
    
            self.firstSV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 30, self.view.frame.size.width , self.view.frame.size.height-95)];
            self.firstSV.showsHorizontalScrollIndicator=YES;
            
            //弹簧效果
            self.firstSV.bounces=NO;

    
#pragma play 广告图

    
    playEdAppListAdvUserInfo *advUserInfo = self.playEdAppListAdvAry[0];
    
    
    self.advBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,170)];
//    [advBtn setImage:[UIImage imageNamed:@"play_01mainpage_20141105_21.png"] forState:UIControlStateNormal];
    
    
    
    
    
    [self.advBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:advUserInfo.iconUrl] forState:UIControlStateNormal];
    [self.advBtn addTarget:self action:@selector(secondLeftViewBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.firstSV addSubview:self.advBtn];
    
#pragma 左右滚动
            
//            [self.firstSV addSubview:leftRightSV];
    
            
  
    
    
    
    
    
    
#pragma people
            CGFloat peopleWidth = (self.view.frame.size.width-60)/2;
    
            for (int i = 0; i<self.ary.count; i++) {
                
                UIView*view=[[UIView alloc]initWithFrame:CGRectMake(20+i%2*(peopleWidth+20),
                                                                   190+i/2*150,
                                                                   peopleWidth,
                                                                   140)];
                
                
                UIButton*btn=[[UIButton alloc]initWithFrame:CGRectMake(10, 0, view.frame.size.width-20, view.frame.size.height-20)];
                
                btn.tag = i;
                
                
                
                
#pragma         self.ary[i]   peopleAll.png
                playUserInfo*userInfo = self.ary[i];
        
              
                
                
                [btn sd_setImageWithURL:[NSURL URLWithString:userInfo.leftSegmentconUrl] forState:UIControlStateNormal];
                
                [btn addTarget:self action:@selector(secondLeftViewBtn:) forControlEvents:UIControlEventTouchUpInside];
                
               
                [view addSubview:btn];
                
                UIImageView*iv=[[UIImageView alloc]initWithFrame:CGRectMake(0, view.frame.size.height-20, 20, 20)];
                
                
                iv.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:userInfo.leftSegmenttype]]];
                
                [view addSubview:iv];
                
                UILabel*label = [[UILabel alloc]initWithFrame:CGRectMake(20, view.frame.size.height-20, view.frame.size.width-20, 20)];
                label.text = userInfo.leftSegmenttitle;
                label.font = [UIFont systemFontOfSize:10];
                label.textColor = [UIColor blueColor];
                [view addSubview:label];
                
               // view.backgroundColor = [UIColor clearColor];
                
                [self.firstSV addSubview:view];
                 
            }
            
           
                        
    
    
    
    
    UIView*fiveIVdown=[[UIView alloc]initWithFrame:
                       CGRectMake(0,
                                  self.advBtn.frame.size.height+
                                (self.ary.count%2 == 0 ?  20+self.ary.count/2*150 :  20+(self.ary.count/2+1)*150) ,
                                  self.firstSV.frame.size.width,
                                  50)];
    
    UIImageView*oneIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
    oneIV.image = [UIImage imageNamed:@"Bodhiword_76"];
    [fiveIVdown addSubview:oneIV];
    
    UIImageView*twoIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 30)];
    twoIV.image = [UIImage imageNamed:@"Bodhiword_77"];
    [fiveIVdown addSubview:twoIV];
    
    UIButton*fiveBtnLeft=[[UIButton alloc]initWithFrame:CGRectMake(5 , 0, 60, 20)];
    
    
    UIButton*fiveBtnRight=[[UIButton alloc]initWithFrame:CGRectMake(fiveIVdown.frame.size.width-70, 0, 65, 20)];
    
    [oneIV addSubview:fiveBtnLeft];
    [oneIV addSubview:fiveBtnRight];
    
    [self.firstSV addSubview:fiveIVdown];

 
            CGFloat btnHeght = self.ary.count%2 == 0 ?  20+self.ary.count/2*150 :  20+(self.ary.count/2+1)*150;
            
            CGFloat height  =self.advBtn.frame.size.height+
                              btnHeght+110-30;
            
    
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
            
            if (!self.viewRight) {
                 
            self.playSocialAry = [NSMutableArray array ];
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
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self creatRightView];
                });
                
              }];
            }else{
                
            
            }
            
                }
            break;
            
        default:
            break;
    }



}




#pragma secondLeftViewBtn
-(void)secondLeftViewBtn:(UIButton*)sender
{
    self.playEdAppDetailAppAry =[NSMutableArray array];
    self.playEdAppDetailAppImgAry = [NSMutableArray array];
    
    
    self.viewFirst.hidden = YES;
    
    self.clickView = [[UIView alloc]initWithFrame:CGRectMake(0, 95, self.view.frame.size.width, self.view.frame.size.height-95)];
//    self.clickView.backgroundColor = [UIColor redColor];
    
        UIView*viewF=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    
    UIImageView*imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    imageView.image =[UIImage imageNamed:@"play_03bodhirace_20141105_02"];
    
    
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 30)];
    [btn setImage:[UIImage imageNamed:@"play_03bodhirace_20141105_03.png"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(backLeftView:) forControlEvents:UIControlEventTouchUpInside];
    
    [viewF addSubview:imageView];
    [viewF addSubview:btn];
 
    
    

    
    
    NSString*ID = nil;
    
    
    if ([sender isEqual:self.advBtn]) {
        playEdAppListAdvUserInfo*advUserInfo = self.playEdAppListAdvAry[0];
        
        ID = advUserInfo.iosLink;
        
    }else{
         playUserInfo*userInfo = self.ary[sender.tag];
        
        ID = userInfo.leftSegmentId;
    }
    
      
    
    [self.jpm requestPlayViewedAppDetailWithParams:ID and:^(id obj) {
        
        
        NSDictionary*dic = obj;
        
        
#pragma        app
        NSArray*appAry= [dic objectForKey:@"app"];
        
        for (NSDictionary*dic in appAry)
        {
            playEdAppDetailAppUserInfo*playEdappDetail =[[playEdAppDetailAppUserInfo alloc]init];
            playEdappDetail.iconUrl = [dic objectForKey:@"iconUrl"];
            playEdappDetail.type = [dic objectForKey:@"type"];
            playEdappDetail.title = [dic objectForKey:@"title"];
            playEdappDetail.appID = [dic objectForKey:@"id"];
            
            playEdappDetail.status = [dic objectForKey:@"status"];
            
            playEdappDetail.context = [dic objectForKey:@"context"];
            
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
            
            
            UIScrollView*centerSV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 30, self.clickView.frame.size.width, self.clickView.frame.size.height-80)];
            
            centerSV.pagingEnabled = YES;
            centerSV.bounces = NO;
            centerSV.showsVerticalScrollIndicator= NO;
            centerSV.delegate = self;
            
            
        
            
            
            
            playEdAppDetailAppUserInfo*appUserInfo = [self.playEdAppDetailAppAry lastObject];
            
            
            UIImageView*peopleIV = [[UIImageView alloc]initWithFrame:CGRectMake(20, 20, 80, 80)];
            
            peopleIV.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:appUserInfo.iconUrl]]];
            
            UIImageView*smallIV=[[UIImageView alloc]initWithFrame:CGRectMake(105, 30, 30, 30)];
            
            smallIV.image =[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:appUserInfo.type]]];
            
            
            
            UILabel*label = [[UILabel alloc]initWithFrame:CGRectMake(135, 30, 100, 30)];
            label.text = appUserInfo.title;
            label.font = [UIFont systemFontOfSize:10];
            label.textColor =  [UIColor colorWithRed:25/255.0 green:87/255.0 blue:28/255.0 alpha:1];
            
            
            
#pragma coming soon
            
            if ((appUserInfo.status != nil) && (([appUserInfo.status intValue] ==0 )|| ([appUserInfo.status intValue] == 2))) {
                
                UILabel*comingsoon = [[UILabel alloc]initWithFrame:CGRectMake(105, 70, 100, 30)];
                comingsoon.text = @"coming soon";
                comingsoon.font = [UIFont systemFontOfSize:16.0f];
                comingsoon.textColor =[UIColor colorWithRed:25/255.0 green:87/255.0 blue:28/255.0 alpha:1];
                
                
                [centerSV addSubview:comingsoon];
                
            }
            
            
            
            
            
            UIButton*playBtn=[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-10-100, 70, 100, 30)];
            [playBtn setImage:[UIImage imageNamed:@"btn_ios.png"] forState:UIControlStateNormal];
            
            [playBtn addTarget:self action:@selector(playBtn:) forControlEvents:UIControlEventTouchUpInside];
            
            
            
            UITextView*textView = [[UITextView alloc]initWithFrame:CGRectMake(10, 120, self.view.frame.size.width-20, 110)];
            textView.text = appUserInfo.context;
            textView.textColor = [UIColor colorWithRed:25/255.0 green:87/255.0 blue:28/255.0 alpha:1];
            
            textView.editable = NO;
            textView.selectable= NO;
            
            [centerSV addSubview:textView];
            
            
            
            
            [centerSV addSubview:peopleIV];
            [centerSV addSubview:smallIV];
            [centerSV addSubview:label];
            [centerSV addSubview:playBtn];
            
            
            
            UIView*fiveIVdown=[[UIView alloc]initWithFrame:CGRectMake(0, self.clickView.frame.size.height-50, self.clickView.frame.size.width, 50)];
            UIImageView*oneIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
            oneIV.image = [UIImage imageNamed:@"Bodhiword_76"];
            [fiveIVdown addSubview:oneIV];
            
            UIImageView*twoIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 30)];
            twoIV.image = [UIImage imageNamed:@"Bodhiword_77"];
            [fiveIVdown addSubview:twoIV];
            
            UIButton*fiveBtnLeft=[[UIButton alloc]initWithFrame:CGRectMake(5 , 0, 65, 20)];
//            fiveBtnLeft.backgroundColor = [UIColor redColor];
            
            
            UIButton*fiveBtnRight=[[UIButton alloc]initWithFrame:CGRectMake(fiveIVdown.frame.size.width-70, 0, 65, 20)];
//            fiveBtnRight.backgroundColor = [UIColor redColor];
            
            
            [oneIV addSubview:fiveBtnLeft];
            [oneIV addSubview:fiveBtnRight];
            
            [self.clickView addSubview:fiveIVdown];
            
            
//            CGFloat height =self.clickView.frame.size.height - fiveIVdown.frame.size.height - 10 - 220;
            
            
            UIView*svView =[[UIView alloc]initWithFrame:CGRectMake(10, 240, self.view.frame.size.width-20, 220)];
            
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
            
            [svView addSubview:self.pageCtrl];
            
            [centerSV addSubview:svView];
            
            [self.clickView addSubview:viewF];
            
            
            
            [centerSV setContentSize:CGSizeMake(centerSV.frame.size.width, 500)];
            
            [self.clickView addSubview:centerSV];
            [self.view addSubview:self.clickView];

            
        });
        
    }];
    
   
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGPoint offset = scrollView.contentOffset;
    CGRect bounds =scrollView.frame;
    [self.pageCtrl setCurrentPage:offset.x/(bounds.size.width)];
    
    
}

#pragma 左视图role按钮 点击界面 ios按钮

-(void)playBtn:(UIButton*)sender
{
    NSLog(@"playBtn");

}

#pragma backLeftView

-(void)backLeftView:(UIButton *)sender
{
   
    self.clickView.hidden = YES;
    self.viewFirst.hidden = NO;
}



-(void)creatRightView
{
     self.viewRight  =[[UIView alloc]initWithFrame:CGRectMake(0, 125, self.view.frame.size.width, self.view.frame.size.height-75)];
//    self.viewRight.backgroundColor = [UIColor redColor];
    
#pragma 右试图
 
    
    for (int i = 0; i<self.playSocialAry.count; i++) {
        
        playSocialUserInfo*psUser = self.playSocialAry[i];
        
        UIView*view = [[UIView alloc]initWithFrame:CGRectMake(0, i*100, self.view.frame.size.width, 100)];
        CGFloat height = view.frame.size.height - 20;
        
        
        if (i%2 != 0) {
//            #f2fcfe
            view.backgroundColor = [UIColor colorWithRed:242/255.0 green:252/255.0 blue:254/255.0 alpha:1];
        }
        
        
        UIButton*iv1 = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, height, height)];
        
        UIImage* image =[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:psUser.iconUrl]]];
        iv1.tag = i;
        [iv1 setImage:image forState:UIControlStateNormal];
        
        [iv1 addTarget:self action:@selector(rightBtnView:) forControlEvents:UIControlEventTouchUpInside];
        
        [view addSubview:iv1];
        
        UILabel*label = [[UILabel alloc]initWithFrame:CGRectMake(height+20, 30, view.frame.size.width-height-30, height)];
        label.text = psUser.describes;
        label.font = [UIFont systemFontOfSize:12];
        
//        #0074fe
        
        label.textColor = [UIColor colorWithRed:0 green:116/255.0 blue:254/255.0 alpha:1];
        
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
                                                                   self.viewRight.frame.size.height-100, self.viewRight.frame.size.width, 50)];
    UIImageView*oneIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
    oneIV.image = [UIImage imageNamed:@"Bodhiword_76"];
    [fiveIVdown addSubview:oneIV];
    
    UIImageView*twoIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 30)];
    twoIV.image = [UIImage imageNamed:@"Bodhiword_77"];
    [fiveIVdown addSubview:twoIV];
    
    UIButton*fiveBtnLeft=[[UIButton alloc]initWithFrame:CGRectMake(5 , 0, 65, 20)];
    
    
    UIButton*fiveBtnRight=[[UIButton alloc]initWithFrame:CGRectMake(fiveIVdown.frame.size.width-70, 0, 65, 20)];
    
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
       
        
#pragma social
        NSArray*socialAry= [dic objectForKey:@"social"];
        
        for (NSDictionary*dic in socialAry)
        {
            playSocialDetailSocial*psds =[[playSocialDetailSocial alloc]init];
            psds.iconUrl = [dic objectForKey:@"iconUrl"];
            psds.describes = [dic objectForKey:@"describes"];
            psds.title = [dic objectForKey:@"title"];
            psds.socialDetailSocialID = [dic objectForKey:@"id"];
            psds.age =[dic objectForKey:@"age"];
            psds.status = [dic objectForKey:@"status"];
            
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
            
            self.rightClickView = [[UIView alloc]initWithFrame:CGRectMake(0, 65, self.view.frame.size.width, self.view.frame.size.height-65)];
            
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
            labelName.textColor = [UIColor colorWithRed:12/255.0 green:149/255.0 blue:254/255.0 alpha:1];
            CGSize labelSize = {0,0};
            labelSize = [labelName.text sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(self.rightClickView.frame.size.width-115, 50) lineBreakMode: UILineBreakModeWordWrap];
            labelName.numberOfLines = 2;
            
            [self.rightClickView addSubview:labelName];
            
            UILabel*labelAge = [[UILabel alloc]initWithFrame:CGRectMake(105, 110, self.rightClickView.frame.size.width-115, 30)];
            labelAge.text = [NSString stringWithFormat:@"Target age:%@",psds.age];
            labelAge.textColor = [UIColor colorWithRed:89/255.0 green:176/255.0 blue:65/255.0 alpha:1];
            CGSize labelAgeSize = {0,0};
            labelAgeSize = [labelAge.text sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(self.rightClickView.frame.size.width-115, 50) lineBreakMode: UILineBreakModeWordWrap];
            labelName.numberOfLines = 2;
            
            [self.rightClickView addSubview:labelAge];
            
            
            if (psds.status !=nil) {
                if ([psds.status intValue] == 0|| [psds.status intValue] ==2) {
                    UILabel*lb = [[UILabel alloc]initWithFrame:CGRectMake(105, 130,
                                                                          self.rightClickView.frame.size.width-115, 25)];
                    
                    lb.text =@"coming soon";
                    lb.textColor = [UIColor colorWithRed:89/255.0 green:176/255.0 blue:65/255.0 alpha:1];
                    
                    lb.font = [UIFont systemFontOfSize:15];
                    
                    [self.rightClickView addSubview:lb];
                    
                    
                }
            }
            

            UITextView*textView = [[UITextView alloc]initWithFrame:CGRectMake(10, 165, self.rightClickView.frame.size.width-20, 100)];
            textView.text = psds.describes;
            textView.textColor = [UIColor colorWithRed:25/255.0 green:87/255.0 blue:28/255.0 alpha:1];
            
            textView.editable = NO;
            textView.selectable= NO;
            
            
            [self.rightClickView addSubview:textView];
            
            
            UIView*svView =[[UIView alloc]initWithFrame:CGRectMake(10, 275, self.rightClickView.frame.size.width-20, 170)];
            
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
                                                                                self.self.rightClickView.frame.size.height-50, self.rightClickView.frame.size.width, 50)];
//            fiveIVdown.image=[UIImage imageNamed:@"Bodhiword_.png"];
            
//    ????????????
//            self.rightClickView.backgroundColor = [UIColor redColor];
            
            UIImageView*oneIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
            oneIV.image = [UIImage imageNamed:@"Bodhiword_76"];
            [fiveIVdown addSubview:oneIV];
            
            UIImageView*twoIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 30)];
            twoIV.image = [UIImage imageNamed:@"Bodhiword_77"];
            [fiveIVdown addSubview:twoIV];
            
            UIButton*fiveBtnLeft=[[UIButton alloc]initWithFrame:CGRectMake(5 , 0, 65, 20)];
            
            
            UIButton*fiveBtnRight=[[UIButton alloc]initWithFrame:CGRectMake(fiveIVdown.frame.size.width-70, 0, 65, 20)];
            
            [oneIV addSubview:fiveBtnLeft];
            [oneIV addSubview:fiveBtnRight];
            
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
