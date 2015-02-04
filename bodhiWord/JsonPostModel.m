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
#import "WatchVideoListUserInfo.h"
#import "WatchBookListUserInfo.h"

#import "AFNetworking.h"

#define AddressIP @"http://www.bodhiworld.com"

//@"http://122.225.196.222"



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






-(void)postByApiName:(NSString*)apiName andParams:(NSDictionary*)params andCallBack:(CallBack)callBack
{
    //role mainView scrolleView image
    
    
    [self showWaitAlertView];
    NSString*path = [NSString stringWithFormat:@"%@/bodhiworld_home/AppController/%@",AddressIP,apiName];
    
    
//    NSURL*url = [NSURL URLWithString:path];
//    NSMutableURLRequest*request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
//    
//    
//    [request setHTTPMethod:@"POST"];
//    [request setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    NSURLSession*session = [NSURLSession sharedSession];
//    NSURLSessionDataTask*task =[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//        NSDictionary*dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
//        
//        callBack(dic);
//        
//        [self dismissWaitAlertView];
//        
//    }];
//    [task resume];
    
    
    
    
    
    
    AFHTTPRequestOperationManager*manager = [AFHTTPRequestOperationManager manager];
    
    
    [manager POST:path parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
       
        NSLog(@"success");
        
        
        
//        NSDictionary*dic = responseObject;
        callBack(responseObject);
        [self dismissWaitAlertView];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error);
        UIAlertView*av = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请求数据失败，请查看网络是否异常!" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        
        [av show];
        [self dismissWaitAlertView];
        
    }];
    
    
    
    
    
    

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
    
    
#pragma 根据当机机器型号 匹配图片尺寸
//    NSString*allParams = [NSString stringWithFormat:@"locale=%@&imgType=WEB&imgSize=%d*%d",[self currentLanguage],(int)[UIScreen mainScreen].nativeBounds.size.width,(int)[UIScreen mainScreen].nativeBounds.size.height];
//     NSLog(@"%d--%d",(int)[UIScreen mainScreen].nativeBounds.size.width,(int)[UIScreen mainScreen].nativeBounds.size.height);
//    NSLog(@"%@",allParams);
    
    
    [self showWaitAlertView];
    
//     NSString*allParams = [NSString stringWithFormat:@"locale=%@&imgType=WEB&imgSize=1920*1920",[self currentLanguage]];
//    NSString*languages = [self currentLanguage];
    
    NSDictionary*allParams = @{@"locale":[self currentLanguage],@"imgType":@"WEB",@"imgSize":@"1920*1920" };
    
    
    [self postByApiName:@"homeList" andParams:allParams andCallBack:^(id obj) {
        NSDictionary*dic = obj;
        
        NSArray*adv = [dic objectForKey:@"adv"];
        
        
        callBack(adv);
        
    }];
    


}


//post请求  play 图片

-(void)requestPlayViewData:(CallBack)callBack
{
    NSDictionary*allParams = @{@"locale":[self currentLanguage],@"imgType":@"WEB",@"imgSize":@"1920*1920" };
    
    [self postByApiName:@"edAppList" andParams:allParams andCallBack:^(id obj) {
        NSDictionary*dic  =obj;
        
        NSLog(@"dic -----------%@",dic);
       
        
        callBack(dic);
        
    }];
    

}
-(void)requestPlayViewedAppDetailWithParams:(NSString*)params and:(CallBack)callBack
{
    
//    NSString*allParams = [NSString stringWithFormat:@"imgType=WEB&imgSize=1920*1920&AppId=%@",params];
    NSDictionary*allParams = @{@"locale":[self currentLanguage],
                               @"imgType":@"WEB",
                               @"imgSize":@"1920*1920",
                               @"AppId":params };
    
    [self postByApiName:@"edAppDetail" andParams:allParams andCallBack:^(id obj) {
        
        NSDictionary*dic = obj;
        
//        NSLog(@"%@",dic);
        
        
        callBack(dic);
        
    }];
    
    
}







//Play  右视图界面加载
-(void)requestPlayViewSegmentRightView:(CallBack)callBack
{
    
    NSDictionary*allParams = @{@"locale":[self currentLanguage],
                               @"imgType":@"WEB",
                               @"imgSize":@"1920*1920" };
    
    
    [self postByApiName:@"socialList" andParams:allParams andCallBack:^(id obj) {
    
        NSDictionary*dic =obj;
        NSArray*socialAry= [dic objectForKey:@"social"];

        
//        NSLog(@"obj---------------%@",socialAry);
        
        callBack(socialAry);
        
        
    }];
    

}




