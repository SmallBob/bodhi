//
//  JsonPostModel.h
//  bodhiWord
//
//  Created by apple on 14/12/15.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CallBack) (id obj);


@interface JsonPostModel : NSObject
+(JsonPostModel*)shareJsonPostModel;
-(void)requestMainviewRoleImage:(CallBack)callBack;


-(void)requestPlayViewData:(CallBack)callBack;
-(void)requestPlayViewSegmentRightView:(CallBack)callBack;

@end
