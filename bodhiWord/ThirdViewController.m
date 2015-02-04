//
//  ThirdViewController.m
//  bodhiWord
//
//  Created by apple on 14/12/2.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "ThirdViewController.h"

#import "UIImageView+WebCache.h"

#import "JsonPostModel.h"
#import "WatchTVListUserInfo.h"
#import <MediaPlayer/MediaPlayer.h>

#import "WatchFilmsListUserInfo.h"
#import "UIButton+WebCache.h"

#import "WatchVideoListUserInfo.h"
#import "WatchBookListUserInfo.h"


@interface ThirdViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UIScrollView*firstSV;
@property(nonatomic,strong)UIView*TVView;
@property(nonatomic,strong)UIScrollView*secondSV;
@property(nonatomic,strong)UIWebView*webv;
@property(nonatomic,strong)UISegmentedControl*segmentControl;
@property(nonatomic,strong)UITableView*setTableView;
@property(nonatomic,copy)NSString*pageNo;

@property(nonatomic,strong)UIView*filmsView;
@property(nonatomic,strong)UIScrollView*filmsSV;

@property(nonatomic,strong)UIView*videoView;
@property(nonatomic,strong)UIScrollView*videoSV;

@property(nonatomic,strong)UIView*bookView;

@property(nonatomic,strong)UIView*listsView;

@property(nonatomic,strong)NSArray*watchMainAry;

@property(nonatomic,strong)NSArray*tvLists;
@property(nonatomic,strong)NSMutableArray*tvListAry;
@property(nonatomic,strong)NSMutableArray*filmsListAry;
@property(nonatomic,strong)NSMutableArray*videoListAry;
@property(nonatomic,strong)NSMutableArray*bookListAry;



//@property(nonatomic,strong)MPMoviePlayerViewController*videoTV;

@property(nonatomic,strong)JsonPostModel*jpm;
@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatBackBtn];
    self.tabBarController.tabBar.hidden = YES;
    
    
//    [self creatView];
//    [self JsonData];
   
    
}



-(void)JsonData
{
    self.jpm = [JsonPostModel shareJsonPostModel];
    
    self.tvListAry = [NSMutableArray array ];
    self.filmsListAry = [NSMutableArray array ];
    self.videoListAry = [NSMutableArray array ];
    self.bookListAry = [NSMutableArray array];
    
    [self.jpm requestwatchMainViewWithCallBack:^(id obj) {
        NSDictionary*dic = obj;
        
        
        self.watchMainAry = @[[dic objectForKey:@"tv"],
                              [dic objectForKey:@"film"],
                              [dic objectForKey:@"video"],
                              [dic objectForKey:@"book"]] ;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            [self creatView];
        });
        

       
        
    }];
    
    [self.jpm requestWatchViewTVListsNumber:^(id obj) {

        self.tvLists = obj;
        
        self.tvListAry = self.tvLists[0];
        
        
    }];
    
    
    
    
//    [self.jpm requestWatchViewTVListWithpageNO:@"1" andPageSize:@"10" andCallBack:^(id obj) {
////        self.tvListAry = obj;
//    }];
    
    
    
    [self.jpm requestwatchviewFilmsList:^(id obj) {
        self.filmsListAry = obj;

    }];
    
    
    [self.jpm requestwatchViewVideoList:^(id obj) {
        self.videoListAry = obj;
    }];
    
    [self.jpm requestwatchViewebookList:^(id obj) {
        self.bookListAry = obj;
    }];


}


-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    if (!self.jpm) {
        [self JsonData];
        
        
//        加载主界面json之后 加载数据
        }else
    {
        if (!self.firstSV ) {
            [self creatView];
        }else
         {
            self.firstSV.hidden = NO;
            self.TVView.hidden = YES;
            self.filmsView.hidden = YES;
            self.videoView.hidden = YES;
            self.bookView.hidden =YES;
            self.listsView.hidden = YES;
            
        }
    }
    

}


-(void)creatBackBtn
{
    
    UIButton*backBtn=[[UIButton alloc]initWithFrame:CGRectMake(10, 34, 75, 55)];
    [backBtn setImage:[UIImage imageNamed:@"ingame_logo"] forState:UIControlStateNormal];
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
        
        [self.view addSubview:studyBtn];
        
    }
    
}

-(void)goSecondView:(UIButton*)sender
{
    
    if (self.webv) {
        
        
        [UIView animateWithDuration:1 animations:^{
            CGRect frame = self.webv.frame;
            frame.size.height = 0;
            self.webv.frame =frame;
        } completion:^(BOOL finished) {
            [self.webv removeFromSuperview];
            self.webv = nil;
        }];
        
        
        [UIView animateWithDuration:1 animations:^{
            CGRect frame = self.secondSV.frame;
            frame.origin.y = 30;
            self.secondSV.frame =frame;
            
        }];
        
        [UIView animateWithDuration:5 animations:^{
            CGRect frame = self.filmsSV.frame;
            frame.origin.y = 30;
            self.filmsSV.frame =frame;
            
        }];

        [UIView animateWithDuration:5 animations:^{
            CGRect frame = self.videoSV.frame;
            frame.origin.y = 30;
            self.videoSV.frame =frame;
            
        }];
        
    }
    
    if (sender.tag == 1) {

        [self.TVView removeFromSuperview];
        [self.filmsView removeFromSuperview];
        [self.videoView removeFromSuperview];
        [self.bookView removeFromSuperview];
        [self.firstSV removeFromSuperview];
        [self.listsView removeFromSuperview];
        
        
        [self JsonData];
//        [self creatView];
       

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
 
#pragma 主界面4个按钮
    
    
    CGFloat width = (self.firstSV.frame.size.width-10)/2;
    for (int i=0; i<self.watchMainAry.count; i++) {
        
        UIImageView*imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10+i%2*width, 5+i/2*120, width-10, 30)];
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat: @"001_watch_06mainpage_20141105_0%d.png",i+1 ]];
        [self.firstSV addSubview:imageView];
        
        UIButton*btn = [[UIButton alloc]initWithFrame:CGRectMake(10+i%2*width, 35+i/2*120, width-10, 60)];
       
        
