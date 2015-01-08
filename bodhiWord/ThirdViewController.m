//
//  ThirdViewController.m
//  bodhiWord
//
//  Created by apple on 14/12/2.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "ThirdViewController.h"

@interface ThirdViewController ()
@property(nonatomic,strong)UIScrollView*firstSV;
@property(nonatomic,strong)UIView*secondView;
@property(nonatomic,strong)UIView*thirdView;
@property(nonatomic,strong)UIView*fourView;
@property(nonatomic,strong)UIView*fiveView;

@property(nonatomic,strong)UIView*backView;
@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   

    [self creatBackBtn];
    self.tabBarController.tabBar.hidden = YES;
    
    
    [self creatView];
    [self.view addSubview:self.firstSV];
    
    

            // Do any additional setup after loading the view.
    
    
    }


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
        
        
    }
    
}

-(void)goSecondView:(UIButton*)sender
{
    if (sender.tag == 1) {
        self.secondView.hidden = YES;
        self.thirdView.hidden = YES;
        self.fourView.hidden = YES;
        self.fiveView.hidden = YES;
        self.backView.hidden = YES;
        
        
        
        self.firstSV.hidden = NO;
        NSLog(@"%lu",(unsigned long)self.view.subviews.count);

    }else {
    
    [self.tabBarController setSelectedIndex:sender.tag];
    
    }
    
}



-(void)backMainView:(UIButton*)sender
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


-(void)creatView
{
        
    self.firstSV  = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 96, self.view.frame.size.width, self.view.frame.size.height-95)];
        self.firstSV.bounces= NO;
    self.firstSV.showsHorizontalScrollIndicator = NO;
    
    CGFloat width = (self.firstSV.frame.size.width-10)/2;
    for (int i=0; i<4; i++) {
        UIButton*btn = [[UIButton alloc]initWithFrame:CGRectMake(10+i%2*width, 5+i/2*120, width-10, 120)];
        [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%02d.png",i+1]] forState:UIControlStateNormal];
        btn.tag = i;
        [btn addTarget:self action:@selector(viewChanged:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.firstSV addSubview:btn];
        
        
    }
    
    UIImageView*imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(10, 280, self.view.frame.size.width-20, 160)];
    imageView1.image = [UIImage imageNamed:@"001_watch_06mainpage_20141105_16.png"];
    
    [self.firstSV addSubview:imageView1];
//
//    
//    UIImageView*fiveIVdown=[[UIImageView alloc]initWithFrame:CGRectMake(0,500,self.firstSV.frame.size.width,110)];
//    fiveIVdown.image=[UIImage imageNamed:@"Bodhiword_.png"];
//    UIButton*fiveBtnLeft=[[UIButton alloc]initWithFrame:CGRectMake(10 , 0, 60, 30)];
//    [fiveBtnLeft setImage:[UIImage imageNamed:@"Bodhiword_35.png"] forState:UIControlStateNormal];
//    UIButton*fiveBtnRight=[[UIButton alloc]initWithFrame:CGRectMake(fiveIVdown.frame.size.width-70, 0, 60, 30)];
//    [fiveBtnRight setImage:[UIImage imageNamed:@"Bodhiword_37.png"] forState:UIControlStateNormal];
//        [fiveIVdown addSubview:fiveBtnLeft];
//    [fiveIVdown addSubview:fiveBtnRight];

    
    
    UIView*fiveIVdown=[[UIView alloc]initWithFrame:CGRectMake(0,470,self.firstSV.frame.size.width,80)];
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
    
    [self.firstSV setContentSize:CGSizeMake(self.firstSV.frame.size.width, 540)];
//[self.view addSubview:self.firstSV];




}

-(void)viewChanged:(UIButton*)sender
{
    self.firstSV.hidden = YES;
    [self clickButtonToView:sender.tag];
    
    
    
    }

