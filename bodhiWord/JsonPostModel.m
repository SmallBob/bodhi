//
//  JsonPostModel.m
//  bodhiWord
//
//  Created by apple on 14/12/15.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "JsonPostModel.h"
#import <UIKit/UIKit.h>
#import "UserInfo.h"
#import "playUserInfo.h"

#define AddressIP  @"http://122.225.196.222"
static JsonPostModel*jsonP;
static UIAlertView*waitAlertView;


@implementation JsonPostModel
+(JsonPostModel *)shareJsonPostModel
{
    if (!jsonP) {
        jsonP = [[JsonPostModel alloc]init];
     waitAlertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"正在加载..." delegate:self cancelButtonTitle:Nil otherButtonTitles:nil, nil];
        
    }
    return jsonP;
    
}

-(void)postByApiName:(NSString*)apiName andParams:(NSString*)params andCallBack:(CallBack)callBack
{
    //role mainView scrolleView image
    NSString*path = [NSString stringWithFormat:@"%@/bodhiworld_home/AppController/%@",AddressIP,apiName];
    
   NSLog(@"%@",path);
    NSURL*url = [NSURL URLWithString:path];
    NSMutableURLRequest*request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSession*session = [NSURLSession sharedSession];
    NSURLSessionDataTask*task =[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSDictionary*dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        
        callBack(dic);
        
        [self dismissWaitAlertView];
        
    }];
    [task resume];
    


}


-(void)showWaitAlertView
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [waitAlertView show];
    });
    
}

-(void)dismissWaitAlertView
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [waitAlertView dismissWithClickedButtonIndex:0 animated:NO];
    });
    

}



-(void)requestMainviewRoleImage:(CallBack)callBack
{
    [self postByApiName:@"homeList" andParams:@"imgType=WEB&imgSize=1920*1920" andCallBack:^(id obj) {
        NSDictionary*dic = obj;
        
        NSMutableArray*ary = [NSMutableArray array];
        
        NSArray*adv = [dic objectForKey:@"adv"];
#pragma 解析
        if (![adv isMemberOfClass:[NSNull class]]) {
            
            for (NSDictionary*dicResult in adv) {
                
            
            
            UserInfo*userInfo = [[UserInfo alloc]init];
                userInfo.iconUrl = [dicResult objectForKey:@"iconUrl" ];
                userInfo.androidLink = [dicResult objectForKey:@"androidLink"];
                userInfo.advId = [dicResult objectForKey:@"id"];
                userInfo.imgSize = [dicResult objectForKey:@"imgSize"];
                userInfo.imgType = [dicResult objectForKey:@"imgType"];
                userInfo.iosLink = [dicResult objectForKey:@"iosLink"];
                userInfo.adressIP = [dicResult objectForKey:@"ip"];
                userInfo.isnew =[dicResult objectForKey:@"isnew"];
                userInfo.language = [dicResult objectForKey:@"language"];
                userInfo.name = [dicResult objectForKey:@"name"];
                userInfo.postion = [dicResult objectForKey:@"postion"];
                userInfo.sorting = [dicResult objectForKey:@"sorting"];
                userInfo.webLink = [dicResult objectForKey:@"webLink"];
                
                
                [ary addObject:userInfo];
                
            }
            
        }else{
            NSLog(@"adv  json == nil");
        
        }
        
        
        callBack(ary);
    }];
    


}


//post请求  play 图片

-(void)requestPlayViewData:(CallBack)callBack
{
    [self postByApiName:@"edAppList" andParams:@"imgType=WEB&imgSize=1920*1920" andCallBack:^(id obj) {
        NSDictionary*dic  =obj;
        NSMutableArray*ary = [NSMutableArray array ];
        NSArray*app = [dic objectForKey:@"app"];
        if (![app isMemberOfClass:[NSNull class]]) {
            NSLog(@"dic -%@   app-%@",dic,app);
            
            for (NSDictionary*dicApp  in app) {
                playUserInfo*pui = [[playUserInfo alloc]init];
                pui.playLeftViewIconUrl = [dicApp objectForKey:@"iconUrl"];
                pui.leftSegmenttitle = [dicApp objectForKey:@"title"];
                pui.leftSegmenttype = [dicApp objectForKey:@"type"];
               
               
                [ary addObject:pui];
                
            }
            
        }
        callBack(ary);
    }];
    

}


//Play  右视图界面加载
-(void)requestPlayViewSegmentRightView:(CallBack)callBack
{
    [self postByApiName:@"socialList" andParams:@"imgType=WEB&imgSize=1920*1920" andCallBack:^(id obj) {
    
        NSDictionary*dic =obj;
        NSMutableArray*ary =[NSMutableArray array];
        NSArray*socialAry= [dic objectForKey:@"social"];
        if (![socialAry isMemberOfClass:[NSNull class]]) {
            for (NSDictionary*dicRight in socialAry) {
                playUserInfo*pui = [[playUserInfo alloc]init];
                pui.rightSegmentDescribes = [dicRight objectForKey:@"describes"];
                pui.rightSegmentIconUrl = [dicRight objectForKey:@"iconUrl"];
                pui.rightSegmentTitile = [dicRight objectForKey:@"title"];
                
                [ary addObject:pui];
            }
        }
        
        callBack(ary);
        
        
    }];
    

}



@end
