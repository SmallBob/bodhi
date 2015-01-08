//
//  SecondViewController.m
//  bodhiWord
//
//  Created by apple on 14/11/28.
//  Copyright (c) 2014年 apple. All rights reserved.
//



#import "JsonPostModel.h"
#import "UserInfo.h"
#import "playUserInfo.h"
#import "SecondViewController.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "MBProgressHUD.h"
#import <unistd.h>



#import "ViewController.h"
@interface SecondViewController ()<MBProgressHUDDelegate>
@property(nonatomic,strong)UIScrollView*firstSV;
@property(nonatomic,strong)UIView*changeView;
@property(nonatomic,strong)UIView*viewFirst;
@property(nonatomic,strong)UIView*viewRight;
@property(nonatomic,strong)UIView*clickView;

@property(nonatomic,strong)UIView*rightClickView;


@property(nonatomic,strong)UIButton*contentBtn;


@property(nonatomic,strong)NSMutableArray*ary;
@property(nonatomic,strong)NSMutableArray*rightSegmentAry;



@property(nonatomic)float length;

@property(nonatomic,strong)MBProgressHUD*HUD;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.hidden = YES;
    
    [self creatBackBtn];
    
    
    self.HUD = [[MBProgressHUD alloc]initWithView:self.view];
    
    [self.tabBarController.view addSubview:self.HUD];
    
    [self.view bringSubviewToFront:self.HUD];
    //self.HUD.delegate=self;
    self.HUD.labelText =@"loading";
    
    
    [self.HUD showAnimated:YES whileExecutingBlock:^{
        
        [[JsonPostModel shareJsonPostModel] requestPlayViewData:^(id obj) {
            self.ary = obj;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                
                
                [self changedLeftView];
                
                
                
                self.viewRight.hidden= YES;
                
                UIImage*image1=[UIImage imageNamed:@"leftRight.png"] ;
                UISegmentedControl *segmentedControl = [[UISegmentedControl alloc]initWithItems:@[@"",@""]];
                [segmentedControl addTarget:self action:@selector(changedSegment:) forControlEvents:UIControlEventValueChanged];
                
                segmentedControl.selectedSegmentIndex = 0;
                
                
                segmentedControl.frame = CGRectMake(0, 95, self.view.frame.size.width, 30);
                
                [segmentedControl setBackgroundImage:image1 forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
                [self.view addSubview:segmentedControl];
                
                
                
            });
            
            
        }];
        
      [self myTask];
    } completionBlock:^{
        [self.HUD removeFromSuperview];
        
    }];
    
  
    
 }


-(void)myTask
{
    
    
    
    sleep(1);


    
}

-(void)hudWasHidden:(MBProgressHUD *)hud
{
    [self.HUD removeFromSuperview];
    
    self.HUD = nil;
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    

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
        [studyBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"btn0%d.png",(i+1)]] forState:UIControlStateNormal];
        [studyBtn addTarget:self action:@selector(goSecondView:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:studyBtn];
        if (studyBtn.tag == 0 ) {
            studyBtn.enabled = NO;
        ;
        }
        
    }


}
-(void)backMainView:(UIButton*)sender
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
   
    
}


#pragma secondeView

-(void)goSecondView:(UIButton*)btn
{
    [self.tabBarController setSelectedIndex:btn.tag];
}







-(void)changedLeftView;
{
    NSLog(@"%lu",(unsigned long)self.ary.count);

    
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
            NSLog(@" ---- self.ary.count  %lu ",(unsigned long)self.ary.count);
    
            for (int i = 0; i<self.ary.count; i++) {
                
                UIView*view=[[UIView alloc]initWithFrame:CGRectMake(20+i%2*(peopleWidth+20),
                                                                   190+i/2*150,
                                                                   peopleWidth,
                                                                   140)];
                
               // UIButton*btn = [[UIButton alloc]initWithFrame:CGRectMake(20+i%2*(peopleWidth+20),
//                                                                         190+i/2*150,
//                                                                         peopleWidth,
//                                                                         140)];
                
                               UIButton*btn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height-30)];
                
                btn.tag = i;
                
                
                
                
               // self.ary[i]   peopleAll.png
                playUserInfo*userInfo = self.ary[i];
                
                
                
                
                [btn sd_setImageWithURL:[NSURL URLWithString:userInfo.playLeftViewIconUrl] forState:UIControlStateNormal];

//                [btn setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:userInfo.playLeftViewIconUrl]]] forState:UIControlStateNormal];
                
                
                
                
                
               
                
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

    NSLog(@"%ld",(long)sender.selectedSegmentIndex);
    switch (sender.selectedSegmentIndex) {
        case 0:
        {
            self.firstSV.hidden = NO;
            self.viewRight.hidden = YES;
        }
            break;
        case 1:
        {
            self.firstSV.hidden =YES;
            self.viewRight.hidden = NO;
            
                }
            break;
            
        default:
            break;
    }



}




