//
//  loginUserInfo.h
//  bodhiWord
//
//  Created by 王凯 on 15/2/2.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface loginUserInfo : NSObject
@property(nonatomic,copy)NSString*status;
@property(nonatomic,copy)NSString*imgUrl;
@property(nonatomic,copy)NSString*star;
@property(nonatomic,copy)NSString*myName;
@property(nonatomic,copy)NSString*errText;



@end
//{"status":0,"ImgUrl":"","Star":"0","MyName":"wangkai","errText":"wangkai用户不存在!"}