//        数据对应,有过更新
        
        [btn sd_setImageWithURL:[NSURL URLWithString:[self.watchMainAry[i] objectForKey:@"imgUrl"]] forState:UIControlStateNormal];
        
        
        btn.tag = i;
        [btn addTarget:self action:@selector(viewChanged:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.firstSV addSubview:btn];
        
        UIImageView*imageView1 =[[UIImageView alloc]initWithFrame:CGRectMake(10+i%2*width, 95+i/2*120, width-10, 30)];
        imageView1.image = [UIImage imageNamed:[NSString stringWithFormat:@"001_watch_06mainpage_20141105_1%d.png",i+1]];
        [self.firstSV addSubview:imageView1];
    }
    
    UIImageView*imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(10, 280, self.view.frame.size.width-20, 160)];
    imageView1.image = [UIImage imageNamed:@"001_watch_06mainpage_20141105_16.png"];
    
    [self.firstSV addSubview:imageView1];

  
    
    
    UIView*fiveIVdown=[[UIView alloc]initWithFrame:CGRectMake(0,470,self.firstSV.frame.size.width,50)];
    UIImageView*oneIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
    oneIV.image = [UIImage imageNamed:@"Bodhiword_76"];
    [fiveIVdown addSubview:oneIV];
    
    UIImageView*twoIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height-20)];
    twoIV.image = [UIImage imageNamed:@"Bodhiword_77"];
    [fiveIVdown addSubview:twoIV];
    
    UIButton*fiveBtnLeft=[[UIButton alloc]initWithFrame:CGRectMake(5 , 0, 65, 30)];
    
    
    UIButton*fiveBtnRight=[[UIButton alloc]initWithFrame:CGRectMake(fiveIVdown.frame.size.width-70, 0, 65, 30)];
    
    [oneIV addSubview:fiveBtnLeft];
    [oneIV addSubview:fiveBtnRight];

    
    
    [self.firstSV addSubview:fiveIVdown];
    
    [self.firstSV setContentSize:CGSizeMake(self.firstSV.frame.size.width, 520)];
    [self.view addSubview:self.firstSV];




}

-(void)viewChanged:(UIButton*)sender
{
    self.firstSV.hidden = YES;
    
    
    
    [self clickButtonToView:sender.tag];
    
    
    
    }

-(void)lists:(UIButton*)sender
{
    if (self.webv) {
        
    
    [UIView animateWithDuration:1 animations:^{
        CGRect frame = self.webv.frame;
        frame.size.height = 0;
        self.webv.frame =frame;
    } completion:^(BOOL finished) {
        [self.webv removeFromSuperview];
        self.webv = nil;
    }];
    
    
    [UIView animateWithDuration:1 animations:^{
        CGRect frame = self.secondSV.frame;
        frame.origin.y = 30;
        frame.size.height = self.secondSV.frame.size.height+230;
        self.secondSV.frame =frame;
    }];
        
        
    [UIView animateWithDuration:5 animations:^{
            CGRect frame = self.filmsSV.frame;
            frame.origin.y = 30;
        frame.size.height = self.filmsSV.frame.size.height+230;
            self.filmsSV.frame =frame;
            
    }];
        
    [UIView animateWithDuration:5 animations:^{
            CGRect frame = self.videoSV.frame;
            frame.origin.y = 30;
        frame.size.height = self.videoSV.frame.size.height+230;
            self.videoSV.frame =frame;
            
    }];
    
    }
    
    
    
    self.TVView.hidden = YES;
    self.filmsView.hidden = YES;
    self.videoView.hidden = YES;
    self.bookView.hidden = YES;
    
    
    
    
    self.firstSV.hidden = YES;
    
    
    
    self.listsView = [[UIView alloc]initWithFrame:CGRectMake(0, 95, self.view.frame.size.width, self.view.frame.size.height-95)];
//    self.listsView.frame=CGRectMake(0, 95, 0, self.view.frame.size.height-95);
//    
//    [UIView animateWithDuration:1 animations:^{
//        CGRect frame = self.listsView.frame;
//        frame.size.width = self.view.bounds.size.width/3;
//        self.listsView.frame = frame;
//    } completion:^(BOOL finished) {
//        
//    }];
    
    
    
    
    
    UIImageView*imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.listsView.frame.size.width, self.listsView.frame.size.height)];
    imageView.image =[UIImage imageNamed:@"watch_05categories_20141105_bg"];
    
    [self.listsView addSubview:imageView];
    
    
    CGFloat width = self.view.frame.size.width/2;
    
    for (int i = 0; i<4; i++) {
        UIButton *btn  =[[ UIButton alloc]initWithFrame:CGRectMake(width-75, 20+i*45, 150, 25)];
        [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"watch_05categories_20141105_%02d",i+1]] forState:UIControlStateNormal];
        
        
        [btn addTarget:self action:@selector(lookView:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        btn.tag = i;
        
        
        
        [self.listsView addSubview: btn];
       
        
    }
    
    
    UIImageView*fiveIVdown=[[UIImageView alloc]initWithFrame:CGRectMake(0,imageView.frame.size.height-50   ,imageView.frame.size.width    ,50)];
    UIImageView*oneIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
    oneIV.image = [UIImage imageNamed:@"Bodhiword_76"];
    [fiveIVdown addSubview:oneIV];
    
    UIImageView*twoIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height-20)];
    twoIV.image = [UIImage imageNamed:@"Bodhiword_77"];
    [fiveIVdown addSubview:twoIV];
    
    UIButton*fiveBtnLeft=[[UIButton alloc]initWithFrame:CGRectMake(5 , 0, 65, 30)];
    
    
    UIButton*fiveBtnRight=[[UIButton alloc]initWithFrame:CGRectMake(fiveIVdown.frame.size.width-70, 0, 65, 30)];
    
    
    
    
    
    [oneIV addSubview:fiveBtnLeft];
    
    [oneIV addSubview:fiveBtnRight];
    [imageView addSubview:fiveIVdown];

    
    
    
    
    [self.view addSubview:self.listsView];

    
    
    
    
}


