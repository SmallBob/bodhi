//
//  FourViewController.m
//  bodhiWord
//
//  Created by apple on 14/12/2.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "FourViewController.h"

@interface FourViewController ()

@end

@implementation FourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [self creatBackBtn];
    self.tabBarController.tabBar.hidden = YES;

    // Do any additional setup after loading the view.

    UIScrollView * sv = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 95, self.view.frame.size.width, self.view.frame.size.height-95)];
    
    sv.bounces = NO;
    sv.showsHorizontalScrollIndicator = NO;
    
    
    
    UIImageView*imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, sv.frame.size.width, 760)];
    imageView.image =[UIImage imageNamed:@"bodhi-learn_02"];
    
    [sv addSubview:imageView];
    
    
    
    
    UIImageView*imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, sv.frame.size.width, 230)];
    imageView1.image =[UIImage imageNamed:@"bodhi-learn_03"];
    
    [sv addSubview:imageView1];
    
    [self.view addSubview:sv];
    
    
    UIButton*btn = [[UIButton alloc]initWithFrame:CGRectMake(sv.frame.size.width/2-10-80, 240, 80, 30)];
    [btn setImage:[UIImage imageNamed:@"bodhi-learn_07"] forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(iosBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [sv addSubview:btn];
    
    
    UIButton*btn1 = [[UIButton alloc]initWithFrame:CGRectMake(sv.frame.size.width/2+10, 240, 80, 30)];
    [btn1 setImage:[UIImage imageNamed:@"bodhi-learn_09"] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(androidBtn:) forControlEvents:UIControlEventTouchUpInside];

    
    [sv addSubview:btn1];
    
    


    UILabel*label = [[UILabel alloc]initWithFrame:CGRectMake(30, 290, sv.frame.size.width-60, 80)];
    label.text=@"文本框";
    label.backgroundColor = [UIColor grayColor];
    [sv addSubview:label];
    
    UIScrollView*scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(30, 380, sv.frame.size.width-60, 80)];
    scrollView.bounces = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    
    for (int i = 0 ; i<4; i++) {
        UIImageView*iv = [[UIImageView alloc]initWithFrame:CGRectMake(i*scrollView.frame.size.width, 0, scrollView.frame.size.width, scrollView.frame.size.height)];
        
        iv.image = [UIImage imageNamed:[NSString stringWithFormat:@"bodhi-learn%02d",i+1]];
        
        [scrollView addSubview:iv ] ;
        
    }
    
    
    [scrollView setContentSize:CGSizeMake(4*scrollView.frame.size.width, scrollView.frame.size.height)];
    [sv addSubview:scrollView];
    
    
    
    UIImageView*imageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 480, sv.frame.size.width, 80)];
    imageView2.image =[UIImage imageNamed:@"bodhi-learn_17"];
    
    [sv addSubview:imageView2];
    
    
    UIImageView*imageView3 = [[UIImageView alloc]initWithFrame:CGRectMake(sv.frame.size.width/2-50, 570, 100, 30)];
    imageView3.image =[UIImage imageNamed:@"bodhi-learn_21"];
    
    [sv addSubview:imageView3];

    
    
    UIView*fiveIVdown=[[UIView alloc]initWithFrame:CGRectMake(0,630,sv.frame.size.width,80)];

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
    

    
    
    [sv addSubview:fiveIVdown];
    
    [sv setContentSize:CGSizeMake(self.view.frame.size.width,710)];
    
    
    
    
    
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
        if (studyBtn.tag == 2 ) {
            studyBtn.enabled = NO;
            ;
        }

        
        [self.view addSubview:studyBtn];
        
        
    }
    
    
}

-(void)goSecondView:(UIButton*)sender
{
    [self.tabBarController setSelectedIndex:sender.tag];

    
}



-(void)iosBtn:(UIButton *)sender
{
    NSLog(@"iosBtn");

}

-(void)androidBtn:(UIButton *)sender
{
    NSLog(@"andriodBtn");
    
}



















-(void)backMainView:(UIButton*)sender
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
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
