//
//  RegisteViewController.m
//  bodhiWord
//
//  Created by 王凯 on 15/2/2.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "RegisteViewController.h"
#import "JsonPostModel.h"

@interface RegisteViewController ()
@property(nonatomic,strong)UITextField*usernameTF;
@property(nonatomic,strong)UITextField*passwordTF;
@property(nonatomic,strong)UITextField*email;
@property(nonatomic,strong)JsonPostModel*jpm;


@end

@implementation RegisteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.jpm = [JsonPostModel shareJsonPostModel];
    
    UIButton*btn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-40 , 50, 80, 80)];
    [btn addTarget:self action:@selector(go:) forControlEvents:UIControlEventTouchUpInside];
    
//    btn.backgroundColor=[UIColor redColor];
    
    [btn setImage:[UIImage imageNamed:@"logo.png"] forState:UIControlStateNormal];
    
    [self.view addSubview:btn];
    
    
    
    UILabel*usernameLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 150, 60, 30)];
    usernameLabel.text = @"用户名:";
    usernameLabel.textAlignment = NSTextAlignmentCenter;
    usernameLabel .backgroundColor = [[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"mainpage_20141105_03.png"]];
    
    [self.view addSubview:usernameLabel];
    
    
    self.usernameTF  = [[UITextField alloc]initWithFrame:CGRectMake(120, 150, 160, 30)];
    //    tf.backgroundColor  = [UIColor grayColor];
    
    self.usernameTF.borderStyle = UITextBorderStyleNone;
    self.usernameTF.textAlignment = NSTextAlignmentCenter;
    self.usernameTF.placeholder = @"username";
    self.usernameTF.background = [UIImage imageNamed:@"mainpage_20141105_03.png"];
    self.usernameTF.clearsOnBeginEditing = YES;
    self.usernameTF.returnKeyType = UIReturnKeyNext;
    
    [self.usernameTF addTarget:self action:@selector(next:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    self.usernameTF.clearButtonMode = UITextFieldViewModeAlways;
    
    
    [self.view addSubview:self.usernameTF];
    
    UILabel*passwordLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 200, 60, 30)];
    passwordLabel.text = @"密  码:";
    passwordLabel.textAlignment = NSTextAlignmentCenter;
    passwordLabel .backgroundColor = [[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"mainpage_20141105_03.png"]];
    
    
    [self.view addSubview:passwordLabel];
    
    
    self.passwordTF  = [[UITextField alloc]initWithFrame:CGRectMake(120, 200, 160, 30)];
    //    tf.backgroundColor  = [UIColor grayColor];
    
    self.passwordTF.borderStyle = UITextBorderStyleNone;
    self.passwordTF.textAlignment = NSTextAlignmentCenter;
    self.passwordTF.placeholder = @"passworld";
    self.passwordTF.background = [UIImage imageNamed:@"mainpage_20141105_03.png"];
    self.passwordTF.clearsOnBeginEditing = YES;
    self.passwordTF.clearButtonMode = UITextFieldViewModeAlways;
    
    self.passwordTF.returnKeyType = UIReturnKeyDone;
//    self.passwordTF.secureTextEntry = YES;             //加密
    
    
    [self.passwordTF addTarget:self action:@selector(next:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    
    [self.view addSubview:self.passwordTF];
    
    
    UILabel*emailLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 250, 60, 30)];
    emailLabel.text = @"用户名:";
    emailLabel.textAlignment = NSTextAlignmentCenter;
    emailLabel .backgroundColor = [[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"mainpage_20141105_03.png"]];
    
    [self.view addSubview:emailLabel];
    
    self.email  = [[UITextField alloc]initWithFrame:CGRectMake(120, 250, 160, 30)];
    //    tf.backgroundColor  = [UIColor grayColor];
    
    self.email.borderStyle = UITextBorderStyleNone;
    self.email.textAlignment = NSTextAlignmentCenter;
    self.email.placeholder = @"email";
    self.email.background = [UIImage imageNamed:@"mainpage_20141105_03.png"];
    self.email.clearsOnBeginEditing = YES;
    self.email.returnKeyType = UIReturnKeyNext;
    
    [self.email addTarget:self action:@selector(next:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    self.email.clearButtonMode = UITextFieldViewModeAlways;
    
    
    [self.view addSubview:self.email];
    
    
    UIButton*registeBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-40, 300, 80, 50)];
    registeBtn.backgroundColor = [UIColor redColor];
    
    [registeBtn addTarget:self action:@selector(registerBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:registeBtn];
    
    
    
    // Do any additional setup after loading the view.
}


-(NSString*)currentLanguage
{
    NSArray*languages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
    //    NSLog(@"%@",languages);
    NSString*str =  [languages objectAtIndex:0];
    
    if ([str isEqualToString:@"zh-Hans"]) {
        return @"zh_CN";
    }else if([str isEqualToString:@"zh-Hant"]){
        return @"zh_TW";
    }else
    {
        return @"en";
        
    }
    
}

-(void)registerBtn:(UIButton*)sender
{
    
    
    
    [self.jpm requestRegisteWithUserName:self.usernameTF.text andPassWord:self.passwordTF.text andEmail:self.email.text andLocale:[self currentLanguage] andCallBack:^(id obj) {
        
        NSLog(@"%@",obj);
        
    }];


}




-(void)go:(UIButton*)sender
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