#pragma click
-(void)click:(UIButton*)sender
{
    
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
    
    
    UIImageView*peopleIV = [[UIImageView alloc]initWithFrame:CGRectMake(20, 50, 80, 80)];
    peopleIV.image= [UIImage imageNamed:@"people.png"];
    
    UIImageView*smallIV=[[UIImageView alloc]initWithFrame:CGRectMake(105, 60, 30, 30)];
    smallIV.image = [UIImage imageNamed:@"play_03bodhirace_20141105_08.png"];
    
    UIImageView*textIV =[[UIImageView alloc]initWithFrame:CGRectMake(135, 60, 50, 30)];
    textIV.image = [UIImage imageNamed:@"play_03bodhirace_20141105_10.png"];
    
    UIButton*playBtn=[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-20-100, 100, 100, 30)];
    [playBtn setImage:[UIImage imageNamed:@"play_03bodhirace_20141105_15.png"] forState:UIControlStateNormal];
    
    
    [self.clickView addSubview:peopleIV];
    [self.clickView addSubview:smallIV];
    [self.clickView addSubview:textIV];
    [self.clickView addSubview:playBtn];

   
    
    UIView*fiveIVdown=[[UIView alloc]initWithFrame:CGRectMake(0, self.clickView.frame.size.height-80, self.clickView.frame.size.width, 80)];
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
    
    [self.clickView addSubview:fiveIVdown];

    
    
    
    
    
    
    
    CGFloat height =self.clickView.frame.size.height - fiveIVdown.frame.size.height - 10 - 220;
    
    UIScrollView*sv  =[[UIScrollView alloc]initWithFrame:CGRectMake(80, self.clickView.frame.size.height - fiveIVdown.frame.size.height - 10 - 220, self.view.frame.size.width-160, 220)];
    sv.bounces = NO;
    sv.showsHorizontalScrollIndicator= NO;
    
    UIImageView*svView1=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, sv.frame.size.width, sv.frame.size.height)];
   
    svView1 .image = [UIImage imageNamed:@"play_03bodhirace_20141105_20.png"];
    
    UIImageView*svView2=[[UIImageView alloc]initWithFrame:CGRectMake(sv.frame.size.width, 0, sv.frame.size.width, sv.frame.size.height)];
    
    svView2 .image = [UIImage imageNamed:@"play_03bodhirace_20141105_20.png"];
    
    
    [sv setContentSize:CGSizeMake(sv.frame.size.width*2, sv.frame.size.height)];
    
    [sv addSubview:svView1];
    [sv addSubview:svView2];
    
    UIImageView*leftIV = [[UIImageView alloc]initWithFrame:CGRectMake(30, height+110-25, 50, 50)];
    leftIV.image = [UIImage imageNamed:@"play_03bodhirace_20141105_23.png"];
    
    [self.clickView addSubview:leftIV];
    
    UIImageView*rightIV = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width-80, height+110-25, 50, 50)];
    rightIV.image = [UIImage imageNamed:@"play_03bodhirace_20141105_26.png"];
    
    [self.clickView addSubview:rightIV];

    
    
    [self.clickView addSubview:sv];
    
    [self.clickView addSubview:viewF];
    [self.view addSubview:self.clickView];
    
    
   
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
 
    
    for (int i = 0; i<self.rightSegmentAry.count; i++) {
        
        playUserInfo*sjm = self.rightSegmentAry[i];
        
        UIView*view = [[UIView alloc]initWithFrame:CGRectMake(0, i*100, self.view.frame.size.width, 100)];
        CGFloat height = view.frame.size.height - 20;
        
        UIButton*iv1 = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, height, height)];
        
        UIImage* image =[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:sjm.rightSegmentIconUrl]]];
        
        [iv1 setImage:image forState:UIControlStateNormal];
        
        [iv1 addTarget:self action:@selector(rightBtnView:) forControlEvents:UIControlEventTouchUpInside];
        
        [view addSubview:iv1];
        
        UILabel*label = [[UILabel alloc]initWithFrame:CGRectMake(height+20, 30, view.frame.size.width-height-30, height)];
        label.text = sjm.rightSegmentDescribes;
        label.font = [UIFont systemFontOfSize:12];
        label.textColor = [UIColor blueColor];
        CGSize labelSize = {0,0};
        labelSize = [label.text sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(view.frame.size.width-height-30, height) lineBreakMode: UILineBreakModeWordWrap];
        label.numberOfLines = 3;
        
        
        [view addSubview:label];

        UILabel*label2 =[[UILabel alloc]initWithFrame:CGRectMake(height+30, 10, view.bounds.size.width-height-20, 20)];
        label2.text = sjm.rightSegmentTitile;
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
    
    
    UIImageView*peopleIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 70, 80, 80)];
    peopleIV.image= [UIImage imageNamed:@"play_04bodhifinancial_20141105_03"];
    
    UIImageView*smallIV=[[UIImageView alloc]initWithFrame:CGRectMake(105, 70, self.rightClickView.frame.size.width-115, 80)];
    smallIV.image = [UIImage imageNamed:@"play_04bodhifinancial_20141105_05.png"];
    
    UIImageView*textIV=[[UIImageView alloc]initWithFrame:CGRectMake(10, 150, self.rightClickView.frame.size.width-20, 100)];
    textIV.image = [UIImage imageNamed:@"play_04bodhifinancial_20141105_10.png"];
    
    UIImageView*vidioIV=[[UIImageView alloc]initWithFrame:CGRectMake(10, 260, self.rightClickView.frame.size.width-20, 150)];
    vidioIV.image = [UIImage imageNamed:@"play_04bodhifinancial_20141105_14.png"];
    
    [self.rightClickView addSubview:vidioIV];
    [self.rightClickView addSubview:textIV];
    [self.rightClickView addSubview:peopleIV];
    [self.rightClickView addSubview:smallIV];
    

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

}
  
  


-(void)backRightView:(UIButton*)sender
{
    self.rightClickView.hidden = YES;
    self.viewRight.hidden = NO;
    NSLog(@"123");


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
