//
//  ThirdViewController.m
//  bodhiWord
//
//  Created by apple on 14/12/2.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "ThirdViewController.h"

#import "JsonPostModel.h"
#import "WatchTVListUserInfo.h"

@interface ThirdViewController ()
@property(nonatomic,strong)UIScrollView*firstSV;
@property(nonatomic,strong)UIView*TVView;
@property(nonatomic,strong)UIView*filmsView;
@property(nonatomic,strong)UIView*videoView;
@property(nonatomic,strong)UIView*bookView;

@property(nonatomic,strong)UIView*listsView;

@property(nonatomic,strong)NSMutableArray*tvListAry;
@property(nonatomic,strong)NSMutableArray*filmsListAry;
@property(nonatomic,strong)NSMutableArray*videoListAry;
@property(nonatomic,strong)NSMutableArray*bookListAry;


@property(nonatomic,strong)JsonPostModel*jpm;
@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatBackBtn];
    self.tabBarController.tabBar.hidden = YES;
    
    
    
    
    [self creatView];
    
    
    
//[self JsonData];
  
   
    
}



-(void)JsonData
{
    self.jpm = [JsonPostModel shareJsonPostModel];
    [self.jpm requestWatchViewTVList:^(id obj) {
        self.tvListAry = obj;
        
    }];
    
    [self.jpm requestwatchviewFilmsList:^(id obj) {
        self.filmsListAry = obj;
    }];
    
    
    [self.jpm requestwatchViewVideoList:^(id obj) {
        
    }];
    
    [self.jpm requestwatchViewebookList:^(id obj) {
        
    }];


}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    
    
    
 NSLog(@"viewwillappear::%d",self.view.subviews.count);
}


-(void)creatBackBtn
{
     NSLog(@"creatBack:%d",self.view.subviews.count);
    
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

        [self.TVView removeFromSuperview];
        [self.filmsView removeFromSuperview];
        [self.videoView removeFromSuperview];
        [self.bookView removeFromSuperview];
        [self.firstSV removeFromSuperview];
        [self.listsView removeFromSuperview];
        
        [self creatView];
        
        
//        self.firstSV.hidden = NO;
//        NSLog(@"%lu",(unsigned long)self.view.subviews.count);

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
    [self.view addSubview:self.firstSV];




}

-(void)viewChanged:(UIButton*)sender
{
    self.firstSV.hidden = YES;
    [self clickButtonToView:sender.tag];
    
    
    
    }