-(void)lookView:(UIButton*)sender
{
   
    self.listsView.hidden = YES;
    
    
    
    
    
    [self clickButtonToView:sender.tag];


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
            
            self.segmentControl = [[UISegmentedControl alloc]initWithItems:@[@"季",@"集"]];
//            [segmentControl setBackgroundImage:[UIImage imageNamed:@"segmentControl.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
            
            
            self.segmentControl.backgroundColor= [UIColor colorWithRed:253/255.0 green:235/255.0 blue:247/255.0 alpha:1];
            
            self.segmentControl.frame =CGRectMake(50, 0,self.view.frame.size.width-50  , 30) ;
            
            
            
            
            [self.segmentControl addTarget:self action:@selector(tvSegmentControl:) forControlEvents:UIControlEventValueChanged];
            
            self.segmentControl.momentary = YES;
            
            
            
            
            
            
            
            
            
            
//            [self.segmentControl  setSelected:NO];
            [view addSubview:self.segmentControl];
            
            
            self.secondSV=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 30, self.TVView.frame.size.width, self.TVView.frame.size.height - 80)];
            self.secondSV.bounces= NO;
            self.secondSV.showsHorizontalScrollIndicator = NO;
            
            
#pragma TV
            for (int i = 0; i<self.tvListAry.count; i++) {
                WatchTVListUserInfo*tvUserInfo = self.tvListAry[i];
                
                UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, i*120, self.TVView.frame.size.width, 120)];
//                view.backgroundColor = [UIColor redColor];
                
                if (i%2 != 0) {
                    view.backgroundColor = [UIColor colorWithRed:253/255.0 green:235/255.0 blue:247/255.0 alpha:1];
                }
                
                UIImageView*iv = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 150, 80)];
                
                [iv sd_setImageWithURL:[NSURL URLWithString:tvUserInfo.imgUrl]];
                
                [view addSubview:iv];
                
                
                UILabel*label = [[UILabel alloc]initWithFrame:CGRectMake(180, 20, 100, 30)];
//                label.backgroundColor = [UIColor redColor];
                
                label.text = [NSString stringWithFormat:@"%@.%@",tvUserInfo.blues,tvUserInfo.title];
                label.font = [UIFont systemFontOfSize:12];
                label.textColor = [UIColor redColor];
                CGSize labelSize = {0,0};
                labelSize = [label.text sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(100,30) lineBreakMode: UILineBreakModeWordWrap];
                label.numberOfLines = 3;
                [view addSubview:label];
                
                
#pragma 分享
                
                UIButton*iv2 = [[UIButton alloc]initWithFrame:CGRectMake(self.TVView.frame.size.width-100, 60, 40, 40)];
                [iv2 setImage:[UIImage imageNamed:@"002_watch_01tv_20141105_29"] forState:UIControlStateNormal];
                
                iv2.tag = i;
                
                [iv2 addTarget:self action:@selector(tvShareVedio:) forControlEvents:UIControlEventTouchUpInside];
                
                
                [view addSubview:iv2];

                
                
                
                
                
                
                
                
#pragma 播放
                UIButton * btn1 = [[UIButton alloc]initWithFrame:CGRectMake(self.TVView.frame.size.width-50, 60, 40, 40)];
                [btn1 setImage:[UIImage imageNamed:@"002_watch_01tv_20141105_26"] forState:UIControlStateNormal];
                
                btn1.tag = i;
                
                
                [btn1 addTarget:self action:@selector(tvPlayVedio:) forControlEvents:UIControlEventTouchUpInside];
                
                [view addSubview:btn1];
                
                [self.secondSV addSubview:view];
                
                
                
                
            }
            
            [self.secondSV setContentSize:CGSizeMake(self.secondSV.frame.size.width, self.tvListAry.count*120)];
           
            
            [self.TVView addSubview:self.secondSV];
            
            
            UIView*fiveIVdown=[[UIView alloc]initWithFrame:CGRectMake(0,self.TVView.frame.size.height-50,self.TVView.frame.size.width,50)];
            UIImageView*oneIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
            oneIV.image = [UIImage imageNamed:@"Bodhiword_76"];
            [fiveIVdown addSubview:oneIV];
            
            UIImageView*twoIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 30)];
            twoIV.image = [UIImage imageNamed:@"Bodhiword_77"];
            [fiveIVdown addSubview:twoIV];
            
            UIButton*fiveBtnLeft=[[UIButton alloc]initWithFrame:CGRectMake(5 , 0, 65, 30)];
            
            
            UIButton*fiveBtnRight=[[UIButton alloc]initWithFrame:CGRectMake(fiveIVdown.frame.size.width-70, 0, 65, 30)];
            
            
            [oneIV addSubview:fiveBtnLeft];
            
            [oneIV addSubview:fiveBtnRight];
            
            
            
            
            [self.TVView addSubview:fiveIVdown];
            
            
            
            [self.TVView addSubview:view];
            
            
            
           [self.view addSubview:self.TVView];
  
            
        }
         
            break;
