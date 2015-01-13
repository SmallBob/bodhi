//
//  WatchVideoListUserInfo.h
//  bodhiWord
//
//  Created by 王凯 on 15/1/9.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WatchVideoListUserInfo : NSObject

/*
 "age":"",
 "id":"000000004a58560e014a59dedef8005e",
 "imgSize":"402881034a3c3083014a3c3383420003",
 "imgType":"402881034a3c3083014a3c325dc20001","imgUrl":"http://beta.bodhiworld.com/bodhiworld/resources/Video/English/WEB/1920*1920/082d42ec-7028-45b6-9d96-8ef09aca1ae7.png",
 "ip":"http://122.225.196.222",
 "keywords":"",
 "language":"4028bc81497b0ff401497b11950b0002","link":"http://www.youtube.com/embed/H6LsjJF5AJ8",
 "love":0,
 "name":"mv_001.png",
 "sorting":1,
 "title":"Bodhi Magic <br>(Bodhi Dance)"
 */

@property(nonatomic,copy)NSString*age;
@property(nonatomic,copy)NSString*watchVideoID;
@property(nonatomic,copy)NSString*imgSize;
@property(nonatomic,copy)NSString*imgType;
@property(nonatomic,copy)NSString*imgUrl;
@property(nonatomic,copy)NSString*addressIP;
@property(nonatomic,copy)NSString*keywords;
@property(nonatomic,copy)NSString*language;
@property(nonatomic,copy)NSString*link;
@property(nonatomic,copy)NSString*love;
@property(nonatomic,copy)NSString*name;
@property(nonatomic,copy)NSString*sorting;
@property(nonatomic,copy)NSString*title;



@end