-(void)lists:(UIButton*)sender
{
    self.TVView.hidden = YES;
    self.filmsView.hidden = YES;
    self.videoView.hidden = YES;
    self.bookView.hidden = YES;
    
    
    
    
    self.firstSV.hidden = YES;
    
    
    
    self.listsView = [[UIView alloc]initWithFrame:CGRectMake(0, 95, self.view.frame.size.width, self.view.frame.size.height-95)];
    
    UIImageView*imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.listsView.frame.size.width, self.listsView.frame.size.height)];
    imageView.image =[UIImage imageNamed:@"watch_05categories_20141105_bg"];
    
    [self.listsView addSubview:imageView];
    
    
    CGFloat width = self.view.frame.size.width/2;
    
    for (int i = 0; i<4; i++) {
        UIButton *btn  =[[ UIButton alloc]initWithFrame:CGRectMake(width-75, 13+i*56, 150, 25)];
        [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"watch_05categories_20141105_%02d",i+1]] forState:UIControlStateNormal];
        
        
        [btn addTarget:self action:@selector(lookView:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        btn.tag = i;
        
        
        
        [self.listsView addSubview: btn];
        NSLog(@"lists:%d",self.view.subviews.count);
        
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

    
    
    
    
    [self.view addSubview:self.listsView];
    
    
    
    
    
}


-(void)lookView:(UIButton*)sender
{
   
    self.listsView.hidden = YES;
    [self clickButtonToView:sender.tag];


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
            
            self.TVView = [[UIView alloc]initWithFrame:CGRectMake(0, 95, self.view.frame.size.width, self.view.frame.size.height-95)];
            
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
            
            
            
            
            UIScrollView*secondSV=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 30, self.TVView.frame.size.width, self.TVView.frame.size.height - 110)];
            secondSV.bounces= NO;
            secondSV.showsHorizontalScrollIndicator = NO;
            
            for (int i = 0; i<4; i++) {
                UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, i*120, self.TVView.frame.size.width, 120)];
                
                UIImageView*iv = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 150, 80)];
                
                UIImage*image = [UIImage imageNamed:[NSString stringWithFormat:@"playOne%02d.png",i+1]];
                iv.image = image;
                
                [view addSubview:iv];
                
                UIImageView*iv1 = [[UIImageView alloc]initWithFrame:CGRectMake(180, 40, 100, 30)];
                iv1.image = [UIImage imageNamed:@"002_watch_01tv_20141105_23"];
                
                [view addSubview:iv1];
                
                UIImageView*iv2 = [[UIImageView alloc]initWithFrame:CGRectMake(self.TVView.frame.size.width-80, 75, 25, 25)];
                iv2.image = [UIImage imageNamed:@"002_watch_01tv_20141105_29"];
                
                [view addSubview:iv2];
                
                UIButton * btn1 = [[UIButton alloc]initWithFrame:CGRectMake(self.TVView.frame.size.width-45, 75, 25, 25)];
                [btn1 setImage:[UIImage imageNamed:@"002_watch_01tv_20141105_26"] forState:UIControlStateNormal];
                
                [btn1 addTarget:self action:@selector(playVedio:) forControlEvents:UIControlEventTouchUpInside];
                
                [view addSubview:btn1];
                
                [secondSV addSubview:view];
                
                
                
                
            }
            
            [secondSV setContentSize:CGSizeMake(secondSV.frame.size.width, 4*120)];
            
            
            
            
            [self.TVView addSubview:secondSV];
            

            
            
            UIView*fiveIVdown=[[UIView alloc]initWithFrame:CGRectMake(0,self.TVView.frame.size.height-80,self.TVView.frame.size.width,80)];
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
            
            
            
            
            [self.TVView addSubview:fiveIVdown];
            
            
            
            [self.TVView addSubview:view];
            
            
            
           [self.view addSubview:self.TVView];

            
            
            
            
        }
            
            break;
        case 1:
            
        {
            
            self.filmsView = [[UIView alloc]initWithFrame:CGRectMake(0, 95, self.view.frame.size.width, self.view.frame.size.height-95)];
            
            UIView*view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
            
            
            UIButton*btn = [[UIButton alloc]initWithFrame:view.frame];
            [btn setImage:[UIImage imageNamed:@"004_watch_04_microfilm_20141105_02.png"] forState:UIControlStateNormal];
            
            [btn addTarget:self action:@selector(lists:) forControlEvents:UIControlEventTouchUpInside];
            
            [view addSubview:btn];
            [self.filmsView addSubview:view];
            
            
            UIScrollView*thirdSV=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 30, self.filmsView.frame.size.width, self.filmsView.frame.size.height - 30)];
            thirdSV.bounces= NO;
            thirdSV.showsHorizontalScrollIndicator = NO;
            
            for (int i = 0; i<8; i++) {
                UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, i*120, self.filmsView.frame.size.width, 120)];
                
                UIImageView*iv = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 80, 80)];
                
                UIImage*image = [UIImage imageNamed:@"004_watch_04_microfilm_20141105_05"];
                iv.image = image;
                
                [view addSubview:iv];
                
                UIImageView*iv1 = [[UIImageView alloc]initWithFrame:CGRectMake(95, 25, 120, 60)];
                iv1.image = [UIImage imageNamed:@"004_watch_04_microfilm_20141105_07.png"];
                
                [view addSubview:iv1];
                
                
                UIImageView*iv2 = [[UIImageView alloc]initWithFrame:CGRectMake(self.filmsView.frame.size.width-40, 75, 25, 25)];
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
            
            [self.filmsView addSubview:thirdSV];
            
            [self.view addSubview:self.filmsView];
            
            
            
        }
            
            
            break;
        case 2:
        {
            
            
            
            self.videoView = [[UIView alloc]initWithFrame:CGRectMake(0, 95, self.view.frame.size.width, self.view.frame.size.height-95)];
            
            UIView*view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
            
            
            UIButton*btn = [[UIButton alloc]initWithFrame:view.frame];
            [btn setImage:[UIImage imageNamed:@"004_watch_04_microfilm_20141105_02.png"] forState:UIControlStateNormal];
            
            [btn addTarget:self action:@selector(lists:) forControlEvents:UIControlEventTouchUpInside];
            
            [view addSubview:btn];
            [self.videoView addSubview:view];
            
            
            UIScrollView*fourSV=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 30, self.videoView.frame.size.width, self.videoView.frame.size.height - 30)];
            fourSV.bounces= NO;
            fourSV.showsHorizontalScrollIndicator = NO;
            
            for (int i = 0; i<4; i++) {
                
                
                UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, i*120, self.videoView.frame.size.width, 120)];
                
                UIImageView*iv = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 150, 80)];
                
                UIImage*image = [UIImage imageNamed:@"005_watch_03mv_20141105_05"];
                iv.image = image;
                
                [view addSubview:iv];
                
                UIImageView*iv1 = [[UIImageView alloc]initWithFrame:CGRectMake(180, 40, 100, 30)];
                iv1.image = [UIImage imageNamed:@"005_watch_03mv_20141105_08"];
                
                [view addSubview:iv1];
                
                UIImageView*iv2 = [[UIImageView alloc]initWithFrame:CGRectMake(self.videoView.frame.size.width-80, 75, 25, 25)];
                iv2.image = [UIImage imageNamed:@"005_watch_03mv_20141105_14"];
                
                [view addSubview:iv2];
                
                UIButton * btn1 = [[UIButton alloc]initWithFrame:CGRectMake(self.videoView.frame.size.width-45, 75, 25, 25)];
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
            
            [self.videoView addSubview:fourSV];
            
            [self.view addSubview:self.videoView];
            
            
            
        }
            break;
            
        case 3:
        {
            self.bookView = [[UIView alloc]initWithFrame:CGRectMake(0, 95, self.view.frame.size.width, self.view.frame.size.height-95)];
            
            UIView*view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
            
            
            UIButton*btn = [[UIButton alloc]initWithFrame:view.frame];
            [btn setImage:[UIImage imageNamed:@"004_watch_04_microfilm_20141105_02.png"] forState:UIControlStateNormal];
            
            [btn addTarget:self action:@selector(lists:) forControlEvents:UIControlEventTouchUpInside];
            
            [view addSubview:btn];
            [self.bookView addSubview:view];
            
            UIScrollView*fiveSV=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 30, self.bookView.frame.size.width, self.bookView.frame.size.height - 30)];
            fiveSV.bounces= NO;
            fiveSV.showsHorizontalScrollIndicator = NO;
            
            
            
            UIImageView*imageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, self.view.frame.size.width-30, 40)];
            imageView.image =[UIImage imageNamed:@"006_watch_05eComics_20141105_03"];
            
            [fiveSV addSubview:imageView];
            
            
            for (int i = 0; i<12; i++) {
                
                
                UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, 50+i*100, self.bookView.frame.size.width, 100)];
                
                UIImageView*iv = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 70, 70)];
                
                UIImage*image = [UIImage imageNamed:@"006_watch_05eComics_20141105_07"];
                iv.image = image;
                
                [view addSubview:iv];
                
                UIImageView*iv1 = [[UIImageView alloc]initWithFrame:CGRectMake(100, 30, 100, 30)];
                iv1.image = [UIImage imageNamed:@"006_watch_05eComics_20141105_13"];
                
                [view addSubview:iv1];
                
                UIImageView*iv2 = [[UIImageView alloc]initWithFrame:CGRectMake(self.bookView.frame.size.width-115, 30, 100, 30)];
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
            
            
            
            
            [self.bookView addSubview:fiveSV];
            
            [self.view addSubview:self.bookView];
            
            
            
            
            
            
            
            
            
        }
            break;
            
            
        default:
            break;
    }







 NSLog(@"btn::%d",self.view.subviews.count);


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