#pragma filmsView
        case 1:
            
        {
            
            self.filmsView = [[UIView alloc]initWithFrame:CGRectMake(0, 95, self.view.frame.size.width, self.view.frame.size.height-95)];
            
            UIView*view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
            
            
            UIButton*btn = [[UIButton alloc]initWithFrame:view.frame];
            [btn setImage:[UIImage imageNamed:@"004_watch_04_microfilm_20141105_02.png"] forState:UIControlStateNormal];
            
            [btn addTarget:self action:@selector(lists:) forControlEvents:UIControlEventTouchUpInside];
            
            [view addSubview:btn];
            [self.filmsView addSubview:view];

            
            self.filmsSV=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 30, self.filmsView.frame.size.width, self.filmsView.frame.size.height - 30)];
            self.filmsSV.bounces= NO;
            self.filmsSV.showsHorizontalScrollIndicator = NO;
            
            
           NSLog(@"%lu",(unsigned long)self.filmsListAry.count);
            
            for (int i = 0; i<self.filmsListAry.count; i++) {
                WatchFilmsListUserInfo*filmsUserInfo  = self.filmsListAry[i];
                
                UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, i*120, self.filmsView.frame.size.width, 120)];
                
                if (i%2 != 0) {
                    view.backgroundColor = [UIColor colorWithRed:253/255.0 green:235/255.0 blue:247/255.0 alpha:1];
                }

                
                UIButton*roleBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, 15, 80, 80)];
                roleBtn.tag = i;

                [roleBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:filmsUserInfo.imgUrl] forState:UIControlStateNormal];

//                [roleBtn addTarget:self action:@selector(roleVideoBtn:) forControlEvents:UIControlEventTouchUpInside];
                
                [view addSubview:roleBtn];
               
                
                
                
                
                
                
                
                
                
                
                
                
                UIImageView*iv1 = [[UIImageView alloc]initWithFrame:CGRectMake(95, 25, 80, 60)];
                [iv1 sd_setImageWithURL:[NSURL URLWithString:filmsUserInfo.type]];

                if (i!=self.filmsListAry.count) {
                   [view addSubview:iv1];
                    
                }
                
                UILabel*labelBodhi = [[UILabel alloc]initWithFrame:CGRectMake(175, 15, 60, 20)];
                labelBodhi.text =@"Bodhi";
                labelBodhi.font = [UIFont systemFontOfSize:10];
                labelBodhi.textColor = [UIColor colorWithRed:233/255.0 green:46/255.0 blue:177/255.0 alpha:1];
                
                [view addSubview:labelBodhi];
                
                UILabel*labelTitle = [[UILabel alloc]initWithFrame:CGRectMake(175, 35, 150, 30)];
//                labelTitle.backgroundColor = [UIColor redColor];
                
                labelTitle.text = filmsUserInfo.title;
                labelTitle.font = [UIFont systemFontOfSize:8];
                labelTitle.textColor = [UIColor colorWithRed:233/255.0 green:46/255.0 blue:177/255.0 alpha:1];
                [view addSubview:labelTitle];
                
                
                UIButton*iv2 = [[UIButton alloc]initWithFrame:CGRectMake(self.filmsView.frame.size.width-100, 65, 40, 40)];
                iv2.tag = i;

                [iv2 setImage:[UIImage imageNamed:@"004_watch_04_microfilm_20141105_10.png"] forState:UIControlStateNormal];
                [iv2 addTarget:self action:@selector(filmsShareVedio:) forControlEvents:UIControlEventTouchUpInside];
                
                [view addSubview:iv2];
                
                
                