-(void)lists:(UIButton*)sender
{
    self.secondView.hidden = YES;
    self.thirdView.hidden = YES;
    self.fourView.hidden = YES;
    self.fiveView.hidden = YES;
    
    
    
    
    self.firstSV.hidden = YES;
    
    
    
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(0, 95, self.view.frame.size.width, self.view.frame.size.height-95)];
    
    UIImageView*imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.backView.frame.size.width, self.backView.frame.size.height)];
    imageView.image =[UIImage imageNamed:@"watch_05categories_20141105_bg"];
    
    [self.backView addSubview:imageView];
    
    
    CGFloat width = self.view.frame.size.width/2;
    
    for (int i = 0; i<4; i++) {
        UIButton *btn  =[[ UIButton alloc]initWithFrame:CGRectMake(width-75, 13+i*56, 150, 25)];
        [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"watch_05categories_20141105_%02d",i+1]] forState:UIControlStateNormal];
        
        
        [btn addTarget:self action:@selector(lookView:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        btn.tag = i;
        
        
        
        [self.backView addSubview: btn];
        
        
    }
    
    
    UIImageView*fiveIVdown=[[UIImageView alloc]initWithFrame:CGRectMake(0,imageView.frame.size.height-80   ,imageView.frame.size.width    ,80)];
    fiveIVdown.image=[UIImage imageNamed:@"Bodhiword_.png"];
    UIButton*fiveBtnLeft=[[UIButton alloc]initWithFrame:CGRectMake(10 , 0, 60, 30)];
    [fiveBtnLeft setImage:[UIImage imageNamed:@"Bodhiword_35.png"] forState:UIControlStateNormal];
    UIButton*fiveBtnRight=[[UIButton alloc]initWithFrame:CGRectMake(fiveIVdown.frame.size.width-70, 0, 60, 30)];
    [fiveBtnRight setImage:[UIImage imageNamed:@"Bodhiword_37.png"] forState:UIControlStateNormal];
    [fiveIVdown addSubview:fiveBtnLeft];
    [fiveIVdown addSubview:fiveBtnRight];
    
    
    [imageView addSubview:fiveIVdown];

    
    
    
    
    [self.view addSubview:self.backView];
    
    
    
    
    
}


-(void)lookView:(UIButton*)sender
{
    
    
    
    
    
    
    self.backView.hidden = YES;
    [self clickButtonToView:sender.tag];
    NSLog(@"lookView  clickButton :%ld",(long)sender.tag);




}



-(void)playVedio:(UIButton*)sender
{
    NSLog(@"playVedio");
    

}