-(void)requestPlayViewSocialWithParams:(NSString*)params andCallBack:(CallBack)callBack
{

    NSDictionary*allParams = @{@"locale":[self currentLanguage],
                               @"imgType":@"WEB",@"imgSize":@"1920*1920",@"AppId":params };
    
    [self postByApiName:@"socialDetail" andParams:allParams andCallBack:^(id obj) {
        
        NSDictionary*dic = obj;
        
        
        callBack(dic);

    }];

}



/*
{"tv":"http://beta.bodhiworld.com/bodhiworld/resources/tv/Chinese/WEB/1920*1920/906371b3-3b90-4b79-b99c-2cdb1c94dc55.png",
    "book":"http://beta.bodhiworld.com/bodhiworld/resources/ebook/Chinese/WEB/1920*1920/19cf0d8d-7a99-4d9f-ab9c-93cbd9926f35.png",
    "film":"http://beta.bodhiworld.com/bodhiworld/resources/films/Chinese/WEB/1920*1920/3e85e711-b28a-4956-ad2e-d9d62858c262.png",
    "video":"http://beta.bodhiworld.com/bodhiworld/resources/Video/Chinese/WEB/1920*1920/5baaeba8-f765-4ccb-804c-a5a6de2f4d0d.png"}

*/
//watch main
-(void)requestwatchMainViewWithCallBack:(CallBack)callBack
{
    

    NSDictionary*allParams = @{@"locale":[self currentLanguage],
                               @"imgType":@"WEB",@"imgSize":@"1920*1920" };
    
    
    [self postByApiName:@"watchList" andParams:allParams andCallBack:^(id obj) {
        NSDictionary*dic = obj;
        
//        NSLog(@"%@",dic);
    
        callBack(dic);
    }];
    
//    [self dismissWaitAlertView];
    
}





//Watch tvList
-(void)requestWatchViewTVListsNumber:(CallBack)callBack
{
    
//    [self showWaitAlertView];
    NSDictionary*allParams = @{@"locale":[self currentLanguage],@"imgType":@"WEB",@"imgSize":@"1920*1920" };
    [self postByApiName:@"tvList" andParams:allParams andCallBack:^(id obj) {
        NSDictionary*dic = obj;
        
        NSMutableArray*ary =[NSMutableArray array ];
        NSArray*tvAry = [dic objectForKey:@"tv"];
        NSString*num = [dic objectForKey:@"tvNumber"];
        
        if (![tvAry isMemberOfClass:[NSNull class]]) {
            for (NSDictionary*dicTV in tvAry) {
                WatchTVListUserInfo*tvListUserInfo = [[WatchTVListUserInfo alloc]init];
                tvListUserInfo.age = [dicTV objectForKey:@"age"];
                tvListUserInfo.blues = [dicTV objectForKey:@"blues"];
                
                tvListUserInfo.describes = [dicTV objectForKey:@"describes"];
                
                tvListUserInfo.watchTVListID = [dicTV objectForKey:@"id"];
                tvListUserInfo.imgSize = [dicTV objectForKey:@"imgSize"];
                tvListUserInfo.imgType = [dicTV objectForKey:@"imgType"];
                tvListUserInfo.imgUrl = [dicTV objectForKey:@"imgUrl"];
                tvListUserInfo.addressIP = [dicTV objectForKey:@"ip"];
                tvListUserInfo.language = [dicTV objectForKey:@"language"];
                tvListUserInfo.love = [dicTV objectForKey:@"love"];
                tvListUserInfo.sorting = [dicTV objectForKey:@"sorting"];
                tvListUserInfo.title = [dicTV objectForKey:@"title"];
                tvListUserInfo.watchTVVideoLink = [dicTV objectForKey:@"videoLink"];
                [ary addObject:tvListUserInfo];
            }
        }
        
        
        
        
        
        NSArray*arry = @[ary ,num];
        
       
        
        callBack(arry);
//        [self dismissWaitAlertView];
        
    }];
    


}

//watchTVlist pageNo  pageSize