//                ?????
                UIButton * btn1 = [[UIButton alloc]initWithFrame:CGRectMake(self.filmsView.frame.size.width-50, 65, 40, 40)];
                [btn1 setImage:[UIImage imageNamed:@"002_watch_01tv_20141105_26"] forState:UIControlStateNormal];
                
                btn1.tag = i;
                
                
                [btn1 addTarget:self action:@selector(roleVideoBtn:) forControlEvents:UIControlEventTouchUpInside];
                
                [view addSubview:btn1];

                
                [self.filmsSV addSubview:view];
                
                
                
                
            }
            
            
            
            UIView*fiveIVdown=[[UIView alloc]initWithFrame:CGRectMake(0,self.filmsListAry.count*120,self.filmsSV.frame.size.width,50)];
            UIImageView*oneIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
            oneIV.image = [UIImage imageNamed:@"Bodhiword_76"];
            [fiveIVdown addSubview:oneIV];
            
            UIImageView*twoIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 30)];
            twoIV.image = [UIImage imageNamed:@"Bodhiword_77"];
            [fiveIVdown addSubview:twoIV];
            
            UIButton*fiveBtnLeft=[[UIButton alloc]initWithFrame:CGRectMake(5 , 0, 65, 30)];
            
            
            UIButton*fiveBtnRight=[[UIButton alloc]initWithFrame:CGRectMake(fiveIVdown.frame.size.width-70, 0, 65, 30)];
            
            
            [oneIV addSubview:fiveBtnLeft];
            
            [oneIV addSubview:fiveBtnRight];

            
            [self.filmsSV addSubview:fiveIVdown];
            
            
            [self.filmsSV setContentSize:CGSizeMake(self.filmsSV.frame.size.width, self.filmsListAry.count*120+50)];
            
            
            
            [self.filmsView addSubview:self.filmsSV];
            
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
            
            
            self.videoSV=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 30, self.videoView.frame.size.width, self.videoView.frame.size.height - 30)];
            self.videoSV.bounces= NO;
            self.videoSV.showsHorizontalScrollIndicator = NO;
            
            for (int i = 0; i<self.videoListAry.count; i++) {
                WatchVideoListUserInfo*videoUserInfo =self.videoListAry[i];
                
                UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, i*120, self.videoView.frame.size.width, 120)];
                
                if (i%2 != 0) {
                    view.backgroundColor = [UIColor colorWithRed:253/255.0 green:235/255.0 blue:247/255.0 alpha:1];
                }
                
                UIImageView*iv = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 150, 80)];
                
                [iv sd_setImageWithURL:[NSURL URLWithString:videoUserInfo.imgUrl]];


                
                [view addSubview:iv];


                UILabel*label = [[UILabel alloc]initWithFrame:CGRectMake(180, 20, 140, 30)];
                label.text = videoUserInfo.title;
                label.font = [UIFont systemFontOfSize:16];
                label.textColor = [UIColor colorWithRed:233/255.0 green:46/255.0 blue:177/255.0 alpha:1];
                
                [view addSubview:label];
                
                
                UIButton*shareBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.videoView.frame.size.width-100, 65, 40, 40)];
                shareBtn.tag = i;

                [shareBtn setImage:[UIImage imageNamed:@"005_watch_03mv_20141105_14"] forState:UIControlStateNormal];
                [shareBtn addTarget:self action:@selector(videoShare:) forControlEvents:UIControlEventTouchUpInside];
                
                
                
                [view addSubview:shareBtn];
                
                UIButton * btn1 = [[UIButton alloc]initWithFrame:CGRectMake(self.videoView.frame.size.width-50, 65, 40, 40)];
                btn1.tag = i;
                [btn1 setImage:[UIImage imageNamed:@"005_watch_03mv_20141105_11"] forState:UIControlStateNormal];
                
                 [btn1 addTarget:self action:@selector(videoPlay:) forControlEvents:UIControlEventTouchUpInside];
                
                [view addSubview:btn1];
                
                [self.videoSV addSubview:view];
                
                
                
                
            }
            
            
            
            
            
            UIView*fiveIVdown=[[UIView alloc]initWithFrame:CGRectMake(0,self.videoListAry.count*120,self.videoSV.frame.size.width,50)];
            UIImageView*oneIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
            oneIV.image = [UIImage imageNamed:@"Bodhiword_76"];
            [fiveIVdown addSubview:oneIV];
            
            UIImageView*twoIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 30)];
            twoIV.image = [UIImage imageNamed:@"Bodhiword_77"];
            [fiveIVdown addSubview:twoIV];
            
            UIButton*fiveBtnLeft=[[UIButton alloc]initWithFrame:CGRectMake(5 , 0, 65, 30)];
            
            
            UIButton*fiveBtnRight=[[UIButton alloc]initWithFrame:CGRectMake(fiveIVdown.frame.size.width-70, 0, 65, 30)];
            
            
            [oneIV addSubview:fiveBtnLeft];
            
            [oneIV addSubview:fiveBtnRight];

            
            
            [self.videoSV addSubview:fiveIVdown];
            
            
            [self.videoSV setContentSize:CGSizeMake(self.videoSV.frame.size.width, self.videoListAry.count*120+50)];
            
            [self.videoView addSubview:self.videoSV];
            
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
            
            
            
            
            
            for (int i = 0; i<self.bookListAry.count; i++) {
                WatchBookListUserInfo*bookUserInfo = self.bookListAry[i];
                
                UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, 50+i*100, self.bookView.frame.size.width, 100)];
                
                if (i%2 != 0) {
                    view.backgroundColor = [UIColor colorWithRed:253/255.0 green:235/255.0 blue:247/255.0 alpha:1];
                }
                
                UIImageView*iv = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 70, 70)];
                

                [iv sd_setImageWithURL:[NSURL URLWithString:bookUserInfo.imgUrl]];
                
                [view addSubview:iv];
                
                
                UILabel*labelTitle = [[UILabel alloc]initWithFrame:CGRectMake(100, 30, 100, 30)];
                labelTitle.text = bookUserInfo.title;
                labelTitle.textColor = [UIColor redColor];
                labelTitle.font = [UIFont systemFontOfSize:16];
                
                [view addSubview:labelTitle];
                
                UIButton*btn = [[UIButton alloc]initWithFrame:CGRectMake(self.bookView.frame.size.width-115, 30, 100, 30)];
                btn.tag= i;

                [btn setImage:[UIImage imageNamed:@"006_watch_05eComics_20141105_10"] forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(bookBtn:) forControlEvents:UIControlEventTouchUpInside];
                
                [view addSubview:btn];
                
                
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


}


