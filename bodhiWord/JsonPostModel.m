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
#import "WatchTVListUserInfo.h"
#import "WatchFilmsListUserInfo.h"

#define AddressIP  @"http://122.225.196.222"
static JsonPostModel*jsonP;
static UIAlertView*waitAlertView;


@implementation JsonPostModel
+(JsonPostModel *)shareJsonPostModel
{
    if (!jsonP) {
        jsonP = [[JsonPostModel alloc]init];
     waitAlertView = [[UIAlertView alloc]initWithTitle:nil message:@"loading..." delegate:self cancelButtonTitle:Nil otherButtonTitles:nil, nil];
        
    }
    return jsonP;
    
}


//取本地手机 当前使用语言
-(NSString*)currentLanguage
{
    NSArray*languages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
    NSString*str =  [languages objectAtIndex:0];
    if ([str isEqualToString:@"zh-Hans"]||[str isEqualToString:@"zh-Hant"]) {
        return str;
    }else
    {
        return @"en";
    
    }
    
}






-(void)postByApiName:(NSString*)apiName andParams:(NSString*)params andCallBack:(CallBack)callBack
{
    //role mainView scrolleView image
    [self showWaitAlertView];
    NSString*path = [NSString stringWithFormat:@"%@/bodhiworld_home/AppController/%@",AddressIP,apiName];
    
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
        
        NSArray*adv = [dic objectForKey:@"adv"];
        
        
        callBack(adv);
    }];
    


}


//post请求  play 图片

-(void)requestPlayViewData:(CallBack)callBack
{
    [self postByApiName:@"edAppList" andParams:@"imgType=WEB&imgSize=1920*1920" andCallBack:^(id obj) {
        NSDictionary*dic  =obj;
        
        NSArray*app = [dic objectForKey:@"app"];
        
        callBack(app);
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

//Watch tvList
-(void)requestWatchViewTVList:(CallBack)callBack
{
    [self postByApiName:@"tvList" andParams:@"imgType=WEB&imgSize=1920*1920" andCallBack:^(id obj) {
        NSDictionary*dic = obj;
        NSMutableArray*ary =[NSMutableArray array ];
        NSArray*tvAry = [dic objectForKeyedSubscript:@"tv"];
        
        if (![tvAry isMemberOfClass:[NSNull class]]) {
            for (NSDictionary*dicTV in tvAry) {
                WatchTVListUserInfo*tvListUserInfo = [[WatchTVListUserInfo alloc]init];
                tvListUserInfo.age = [dicTV objectForKey:@"age"];
                tvListUserInfo.blues = (int)[dicTV objectForKey:@"blues"];
                
//               tvListUserInfo.describes = [dicTV objectForKey:@"describes"];
                
                tvListUserInfo.watchTVListID = [dicTV objectForKey:@"id"];
                tvListUserInfo.imgSize = [dicTV objectForKey:@"imgSize"];
                tvListUserInfo.imgType = [dicTV objectForKey:@"imgType"];
                tvListUserInfo.imgUrl = [dicTV objectForKey:@"imgUrl"];
                tvListUserInfo.addressIP = [dicTV objectForKey:@"ip"];
                tvListUserInfo.language = [dicTV objectForKey:@"language"];
                tvListUserInfo.love = [dicTV objectForKey:@"love"];
                tvListUserInfo.sorting = (int)[dicTV objectForKey:@"sorting"];
                tvListUserInfo.title = [dicTV objectForKey:@"title"];
//                tvListUserInfo.watchTVVideoLink = [dicTV objectForKey:@"videoLink"];
                [ary addObject:tvListUserInfo];
            }
        }
        
        callBack(ary);
        
        
    }];
    


}


-(void)requestwatchviewFilmsList:(CallBack)callBack
{
    [self postByApiName:@"filmsList" andParams:@"imgType=WEB&imgSize=1920*1920" andCallBack:^(id obj) {
        NSDictionary*dic = obj;
        NSMutableArray*ary =[NSMutableArray array ];
        NSArray*tvAry = [dic objectForKeyedSubscript:@"films"];
        
        if (![tvAry isMemberOfClass:[NSNull class]]) {
            for (NSDictionary*dicTV in tvAry) {
                WatchFilmsListUserInfo*filmsListUserInfo = [[WatchFilmsListUserInfo alloc]init];
                filmsListUserInfo.age = [dicTV objectForKey:@"age"];
                if ([filmsListUserInfo.age isEqualToString:@""]) {
                    filmsListUserInfo.age =@"未知";
                }
                filmsListUserInfo.watchFilmsID = [dicTV objectForKey:@"id"];
                
                //               tvListUserInfo.describes = [dicTV objectForKey:@"describes"];
                
                filmsListUserInfo.keywords = [dicTV objectForKey:@"keywords"];
                filmsListUserInfo.imgSize = [dicTV objectForKey:@"imgSize"];
                filmsListUserInfo.imgType = [dicTV objectForKey:@"imgType"];
                filmsListUserInfo.imgUrl = [dicTV objectForKey:@"imgUrl"];
                filmsListUserInfo.addressIP = [dicTV objectForKey:@"ip"];
                filmsListUserInfo.language = [dicTV objectForKey:@"language"];
                filmsListUserInfo.love = [dicTV objectForKey:@"love"];
                filmsListUserInfo.sorting = [dicTV objectForKey:@"sorting"];
                filmsListUserInfo.title = [dicTV objectForKey:@"title"];
                filmsListUserInfo.link = [dicTV objectForKey:@"link"];
                filmsListUserInfo.type = [dicTV objectForKey:@"type"];
                
                [ary addObject:filmsListUserInfo];
            }
        }
        
        callBack(ary);
//   直接回掉数组或者字典  在展开的时候做判断 ？
        
        
    }];

}

// watchVideoList
-(void)requestwatchViewVideoList:(CallBack)callBack
{
    [self postByApiName:@"videoList" andParams:@"imgType=WEB&imgSize=1920*1920" andCallBack:^(id obj) {
        NSDictionary*dic = obj;
        NSArray*videoAry = [dic objectForKey:@"video"];
        
        callBack(videoAry);
        
    }];
    
}

// watchBookList
-(void)requestwatchViewebookList:(CallBack)callBack
{
    [self postByApiName:@"ebookList" andParams:@"imgType=WEB&imgSize=1920*1920" andCallBack:^(id obj) {
        NSDictionary*dic = obj;
        NSArray*bookAry = [dic objectForKey:@"book"];
        
        callBack(bookAry);
        
    }];
    
}

@end
