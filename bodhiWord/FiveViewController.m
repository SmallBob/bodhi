//
//  FiveViewController.m
//  bodhiWord
//
//  Created by apple on 14/12/2.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "FiveViewController.h"

@interface FiveViewController ()<UIAlertViewDelegate>
@property(nonatomic,strong)UIView * leftView;
@property(nonatomic,strong)UIView * leftBtnRoleView;
@property(nonatomic,strong)UISegmentedControl*segmentedControl;
@property(nonatomic,strong)UIView*rightBtnRoleView;


@property(nonatomic,strong)UIView * rightView;

@property(nonatomic)NSInteger num;

@end

@implementation FiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [self creatBackBtn];
    
    [self creatSegmentControllerLeftView];
    [self creatSegmentControllerRightView];
    
    
    
    self.tabBarController.tabBar.hidden = YES;
    self.rightView.hidden = YES;
    
    
    UIImage*image = [UIImage imageNamed:@"create_01wallpaper_20141105_02"];
   
    
    
    
    self.segmentedControl = [[UISegmentedControl alloc]initWithItems:@[@"",@""]];
    [self.segmentedControl addTarget:self action:@selector(changedSegment:) forControlEvents:UIControlEventValueChanged];
    
    self.segmentedControl.selectedSegmentIndex = 0;
    
    
    self.segmentedControl.frame = CGRectMake(0, 95, self.view.frame.size.width, 30);
    
    [self.segmentedControl setBackgroundImage:image forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    
    [self.view addSubview:self.segmentedControl];


    // Do any additional setup after loading the view.
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
    if (sender.tag == 3) {
    
    
        
    self.leftBtnRoleView.hidden = YES;
    self.leftView.hidden = NO;
        self.rightView.hidden = YES;
        
        self.segmentedControl.selectedSegmentIndex = 0;
    
    
}else{

    [self.tabBarController setSelectedIndex:sender.tag];
   }
    
}



-(void)backMainView:(UIButton*)sender
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}





-(void)creatSegmentControllerLeftView
{
    
    self.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 125, self.view.frame.size.width, self.view.frame.size.height-95)];
    
    UIScrollView*sv = [[UIScrollView alloc]initWithFrame:self.view.frame];
    sv.bounces = NO;
    sv.showsHorizontalScrollIndicator = NO;
    
    CGFloat width = (self.view.frame.size.width-15)/2;
    for (int i = 0; i<10; i++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(5+i%2*(width+5), 5+i/2*(width+5), width,width)];
        [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"create_01wallpaper_20141105_0%02d",i+1]] forState:UIControlStateNormal];
        btn.tag = i;
        
        [btn addTarget:self action:@selector(roleBtn:) forControlEvents:UIControlEventTouchUpInside];
        [sv addSubview:btn];
        
        
    }
    
    UIView*fiveIVdown=[[UIView alloc]initWithFrame:CGRectMake(0,5*width+5*6,sv.frame.size.width,50)];
    
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

    
    
    [sv addSubview:fiveIVdown];
    
    
    
    
    
    [sv setContentSize:CGSizeMake(sv.frame.size.width, 5*width+5*6+170)];
    
    
    
    
    [self.leftView addSubview:sv];
    [self.view addSubview:self.leftView];
    


}