#pragma TV 播放视频按钮
-(void)tvPlayVedio:(UIButton*)sender
{
    
    
    
    
    
    WatchTVListUserInfo*userInfo = self.tvListAry[sender.tag];

    

    NSURL *url =[NSURL URLWithString:userInfo.watchTVVideoLink];
    
    if (!self.webv) {
        
        self.webv= [[UIWebView alloc]initWithFrame:CGRectMake(0,30 , self.view.bounds.size.width, 0)];
        
        [UIView animateWithDuration:1 animations:^{
           
            CGRect frame = self.webv.frame;
            frame.size.height = 200;
            self.webv.frame = frame;
            
        }];
 
        [UIView animateWithDuration:1 animations:^{
            CGRect frame = self.secondSV.frame;
            frame.origin.y = 230;
            frame.size.height = self.secondSV.frame.size.height-200;
            self.secondSV.frame = frame;
        }];
        
        [self.webv setScalesPageToFit:YES];
        [(UIScrollView *)[[self.webv subviews] objectAtIndex:0] setBounces:NO];
        [(UIScrollView *)[[self.webv subviews] objectAtIndex:0] setScrollEnabled:NO];
        
        NSURLRequest *request =[NSURLRequest requestWithURL:url];
        
        [self.webv loadRequest:request];
        
        
        [self.TVView addSubview:self.webv];
    }else{
        NSURLRequest *request =[NSURLRequest requestWithURL:url];
        
        [self.webv loadRequest:request];
        
    }
    
 
    [self swipeGR];
    
    
    if (self.setTableView  )
    {
        
        [UIView animateWithDuration:1 animations:^{
            
            CGRect frame = self.setTableView.frame;
            frame.size.height = 0;
            self.setTableView.frame = frame;
            
        } completion:^(BOOL finished) {
            
            
            [self.setTableView removeFromSuperview];
            self.setTableView = nil;
            
            
        }];
        
    }
    
    
    
}




-(void)swipeGR
{
    UISwipeGestureRecognizer *swipeGR = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipe:)];
    
    swipeGR.direction = UISwipeGestureRecognizerDirectionLeft | UISwipeGestureRecognizerDirectionRight;
    swipeGR.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:swipeGR];

}

    




//-(void)playVideoWithPath:(NSString*)path
//{
//    
//    NSURL *url =[NSURL URLWithString:path];
//
//    if (!self.webv) {
//    
//    self.webv= [[UIWebView alloc]initWithFrame:CGRectMake(10, 100, self.view.bounds.size.width-20, 200)];
//    
//    
//        
//        
//        
//    
//    [self.webv setScalesPageToFit:YES];
//    [(UIScrollView *)[[self.webv subviews] objectAtIndex:0] setBounces:NO];
//    [(UIScrollView *)[[self.webv subviews] objectAtIndex:0] setScrollEnabled:NO];
//
//    NSURLRequest *request =[NSURLRequest requestWithURL:url];
//    
//    [self.webv loadRequest:request];
//    
//    
//    [self.view addSubview:self.webv];
//    }else{
//        NSURLRequest *request =[NSURLRequest requestWithURL:url];
//        
//        [self.webv loadRequest:request];
//        
//    }
//    
//    
//    UISwipeGestureRecognizer *swipeGR = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipe:)];
//    
//    swipeGR.direction = UISwipeGestureRecognizerDirectionLeft | UISwipeGestureRecognizerDirectionRight;
//    swipeGR.numberOfTouchesRequired = 1;
//    [self.view addGestureRecognizer:swipeGR];
//
//}

-(void)swipe:(UISwipeGestureRecognizer*)gr
{
    
    
    
    [UIView animateWithDuration:1 animations:^{
        CGRect frame = self.webv.frame;
        frame.size.height = 0;
        
        self.webv.frame =frame;
    } completion:^(BOOL finished) {
        [self.webv removeFromSuperview];
        self.webv = nil;
    }];
    
    
    [UIView animateWithDuration:1 animations:^{
        CGRect frame = self.secondSV.frame;
        frame.origin.y = 30;
        frame.size.height = self.secondSV.frame.size.height+200;
        self.secondSV.frame =frame;
    }];

    [UIView animateWithDuration:1 animations:^{
        CGRect frame = self.filmsSV.frame;
        frame.origin.y = 30;
        frame.size.height = self.filmsSV.frame.size.height+200;
        self.filmsSV.frame =frame;
    }];
    
    
    [UIView animateWithDuration:1 animations:^{
        CGRect frame = self.videoSV.frame;
        frame.origin.y = 30;
        frame.size.height = self.videoSV.frame.size.height+200;
        self.videoSV.frame =frame;
    }];
    
}




#pragma tvSegmentControl
-(void)tvSegmentControl:(UISegmentedControl*)sender
{
    
    CGFloat width =sender.frame.size.width/2;
    
    switch (sender.selectedSegmentIndex) {
        case 0:
            
            NSLog(@"%d",sender.selectedSegmentIndex);
            
            break;
        case 1:
        {
             NSLog(@"%d",sender.selectedSegmentIndex);
            
            if (!self.setTableView) {
                 NSString*title = [NSString stringWithFormat:@"共 %@ 集",self.tvLists[1]];
                [sender setTitle:title forSegmentAtIndex:1];
            }
           
            
            
            
            
            if(!self.setTableView){
                
                
                
                self.setTableView = [[UITableView alloc]initWithFrame:CGRectMake(self.segmentControl.frame.origin.x+width, self.segmentControl.frame.size.height, width, 0)];
                
                self.setTableView.backgroundColor = [UIColor colorWithRed:253/255.0 green:235/255.0 blue:247/255.0 alpha:1];
                
                
                [UIView animateWithDuration:1 animations:^{
                    
                    sleep(0.5);
                    
                    CGRect frame = self.setTableView.frame;
                    frame.size.height = 4*self.segmentControl.frame.size.height;
                    self.setTableView.frame = frame;
                    
                } completion:^(BOOL finished) {
                    
                    sleep(0.5);
                    self.segmentControl.enabled = YES;
                }];
                
                
                
                self.setTableView.dataSource =self;
                self.setTableView.delegate = self;
                
                [self.TVView addSubview: self.setTableView];
                
                
            }else
            {
                
                [UIView animateWithDuration:1 animations:^{
                    
                    CGRect frame = self.setTableView.frame;
                    frame.size.height = 0;
                    self.setTableView.frame = frame;
                    
                } completion:^(BOOL finished) {
                    
                    
                    [self.setTableView removeFromSuperview];
                    self.setTableView = nil;
                    
                    
                }];
                
            }
            
            
            
            
        }
            break;
            
        default:
            break;
    }
    
    
    

}




