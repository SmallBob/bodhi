//
//  RoleViewController.m
//  bodhiWord
//
//  Created by 王凯 on 15/1/17.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "RoleViewController.h"
#import "AppDelegate.h"

@interface RoleViewController ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIPageControl*pageCtrl;
@property(nonatomic,strong)UIView*changeView;
@property(nonatomic,strong)UIScrollView*helpScrView;
@property(nonatomic,strong)NSMutableArray*mutableAry;

@property(nonatomic,strong)NSMutableArray*charaterAry;
@property(nonatomic,strong)UIImageView*iv;
@end

@implementation RoleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.hidden = YES;
    
    [self creatBackBtn];
    
    
    self.mutableAry = [NSMutableArray array];
    self.charaterAry = [NSMutableArray array];
        for (int i = 0; i<8; i++) {
            //            UIImage*image =[UIImage imageNamed:[NSString stringWithFormat:@"character_%02d",i]];
            UIImage*imageName = [UIImage imageNamed:[NSString stringWithFormat:@"role_0%d.png",i+1] ];
            
            [self.mutableAry addObject:imageName];
            
            UIImage*imageRole = [UIImage imageNamed:[NSString stringWithFormat:@"charater%d_02.png",i+1]];
            
            [self.charaterAry addObject:imageRole];
            
        }
    

//
    
    
    
    
    
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{[super viewWillAppear:animated];
    self.contentNum =((AppDelegate*)[UIApplication sharedApplication].delegate).roleNum ;
    //NSLog(@"contentNum:::%d",self.contentNum);

 [self creatRoleImageWithNum:((AppDelegate*)[UIApplication sharedApplication].delegate).roleNum ];
}


-(void)creatRoleImageWithNum:(int)num

{
    
    
    self.changeView = [[UIView alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height-100-50)];
    [self.view addSubview:self.changeView];
    
//主背景
    
    UIImageView*imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"charater~~_02"]];
    
    imageView.frame = CGRectMake(0, 0, self.changeView.frame.size.width, self.changeView.frame.size.height);
    
    [self.changeView addSubview:imageView];
    
    
//  草地
    UIImageView*mainIV= [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"charater_cao_02"]];
    mainIV.frame  = CGRectMake(0, 0, self.changeView.frame.size.width, self.changeView.frame.size.height);
    
    [self.changeView addSubview:mainIV];
    
    
//  左右
    UIImageView*leftIV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"charater_03"]];
    
    leftIV.frame = CGRectMake(10, self.changeView.frame.size.height-100, 30,80);
    
//    leftIV.backgroundColor = [UIColor redColor];
    
    [self.changeView addSubview:leftIV];
    
    UIImageView*rightIV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"charater_08"]];
    
    rightIV.frame = CGRectMake(self.changeView.frame.size.width-40, self.changeView.frame.size.height-100, 30,80);
    
    [self.changeView addSubview:rightIV];
    
    
    
    
    
    CGRect bounds = self.changeView.frame;
    
    
    
    
    
    
    self.helpScrView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, bounds.size.width,bounds.size.height)];
    
    self.helpScrView.pagingEnabled = YES;
    self.helpScrView.bounces = NO; //边界
    [self.helpScrView setDelegate:self];
    self.helpScrView.showsVerticalScrollIndicator = NO;//上下滑动
    self.helpScrView.showsHorizontalScrollIndicator = YES ;//左右滑动
    
    
    
    for (int i = 0; i<self.mutableAry.count; i++) {
        self.iv = [[UIImageView alloc]initWithFrame:CGRectMake(bounds.size.width*i, 0, bounds.size.width, bounds.size.height)];
        self.iv.image = self.charaterAry[i];
        [self.helpScrView addSubview:self.iv];
        
        UIImageView*imageView = [[UIImageView alloc]initWithFrame:CGRectMake(bounds.size.width/3+bounds.size.width*i,bounds.size.height -75 , bounds.size.width/2, 40)];
        imageView.image = self.mutableAry[i];
        [self.helpScrView addSubview:imageView];
        
        UIButton*playBtn = [[UIButton alloc]initWithFrame:CGRectMake(50+bounds.size.width*i, bounds.size.height-75, 40, 40)];
        playBtn.tag = i;
        [playBtn setImage:[UIImage imageNamed:@"btn_movies_button.png"] forState:UIControlStateNormal];
//        playBtn.backgroundColor = [UIColor redColor];
        
        [playBtn addTarget:self action:@selector(playBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.helpScrView addSubview:playBtn];
        
        
    }
    
   
    [self.helpScrView setContentSize:CGSizeMake(self.mutableAry.count*self.helpScrView.frame.size.width, self.helpScrView.frame.size.height)];
    [self.changeView addSubview:self.helpScrView];
    
    self.pageCtrl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, bounds.size.height -20,bounds.size.width,20)];
    self.pageCtrl.numberOfPages = self.mutableAry.count;
    self.pageCtrl.currentPage = num;
    
    self.pageCtrl.currentPageIndicatorTintColor = [UIColor yellowColor];
    self.pageCtrl.pageIndicatorTintColor = [UIColor grayColor];

    [self.changeView addSubview:self.pageCtrl];
    
    [self.helpScrView setContentOffset:CGPointMake(bounds.size.width * self
                                                   .pageCtrl.currentPage, 0)];
    


}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGPoint offset = scrollView.contentOffset;
    CGRect bounds =scrollView.frame;
    [self.pageCtrl setCurrentPage:offset.x/(bounds.size.width )];
    
    
}


-(void)playBtn:(UIButton*)sender
{
    


}



-(void)creatBackBtn
{
    
    UIButton*backBtn=[[UIButton alloc]initWithFrame:CGRectMake(10, 34, 80, 60)];
    [backBtn setImage:[UIImage imageNamed:@"ingame_logo"] forState:UIControlStateNormal];
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
    
    
    UIView*fiveIVdown=[[UIView alloc]initWithFrame:CGRectMake(0,  self.view.frame.size.height-50, self.view.frame.size.width, 50)];
    UIImageView*oneIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
    oneIV.image = [UIImage imageNamed:@"Bodhiword_76"];
    [fiveIVdown addSubview:oneIV];
    
    UIImageView*twoIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 50)];
    twoIV.image = [UIImage imageNamed:@"Bodhiword_77"];
    [fiveIVdown addSubview:twoIV];
    
    UIButton*fiveBtnLeft=[[UIButton alloc]initWithFrame:CGRectMake(5 , 0, 65, 30)];
    
    
    UIButton*fiveBtnRight=[[UIButton alloc]initWithFrame:CGRectMake(fiveIVdown.frame.size.width-70, 0, 65, 30)];
    
    
    [oneIV addSubview:fiveBtnLeft];
    
    [oneIV addSubview:fiveBtnRight];
    
    [self.view addSubview:fiveIVdown];

    
    
}

//返回主界面方法
-(void)backMainView:(UIButton*)sender
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}

-(void)goSecondView:(UIButton*)btn
{
    //     NSLog(@"%d",self.view.subviews.count);
    [self.tabBarController setSelectedIndex:btn.tag];

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