-(void)creatSegmentControllerRightView{


    self.rightView = [[UIView alloc]initWithFrame:CGRectMake(0, 125, self.view.frame.size.width, self.view.frame.size.height-95)];
    
    UIImageView*imageview = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 150, 130)];
    imageview.image = [UIImage imageNamed:@"create_03sticker_04"];
    [self.rightView addSubview: imageview ] ;
    
    
    UIImageView*imageview1 = [[UIImageView alloc]initWithFrame:CGRectMake(self.rightView.frame.size.width/2+10, 50, self.rightView.frame.size.width/4, 40)];
    imageview1.image = [UIImage imageNamed:@"create_03sticker_07"];
    [self.rightView addSubview:imageview1];
    
    
    UIButton*btn = [[UIButton alloc]initWithFrame:CGRectMake(self.rightView.frame.size.width/2-10, 100, self.rightView.frame.size.width/2-30, 50)];
    [btn setImage:[UIImage imageNamed:@"create_03sticker_10"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(addRoleBag:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    [self.rightView addSubview:btn];
    
    
    
    
//    表情
    UIImageView*imageview2 = [[UIImageView alloc]initWithFrame:CGRectMake(10, 160, 50, 50)];
    imageview2.image = [UIImage imageNamed:@"create_03sticker_15"];
    [self.rightView addSubview:imageview2];

    
    
    
    UIView*fiveIVdown=[[UIView alloc]initWithFrame:CGRectMake(0,self.rightView.frame.size.height-80 ,self.rightView.frame.size.width,50)];
    
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

    
    
    
    
    [self.rightView addSubview:fiveIVdown];
    
    [self.view addSubview: self.rightView ] ;
    
    

}



//下载表情包
-(void)addRoleBag:(UIButton*)sender
{
    UIAlertView*av = [[UIAlertView alloc]initWithTitle:@"提示" message:@"表情包下载，更新中..." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"ok", nil];
    [av show];
}



-(void)changedSegment:(UISegmentedControl*)sender
{

    
    switch (sender.selectedSegmentIndex) {
        case 0:
        {
        
            self.leftView.hidden = NO;
            self.rightView.hidden = YES;
            
        
        }
            break;
            
            
        case 1:
        {
            self.leftView.hidden = YES;
            self.rightView.hidden = NO;
            
            
        }
            break;
        default:
            break;
    }

    
    
    
    
}


-(void)roleBtn :(UIButton*)sender
{
    
    self.leftBtnRoleView = [[UIView alloc]initWithFrame:CGRectMake(0, 95, self.view.frame.size.width, self.view.frame.size.height-95)];
    
    

            self.leftView.hidden = YES;
            
            
            UIButton*btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.leftBtnRoleView.frame.size.width, 30)];
           UIImage*image  =[UIImage imageNamed:@"create_02getwallpaper_20141105_02"];
            
            
            [btn setImage:image forState:UIControlStateNormal];
            
            [btn addTarget:self action:@selector(backLeftView:) forControlEvents:UIControlEventTouchUpInside];
            
            
            
            
            
            [self.leftBtnRoleView addSubview:btn];
            
            
    
            UIImageView*imageView = [[UIImageView alloc]initWithFrame:CGRectMake(33, 32, self.view.frame.size.width-66, self.leftBtnRoleView.frame.size.height - 32-2-50)];
            imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"750wallpaper_0%d.jpg",sender.tag+1]];
            
            [self.leftBtnRoleView addSubview:imageView];
            
            UIButton*btn1 = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-80,52, 160, 40)];
    
            btn1.tag = sender.tag;
    
    
            [btn1 setImage:[UIImage imageNamed:@"create_02getwallpaper_20141105_08"] forState:UIControlStateNormal];
#pragma get this wallPaper
            
    [btn1 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
            
            
            
            [self.leftBtnRoleView addSubview:btn1];
    
            
            
    
    UIView*fiveIVdown=[[UIView alloc]initWithFrame:CGRectMake(0,self.leftBtnRoleView.frame.size.height-50,self.view.frame.size.width,50)];
    
    UIImageView*oneIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
    oneIV.image = [UIImage imageNamed:@"Bodhiword_76"];
    [fiveIVdown addSubview:oneIV];
    
    UIImageView*twoIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 30)];
    twoIV.image = [UIImage imageNamed:@"Bodhiword_77"];
    [fiveIVdown addSubview:twoIV];
    
    UIButton*fiveBtnLeft=[[UIButton alloc]initWithFrame:CGRectMake(5 , 0, 65, 20)];
    
    
    UIButton*fiveBtnRight=[[UIButton alloc]initWithFrame:CGRectMake(fiveIVdown.frame.size.width-70, 0, 65, 20)];
    fiveIVdown.backgroundColor = [UIColor redColor];
    
    [oneIV addSubview:fiveBtnLeft];
    
    [oneIV addSubview:fiveBtnRight];
    
    [self.leftBtnRoleView addSubview: fiveIVdown];
 
    [self.view addSubview:self.leftBtnRoleView];
    
    
    
}



-(void)click:(UIButton*)sender
{
    self.num = sender.tag;
    UIAlertView*av = [[UIAlertView alloc]initWithTitle:@"提示" message:@"是否下载当前照片" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
    
    
    
    [av show];
    
    
   
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (buttonIndex==1) {
        UIImageWriteToSavedPhotosAlbum([UIImage imageNamed:[NSString stringWithFormat:@"750wallpaper_0%d.jpg",self.num+1]], self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), nil);
    }

}


- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    NSString *message = @"呵呵";
    if (!error) {
        message = @"成功保存到相册";
    }else
    {
        message = [error description];
    }
    NSLog(@"message is %@",message);
}

-(void)backLeftView:(UIButton*)sender
{
    self.leftBtnRoleView.hidden = YES;
    self.leftView.hidden = NO;



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