-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    int num = [self.tvLists[1] intValue];
    
    int count = num%10==0 ? num/10 :num/10+1;
    
    
    
    return count;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString*identifier = @"Cell";
    UITableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    
    
    
    NSString*text = [NSString stringWithFormat:@"%02d------%02d",1+indexPath.row*10,10+indexPath.row*10];
    if ([self.tvLists[1] intValue]%10 != 0 && [self.tvLists[1] intValue]/10 == indexPath.row) {
        text =[NSString stringWithFormat:@"%02d------%02d",1+indexPath.row*10,[self.tvLists[1] intValue]];
    }
    
    cell.textLabel.text = text;
    
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    cell.backgroundColor = [UIColor clearColor];
    
    
    UIView*v = [[UIView alloc]init];
    v.backgroundColor = [UIColor redColor];
    [cell addSubview:v];
    cell.selectedBackgroundView = v;
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if ([tableView isEqual:self.setTableView]) {
    
    if (self.setTableView )
    {
        
        [UIView animateWithDuration:1 animations:^{
            
            CGRect frame = self.setTableView.frame;
            frame.size.height = 0;
            self.setTableView.frame = frame;
            
        } completion:^(BOOL finished) {
            
            
            [self.setTableView removeFromSuperview];
            self.setTableView = nil;
            
            
        }];
        
    }
    
    if (self.webv) {
        
    
    [UIView animateWithDuration:1 animations:^{
        CGRect frame = self.webv.frame;
        frame.size.height = 0;
        self.webv.frame =frame;
    } completion:^(BOOL finished) {
        [self.webv removeFromSuperview];
        self.webv = nil;
    }];

    }
    
    
    
    NSString*text = [NSString stringWithFormat:@"%02d------%02d",1+indexPath.row*10,10+indexPath.row*10];
    if ([self.tvLists[1] intValue]%10 != 0 && [self.tvLists[1] intValue]/10 == indexPath.row) {
        text =[NSString stringWithFormat:@"%02d------%02d",1+indexPath.row*10,[self.tvLists[1] intValue]];
    }
        [self.segmentControl setTitle:text forSegmentAtIndex:1];
    
    self.pageNo = [NSString stringWithFormat:@"%d",indexPath.row+1];

    NSLog(@"%@",self.pageNo);
    
    
    [self.secondSV removeFromSuperview];
    self.secondSV = nil;
    self.tvListAry = [NSMutableArray array ];
    [self.jpm requestWatchViewTVListWithpageNO:self.pageNo andPageSize:@"10" andCallBack:^(id obj) {
        
       self.tvListAry =obj;
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
           

            self.secondSV=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 30, self.TVView.frame.size.width, self.TVView.frame.size.height - 80)];
            self.secondSV.bounces= NO;
            self.secondSV.showsHorizontalScrollIndicator = NO;
            
            
#pragma TV
            for (int i = 0; i<self.tvListAry.count; i++) {
                WatchTVListUserInfo*tvUserInfo = self.tvListAry[i];
                
                UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, i*120, self.TVView.frame.size.width, 120)];
                
                UIImageView*iv = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 150, 80)];
                
                [iv sd_setImageWithURL:[NSURL URLWithString:tvUserInfo.imgUrl]];
                
                [view addSubview:iv];
                
                
                UILabel*label = [[UILabel alloc]initWithFrame:CGRectMake(180, 40, 100, 30)];
                label.text = [NSString stringWithFormat:@"%@.%@",tvUserInfo.blues,tvUserInfo.title];
                label.font = [UIFont systemFontOfSize:12];
                label.textColor = [UIColor redColor];
                CGSize labelSize = {0,0};
                labelSize = [label.text sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(100,30) lineBreakMode: UILineBreakModeWordWrap];
                label.numberOfLines = 3;
                [view addSubview:label];
                
                
#pragma 分享
                UIButton*iv2 = [[UIButton alloc]initWithFrame:CGRectMake(self.TVView.frame.size.width-80, 75, 25, 25)];
                [iv2 setImage:[UIImage imageNamed:@"002_watch_01tv_20141105_29"] forState:UIControlStateNormal];
                
                iv2.tag = i;
                
                [iv2 addTarget:self action:@selector(tvShareVedio:) forControlEvents:UIControlEventTouchUpInside];
                
                
                [view addSubview:iv2];
                
