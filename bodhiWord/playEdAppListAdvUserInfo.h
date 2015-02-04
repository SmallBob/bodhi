//
//  playEdAppListAdvUserInfo.h
//  bodhiWord
//
//  Created by 王凯 on 15/2/4.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
androidLink":"",
"iconUrl":"http://www.bodhiworld.com/bodhiworld/resources/EdApp/Chinese/WEB/1920*1920/158671c9-aa56-4f86-904c-cd923b355e3c.jpg",
"id":"000000004a5eb270014a5ee29cd2001f",
"imgSize":"402881034a3c3083014a3c3383420003",
"imgType":"402881034a3c3083014a3c325dc20001",
"iosLink":"000000004ab9b5fe014abaef15340016",
"ip":"http://122.225.196.222",
"language":"4028bc81497b0ff401497b113a6d0000",
"name":"01 EdApps Adv Chinese",
"postion":1,
"webLink":"/bodhiworld_home/PlayController/listdetails?AppId=ff80b5b54ac02d68014ac6176cf0000a&locale=zh_CN"}]
*/

@interface playEdAppListAdvUserInfo : NSObject
@property(nonatomic,copy)NSString*iconUrl;
@property(nonatomic,copy)NSString*advID;
@property(nonatomic,copy)NSString*imgSize;
@property(nonatomic,copy)NSString*imgType;

@property(nonatomic,copy)NSString*iosLink;

@property(nonatomic,copy)NSString*ip;
@property(nonatomic,copy)NSString*language;
@property(nonatomic,copy)NSString*name;
@property(nonatomic,copy)NSString*postion;
@property(nonatomic,copy)NSString*webLink;


@end