-(void)requestWatchViewTVListWithpageNO:(NSString*)pageNo andPageSize:(NSString*)pageSize andCallBack:(CallBack)callBack
{
//    [self showWaitAlertView];
//    NSString*allParams = [NSString stringWithFormat:@"imgType=WEB&imgSize=1920*1920&pageNo=%@&pageSize=%@",pageNo,pageSize];
    NSDictionary*allParams = @{@"locale":[self currentLanguage],@"imgType":@"WEB",@"imgSize":@"1920*1920",@"pageNo":pageNo,@"pageSize":pageSize };
    
    [self postByApiName:@"tvList" andParams:allParams andCallBack:^(id obj) {
        NSDictionary*dic = obj;
        
        
        NSMutableArray*ary =[NSMutableArray array ];
        NSArray*tvAry = [dic objectForKeyedSubscript:@"tv"];
        
        if (![tvAry isMemberOfClass:[NSNull class]]) {
            for (NSDictionary*dicTV in tvAry) {
                WatchTVListUserInfo*tvListUserInfo = [[WatchTVListUserInfo alloc]init];
                tvListUserInfo.age = [dicTV objectForKey:@"age"];
                tvListUserInfo.blues = [dicTV objectForKey:@"blues"];
                
                tvListUserInfo.describes = [dicTV objectForKey:@"describes"];
                
                tvListUserInfo.watchTVListID = [dicTV objectForKey:@"id"];
                tvListUserInfo.imgSize = [dicTV objectForKey:@"imgSize"];
                tvListUserInfo.imgType = [dicTV objectForKey:@"imgType"];
                tvListUserInfo.imgUrl = [dicTV objectForKey:@"imgUrl"];
                tvListUserInfo.addressIP = [dicTV objectForKey:@"ip"];
                tvListUserInfo.language = [dicTV objectForKey:@"language"];
                tvListUserInfo.love = [dicTV objectForKey:@"love"];
                tvListUserInfo.sorting = [dicTV objectForKey:@"sorting"];
                tvListUserInfo.title = [dicTV objectForKey:@"title"];
                tvListUserInfo.watchTVVideoLink = [dicTV objectForKey:@"videoLink"];
                [ary addObject:tvListUserInfo];
            }
        }
        
        callBack(ary);
        
//        [self dismissWaitAlertView];
    }];





}





//watch films
-(void)requestwatchviewFilmsList:(CallBack)callBack
{
//    [self showWaitAlertView];
    
    NSDictionary*allParams = @{@"locale":[self currentLanguage],@"imgType":@"WEB",@"imgSize":@"1920*1920" };
    [self postByApiName:@"filmsList" andParams:allParams andCallBack:^(id obj) {
        NSDictionary*dic = obj;
//        NSLog(@"%@",obj);
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
//        [self dismissWaitAlertView];
        
    }];

}

// watchVideoList
-(void)requestwatchViewVideoList:(CallBack)callBack
{
    
//    [self showWaitAlertView];
    NSDictionary*allParams = @{@"locale":[self currentLanguage],@"imgType":@"WEB",@"imgSize":@"1920*1920" };
    [self postByApiName:@"videoList" andParams:allParams andCallBack:^(id obj) {
        NSDictionary*dic = obj;
        
        NSArray*videoAry = [dic objectForKey:@"video"];
        NSMutableArray*ary =[NSMutableArray array ];
        
        
        if (![videoAry isMemberOfClass:[NSNull class]]) {
            for (NSDictionary*dicVideo in videoAry) {
                
                WatchVideoListUserInfo *videoListUserInfo = [[WatchVideoListUserInfo alloc]init];
                videoListUserInfo.age = [dicVideo objectForKey:@"age"];
                if ([videoListUserInfo.age isEqualToString:@""]) {
                    videoListUserInfo.age =@"未知";
                }
                videoListUserInfo.watchVideoID = [dicVideo objectForKey:@"id"];
                videoListUserInfo.keywords = [dicVideo objectForKey:@"keywords"];
                videoListUserInfo.imgSize = [dicVideo objectForKey:@"imgSize"];
                videoListUserInfo.imgType = [dicVideo objectForKey:@"imgType"];
                videoListUserInfo.imgUrl = [dicVideo objectForKey:@"imgUrl"];
                videoListUserInfo.addressIP = [dicVideo objectForKey:@"ip"];
                videoListUserInfo.language = [dicVideo objectForKey:@"language"];
                videoListUserInfo.love = [dicVideo objectForKey:@"love"];
                videoListUserInfo.name = [dicVideo objectForKey:@"name"];
                videoListUserInfo.sorting = [dicVideo objectForKey:@"sorting"];
                videoListUserInfo.title = [dicVideo objectForKey:@"title"];
                videoListUserInfo.link = [dicVideo objectForKey:@"link"];

                
                [ary addObject:videoListUserInfo];
            }
        }
        
        callBack(ary);
//        [self dismissWaitAlertView];
        
    }];
    
}

