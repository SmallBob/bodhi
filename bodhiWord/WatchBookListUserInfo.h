//
//  WatchBookListUserInfo.h
//  bodhiWord
//
//  Created by 王凯 on 15/1/9.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WatchBookListUserInfo : NSObject
/*
 {"age":"",
 "id":"000000004a5cf46b014a5d531d000001",
 "imgSize":"402881034a3c3083014a3c3383420003",
 "imgType":"402881034a3c3083014a3c325dc20001",
 "imgUrl":"http://beta.bodhiworld.com/bodhiworld/resources/ebook/English/WEB/1920*1920/24151ed7-c3a5-4a5d-be70-8c7ac34f2606.png",
 "ip":"http://122.225.196.222",
 "keywords":"",
 "language":"4028bc81497b0ff401497b11950b0002",
 "link":"https://itunes.apple.com/hk/app/bodhi-adventures-in-sampolo/id481346864?l=zh&mt=8",
 "love":0,
 "name":"ecomic_001.png",
 "sorting":1,
 "title":"Volume 1"
 */
@property(nonatomic,copy)NSString*age;
@property(nonatomic,copy)NSString*watchBookID;
//@property(nonatomic,copy)NSString*


@end