#pragma 播放
                UIButton * btn1 = [[UIButton alloc]initWithFrame:CGRectMake(self.TVView.frame.size.width-45, 75, 25, 25)];
                [btn1 setImage:[UIImage imageNamed:@"002_watch_01tv_20141105_26"] forState:UIControlStateNormal];
                
                btn1.tag = i;
                
                
                [btn1 addTarget:self action:@selector(tvPlayVedio:) forControlEvents:UIControlEventTouchUpInside];
                
                [view addSubview:btn1];
                
                [self.secondSV addSubview:view];
                
                
                
                
            }
            
            [self.secondSV setContentSize:CGSizeMake(self.secondSV.frame.size.width, self.tvListAry.count*120)];
            
            
            [self.TVView addSubview:self.secondSV];
            
            
            
            
            
        });
        
        
    }];
    
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.segmentControl.frame.size.height;
}

#pragma TV 分享视频按钮

-(void)tvShareVedio:(UIButton*)sender
{
    NSLog(@"分享按钮 ");
    UIAlertView*av = [[UIAlertView alloc]initWithTitle:@"分享" message:@"分享功能，正在检修中..." delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"ok", nil];
    [av show];
    

}

#pragma films role按钮播放
-(void)roleVideoBtn:(UIButton*)sender
{
    
    
    
    
    
    WatchFilmsListUserInfo*filmsUserInfo =self.filmsListAry[sender.tag];
    
    NSURL *url =[NSURL URLWithString:filmsUserInfo.watchFilmsID];
    
    if (!self.webv) {
        
        self.webv= [[UIWebView alloc]initWithFrame:CGRectMake(0,30 , self.view.bounds.size.width, 0)];
        
        [UIView animateWithDuration:1 animations:^{
            
            CGRect frame = self.webv.frame;
            frame.size.height = 200;
            self.webv.frame = frame;
            
        }];
        
        [UIView animateWithDuration:1 animations:^{
            CGRect frame = self.filmsSV.frame;
            frame.origin.y = 230;
            frame.size.height = self.filmsSV.frame.size.height-200;
            self.filmsSV.frame = frame;
        }];
        
        [self.webv setScalesPageToFit:YES];
        [(UIScrollView *)[[self.webv subviews] objectAtIndex:0] setBounces:NO];
        [(UIScrollView *)[[self.webv subviews] objectAtIndex:0] setScrollEnabled:NO];
        
        NSURLRequest *request =[NSURLRequest requestWithURL:url];
        
        [self.webv loadRequest:request];
        
        
        [self.filmsView addSubview:self.webv];
    }else{
        NSURLRequest *request =[NSURLRequest requestWithURL:url];
        
        [self.webv loadRequest:request];
        
    }
    
    
    [self swipeGR];
    
    
    
    


}

#pragma films role分享按钮
-(void)filmsShareVedio:(UIButton*)sender
{
    UIAlertView*av = [[UIAlertView alloc]initWithTitle:@"分享" message:@"分享功能，正在检修中..." delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"ok", nil];
    [av show];

}

#pragma video Role播放按钮
-(void)videoPlay:(UIButton*)sender
{
    WatchVideoListUserInfo*filmsUserInfo =self.videoListAry[sender.tag];
//    [self playVideoWithPath:filmsUserInfo.link];

    NSURL *url =[NSURL URLWithString:filmsUserInfo.watchVideoID];
    
    if (!self.webv) {
        
        self.webv= [[UIWebView alloc]initWithFrame:CGRectMake(0,30 , self.view.bounds.size.width, 0)];
        
        [UIView animateWithDuration:1 animations:^{
            
            CGRect frame = self.webv.frame;
            frame.size.height = 200;
            self.webv.frame = frame;
            
        }];
        
        [UIView animateWithDuration:1 animations:^{
            CGRect frame = self.videoSV.frame;
            frame.origin.y = 230;
            frame.size.height = self.videoSV.frame.size.height-200;
            self.videoSV.frame = frame;
        }];
        
        [self.webv setScalesPageToFit:YES];
        [(UIScrollView *)[[self.webv subviews] objectAtIndex:0] setBounces:NO];
        [(UIScrollView *)[[self.webv subviews] objectAtIndex:0] setScrollEnabled:NO];
        
        NSURLRequest *request =[NSURLRequest requestWithURL:url];
        
        [self.webv loadRequest:request];
        
        
        [self.videoView addSubview:self.webv];
    }else{
        NSURLRequest *request =[NSURLRequest requestWithURL:url];
        
        [self.webv loadRequest:request];
        
    }
    
    
    [self swipeGR];
}

#pragma video share
-(void)videoShare:(UIButton*)sender
{
    UIAlertView*av = [[UIAlertView alloc]initWithTitle:@"分享" message:@"分享功能，正在检修中..." delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"ok", nil];
    [av show];

}


#pragma book 跳转
-(void)bookBtn:(UIButton*)sender
{
    
    WatchBookListUserInfo*bookUserInfo = self.bookListAry[sender.tag];
    NSLog(@"%@",bookUserInfo.link);
    
    self.webv = [[UIWebView alloc]init];
        self.webv.backgroundColor = [UIColor grayColor];
    
        [self.webv setScalesPageToFit:YES];
        [(UIScrollView *)[[self.webv subviews] objectAtIndex:0] setBounces:NO];
        [(UIScrollView *)[[self.webv subviews] objectAtIndex:0] setScrollEnabled:NO];
    //    NSString*urlString =@"http://v.qq.com/iframe/player.html?vid=u01430toez0&tiny=0&auto=0";
        NSURL *url =[NSURL URLWithString:bookUserInfo.link];
    
        NSURLRequest *request =[NSURLRequest requestWithURL:url];
    
        [self.webv loadRequest:request];
    
    
        [self.view addSubview:self.webv];
    
        [self.webv removeFromSuperview];

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