// watchBookList
-(void)requestwatchViewebookList:(CallBack)callBack
{
    
//    [self showWaitAlertView];
    
    NSDictionary*allParams = @{@"locale":[self currentLanguage],@"imgType":@"WEB",@"imgSize":@"1920*1920" };
    [self postByApiName:@"ebookList" andParams:allParams andCallBack:^(id obj) {
        NSDictionary*dic = obj;
        NSLog(@"%@",obj);
        NSArray*bookAry = [dic objectForKey:@"book"];
        NSMutableArray*ary =[NSMutableArray array ];
        
        
        if (![bookAry isMemberOfClass:[NSNull class]]) {
            for (NSDictionary*dicVideo in bookAry) {
                
                WatchBookListUserInfo *bookListUserInfo = [[WatchBookListUserInfo alloc]init];
                bookListUserInfo.age = [dicVideo objectForKey:@"age"];
                if ([bookListUserInfo.age isEqualToString:@""]) {
                    bookListUserInfo.age =@"未知";
                }
                bookListUserInfo.watchBookID = [dicVideo objectForKey:@"id"];
                bookListUserInfo.keywords = [dicVideo objectForKey:@"keywords"];
                bookListUserInfo.imgSize = [dicVideo objectForKey:@"imgSize"];
                bookListUserInfo.imgType = [dicVideo objectForKey:@"imgType"];
                bookListUserInfo.imgUrl = [dicVideo objectForKey:@"imgUrl"];
                bookListUserInfo.addressIP = [dicVideo objectForKey:@"ip"];
                bookListUserInfo.language = [dicVideo objectForKey:@"language"];
                bookListUserInfo.love = [dicVideo objectForKey:@"love"];
                bookListUserInfo.name = [dicVideo objectForKey:@"name"];
                bookListUserInfo.sorting = [dicVideo objectForKey:@"sorting"];
                bookListUserInfo.title = [dicVideo objectForKey:@"title"];
                bookListUserInfo.link = [dicVideo objectForKey:@"link"];
                
                
                [ary addObject:bookListUserInfo];
            }
        }
        callBack(ary);
//        [self dismissWaitAlertView];
    }];
    
}



//登录 注册
-(void)requestLoginWithUserName:(NSString*)userName andPassWord:(NSString*)passWord andCallBack:(CallBack)callBack
{
    NSString*usernamea = [userName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSString*un = [usernamea stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    
    NSString*passworda = [passWord stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString*pw = [passworda stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
//    NSString*params =[NSString stringWithFormat:@"userName=%@&passWord=%@",un,pw];
    
    NSDictionary*allParams = @{@"userName":un,@"passWord":pw };

        [self postByApiName:@"login" andParams:allParams andCallBack:^(id obj) {
           
            NSDictionary*dic = obj;
            callBack(dic);
//            NSLog(@"%@",dic);
        }];
    



}

-(void)requestRegisteWithUserName:(NSString*)userName andPassWord:(NSString*)passWord andEmail:(NSString*)email andLocale :(NSString*)locale  andCallBack:(CallBack)callBack
{
    
    NSString*usernamea = [userName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSString*un = [usernamea stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    
    NSString*passworda = [passWord stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString*pw = [passworda stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
//    NSString*allParams = [NSString stringWithFormat:@"userName=%@&passWord=%@&email=%@&locale=%@",un,pw,email,locale];
    
    NSDictionary*allParams = @{@"userName":un,@"passWord":pw,@"email":email,@"locale":locale};
    
    [self postByApiName:@"register" andParams:allParams andCallBack:^(id obj) {
        if (![obj isMemberOfClass:[NSNull class]]) {
            NSDictionary*dic = obj;
            
            callBack(dic);
        
        
    }

    }];
    


}


@end
