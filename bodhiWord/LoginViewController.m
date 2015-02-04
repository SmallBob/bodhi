
//  LoginViewController.m
//  bodhiWord
//
//  Created by 王凯 on 15/1/26.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "LoginViewController.h"
#import "JsonPostModel.h"

@interface LoginViewController ()

@property(nonatomic,strong)UITextField*usernameTF;
@property(nonatomic,strong)UITextField*passwordTF;

@property(nonatomic,strong)JsonPostModel*jpm;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     self.jpm  =[JsonPostModel shareJsonPostModel];
    
    
    UIButton*btn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-40 , 50, 80, 80)];
    [btn addTarget:self action:@selector(go:) forControlEvents:UIControlEventTouchUpInside];
    
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
    self.passwordTF.secureTextEntry = YES;             //加密
    
    
    [self.passwordTF addTarget:self action:@selector(Done:) forControlEvents:UIControlEventEditingDidEndOnExit];
    

    [self.view addSubview:self.passwordTF];
    
    
    UIButton*loginBtn = [[UIButton alloc]initWithFrame:CGRectMake(60, 250, 100, 40)];
    
    [loginBtn setImage:[UIImage imageNamed:@"mainpage_20141105_05.png"] forState:UIControlStateNormal];
    
    [loginBtn addTarget:self action:@selector(userLogin:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    [self.view addSubview:loginBtn];
    
    UIButton*registerBtn = [[UIButton alloc]initWithFrame:CGRectMake(170, 250, 100, 40)];
    
    [registerBtn setImage:[UIImage imageNamed:@"mainpage_20141105_06.png"] forState:UIControlStateNormal];
    
    [registerBtn addTarget:self action:@selector(userRegister:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:registerBtn];
    
    
#pragma 分享按钮
    
 
    
    


    
    
    
    
    
    
    
    
    
    // Do any additional setup after loading the view.
}



-(void)next:(UITextField*)sender
{

    [self.passwordTF becomeFirstResponder];

}


-(void)Done:(UITextField*)sender
{
    [self submit];

}

- (void)resign {
    [self.usernameTF resignFirstResponder];
    [self.passwordTF resignFirstResponder];
}

- (IBAction)touchBackGround:(id)sender {
    
    [self resign];

    
}



#pragma login

-(void)userLogin:(UIButton*)sender
{
//    NSLog(@"userLogin");
   
    
    
    
    
    
    [self submit];
    
    
}


-(void)submit
{
    
    [self resign];
    
    

    
    
    
   
    [self.jpm requestLoginWithUserName:self.usernameTF.text  andPassWord:self.passwordTF.text andCallBack:^(id obj) {
//       NSLog(@"%@",obj);
        
        NSDictionary*dic = obj;
//        NSLog(@"%@",[dic objectForKey:@"status"]);
        
//        BOOL isbool = [[dic objectForKey:@"status"] boolValue];
        
       
        if (![dic isMemberOfClass:[NSNull class]]) {
            
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            
            if ([[dic objectForKey:@"status"] boolValue]) {
//                NSLog(@"123");
                
                [self dismissViewControllerAnimated:YES completion:nil];
                
                
                
                
            }else{
                
                NSLog(@"%@",[dic objectForKey:@"errText"]);
                
                
                
                
                UIAlertView*av = [[UIAlertView alloc]initWithTitle:@"提示"
                                                           message:[dic objectForKey:@"errText"]
                                                          delegate:nil
                                                 cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                
                [av show];
                
                
            }
            
            
        });
        
        
       
        }
        
    }];
    
    
   
    
    
    
    
   

}

#pragma register
-(void)userRegister:(UIButton*)sender
{
    NSLog(@"userRegister");
    
    [self performSegueWithIdentifier:@"registe" sender:nil];
    
    
    
    
    
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