-(void)clickButtonToView:(NSInteger)tag
{

    switch (tag) {
        case 0:
        {
            
            self.secondView = [[UIView alloc]initWithFrame:CGRectMake(0, 95, self.view.frame.size.width, self.view.frame.size.height-95)];
            
            UIView*view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
            
            
            UIButton*btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 30)];
            [btn setImage:[UIImage imageNamed:@"002_watch_01tv_20141105_02.png"] forState:UIControlStateNormal];
            
            [btn addTarget:self action:@selector(lists:) forControlEvents:UIControlEventTouchUpInside];
            
            [view addSubview:btn];
            
            UISegmentedControl*segmentControl = [[UISegmentedControl alloc]initWithItems:@[@"",@""]];
            [segmentControl setBackgroundImage:[UIImage imageNamed:@"segmentControl.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
            segmentControl.frame =CGRectMake(50, 0,self.view.frame.size.width-50  , 30) ;
            
            [segmentControl  setSelected:NO];
            [view addSubview:segmentControl];
            
            
            
            
            UIScrollView*secondSV=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 30, self.secondView.frame.size.width, self.secondView.frame.size.height - 110)];
            secondSV.bounces= NO;
            secondSV.showsHorizontalScrollIndicator = NO;
            
            for (int i = 0; i<4; i++) {
                UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, i*120, self.secondView.frame.size.width, 120)];
                
                UIImageView*iv = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 150, 80)];
                
                UIImage*image = [UIImage imageNamed:[NSString stringWithFormat:@"playOne%02d.png",i+1]];
                iv.image = image;
                
                [view addSubview:iv];
                
                UIImageView*iv1 = [[UIImageView alloc]initWithFrame:CGRectMake(180, 40, 100, 30)];
                iv1.image = [UIImage imageNamed:@"002_watch_01tv_20141105_23"];
                
                [view addSubview:iv1];
                
                UIImageView*iv2 = [[UIImageView alloc]initWithFrame:CGRectMake(self.secondView.frame.size.width-80, 75, 25, 25)];
                iv2.image = [UIImage imageNamed:@"002_watch_01tv_20141105_29"];
                
                [view addSubview:iv2];
                
                UIButton * btn1 = [[UIButton alloc]initWithFrame:CGRectMake(self.secondView.frame.size.width-45, 75, 25, 25)];
                [btn1 setImage:[UIImage imageNamed:@"002_watch_01tv_20141105_26"] forState:UIControlStateNormal];
                
                [btn1 addTarget:self action:@selector(playVedio:) forControlEvents:UIControlEventTouchUpInside];
                
                [view addSubview:btn1];
                
                [secondSV addSubview:view];
                
                
                
                
            }
            
            [secondSV setContentSize:CGSizeMake(secondSV.frame.size.width, 4*120)];
            
            
            
            
            [self.secondView addSubview:secondSV];
            

            
            
            UIView*fiveIVdown=[[UIView alloc]initWithFrame:CGRectMake(0,self.secondView.frame.size.height-80,self.secondView.frame.size.width,80)];
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
            
            
            
            
            [self.secondView addSubview:fiveIVdown];
            
            
            
            [self.secondView addSubview:view];
            [self.view addSubview:self.secondView];
            
            
            
        }
            
            break;
        case 1:
            
        {
            
            self.thirdView = [[UIView alloc]initWithFrame:CGRectMake(0, 95, self.view.frame.size.width, self.view.frame.size.height-95)];
            
            UIView*view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
            
            
            UIButton*btn = [[UIButton alloc]initWithFrame:view.frame];
            [btn setImage:[UIImage imageNamed:@"004_watch_04_microfilm_20141105_02.png"] forState:UIControlStateNormal];
            
            [btn addTarget:self action:@selector(lists:) forControlEvents:UIControlEventTouchUpInside];
            
            [view addSubview:btn];
            [self.thirdView addSubview:view];
            
            
            UIScrollView*thirdSV=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 30, self.thirdView.frame.size.width, self.thirdView.frame.size.height - 30)];
            thirdSV.bounces= NO;
            thirdSV.showsHorizontalScrollIndicator = NO;
            
            for (int i = 0; i<8; i++) {
                UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, i*120, self.thirdView.frame.size.width, 120)];
                
                UIImageView*iv = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 80, 80)];
                
                UIImage*image = [UIImage imageNamed:@"004_watch_04_microfilm_20141105_05"];
                iv.image = image;
                
                [view addSubview:iv];
                
                UIImageView*iv1 = [[UIImageView alloc]initWithFrame:CGRectMake(95, 25, 120, 60)];
                iv1.image = [UIImage imageNamed:@"004_watch_04_microfilm_20141105_07.png"];
                
                [view addSubview:iv1];
                
                
                UIImageView*iv2 = [[UIImageView alloc]initWithFrame:CGRectMake(self.thirdView.frame.size.width-40, 75, 25, 25)];
                iv2.image = [UIImage imageNamed:@"004_watch_04_microfilm_20141105_10.png"];
                
                [view addSubview:iv2];
                
                
                [thirdSV addSubview:view];
                
                
                
                
            }
            
            
            
            UIView*fiveIVdown=[[UIView alloc]initWithFrame:CGRectMake(0,8*120,thirdSV.frame.size.width,80)];
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

            
            [thirdSV addSubview:fiveIVdown];
            
            
            [thirdSV setContentSize:CGSizeMake(thirdSV.frame.size.width, 8*120+80)];
            
            [self.thirdView addSubview:thirdSV];
            
            [self.view addSubview:self.thirdView];
            
            
            
        }
            
            
            break;
        case 2:
        {
            
            
            
            self.fourView = [[UIView alloc]initWithFrame:CGRectMake(0, 95, self.view.frame.size.width, self.view.frame.size.height-95)];
            
            UIView*view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
            
            
            UIButton*btn = [[UIButton alloc]initWithFrame:view.frame];
            [btn setImage:[UIImage imageNamed:@"004_watch_04_microfilm_20141105_02.png"] forState:UIControlStateNormal];
            
            [btn addTarget:self action:@selector(lists:) forControlEvents:UIControlEventTouchUpInside];
            
            [view addSubview:btn];
            [self.fourView addSubview:view];
            
            
            UIScrollView*fourSV=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 30, self.fourView.frame.size.width, self.fourView.frame.size.height - 30)];
            fourSV.bounces= NO;
            fourSV.showsHorizontalScrollIndicator = NO;
            
            for (int i = 0; i<4; i++) {
                
                
                UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, i*120, self.fourView.frame.size.width, 120)];
                
                UIImageView*iv = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 150, 80)];
                
                UIImage*image = [UIImage imageNamed:@"005_watch_03mv_20141105_05"];
                iv.image = image;
                
                [view addSubview:iv];
                
                UIImageView*iv1 = [[UIImageView alloc]initWithFrame:CGRectMake(180, 40, 100, 30)];
                iv1.image = [UIImage imageNamed:@"005_watch_03mv_20141105_08"];
                
                [view addSubview:iv1];
                
                UIImageView*iv2 = [[UIImageView alloc]initWithFrame:CGRectMake(self.fourView.frame.size.width-80, 75, 25, 25)];
                iv2.image = [UIImage imageNamed:@"005_watch_03mv_20141105_14"];
                
                [view addSubview:iv2];
                
                UIButton * btn1 = [[UIButton alloc]initWithFrame:CGRectMake(self.fourView.frame.size.width-45, 75, 25, 25)];
                [btn1 setImage:[UIImage imageNamed:@"005_watch_03mv_20141105_11"] forState:UIControlStateNormal];
                
                // [btn1 addTarget:self action:@selector(playVedio:) forControlEvents:UIControlEventTouchUpInside];
                
                [view addSubview:btn1];
                
                [fourSV addSubview:view];
                
                
                
                
            }
            
            
            
            
            
            UIView*fiveIVdown=[[UIView alloc]initWithFrame:CGRectMake(0,4*120,fourSV.frame.size.width,80)];
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

            
            
            [fourSV addSubview:fiveIVdown];
            
            
            [fourSV setContentSize:CGSizeMake(fourSV.frame.size.width, 4*120+80)];
            
            [self.fourView addSubview:fourSV];
            
            [self.view addSubview:self.fourView];
            
            
            
        }
            break;
            
        case 3:
        {
            self.fiveView = [[UIView alloc]initWithFrame:CGRectMake(0, 95, self.view.frame.size.width, self.view.frame.size.height-95)];
            
            UIView*view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
            
            
            UIButton*btn = [[UIButton alloc]initWithFrame:view.frame];
            [btn setImage:[UIImage imageNamed:@"004_watch_04_microfilm_20141105_02.png"] forState:UIControlStateNormal];
            
            [btn addTarget:self action:@selector(lists:) forControlEvents:UIControlEventTouchUpInside];
            
            [view addSubview:btn];
            [self.fiveView addSubview:view];
            
            UIScrollView*fiveSV=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 30, self.fiveView.frame.size.width, self.fiveView.frame.size.height - 30)];
            fiveSV.bounces= NO;
            fiveSV.showsHorizontalScrollIndicator = NO;
            
            
            
            UIImageView*imageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, self.view.frame.size.width-30, 40)];
            imageView.image =[UIImage imageNamed:@"006_watch_05eComics_20141105_03"];
            
            [fiveSV addSubview:imageView];
            
            
            for (int i = 0; i<12; i++) {
                
                
                UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, 50+i*100, self.fiveView.frame.size.width, 100)];
                
                UIImageView*iv = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 70, 70)];
                
                UIImage*image = [UIImage imageNamed:@"006_watch_05eComics_20141105_07"];
                iv.image = image;
                
                [view addSubview:iv];
                
                UIImageView*iv1 = [[UIImageView alloc]initWithFrame:CGRectMake(100, 30, 100, 30)];
                iv1.image = [UIImage imageNamed:@"006_watch_05eComics_20141105_13"];
                
                [view addSubview:iv1];
                
                UIImageView*iv2 = [[UIImageView alloc]initWithFrame:CGRectMake(self.fiveView.frame.size.width-115, 30, 100, 30)];
                iv2.image = [UIImage imageNamed:@"006_watch_05eComics_20141105_10"];
                
                [view addSubview:iv2];
                
                
                [fiveSV addSubview:view];
                
                
            }
            
            
            
            
            UIView*fiveIVdown=[[UIView alloc]initWithFrame:CGRectMake(0,13*100,fiveSV.frame.size.width,80)];
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

            
            [fiveSV addSubview:fiveIVdown];
            
            
            [fiveSV setContentSize:CGSizeMake(fiveSV.frame.size.width, 13*100+80)];
            
            
            
            
            [self.fiveView addSubview:fiveSV];
            
            [self.view addSubview:self.fiveView];
            
            
            
            
            
            
            
            
            
        }
            break;
            
            
        default:
            break;
    }










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
