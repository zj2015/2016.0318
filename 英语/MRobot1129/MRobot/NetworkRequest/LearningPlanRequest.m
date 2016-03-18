//
//  LearningPlanRequest.m
//  MRobot
//
//  Created by mac on 15/8/20.
//  Copyright (c) 2015年 silysolong. All rights reserved.
//

#import "LearningPlanRequest.h"
#import "RTHttpClient.h"

#import "UserLoginModel.h"

#import "ExamProModel.h"
#import "ExamProListModel.h"

#import "TeachContentDataModel.h"

#import "AnalyticalKnowledgeModel.h"
#import "KnowledgeModel.h"

#import "KnowledgeVideoModel.h"
#import "ResultArrayListModel.h"
#import "KnowledgeCVideoModel.h"

#import "ProblemSetsList.h"
//#import "SkillInfoModel.h"

#import "WeekVideoModel.h"
#import "KVideoListModel.h"
#import "VideoListModel.h"
#import "CVideoListModel.h"
#import "SVideoListModel.h"

#import "CommonSkillModel.h"
#import "CommonListModel.h"

#import "SkillDataModel.h"
#import "SkillListModel.h"

#import "ImportantAnalysiModel.h"
#import "ImportantListModel.h"

#import "WrongKnowledgeDataModel.h"
#import "WrongKnowledgeListModel.h"

#import "WrongQueDataModel.h"
#import "WrongQueListModel.h"
#import "DateListModel.h"

#import "SimulationPaperModel.h"
#import "SimulationListModel.h"

#import "SubmitByPaperModel.h"
#import "SubmitByWeekModel.h"
#import "ResultListModel.h"
#import "SubmitBySkillModel.h"
#import "SkillResultListModel.h"
#import "KSubmitAnswerModel.h"
#import "SubmitQuestionModel.h"

#import "OpinionListModel.h"
#import "OpinionResultModel.h"

#import "ProvinceListModel.h"
#import "ProvinceDataModel.h"
#import "CityDataModel.h"
#import "DistrictDataModel.h"

#import "TopLevelKnowModel.h"
#import "TopLevelListModel.h"

#import "ChildLevelKnowModel.h"
#import "ChildLevelListModel.h"

#import "TopQTypeChildModel.h"
#import "TopQTypeListModel.h"
#import "TopQTypeResultModel.h"

#import "TypeQuestionListModel.h"
#import "TypeQListModel.h"

#import "TopKVideoModel.h"
#import "TopKVideoListModel.h"

@implementation LearningPlanRequest

-(NSString *)fromType
{
#if TARGET_VERSION_LITE ==1
    //target（中考校内版）需要执行的代码
    if ([UserDefaultsUtils boolValueWithKey:ISINNER]) {
        return @"3";
    }else{
        //target（高考校外版）需要执行的代码
        return @"4";
    }
    
#elif TARGET_VERSION_LITE ==2
    //target（中考校外版）需要执行的代码
    return @"4";
    
#elif TARGET_VERSION_LITE ==3
    //target（高考校内版）需要执行的代码
    if ([UserDefaultsUtils boolValueWithKey:ISINNER]) {
        return @"5";
    }else{
        //target（高考校外版）需要执行的代码
        return @"6";
    }
    
#elif TARGET_VERSION_LITE ==4
    //target（高考校外版）需要执行的代码
    return @"6";
#endif
}

/**
 *  1.4.1 学习进度
 *
 *  @param success 回调函数成功
 *  @param failed 回调函数失败
 */
- (void)userExamProgressListSuccess:(SuccessBlock)success failed:(FailedBlock)failed
{
    RTHttpClient *client = [RTHttpClient defaultClient];
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:[UserDefaultsUtils valueWithKey:USER_TOKEN],@"token",[self fromType],@"fromType",nil];
    [client requestWithPath:[BaseHandler requestUrlWithPath:@"/ExamProgressList"] method:RTHttpRequestGet parameters:dict prepareExecute:^{
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        InfoResult *infoResult = [[InfoResult alloc] init];
        infoResult.code = [infoResult objectOrNilForKey:@"code" fromDictionary:responseObject];
        infoResult.desc = [infoResult objectOrNilForKey:@"desc" fromDictionary:responseObject];
        if ([responseObject objectForKey:@"code"]!= [NSNull null]) {
            if ([infoResult.code isEqualToString:@"0"]) {
                if ([responseObject objectForKey:@"data"] != [NSNull null]) {
                    NSDictionary *examDic = [responseObject objectForKey:@"data"];
                    ExamProModel *examPro = [[ExamProModel alloc]init];
                    [examPro initWithJson:examDic];
                    [infoResult setExtraObj:examPro];
                }
                success(infoResult);
            }else if ([infoResult.code isEqualToString:@"30001"]){
//                [aCommon iToast:@"该账号已在其他设备登陆！"];
                [self performSelector:@selector(againLogin) withObject:self afterDelay:0.2];
            }else{
                [aCommon iToast:infoResult.desc];
            }
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failed(error);
    }];
}

/**
 *  1.4.2 The course credits
 *
 *  @param weekId  周id
 *  @param cType   教学类型
 *  @param classCatagory   班类
 *  @param success 回调函数成功
 *  @param failed  回调函数失败
 */
- (void)userCourseContentWithWeekId:(NSString *)weekId andCType:(NSString *)cType andClassCatagory:(NSString *)classCatagory success:(SuccessBlock)success failed:(FailedBlock)failed
{
    RTHttpClient *client = [RTHttpClient defaultClient];
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:[UserDefaultsUtils valueWithKey:USER_TOKEN],@"token",weekId,@"weekId",cType,@"cType",classCatagory,@"classCatagory",[self fromType],@"fromType",nil];
    [client requestWithPath:[BaseHandler requestUrlWithPath:@"/CourseContent"] method:RTHttpRequestGet parameters:dict prepareExecute:^{
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        InfoResult *infoResult = [[InfoResult alloc] init];
        infoResult.code = [infoResult objectOrNilForKey:@"code" fromDictionary:responseObject];
        infoResult.desc = [infoResult objectOrNilForKey:@"desc" fromDictionary:responseObject];
        if ([responseObject objectForKey:@"code"]!= [NSNull null]) {
            if ([infoResult.code isEqualToString:@"0"]) {
                if ([responseObject objectForKey:@"data"] != [NSNull null]) {
                    NSDictionary * teachConDic = [responseObject objectForKey:@"data"];
                    NSDictionary *dic = [teachConDic objectForKey:@"CourseContent"];
                    TeachContentDataModel * teachContentDataModel = [[TeachContentDataModel alloc] init];
                    [teachContentDataModel initWithJson:dic];
                    [infoResult setExtraObj:teachContentDataModel];
                }
                success(infoResult);
                
            }else if ([infoResult.code isEqualToString:@"30001"]){
                [aCommon iToast:@"该账号已在其他设备登陆！"];
                [self performSelector:@selector(againLogin) withObject:self afterDelay:0.2];
            }else{
                [aCommon iToast:infoResult.desc];
            }
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failed(error);
    }];
}

/**
 *  1.4.3 Analysis
 *
 *  @param weekId  周id
 *  @param success 回调函数成功
 *  @param failed  回调函数失败
 */
- (void)userKnowledgeAnalysisListWithWeekId:(NSString *)weekId success:(SuccessBlock)success failed:(FailedBlock)failed
{
    RTHttpClient *client = [RTHttpClient defaultClient];
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:[UserDefaultsUtils valueWithKey:USER_TOKEN],@"token",weekId,@"weekId",[self fromType],@"fromType",nil];
    [client requestWithPath:[BaseHandler requestUrlWithPath:@"/KnowledgeAnalysisList"] method:RTHttpRequestGet parameters:dict prepareExecute:^{
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        InfoResult *infoResult = [[InfoResult alloc] init];
        infoResult.code = [infoResult objectOrNilForKey:@"code" fromDictionary:responseObject];
        infoResult.desc = [infoResult objectOrNilForKey:@"desc" fromDictionary:responseObject];
        if ([infoResult.code isEqualToString:@"0"]) {
            if ([responseObject objectForKey:@"data"] != [NSNull null]) {
                NSDictionary * knowledgeDic = [responseObject objectForKey:@"data"];
                AnalyticalKnowledgeModel * analyticalKnowledgeModel = [[AnalyticalKnowledgeModel alloc] init];
                if ([[knowledgeDic objectForKey:@"KnowledgeAnalysisList"] count] !=0) {
                    for (NSDictionary * dict in [knowledgeDic objectForKey:@"KnowledgeAnalysisList"]) {
                        KnowledgeModel * knowledgeModel = [[KnowledgeModel alloc] init];
                        [knowledgeModel setKId:[dict objectForKey:@"kId"]];
                        [knowledgeModel setKName:[dict objectForKey:@"kName"]];
                        [knowledgeModel setKContent:[dict objectForKey:@"KContent"]];
                        [analyticalKnowledgeModel.analyticalKnowledgeArr addObject:knowledgeModel];
                    }
                }
                [infoResult setExtraObj:analyticalKnowledgeModel];
            }
            success(infoResult);
            
        }else if ([infoResult.code isEqualToString:@"30001"]){
            [aCommon iToast:@"该账号已在其他设备登陆！"];
            [self performSelector:@selector(againLogin) withObject:self afterDelay:0.2];
        }else{
            [aCommon iToast:infoResult.desc];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failed(error);
    }];
}

/**
 *  1.4.4 知识点视频列表
 *
 *  @param kId     知识点id
 *  @param success 回调函数成功
 *  @param failed  回调函数失败
 */
- (void)userKnowledgeVideoListWithKId:(NSString *)kId success:(SuccessBlock)success failed:(FailedBlock)failed
{
    RTHttpClient *client = [RTHttpClient defaultClient];
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:[UserDefaultsUtils valueWithKey:USER_TOKEN],@"token",kId,@"kId",[self fromType],@"fromType",nil];
    [client requestWithPath:[BaseHandler requestUrlWithPath:@"/KnowledgeVideoList"] method:RTHttpRequestGet parameters:dict prepareExecute:^{
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        InfoResult *infoResult = [[InfoResult alloc] init];
        infoResult.code = [infoResult objectOrNilForKey:@"code" fromDictionary:responseObject];
        infoResult.desc = [infoResult objectOrNilForKey:@"desc" fromDictionary:responseObject];
        if ([infoResult.code isEqualToString:@"0"]) {
            if ([responseObject objectForKey:@"data"] != [NSNull null]) {
                NSDictionary *knowDic = [responseObject objectForKey:@"data"];
                KnowledgeVideoModel *videoModel = [[KnowledgeVideoModel alloc]init];
                if ([[knowDic objectForKey:@"resultArray"] count] != 0) {
                    for (NSDictionary *videoDict in [knowDic objectForKey:@"resultArray"])
                    {
                        ResultArrayListModel *resultModel = [[ResultArrayListModel alloc]init];
                        [resultModel setKVideoCCId:[videoDict objectForKey:@"kVideoCCId"]];
                        [resultModel setKVideoCoverUrl:[videoDict objectForKey:@"kVideoCoverUrl"]];
                        [resultModel setKVideoUrl:[videoDict objectForKey:@"kVideoUrl"]];
                        if ([[videoDict objectForKey:@"cVideoList"] count] != 0) {
                            for (NSDictionary *resultDic in [videoDict objectForKey:@"cVideoList"]) {
                                KnowledgeCVideoModel *cvideoModel = [[KnowledgeCVideoModel alloc]init];
                                cvideoModel.cVideoCCId = [cvideoModel objectOrNilForKey:@"cVideoCCId" fromDictionary:resultDic];
                                cvideoModel.cVideoCoverUrl = [cvideoModel objectOrNilForKey:@"cVideoCoverUrl" fromDictionary:resultDic];
                                cvideoModel.cVideoUrl = [cvideoModel objectOrNilForKey:@"cVideoUrl" fromDictionary:resultDic];
                                [resultModel.cVideoList addObject:cvideoModel];
                            }
                        }
                        [videoModel.resultArray addObject:resultModel];
                    }
                }
                [infoResult setExtraObj:videoModel];
            }
            success(infoResult);
            
        }else if ([infoResult.code isEqualToString:@"30001"]){
            [aCommon iToast:@"该账号已在其他设备登陆！"];
            [self performSelector:@selector(againLogin) withObject:self afterDelay:0.2];
        }else{
            [aCommon iToast:infoResult.desc];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failed(error);
    }];
}

/**
 *  1.4.5 技巧训练-知识点
 *
 *  @param sId     技巧编号
 *  @param success 回调函数成功
 *  @param failed  回调函数失败
 */
- (void)userSkillInfoWithSId:(NSString *)sId success:(SuccessBlock)success failed:(FailedBlock)failed
{
    RTHttpClient *client = [RTHttpClient defaultClient];
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:[UserDefaultsUtils valueWithKey:USER_TOKEN],@"token",sId,@"sId",[self fromType],@"fromType",nil];
    [client requestWithPath:[BaseHandler requestUrlWithPath:@"/SkillInfo"] method:RTHttpRequestGet parameters:dict prepareExecute:^{
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        InfoResult *infoResult = [[InfoResult alloc] init];
        infoResult.code = [infoResult objectOrNilForKey:@"code" fromDictionary:responseObject];
        infoResult.desc = [infoResult objectOrNilForKey:@"desc" fromDictionary:responseObject];
        if ([infoResult.code isEqualToString:@"0"]) {
            if ([responseObject objectForKey:@"data"] != [NSNull null]) {
                NSDictionary *skillDic = [responseObject objectForKey:@"data"];
                SkillListModel *skillInfo = [[SkillListModel alloc]init];
                [skillInfo setSId:[skillDic objectForKey:@"sId"]];
                [skillInfo setSName:[skillDic objectForKey:@"sName"]];
                skillInfo.mainVideoCCId = [skillInfo objectOrNilForKey:@"mainVideoCCId" fromDictionary:skillDic];
                skillInfo.mainVideoCoverUrl = [skillInfo objectOrNilForKey:@"mainVideoCoverUrl" fromDictionary:skillDic];
                skillInfo.mainVideoUrl = [skillInfo objectOrNilForKey:@"mainVideoUrl" fromDictionary:skillDic];
                [infoResult setExtraObj:skillInfo];
                
                success(infoResult);
            }
            else{
                [aCommon iToast:infoResult.desc];
            }
        }else if ([infoResult.code isEqualToString:@"30001"]){
            [aCommon iToast:@"该账号已在其他设备登陆！"];
            [self performSelector:@selector(againLogin) withObject:self afterDelay:0.2];
        }else{
            [aCommon iToast:infoResult.desc];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failed(error);
    }];
}

/**
 *  1.4.6 题目列表-技巧训练
 *
 *  @param sId     技巧编号
 *  @param sType   技巧类型
 *  @param success 回调函数成功
 *  @param failed  回调函数失败
 */
- (void)userSkillQuestionListWithSId:(NSString *)sId andSType:(NSString *)sType success:(SuccessBlock)success failed:(FailedBlock)failed
{
    RTHttpClient *client = [RTHttpClient defaultClient];
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:[UserDefaultsUtils valueWithKey:USER_TOKEN],@"token",sId,@"sId",sType,@"sType",[self fromType],@"fromType",nil];
    [client requestWithPath:[BaseHandler requestUrlWithPath:@"/SkillQuestionList"] method:RTHttpRequestGet parameters:dict prepareExecute:^{
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        success([ProblemSetsList problemSetsListRequestModel:responseObject]);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failed(error);
    }];
}

/**
 *  1.4.7 题目列表-习题训练
 *
 *  @param weekId  周编号
 *  @param success 回调函数成功
 *  @param failed  回调函数失败
 */
- (void)userQuestinListWithWeekId:(NSString *)weekId success:(SuccessBlock)success failed:(FailedBlock)failed
{
    RTHttpClient *client = [RTHttpClient defaultClient];
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:[UserDefaultsUtils valueWithKey:USER_TOKEN],@"token",weekId,@"weekId",[self fromType],@"fromType",nil];
    [client requestWithPath:[BaseHandler requestUrlWithPath:@"/QuestionList"] method:RTHttpRequestGet parameters:dict prepareExecute:^{
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        success([ProblemSetsList problemSetsListRequestModel:responseObject]);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failed(error);
    }];
}

/**
 *  1.4.8 Videos
 *
 *  @param weekId  周编号
 *  @param success 回调函数成功
 *  @param failed  回调函数失败
 */
- (void)userWeekVideoListWithWeekId:(NSString *)weekId success:(SuccessBlock)success failed:(FailedBlock)failed
{
    RTHttpClient *client = [RTHttpClient defaultClient];
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:[UserDefaultsUtils valueWithKey:USER_TOKEN],@"token",weekId,@"weekId",[self fromType],@"fromType",nil];
    [client requestWithPath:[BaseHandler requestUrlWithPath:@"/WeekVideoList"] method:RTHttpRequestGet parameters:dict prepareExecute:^{
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        InfoResult *infoResult = [[InfoResult alloc] init];
        infoResult.code = [infoResult objectOrNilForKey:@"code" fromDictionary:responseObject];
        infoResult.desc = [infoResult objectOrNilForKey:@"desc" fromDictionary:responseObject];
        if ([infoResult.code isEqualToString:@"0"]) {
            if ([responseObject objectForKey:@"data"] != [NSNull null]) {
                NSDictionary *weekDic = [responseObject objectForKey:@"data"];
                WeekVideoModel *weekVideo = [[WeekVideoModel alloc]init];
                if ([[weekDic objectForKey:@"KVideoList"] count] !=  0) {
                    for (NSDictionary *kVideoDic in [weekDic objectForKey:@"KVideoList"]) {
                        KVideoListModel *KVideoModel = [[KVideoListModel alloc]init];
//                        [KVideoModel setKName:[kVideoDic objectForKey:@"kName"]];
                        KVideoModel.kName = [KVideoModel objectOrNilForKey:@"kName" fromDictionary:kVideoDic];
//                        if ([[kVideoDic objectForKey:@"videoList"] count] != 0 ) {
                        if ([[KVideoModel objectOrNilForKey:@"videoList" fromDictionary:kVideoDic] count] != 0 ) {
//                            for (NSDictionary *VideoDict in [kVideoDic objectForKey:@"videoList"]) {
                            for (NSDictionary *VideoDict in [KVideoModel objectOrNilForKey:@"videoList" fromDictionary:kVideoDic]) {
                                VideoListModel *videoModel = [[VideoListModel alloc]init];
                                [videoModel setKVideoCoverUrl:[VideoDict objectForKey:@"kVideoCoverUrl"]];
                                [videoModel setKVideoCCId:[VideoDict objectForKey:@"kVideoCCId"]];
                                [videoModel setKVideoUrl:[VideoDict objectForKey:@"kVideoUrl"]];
                                if ([[VideoDict objectForKey:@"cVideoList"] count] != 0) {
                                    for (NSDictionary *CVideoDict in [VideoDict objectForKey:@"cVideoList"]) {
                                        CVideoListModel *cVideoModel = [[CVideoListModel alloc]init];
                                        cVideoModel.cVideoCoverUrl = [cVideoModel objectOrNilForKey:@"cVideoCoverUrl" fromDictionary:CVideoDict];
                                        cVideoModel.cVideoUrl = [cVideoModel objectOrNilForKey:@"cVideoUrl" fromDictionary:CVideoDict];
                                        cVideoModel.cVideoCCId = [cVideoModel objectOrNilForKey:@"cVideoCCId" fromDictionary:CVideoDict];
                                        [videoModel.cVideoList addObject:cVideoModel];
                                    }
                                }
                                [KVideoModel.videoList addObject:videoModel];
                            }
                        }
                        [weekVideo.kVideoListArr addObject:KVideoModel];
                    }
                }
                if ([[weekDic objectForKey:@"SVideoList"] count] != 0) {
                    for (NSDictionary *SVideoDic in [weekDic objectForKey:@"SVideoList"]) {
                        SVideoListModel *SVideoModel = [[SVideoListModel alloc]init];
                        [SVideoModel setSId:[SVideoDic objectForKey:@"sId"]];
                        [SVideoModel setSName:[SVideoDic objectForKey:@"sName"]];
                        SVideoModel.sVideoCoverUrl = [SVideoModel objectOrNilForKey:@"sVideoCoverUrl" fromDictionary:SVideoDic];
                        SVideoModel.sVideoUrl = [SVideoModel objectOrNilForKey:@"sVideoUrl" fromDictionary:SVideoDic];
                        SVideoModel.sVideoCCId = [SVideoModel objectOrNilForKey:@"sVideoCCId" fromDictionary:SVideoDic];
                        [weekVideo.sVideoListArr addObject:SVideoModel];
                    }
                }
                
                [infoResult setExtraObj:weekVideo];
            }
            success(infoResult);
            
        }else if ([infoResult.code isEqualToString:@"30001"]){
            [aCommon iToast:@"该账号已在其他设备登陆！"];
            [self performSelector:@selector(againLogin) withObject:self afterDelay:0.2];
        }else{
            [aCommon iToast:infoResult.desc];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failed(error);
    }];
}

/**
 *  1.4.9 Lecture on answer to question
Repeat
 *
 *  @param kId     知识点id
 *  @param success 回调函数成功
 *  @param failed  回调函数失败
 */
- (void)userCommonSkillListWithWeekId:(NSString *)weekId success:(SuccessBlock)success failed:(FailedBlock)failed
{
    RTHttpClient *client = [RTHttpClient defaultClient];
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:[UserDefaultsUtils valueWithKey:USER_TOKEN],@"token",weekId,@"weekId",[self fromType],@"fromType",nil];
    [client requestWithPath:[BaseHandler requestUrlWithPath:@"/CommonSkillList"] method:RTHttpRequestGet parameters:dict prepareExecute:^{
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        InfoResult *infoResult = [[InfoResult alloc] init];
        infoResult.code = [infoResult objectOrNilForKey:@"code" fromDictionary:responseObject];
        infoResult.desc = [infoResult objectOrNilForKey:@"desc" fromDictionary:responseObject];
        if ([infoResult.code isEqualToString:@"0"]) {
            if ([responseObject objectForKey:@"data"] != [NSNull null]) {
                NSDictionary *commonDic = [responseObject objectForKey:@"data"];
                CommonSkillModel *commonModel = [[CommonSkillModel alloc]init];
                if ([[commonDic objectForKey:@"CommonSkillList"] count] != 0) {
                    for (NSDictionary *listDic in [commonDic objectForKey:@"CommonSkillList"]) {
                        CommonListModel *listModel = [[CommonListModel alloc]init];
                        [listModel setSId:[listDic objectForKey:@"sId"]];
                        [listModel setSName:[listDic objectForKey:@"sName"]];
                        [listModel setSVideoCoverUrl:[listDic objectForKey:@"sVideoCoverUrl"]];
                        [listModel setSVideoCCId:[listDic objectForKey:@"sVideoCCId"]];
                        [listModel setSVideoUrl:[listDic objectForKey:@"sVideoUrl"]];
                        [commonModel.commonSkillListArr addObject:listModel];
                    }
                }
                [infoResult setExtraObj:commonModel];
            }
            success(infoResult);
            
        }else if ([infoResult.code isEqualToString:@"30001"]){
            [aCommon iToast:@"该账号已在其他设备登陆！"];
            [self performSelector:@selector(againLogin) withObject:self afterDelay:0.2];
        }else{
            [aCommon iToast:infoResult.desc];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failed(error);
    }];
}

/**
 *  1.4.10 技巧训练-综合训练
 *
 *  @param weekId  周编号
 *  @param success 回调函数成功
 *  @param failed  回调函数失败
 */
- (void)userSkillListWithWeekId:(NSString *)weekId success:(SuccessBlock)success failed:(FailedBlock)failed
{
    RTHttpClient *client = [RTHttpClient defaultClient];
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:[UserDefaultsUtils valueWithKey:USER_TOKEN],@"token",weekId,@"weekId",[self fromType],@"fromType",nil];
    [client requestWithPath:[BaseHandler requestUrlWithPath:@"/SkillList"] method:RTHttpRequestGet parameters:dict prepareExecute:^{
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        InfoResult *infoResult = [[InfoResult alloc] init];
        infoResult.code = [infoResult objectOrNilForKey:@"code" fromDictionary:responseObject];
        infoResult.desc = [infoResult objectOrNilForKey:@"desc" fromDictionary:responseObject];
        if ([infoResult.code isEqualToString:@"0"]) {
            if ([responseObject objectForKey:@"data"] != [NSNull null]) {
                NSDictionary *skillDic = [responseObject objectForKey:@"data"];
                SkillDataModel *skillModel = [[SkillDataModel alloc]init];
                if ([[skillDic objectForKey:@"SkillList"] count] != 0) {
                    for (NSDictionary *listDic in [skillDic objectForKey:@"SkillList"]) {
                        SkillListModel *listModel = [[SkillListModel alloc]init];
                        [listModel setSId:[listDic objectForKey:@"sId"]];
                        [listModel setSName:[listDic objectForKey:@"sName"]];
                        listModel.mainVideoCCId = [listModel objectOrNilForKey:@"mainVideoCCId" fromDictionary:listDic];
                        listModel.mainVideoCoverUrl = [listModel objectOrNilForKey:@"mainVideoCoverUrl" fromDictionary:listDic];
                        listModel.mainVideoUrl = [listModel objectOrNilForKey:@"mainVideoUrl" fromDictionary:listDic];
                        [skillModel.skillListArr addObject:listModel];
                    }
                }
                [infoResult setExtraObj:skillModel];
            }
            success(infoResult);
            
        }else if ([infoResult.code isEqualToString:@"30001"]){
            [aCommon iToast:@"该账号已在其他设备登陆！"];
            [self performSelector:@selector(againLogin) withObject:self afterDelay:0.2];
        }else{
            [aCommon iToast:infoResult.desc];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failed(error);
    }];
}

/**
 *  1.4.11 重点解析-综合训练
 *
 *  @param weekId  周编号
 *  @param success 回调函数成功
 *  @param failed  回调函数失败
 */
- (void)userImportantAnalysiWithWeekId:(NSString *)weekId success:(SuccessBlock)success failed:(FailedBlock)failed
{
    RTHttpClient *client = [RTHttpClient defaultClient];
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:[UserDefaultsUtils valueWithKey:USER_TOKEN],@"token",weekId,@"weekId",[self fromType],@"fromType",nil];
    [client requestWithPath:[BaseHandler requestUrlWithPath:@"/ImportantAnalysi"] method:RTHttpRequestGet parameters:dict prepareExecute:^{
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        InfoResult *infoResult = [[InfoResult alloc] init];
        infoResult.code = [infoResult objectOrNilForKey:@"code" fromDictionary:responseObject];
        infoResult.desc = [infoResult objectOrNilForKey:@"desc" fromDictionary:responseObject];
        if ([infoResult.code isEqualToString:@"0"]) {
            if ([responseObject objectForKey:@"data"] != [NSNull null]) {
                NSDictionary *importantDic = [responseObject objectForKey:@"data"];
                ImportantAnalysiModel *importantModel = [[ImportantAnalysiModel alloc]init];
                if ([[importantDic objectForKey:@"SkillList"] count] != 0) {
                    for (NSDictionary *listDic in [importantDic objectForKey:@"SkillList"])
                    {
                        ImportantListModel *listModel = [[ImportantListModel alloc]init];
                        [listModel setSId:[listDic objectForKey:@"sId"]];
                        [listModel setSName:[listDic objectForKey:@"sName"]];
                        [listModel setVideoCoverUrl:[listDic objectForKey:@"videoCoverUrl"]];
                        [listModel setVideoCCId:[listDic objectForKey:@"videoCCId"]];
                        [listModel setVideoName:[listDic objectForKey:@"videoName"]];
                        [listModel setVideoUrl:[listDic objectForKey:@"videoUrl"]];
                        [importantModel.skillListArray addObject:listModel];
                    }
                }
                [infoResult setExtraObj:importantModel];
            }
            success(infoResult);
            
        }else if ([infoResult.code isEqualToString:@"30001"]){
            [aCommon iToast:@"该账号已在其他设备登陆！"];
            [self performSelector:@selector(againLogin) withObject:self afterDelay:0.2];
        }else{
            [aCommon iToast:infoResult.desc];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failed(error);
    }];
}

/**
 *  1.4.12 易错知识点
 *
 *  @param pageIndex 分页下标
 *  @param pageSize  分页大小
 *  @param success   回调函数成功
 *  @param failed    回调函数失败
 */
- (void)userWrongKnowledgeListWithPageIndex:(NSString *)pageIndex andPageSize:(NSString *)pageSize success:(SuccessBlock)success failed:(FailedBlock)failed
{
    RTHttpClient *client = [RTHttpClient defaultClient];
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:[UserDefaultsUtils valueWithKey:USER_TOKEN],@"token",pageIndex,@"pageIndex",pageSize,@"pageSize",[self fromType],@"fromType",nil];
    [client requestWithPath:[BaseHandler requestUrlWithPath:@"/WrongKnowledgeList"] method:RTHttpRequestGet parameters:dict prepareExecute:^{
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        InfoResult *infoResult = [[InfoResult alloc] init];
        infoResult.code = [infoResult objectOrNilForKey:@"code" fromDictionary:responseObject];
        infoResult.desc = [infoResult objectOrNilForKey:@"desc" fromDictionary:responseObject];
        if ([infoResult.code isEqualToString:@"0"]) {
            if ([responseObject objectForKey:@"data"] != [NSNull null]) {
                NSDictionary *wrongListDic = [responseObject objectForKey:@"data"];
                WrongKnowledgeListModel *wrongListModel = [[WrongKnowledgeListModel alloc] init];
                if ([[wrongListDic objectForKey:@"WrongKnowledgeList"] count] != 0) {
                    for (NSDictionary *dic in [wrongListDic objectForKey:@"WrongKnowledgeList"]) {
                        WrongKnowledgeDataModel *wrongModel = [[WrongKnowledgeDataModel alloc] init];
                        [wrongModel setKId:[dic objectForKey:@"kId"]];
                        [wrongModel setKName:[dic objectForKey:@"kName"]];
                        [wrongModel setKContent:[dic objectForKey:@"kContent"]];
                        [wrongModel setWrongPercent:[dic objectForKey:@"wrongPercent"]];
                        [wrongListModel.wrongListArr addObject:wrongModel];
                    }
                }
                [infoResult setExtraObj:wrongListModel];
            }
            success(infoResult);
            
        }else if ([infoResult.code isEqualToString:@"30001"]){
            [aCommon iToast:@"该账号已在其他设备登陆！"];
            [self performSelector:@selector(againLogin) withObject:self afterDelay:0.2];
        }else{
            [aCommon iToast:infoResult.desc];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failed(error);
    }];
}

/**
 *  1.4.13 错题库（按月份返回最新的三个错题库）
 *
 *  @param success 回调函数成功
 *  @param failed  回调函数失败
 */
- (void)userWrongLibraySuccess:(SuccessBlock)success failed:(FailedBlock)failed
{
    RTHttpClient *client = [RTHttpClient defaultClient];
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:[UserDefaultsUtils valueWithKey:USER_TOKEN],@"token",[self fromType],@"fromType",nil];
    [client requestWithPath:[BaseHandler requestUrlWithPath:@"/WrongLibrary"] method:RTHttpRequestGet parameters:dict prepareExecute:^{
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        InfoResult *infoResult = [[InfoResult alloc] init];
        infoResult.code = [infoResult objectOrNilForKey:@"code" fromDictionary:responseObject];
        infoResult.desc = [infoResult objectOrNilForKey:@"desc" fromDictionary:responseObject];
        if ([infoResult.code isEqualToString:@"0"]) {
            if ([responseObject objectForKey:@"data"] != [NSNull null]) {
                NSDictionary *wrongListDic = [responseObject objectForKey:@"data"];
                DateListModel *dateListModel = [[DateListModel alloc] init];
                if ([wrongListDic objectForKey:@"DateList"] != 0) {
                    for (NSDictionary *dic in [wrongListDic objectForKey:@"DateList"]) {
                        WrongQueListModel *wrongQueListModel = [[WrongQueListModel alloc] init];
                        [wrongQueListModel setMonthTimeStamp:[dic objectForKey:@"monthTimeStamp"]];
                        [wrongQueListModel setWrongAmount:[dic objectForKey:@"wrongAmount"]];
                        if ([dic objectForKey:@"questionList"] != 0) {
                            for (NSDictionary *dict in [dic objectForKey:@"questionList"]){
                                WrongQueDataModel *wrongQueModel = [[WrongQueDataModel alloc] init];
                                [wrongQueModel setQId:[dict objectForKey:@"qId"]];
                                [wrongQueModel setQContent:[dict objectForKey:@"qContent"]];
                                wrongQueModel.qContentPicUrl = [wrongQueModel objectOrNilForKey:@"qContentPicUrl" fromDictionary:dict];
                                [wrongQueModel setQType:[[dict objectForKey:@"qType"] integerValue]];
                                
                                [wrongQueListModel.wrongQueListArr addObject:wrongQueModel];
                            }
                        }
                        [dateListModel.dateListArr addObject:wrongQueListModel];
                    }
                }
                [infoResult setExtraObj:dateListModel];
            }
            success(infoResult);
            
        }else if ([infoResult.code isEqualToString:@"30001"]){
            [aCommon iToast:@"该账号已在其他设备登陆！"];
            [self performSelector:@selector(againLogin) withObject:self afterDelay:0.2];
        }else{
            [aCommon iToast:infoResult.desc];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failed(error);
    }];
}

/**
 *  1.4.14 根据月份查询错题列表
 *
 *  @param monthTimeStamp 月份时间戳
 *  @param success        回调函数成功
 *  @param failed         回调函数失败
 */
- (void)userMonthWrongQuestinListWithMonthTimeStamp:(NSString *)monthTimeStamp success:(SuccessBlock)success failed:(FailedBlock)failed
{
    RTHttpClient *client = [RTHttpClient defaultClient];
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:[UserDefaultsUtils valueWithKey:USER_TOKEN],@"token",monthTimeStamp,@"monthTimeStamp",[self fromType],@"fromType",nil];
    [client requestWithPath:[BaseHandler requestUrlWithPath:@"/MonthWrongQuestionList"] method:RTHttpRequestGet parameters:dict prepareExecute:^{
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        success([ProblemSetsList problemErrorListRequestModel:responseObject]);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failed(error);
    }];
}

/**
 *  1.4.15 根据月份查询错题库
 *
 *  @param monthTimeStamp 月份时间戳
 *  @param pageIndex      分页下标
 *  @param pageSize       分页大小
 *  @param success        回调函数成功
 *  @param failed         回调函数失败
 */
- (void)userMonthWrongLibrayWithMonthTimeStamp:(NSString *)monthTimeStamp andPageIndex:(NSString *)pageIndex andPageSize:(NSString *)pageSize success:(SuccessBlock)success failed:(FailedBlock)failed
{
    RTHttpClient *client = [RTHttpClient defaultClient];
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:[UserDefaultsUtils valueWithKey:USER_TOKEN],@"token",monthTimeStamp,@"monthTimeStamp",pageIndex,@"pageIndex",pageSize,@"pageSize",[self fromType],@"fromType",nil];
    [client requestWithPath:[BaseHandler requestUrlWithPath:@"/MonthWrongLibrary"] method:RTHttpRequestGet parameters:dict prepareExecute:^{
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        InfoResult *infoResult = [[InfoResult alloc] init];
        infoResult.code = [infoResult objectOrNilForKey:@"code" fromDictionary:responseObject];
        infoResult.desc = [infoResult objectOrNilForKey:@"desc" fromDictionary:responseObject];
        if ([infoResult.code isEqualToString:@"0"]) {
            if ([responseObject objectForKey:@"data"] != [NSNull null]) {
                NSDictionary *wrongListDic = [responseObject objectForKey:@"data"];
                WrongQueListModel *wrongQueListModel = [[WrongQueListModel alloc] init];
                if ([wrongListDic objectForKey:@"questionList"] != 0) {
                    for (NSDictionary *dict in [wrongListDic objectForKey:@"questionList"]){
                        WrongQueDataModel *wrongQueModel = [[WrongQueDataModel alloc] init];
                        [wrongQueModel setQId:[dict objectForKey:@"qId"]];
                        [wrongQueModel setQContent:[dict objectForKey:@"qContent"]];
                        wrongQueModel.qContentPicUrl = [wrongQueModel objectOrNilForKey:@"qContentPicUrl" fromDictionary:dict];
                        [wrongQueModel setQType:[[dict objectForKey:@"qType"] integerValue]];
                        
                        [wrongQueListModel.wrongQueListArr addObject:wrongQueModel];
                    }
                }
                [infoResult setExtraObj:wrongQueListModel];
            }
        }else if ([infoResult.code isEqualToString:@"30001"]){
            [aCommon iToast:@"该账号已在其他设备登陆！"];
            [self performSelector:@selector(againLogin) withObject:self afterDelay:0.2];
        }else{
            [aCommon iToast:infoResult.desc];
        }
        success(infoResult);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failed(error);
    }];
}

/**
 *  1.4.16 模拟试卷列表
 *
 *  @param pageIndex 分页上标
 *  @param pageSize  分页大小
 *  @param success   回调函数成功
 *  @param failed    回调函数失败
 */
- (void)userSimulationPaperListWithPageIndex:(NSString *)pageIndex andPageSize:(NSString *)pageSize success:(SuccessBlock)success failed:(FailedBlock)failed
{
    RTHttpClient *client = [RTHttpClient defaultClient];
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:[UserDefaultsUtils valueWithKey:USER_TOKEN],@"token",pageIndex,@"pageIndex",pageSize,@"pageSize",[self fromType],@"fromType",nil];
    [client requestWithPath:[BaseHandler requestUrlWithPath:@"/SimulationPaperList"] method:RTHttpRequestGet parameters:dict prepareExecute:^{
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        InfoResult *infoResult = [[InfoResult alloc] init];
        infoResult.code = [infoResult objectOrNilForKey:@"code" fromDictionary:responseObject];
        infoResult.desc = [infoResult objectOrNilForKey:@"desc" fromDictionary:responseObject];
        if ([infoResult.code isEqualToString:@"0"]) {
            if ([responseObject objectForKey:@"data"] != [NSNull null]) {
                NSDictionary *simulationDic = [responseObject objectForKey:@"data"];
                SimulationPaperModel *simulationModel = [[SimulationPaperModel alloc]init];
                if ([[simulationDic objectForKey:@"SimulationPaperList"] count] != 0) {
                    for (NSDictionary *paperDic in [simulationDic objectForKey:@"SimulationPaperList"]) {
                        SimulationListModel *paperModel = [[SimulationListModel alloc]init];
                        [paperModel setPaperId:[paperDic objectForKey:@"paperId"]];
                        [paperModel setPaperName:[paperDic objectForKey:@"paperName"]];
                        [paperModel setThisWeek:[paperDic objectForKey:@"thisWeek"]];
                        [simulationModel.simulationPaperList addObject:paperModel];
                    }
                }
                [infoResult setExtraObj:simulationModel];
            }
        }else if ([infoResult.code isEqualToString:@"30001"]){
            [aCommon iToast:@"该账号已在其他设备登陆！"];
            [self performSelector:@selector(againLogin) withObject:self afterDelay:0.2];
        }else{
            [aCommon iToast:infoResult.desc];
        }
        success(infoResult);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failed(error);
    }];
}


/**
 *  1.4.17 试卷题目列表
 *
 *  @param paperId 试卷id
 *  @param success 回调函数成功
 *  @param failed  回调函数失败
 */
- (void)userQuestionListByPaperWithPaperId:(NSString *)paperId success:(SuccessBlock)success failed:(FailedBlock)failed
{
    RTHttpClient *client = [RTHttpClient defaultClient];
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:[UserDefaultsUtils valueWithKey:USER_TOKEN],@"token",paperId,@"paperId",[self fromType],@"fromType",nil];
    [client requestWithPath:[BaseHandler requestUrlWithPath:@"/QuestionListByPaper"] method:RTHttpRequestGet parameters:dict prepareExecute:^{
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        success([ProblemSetsList problemSetsListRequestModel:responseObject]);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failed(error);
    }];
}

/**
 *  1.4.18 提交答案-试卷
 *
 *  @param paperId      试卷id
 *  @param takeTime     考试时间 单位：毫秒
 *  @param answerResult 答案结果
 *  @param success      回调函数成功
 *  @param failed       回调函数失败
 */
- (void)userSubmitAnswerByPaperWithPaperId:(NSString *)paperId andTakeTime:(NSString *)takeTime andAnswerResult:(NSString *)answerResult success:(SuccessBlock)success failed:(FailedBlock)failed
{
    NSString * dataStr = [NSString stringWithFormat:@"token=%@&paperId=%@&takeTime=%@&answerResult=%@&fromType=%@",[UserDefaultsUtils valueWithKey:USER_TOKEN],paperId,takeTime,answerResult,[self fromType]];
    [LoginHandler executeUrl:[BaseHandler requestUrlWithPath:@"/SubmitAnswerByPaper?"] data:dataStr success:^(id obj) {
        NSDictionary *responseObject = (NSDictionary *)obj;
        InfoResult *infoResult = [[InfoResult alloc] init];
        infoResult.code = [infoResult objectOrNilForKey:@"code" fromDictionary:responseObject];
        infoResult.desc = [infoResult objectOrNilForKey:@"desc" fromDictionary:responseObject];
        if ([infoResult.code isEqualToString:@"0"]) {
            if ([responseObject objectForKey:@"data"] != [NSNull null]) {
                NSDictionary *submitDic = [responseObject objectForKey:@"data"];
                SubmitByPaperModel *submitModel = [[SubmitByPaperModel alloc]init];
                [submitModel setScore:[submitDic objectForKey:@"score"]];
                if ([[submitDic objectForKey:@"wrongQIdList"] count] != 0) {
                    for (NSString *list in [submitDic objectForKey:@"wrongQIdList"]) {
                        [submitModel.wrongQIdList addObject:list];
                    }
                }
                [infoResult setExtraObj:submitModel];
            }
        }else if ([infoResult.code isEqualToString:@"30001"]){
            [aCommon iToast:@"该账号已在其他设备登陆！"];
            [self performSelector:@selector(againLogin) withObject:self afterDelay:0.2];
        }else{
            [aCommon iToast:infoResult.desc];
        }
        success(infoResult);
    } failed:^(id obj) {
        failed(obj);
    }];
    
//    RTHttpClient *client = [RTHttpClient defaultClient];
//    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:[UserDefaultsUtils valueWithKey:USER_TOKEN],@"token",paperId,@"paperId",takeTime,@"takeTime",answerResult,@"answerResult",[self fromType],@"fromType",nil];
//    [client requestWithPath:[BaseHandler requestUrlWithPath:@"/SubmitAnswerByPaper"] method:RTHttpRequestGet parameters:dict prepareExecute:^{
//    } success:^(NSURLSessionDataTask *task, id responseObject) {
//        InfoResult *infoResult = [[InfoResult alloc] init];
//        infoResult.code = [infoResult objectOrNilForKey:@"code" fromDictionary:responseObject];
//        infoResult.desc = [infoResult objectOrNilForKey:@"desc" fromDictionary:responseObject];
//        if ([infoResult.code isEqualToString:@"0"]) {
//            if ([responseObject objectForKey:@"data"] != [NSNull null]) {
//                NSDictionary *submitDic = [responseObject objectForKey:@"data"];
//                SubmitByPaperModel *submitModel = [[SubmitByPaperModel alloc]init];
//                [submitModel setScore:[submitDic objectForKey:@"score"]];
//                if ([[submitDic objectForKey:@"wrongQIdList"] count] != 0) {
//                    for (NSString *list in [submitDic objectForKey:@"wrongQIdList"]) {
//                        [submitModel.wrongQIdList addObject:list];
//                    }
//                }
//                [infoResult setExtraObj:submitModel];
//            }     
//        }else if ([infoResult.code isEqualToString:@"30001"]){
//            [aCommon iToast:@"该账号已在其他设备登陆！"];
//            [self performSelector:@selector(againLogin) withObject:self afterDelay:0.2];
//        }else{
//            [aCommon iToast:infoResult.desc];
//        }
//        success(infoResult);
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        failed(error);
//    }];
}

/**
 *  1.4.19 提交答案-教材强化习题训练
 *
 *  @param weekId       周 id
 *  @param takeTime     考试用时  单位：毫秒
 *  @param answerResult 答题结果
 *  @param success      回调函数成功
 *  @param failed       回调函数失败
 */
- (void)userSubmitAnswerByWeekWithWeekId:(NSString *)weekId andTakeTime:(NSString *)takeTime andAnswerResult:(NSString *)answerResult success:(SuccessBlock)success failed:(FailedBlock)failed
{
    
    NSString * dataStr = [NSString stringWithFormat:@"token=%@&weekId=%@&takeTime=%@&answerResult=%@&fromType=%@",[UserDefaultsUtils valueWithKey:USER_TOKEN],weekId,takeTime,answerResult,[self fromType]];
    [LoginHandler executeUrl:[BaseHandler requestUrlWithPath:@"/SubmitAnswerByWeek?"] data:dataStr success:^(id obj) {
        NSDictionary *responseObject = (NSDictionary *)obj;
        InfoResult *infoResult = [[InfoResult alloc] init];
        infoResult.code = [infoResult objectOrNilForKey:@"code" fromDictionary:responseObject];
        infoResult.desc = [infoResult objectOrNilForKey:@"desc" fromDictionary:responseObject];
        if ([infoResult.code isEqualToString:@"0"]) {
            if ([responseObject objectForKey:@"data"] != [NSNull null]) {
                NSDictionary *submitDic = [responseObject objectForKey:@"data"];
                SubmitByWeekModel *submitModel = [[SubmitByWeekModel alloc]init];
                [submitModel setScore:[submitDic objectForKey:@"score"]];
                if ([[submitDic objectForKey:@"result"]count] != 0) {
                    for (NSDictionary *listDic in [submitDic objectForKey:@"result"]) {
                        ResultListModel *listModel = [[ResultListModel alloc]init];
                        [listModel setKId:[listDic objectForKey:@"kId"]];
                        [listModel setKName:[listDic objectForKey:@"kName"]];
                        [listModel setKContent:[listDic objectForKey:@"kContent"]];
                        if ([[listDic objectForKey:@"wrongQIdList"] count] != 0) {
                            for (NSString *list in [listDic objectForKey:@"wrongQIdList"]) {
                                [listModel.wrongQIdList addObject:list];
                            }
                        }
                        [submitModel.resultArr addObject:listModel];
                    }
                }
                
                [infoResult setExtraObj:submitModel];
            }
        }else if ([infoResult.code isEqualToString:@"30001"]){
            [aCommon iToast:@"该账号已在其他设备登陆！"];
            [self performSelector:@selector(againLogin) withObject:self afterDelay:0.2];
        }else{
            [aCommon iToast:infoResult.desc];
        }
        success(infoResult);
    } failed:^(id obj) {
        failed(obj);
    }];
}

/**
 *  1.4.20 提交答案-综合训练技巧训练
 *
 *  @param sId          技巧id
 *  @param takeTime     考试用时   单位：毫秒
 *  @param answerResult 答题结果
 *  @param success      回调函数成功
 *  @param failed       回调函数失败
 */
- (void)userSubmitAnswerBySkillWithSId:(NSString *)sId andTakeTime:(NSString *)takeTime andAnswerResult:(NSString *)answerResult success:(SuccessBlock)success failed:(FailedBlock)failed
{
    NSString * dataStr = [NSString stringWithFormat:@"token=%@&sId=%@&takeTime=%@&answerResult=%@&fromType=%@",[UserDefaultsUtils valueWithKey:USER_TOKEN],sId,takeTime,answerResult,[self fromType]];
    [LoginHandler executeUrl:[BaseHandler requestUrlWithPath:@"/SubmitAnswerBySkill?"] data:dataStr success:^(id obj) {
        NSDictionary *responseObject = (NSDictionary *)obj;
        InfoResult *infoResult = [[InfoResult alloc] init];
        infoResult.code = [infoResult objectOrNilForKey:@"code" fromDictionary:responseObject];
        infoResult.desc = [infoResult objectOrNilForKey:@"desc" fromDictionary:responseObject];
        if ([infoResult.code isEqualToString:@"0"]) {
            if ([responseObject objectForKey:@"data"] != [NSNull null]) {
                NSDictionary *submitDic = [responseObject objectForKey:@"data"];
                SubmitBySkillModel *submitModel = [[SubmitBySkillModel alloc]init];
                if ([[submitDic objectForKey:@"result"] count] != 0) {
                    for (NSDictionary *listDict in [submitDic objectForKey:@"result"]) {
                        SkillResultListModel *listModel = [[SkillResultListModel alloc]init];
                        [listModel setQId:[listDict objectForKey:@"qId"]];
                        [listModel setIsRight:[listDict objectForKey:@"isRight"]];
                        [listModel setSId:[listDict objectForKey:@"sId"]];
                        [listModel setSName:[listDict objectForKey:@"sName"]];
                        [submitModel.resultList addObject:listModel];
                    }
                }
                [infoResult setExtraObj:submitModel];
            }
        }else if ([infoResult.code isEqualToString:@"30001"]){
            [aCommon iToast:@"该账号已在其他设备登陆！"];
            [self performSelector:@selector(againLogin) withObject:self afterDelay:0.2];
        }else{
            [aCommon iToast:infoResult.desc];
        }
        success(infoResult);
    } failed:^(id obj) {
        failed(obj);
    }];
}

/**
 *  1.4.21 提交答案-知识点习题训练
 *
 *  @param kId          知识点id
 *  @param takeTime     考试用时  单位：毫秒
 *  @param answerResult 答案结果
 *  @param success      回调函数成功
 *  @param failed       回调函数失败
 */
- (void)userKSubmitAnswerWithKid:(NSString *)kId andTakeTime:(NSString *)takeTime andAnswerResult:(NSString *)answerResult success:(SuccessBlock)success failed:(FailedBlock)failed
{
    NSString * dataStr = [NSString stringWithFormat:@"token=%@&kId=%@&takeTime=%@&answerResult=%@&fromType=%@",[UserDefaultsUtils valueWithKey:USER_TOKEN],kId,takeTime,answerResult,[self fromType]];
    [LoginHandler executeUrl:[BaseHandler requestUrlWithPath:@"/KSubmitAnswer?"] data:dataStr success:^(id obj) {
        NSDictionary *responseObject = (NSDictionary *)obj;
        InfoResult *infoResult = [[InfoResult alloc] init];
        infoResult.code = [infoResult objectOrNilForKey:@"code" fromDictionary:responseObject];
        infoResult.desc = [infoResult objectOrNilForKey:@"desc" fromDictionary:responseObject];
        if ([infoResult.code isEqualToString:@"0"]) {
            if ([responseObject objectForKey:@"data"] != [NSNull null]) {
                NSDictionary *submitDic = [responseObject objectForKey:@"data"];
                SubmitQuestionModel *submitQuestionModel = [[SubmitQuestionModel alloc] init];
                [submitQuestionModel setScore:[submitDic objectForKey:@"score"]];
                [submitQuestionModel setHighestScore:[submitDic objectForKey:@"highestScore"]];
                [submitQuestionModel setBeatPercent:[submitDic objectForKey:@"beatPercent"]];
                
                if ([submitDic objectForKey:@"wrongQIdList"] != 0) {
                    for (NSString *dict2 in [submitDic objectForKey:@"wrongQIdList"]){
                        [submitQuestionModel.wrongQIdList addObject:dict2];
                    }
                }
                
                [infoResult setExtraObj:submitQuestionModel];
            }
        }else if ([infoResult.code isEqualToString:@"30001"]){
            [aCommon iToast:@"该账号已在其他设备登陆！"];
            [self performSelector:@selector(againLogin) withObject:self afterDelay:0.2];
        }else{
            [aCommon iToast:infoResult.desc];
        }
        success(infoResult);
    } failed:^(id obj) {
        failed(obj);
    }];
}

/**
 *  1.4.22 提交答案-题型选择
 *
 *  @param tId          题型id
 *  @param bigQId       答题id
 *  @param takeTime     考试用时  单位：毫秒
 *  @param answerResult 答案结果
 *  @param success      回调函数成功
 *  @param failed       回调函数失败
 */
- (void)userSubmitAnswerByQTypeWithTId:(NSString *)tId andBigQId:(NSString *)bigQId andTakeTime:(NSString *)takeTime andAnswerResult:(NSString *)answerResult success:(SuccessBlock)success failed:(FailedBlock)failed
{
    NSString * dataStr = [NSString stringWithFormat:@"token=%@&tId=%@&bigQId=%@&takeTime=%@&answerResult=%@&fromType=%@",[UserDefaultsUtils valueWithKey:USER_TOKEN],tId,bigQId,takeTime,answerResult,[self fromType]];
    [LoginHandler executeUrl:[BaseHandler requestUrlWithPath:@"/SubmitAnswerByQType?"] data:dataStr success:^(id obj) {
        NSDictionary *responseObject = (NSDictionary *)obj;
        InfoResult *infoResult = [[InfoResult alloc] init];
        infoResult.code = [infoResult objectOrNilForKey:@"code" fromDictionary:responseObject];
        infoResult.desc = [infoResult objectOrNilForKey:@"desc" fromDictionary:responseObject];
        if ([infoResult.code isEqualToString:@"0"]) {
            if ([responseObject objectForKey:@"data"] != [NSNull null]) {
                NSDictionary *submitDic = [responseObject objectForKey:@"data"];
                SubmitBySkillModel *submitModel = [[SubmitBySkillModel alloc]init];
                if ([[submitDic objectForKey:@"result"] count] != 0) {
                    for (NSDictionary *listDict in [submitDic objectForKey:@"result"]) {
                        SkillResultListModel *listModel = [[SkillResultListModel alloc]init];
                        [listModel setQId:[listDict objectForKey:@"qId"]];
                        [listModel setIsRight:[listDict objectForKey:@"isRight"]];
                        [listModel setSId:[listDict objectForKey:@"sId"]];
                        [listModel setSName:[listDict objectForKey:@"sName"]];
                        [submitModel.resultList addObject:listModel];
                    }
                }
                [infoResult setExtraObj:submitModel];
            }
        }else if ([infoResult.code isEqualToString:@"30001"]){
            [aCommon iToast:@"该账号已在其他设备登陆！"];
            [self performSelector:@selector(againLogin) withObject:self afterDelay:0.2];
        }else{
            [aCommon iToast:infoResult.desc];
        }
        success(infoResult);
    } failed:^(id obj) {
        failed(obj);
    }];
}

/**
 *  1.4.23 系统意见列表
 *
 *  @param success 回调函数成功
 *  @param failed  回调函数失败
 */
- (void)userOpinionListSuccess:(SuccessBlock)success failed:(FailedBlock)failed
{
    RTHttpClient *client = [RTHttpClient defaultClient];
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:[UserDefaultsUtils valueWithKey:USER_TOKEN],@"token",[self fromType],@"fromType",nil];
    [client requestWithPath:[BaseHandler requestUrlWithPath:@"/OpinionList"] method:RTHttpRequestGet parameters:dict prepareExecute:^{
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        InfoResult *infoResult = [[InfoResult alloc] init];
        infoResult.code = [infoResult objectOrNilForKey:@"code" fromDictionary:responseObject];
        infoResult.desc = [infoResult objectOrNilForKey:@"desc" fromDictionary:responseObject];
        if ([infoResult.code isEqualToString:@"0"]) {
            if ([responseObject objectForKey:@"data"] != [NSNull null]) {
                NSDictionary *opinionDic = [responseObject objectForKey:@"data"];
                OpinionListModel *opinionModel = [[OpinionListModel alloc]init];
                if ([[opinionDic objectForKey:@"result"] count] != 0) {
                    for (NSDictionary *dict in [opinionDic objectForKey:@"result"]) {
                        OpinionResultModel *listModel = [[OpinionResultModel alloc]init];
                        [listModel setOId:[dict objectForKey:@"oId"]];
                        [listModel setOContent:[dict objectForKey:@"oContent"]];
                        [opinionModel.resultArray addObject:listModel];
                    }
                }
                [infoResult setExtraObj:opinionModel];
            }
            success(infoResult);
            
        }else if ([infoResult.code isEqualToString:@"30001"]){
            [aCommon iToast:@"该账号已在其他设备登陆！"];
            [self performSelector:@selector(againLogin) withObject:self afterDelay:0.2];
        }else{
            [aCommon iToast:infoResult.desc];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failed(error);
    }];
}

/**
 *  1.4.24 反馈意见
 *
 *  @param opinionResult 意见Json数据
 *  @param success       回调函数成功
 *  @param failed        回调函数失败
 */
- (void)userSubmitOpinionWithOpinionResult:(NSString *)opinionResult success:(SuccessBlock)success failed:(FailedBlock)failed
{
    RTHttpClient *client = [RTHttpClient defaultClient];
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:[UserDefaultsUtils valueWithKey:USER_TOKEN],@"token",opinionResult,@"opinionResult",[self fromType],@"fromType",nil];
    [client requestWithPath:[BaseHandler requestUrlWithPath:@"/SubmitOpinion"] method:RTHttpRequestGet parameters:dict prepareExecute:^{
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        InfoResult *infoResult = [[InfoResult alloc] init];
        infoResult.code = [infoResult objectOrNilForKey:@"code" fromDictionary:responseObject];
        infoResult.desc = [infoResult objectOrNilForKey:@"desc" fromDictionary:responseObject];
        if ([infoResult.code isEqualToString:@"0"]) {
            // 输出参数为空
            
            success(infoResult);
        }else if ([infoResult.code isEqualToString:@"30001"]){
            [aCommon iToast:@"该账号已在其他设备登陆！"];
            [self performSelector:@selector(againLogin) withObject:self afterDelay:0.2];
        }else{
            [aCommon iToast:infoResult.desc];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failed(error);
    }];
}

/**
 *  1.4.25 一级知识点列表
 *
 *  @param success 回调函数成功
 *  @param failed  回调函数失败
 */
- (void)userTopLevelKnowledgeSuccess:(SuccessBlock)success failed:(FailedBlock)failed
{
    RTHttpClient *client = [RTHttpClient defaultClient];
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:[UserDefaultsUtils valueWithKey:USER_TOKEN],@"token",[self fromType],@"fromType",nil];
    [client requestWithPath:[BaseHandler requestUrlWithPath:@"/TopLevelKnowledge"] method:RTHttpRequestGet parameters:dict prepareExecute:^{
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        InfoResult *infoResult = [[InfoResult alloc] init];
        infoResult.code = [infoResult objectOrNilForKey:@"code" fromDictionary:responseObject];
        infoResult.desc = [infoResult objectOrNilForKey:@"desc" fromDictionary:responseObject];
        if ([infoResult.code isEqualToString:@"0"]) {
            if ([responseObject objectForKey:@"data"] != [NSNull null]) {
                NSDictionary *topDict = [responseObject objectForKey:@"data"];
                TopLevelKnowModel *topModel = [[TopLevelKnowModel alloc]init];
                if ([[topDict objectForKey:@"result"] count] != 0) {
                    for (NSDictionary *levelDict in [topDict objectForKey:@"result"]) {
                        TopLevelListModel *listModel = [[TopLevelListModel alloc]init];
                        [listModel setKId:[levelDict objectForKey:@"kId"]];
                        [listModel setKName:[levelDict objectForKey:@"kName"]];
                        [listModel setKContent:[levelDict objectForKey:@"kContent"]];
                        [topModel.resultArray addObject:listModel];
                    }
                }
                [infoResult setExtraObj:topModel];
            }
            success(infoResult);
            
        }else if ([infoResult.code isEqualToString:@"30001"]){
            [aCommon iToast:@"该账号已在其他设备登陆！"];
            [self performSelector:@selector(againLogin) withObject:self afterDelay:0.2];
        }else{
            [aCommon iToast:infoResult.desc];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failed(error);
    }];
}

/**
 *  1.4.26 子级知识点列表
 *
 *  @param kId     上级知识点id
 *  @param success 回调函数成功
 *  @param failed  回调函数失败
 */
- (void)userChildLevelKnowledgeWithKId:(NSString *)kId success:(SuccessBlock)success failed:(FailedBlock)failed
{
    RTHttpClient *client = [RTHttpClient defaultClient];
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:[UserDefaultsUtils valueWithKey:USER_TOKEN],@"token",kId,@"kId",[self fromType],@"fromType",nil];
    [client requestWithPath:[BaseHandler requestUrlWithPath:@"/ChildLevelKnowledge"] method:RTHttpRequestGet parameters:dict prepareExecute:^{
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        InfoResult *infoResult = [[InfoResult alloc] init];
        infoResult.code = [infoResult objectOrNilForKey:@"code" fromDictionary:responseObject];
        infoResult.desc = [infoResult objectOrNilForKey:@"desc" fromDictionary:responseObject];
        if ([infoResult.code isEqualToString:@"0"]) {
            if ([responseObject objectForKey:@"data"] != [NSNull null]) {
                NSDictionary *childDic = [responseObject objectForKey:@"data"];
                ChildLevelKnowModel *childModel = [[ChildLevelKnowModel alloc]init];
                if ([[childDic objectForKey:@"result"] count] != 0) {
                    for (NSDictionary *dict in [childDic objectForKey:@"result"]) {
                        ChildLevelListModel *listModel = [[ChildLevelListModel alloc]init];
                        [listModel setKId:[dict objectForKey:@"kId"]];
                        [listModel setKName:[dict objectForKey:@"kName"]];
                        [listModel setKContent:[dict objectForKey:@"kContent"]];
//                        [listModel setHasViewed:[dict objectForKey:@"hasViewed"]];
//                        [listModel setRemainAmount:[dict objectForKey:@"remainAmount"]];
                        [childModel.resultArray addObject:listModel];
                    }
                }
                [infoResult setExtraObj:childModel];
            }
            success(infoResult);
            
        }else if ([infoResult.code isEqualToString:@"30001"]){
            [aCommon iToast:@"该账号已在其他设备登陆！"];
            [self performSelector:@selector(againLogin) withObject:self afterDelay:0.2];
        }else{
            [aCommon iToast:infoResult.desc];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failed(error);
    }];
}

/**
 *  1.4.27 知识点题目列表
 *
 *  @param kId     知识点id
 *  @param success 回调函数成功
 *  @param failed  回调函数失败
 */
- (void)userKnowledgeQuestionListWithKId:(NSString *)kId success:(SuccessBlock)success failed:(FailedBlock)failed
{
    RTHttpClient *client = [RTHttpClient defaultClient];
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:[UserDefaultsUtils valueWithKey:USER_TOKEN],@"token",kId,@"kId",[self fromType],@"fromType",nil];
    [client requestWithPath:[BaseHandler requestUrlWithPath:@"/KnowledgeQuestionList"] method:RTHttpRequestGet parameters:dict prepareExecute:^{
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        success([ProblemSetsList problemSetsListRequestModel:responseObject]);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failed(error);
    }];
}

/**
 *  1.4.28 用户登录
 *
 *  @param account  账号
 *  @param tel      手机号码
 *  @param password 密码
 *  @param success  回调函数成功
 *  @param failed   回调函数失败
 */
- (void)userUserLoginWithAccount:(NSString *)account andTel:(NSString *)tel andPassword:(NSString *)password success:(SuccessBlock)success failed:(FailedBlock)failed
{
    RTHttpClient *client = [RTHttpClient defaultClient];
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:account,@"account",tel,@"tel",password,@"password",[self fromType],@"fromType",@"iOS",@"clientType",nil];
    [client requestWithPath:[BaseHandler requestUrlWithPath:@"/UserLogin"] method:RTHttpRequestGet parameters:dict prepareExecute:^{
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        InfoResult *infoResult = [[InfoResult alloc] init];
        infoResult.code = [infoResult objectOrNilForKey:@"code" fromDictionary:responseObject];
        infoResult.desc = [infoResult objectOrNilForKey:@"desc" fromDictionary:responseObject];
        if ([infoResult.code isEqualToString:@"0"]) {
            if ([responseObject objectForKey:@"data"] != [NSNull null]) {
                NSDictionary *userDic = [responseObject objectForKey:@"data"];
                UserLoginModel *userLogin = [[UserLoginModel alloc]init];
                [userLogin initWithJson:userDic];
                [infoResult setExtraObj:userLogin];
            }
        }else if ([infoResult.code isEqualToString:@"30017"]) {
            if ([responseObject objectForKey:@"data"] != [NSNull null]) {
                NSDictionary *userDic = [responseObject objectForKey:@"data"];
                UserLoginModel *userLogin = [[UserLoginModel alloc]init];
                [userLogin initWithJson:userDic];
                [infoResult setExtraObj:userLogin];
            }
        }
        success(infoResult);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failed(error);
    }];
}

/**
 *  1.4.29 题型列表
 *
 *  @param success 回调函数成功
 *  @param failed  回调函数失败
 */
- (void)userTopQTypeListSuccess:(SuccessBlock)success failed:(FailedBlock)failed
{
    RTHttpClient *client = [RTHttpClient defaultClient];
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:[UserDefaultsUtils valueWithKey:USER_TOKEN],@"token",[self fromType],@"fromType",nil];
    [client requestWithPath:[BaseHandler requestUrlWithPath:@"/TopQTypeList"] method:RTHttpRequestGet parameters:dict prepareExecute:^{
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        InfoResult *infoResult = [[InfoResult alloc] init];
        infoResult.code = [infoResult objectOrNilForKey:@"code" fromDictionary:responseObject];
        infoResult.desc = [infoResult objectOrNilForKey:@"desc" fromDictionary:responseObject];
        if ([infoResult.code isEqualToString:@"0"]) {
            if ([responseObject objectForKey:@"data"] != [NSNull null]) {
                NSDictionary *topDict = [responseObject objectForKey:@"data"];
                TopQTypeListModel *listModel = [[TopQTypeListModel alloc]init];
                if ([[topDict objectForKey:@"result"] count] != 0) {
                    for (NSDictionary *listDict in [topDict objectForKey:@"result"]) {
                        TopQTypeResultModel *childModel = [[TopQTypeResultModel alloc]init];
                        [childModel setTId:[listDict objectForKey:@"tId"]];
                        [childModel setTName:[listDict objectForKey:@"tName"]];
                        if ([[listDict objectForKey:@"childType"] count] != 0) {
                            for (NSDictionary *typeDict in [listDict objectForKey:@"childType"]) {
                                TopQTypeChildModel *resultModel = [[TopQTypeChildModel alloc]init];
                                [resultModel setTId:[typeDict objectForKey:@"tId"]];
                                [resultModel setTName:[typeDict objectForKey:@"tName"]];
                                [childModel.childTypeArray addObject:resultModel];
                            }
                        }
                        [listModel.resultArray addObject:childModel];
                    }
                }
                [infoResult setExtraObj:listModel];
            }
            success(infoResult);
            
        }else if ([infoResult.code isEqualToString:@"30001"]){
            [aCommon iToast:@"该账号已在其他设备登陆！"];
            [self performSelector:@selector(againLogin) withObject:self afterDelay:0.2];
        }else{
            [aCommon iToast:infoResult.desc];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failed(error);
    }];
}

/**
 *  1.4.30 题型题目列表
 *
 *  @param tId     题型Id
 *  @param success 回调函数成功
 *  @param failed  回调函数失败
 */
- (void)userTypeQuestionListWithTId:(NSString *)tId success:(SuccessBlock)success failed:(FailedBlock)failed
{
    RTHttpClient *client = [RTHttpClient defaultClient];
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:[UserDefaultsUtils valueWithKey:USER_TOKEN],@"token",tId,@"tId",[self fromType],@"fromType",nil];
    [client requestWithPath:[BaseHandler requestUrlWithPath:@"/TypeQuestionList"] method:RTHttpRequestGet parameters:dict prepareExecute:^{
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        InfoResult *infoResult = [[InfoResult alloc] init];
        infoResult.code = [infoResult objectOrNilForKey:@"code" fromDictionary:responseObject];
        infoResult.desc = [infoResult objectOrNilForKey:@"desc" fromDictionary:responseObject];
        if ([infoResult.code isEqualToString:@"0"]) {
            if ([responseObject objectForKey:@"data"] != [NSNull null]) {
                NSDictionary *typeDict = [responseObject objectForKey:@"data"];
                TypeQuestionListModel *questionModel = [[TypeQuestionListModel alloc]init];
                [questionModel setTVideoCCId:[typeDict objectForKey:@"tVideoCCId"]];
                [questionModel setTVideoCoverUrl:[typeDict objectForKey:@"tVideoCoverUrl"]];
                [questionModel setTVideoUrl:[typeDict objectForKey:@"tVideoUrl"]];
                questionModel.hasMoreVideo = [questionModel objectOrNilForKey:@"hasMoreVideo" fromDictionary:typeDict];
                if ([[typeDict objectForKey:@"questionList"] count] != 0) {
                    for (NSDictionary *dict in [typeDict objectForKey:@"questionList"]) {
                        TypeQListModel *qListModel = [[TypeQListModel alloc]init];
                        [qListModel setQId:[dict objectForKey:@"qId"]];
                        [qListModel setQVideoCCId:[dict objectForKey:@"qVideoCCId"]];
                        [qListModel setQVideoCoverUrl:[dict objectForKey:@"qVideoCoverUrl"]];
                        [qListModel setQVideoUrl:[dict objectForKey:@"qVideoUrl"]];
                        [questionModel.questionListArray addObject:qListModel];
                    }
                }
                [infoResult setExtraObj:questionModel];
            }
            success(infoResult);
            
        }else if ([infoResult.code isEqualToString:@"30001"]){
            [aCommon iToast:@"该账号已在其他设备登陆！"];
            [self performSelector:@selector(againLogin) withObject:self afterDelay:0.2];
        }else{
            [aCommon iToast:infoResult.desc];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failed(error);
    }];
}

/**
 *  1.4.31 查询答题
 *
 *  @param qId     答题id
 *  @param success 回调函数成功
 *  @param failed  回调函数失败
 */
- (void)userQuestionInfoWithQId:(NSString *)qId success:(SuccessBlock)success failed:(FailedBlock)failed
{
    RTHttpClient *client = [RTHttpClient defaultClient];
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:[UserDefaultsUtils valueWithKey:USER_TOKEN],@"token",qId,@"qId",[self fromType],@"fromType",nil];
    [client requestWithPath:[BaseHandler requestUrlWithPath:@"/QuestionInfo"] method:RTHttpRequestGet parameters:dict prepareExecute:^{
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        success([ProblemSetsList problemSetsListRequestModel:responseObject]);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failed(error);
    }];
}

/**
 *  1.4.32 学习进度统计
 *
 *  @param weekId        学习周Id
 *  @param weekIndex     学习周序号
 *  @param thisWeekIndex 本周序号
 *  @param success       回调函数成功
 *  @param failed        回调函数失败
 */
- (void)userProgressStatisticsWithWeekId:(NSString *)weekId andWeekIndex:(NSString *)weekIndex andThisWeekIndex:(NSString *)thisWeekIndex success:(SuccessBlock)success failed:(FailedBlock)failed
{
    RTHttpClient *client = [RTHttpClient defaultClient];
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:[UserDefaultsUtils valueWithKey:USER_TOKEN],@"token",weekId,@"weekId",weekIndex,@"weekIndex",thisWeekIndex,@"thisWeekIndex",[self fromType],@"fromType",nil];
    [client requestWithPath:[BaseHandler requestUrlWithPath:@"/ProgressStatistics"] method:RTHttpRequestGet parameters:dict prepareExecute:^{
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        InfoResult *infoResult = [[InfoResult alloc] init];
        infoResult.code = [infoResult objectOrNilForKey:@"code" fromDictionary:responseObject];
        infoResult.desc = [infoResult objectOrNilForKey:@"desc" fromDictionary:responseObject];
        if ([infoResult.code isEqualToString:@"0"]) {
            if ([responseObject objectForKey:@"data"] != [NSNull null]) {
                
            }
            success(infoResult);
        }else if ([infoResult.code isEqualToString:@"30001"]){
            [aCommon iToast:@"该账号已在其他设备登陆！"];
            [self performSelector:@selector(againLogin) withObject:self afterDelay:0.2];

        }else{
            [aCommon iToast:infoResult.desc];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failed(error);
    }];

}

/**
 *  1.4.33 知识点错题集
 *
 *  @param kId     知识点id
 *  @param success 回调函数成功
 *  @param failed  回调函数失败
 */
- (void)userKnowledgeWrongQuestionListWithKId:(NSString *)kId success:(SuccessBlock)success failed:(FailedBlock)failed
{
    RTHttpClient *client = [RTHttpClient defaultClient];
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:[UserDefaultsUtils valueWithKey:USER_TOKEN],@"token",kId,@"kId",[self fromType],@"fromType",nil];
    [client requestWithPath:[BaseHandler requestUrlWithPath:@"/KnowledgeWrongQuestionList"] method:RTHttpRequestGet parameters:dict prepareExecute:^{
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        success([ProblemSetsList problemErrorListRequestModel:responseObject]);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failed(error);
    }];
}

/**
 *  1.4.34 标记已掌握
 *
 *  @param qId     题目id
 *  @param success 回调函数成功
 *  @param failed  回调函数失败
 */
- (void)userMasterWrongWithQId:(NSString *)qId success:(SuccessBlock)success failed:(FailedBlock)failed
{
    RTHttpClient *client = [RTHttpClient defaultClient];
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:[UserDefaultsUtils valueWithKey:USER_TOKEN],@"token",qId,@"qId",[self fromType],@"fromType",nil];
    [client requestWithPath:[BaseHandler requestUrlWithPath:@"/MasterWrong"] method:RTHttpRequestGet parameters:dict prepareExecute:^{
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        InfoResult *infoResult = [[InfoResult alloc] init];
        infoResult.code = [infoResult objectOrNilForKey:@"code" fromDictionary:responseObject];
        infoResult.desc = [infoResult objectOrNilForKey:@"desc" fromDictionary:responseObject];
        if ([infoResult.code isEqualToString:@"0"]) {
            if ([responseObject objectForKey:@"data"] != [NSNull null]) {
                
            }
        }else if ([infoResult.code isEqualToString:@"30001"]){
            [aCommon iToast:@"该账号已在其他设备登陆！"];
            [self performSelector:@selector(againLogin) withObject:self afterDelay:0.2];
        }else{
            [aCommon iToast:infoResult.desc];
        }
        success(infoResult);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failed(error);
    }];
}

/**
 *  1.4.35 模块统计
 *
 *  @param mId     模块Id
 *  @param mType   模块类型
 *  @param success 回调函数成功
 *  @param failed  回调函数失败
 */
- (void)userModuleStatisticsWithMId:(NSString *)mId WithMType:(NSString *)mType success:(SuccessBlock)success failed:(FailedBlock)failed
{
    RTHttpClient *client = [RTHttpClient defaultClient];
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:[UserDefaultsUtils valueWithKey:USER_TOKEN],@"token",mId,@"mId",mType,@"mType",[self fromType],@"fromType",nil];
    [client requestWithPath:[BaseHandler requestUrlWithPath:@"/ModuleStatistics"] method:RTHttpRequestGet parameters:dict prepareExecute:^{
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        InfoResult *infoResult = [[InfoResult alloc] init];
        infoResult.code = [infoResult objectOrNilForKey:@"code" fromDictionary:responseObject];
        infoResult.desc = [infoResult objectOrNilForKey:@"desc" fromDictionary:responseObject];
        if ([infoResult.code isEqualToString:@"0"]) {
            if ([responseObject objectForKey:@"data"] != [NSNull null]) {
                
            }
        }else if ([infoResult.code isEqualToString:@"30001"]){
            [aCommon iToast:@"该账号已在其他设备登陆！"];
            [self performSelector:@selector(againLogin) withObject:self afterDelay:0.2];
        }else{
            [aCommon iToast:infoResult.desc];
        }
        success(infoResult);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failed(error);
    }];
}

/**
 *  1.4.36 视频播放&再次训练 付费控制
 *
 *  @param videoId 视频Id
 *  @param source  来源   0：视频付费控制  1：再次训练控制
 *  @param success 回调函数成功
 *  @param failed  回调函数失败
 */
- (void)userPayCCWithVideoId:(NSString *)videoId source:(NSString *)source success:(SuccessBlock)success failed:(FailedBlock)failed
{
    RTHttpClient *client = [RTHttpClient defaultClient];
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:[UserDefaultsUtils valueWithKey:USER_TOKEN],@"token",videoId,@"videoId",source,@"source",[self fromType],@"fromType",nil];
    [client requestWithPath:[BaseHandler requestUrlWithPath:@"/PayCC"] method:RTHttpRequestGet parameters:dict prepareExecute:^{
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        InfoResult *infoResult = [[InfoResult alloc] init];
        infoResult.code = [infoResult objectOrNilForKey:@"code" fromDictionary:responseObject];
        infoResult.desc = [infoResult objectOrNilForKey:@"desc" fromDictionary:responseObject];
        if ([infoResult.code isEqualToString:@"0"]) {
            if ([responseObject objectForKey:@"data"] != [NSNull null]) {
                NSDictionary *userDic = [responseObject objectForKey:@"data"];
                UserLoginModel *userLogin = [[UserLoginModel alloc]init];
                userLogin.ccAmount = [userLogin objectOrNilForKey:@"ccAmount" fromDictionary:userDic];
                [infoResult setExtraObj:userLogin];
            }
        }else if ([infoResult.code isEqualToString:@"30001"]){
            [aCommon iToast:@"该账号已在其他设备登陆！"];
            [self performSelector:@selector(againLogin) withObject:self afterDelay:0.2];
        }else if ([infoResult.code isEqualToString:@"30019"]){
            [aCommon iToast:@"cc币数量不足"];
        }else{
            [aCommon iToast:infoResult.desc];
        }
        success(infoResult);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failed(error);
    }];
}

/**
 *  1.4.37 视频播放所需CC币查询
 *
 *  @param videoId 视频Id
 *  @param success 回调函数成功
 *  @param failed  回调函数失败
 */
- (void)userqueryVCCNumWithVideoId:(NSString *)videoId success:(SuccessBlock)success failed:(FailedBlock)failed
{
    RTHttpClient *client = [RTHttpClient defaultClient];
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:[UserDefaultsUtils valueWithKey:USER_TOKEN],@"token",videoId,@"videoId",[self fromType],@"fromType",nil];
    [client requestWithPath:[BaseHandler requestUrlWithPath:@"/queryVCCNum"] method:RTHttpRequestGet parameters:dict prepareExecute:^{
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        InfoResult *infoResult = [[InfoResult alloc] init];
        infoResult.code = [infoResult objectOrNilForKey:@"code" fromDictionary:responseObject];
        infoResult.desc = [infoResult objectOrNilForKey:@"desc" fromDictionary:responseObject];
        if ([infoResult.code isEqualToString:@"0"]) {
            if ([responseObject objectForKey:@"data"] != [NSNull null]) {
                NSDictionary *userDic = [responseObject objectForKey:@"data"];
                UserLoginModel *userLogin = [[UserLoginModel alloc]init];
                userLogin.vCCNum = [userLogin objectOrNilForKey:@"vCCNum" fromDictionary:userDic];
                [infoResult setExtraObj:userLogin];
            }
        }else if ([infoResult.code isEqualToString:@"30001"]){
            [aCommon iToast:@"该账号已在其他设备登陆！"];
            [self performSelector:@selector(againLogin) withObject:self afterDelay:0.2];
        }else {
            [aCommon iToast:infoResult.desc];
        }
        success(infoResult);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failed(error);
    }];
}

/**
 *  1.4.38 题型更多视频列表
 *
 *  @param tId     题型Id
 *  @param success 回调函数成功
 *  @param failed  回调函数失败
 */
- (void)usermoreQTypeQuestionListWithTId:(NSString *)tId success:(SuccessBlock)success failed:(FailedBlock)failed
{
    RTHttpClient *client = [RTHttpClient defaultClient];
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:[UserDefaultsUtils valueWithKey:USER_TOKEN],@"token",tId,@"tId",[self fromType],@"fromType",nil];
    [client requestWithPath:[BaseHandler requestUrlWithPath:@"/moreQTypeQuestionList"] method:RTHttpRequestGet parameters:dict prepareExecute:^{
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        InfoResult *infoResult = [[InfoResult alloc] init];
        infoResult.code = [infoResult objectOrNilForKey:@"code" fromDictionary:responseObject];
        infoResult.desc = [infoResult objectOrNilForKey:@"desc" fromDictionary:responseObject];
        if ([infoResult.code isEqualToString:@"0"]) {
            if ([responseObject objectForKey:@"data"] != [NSNull null]) {
                NSDictionary *typeDict = [responseObject objectForKey:@"data"];
                TopKVideoModel *questionModel = [[TopKVideoModel alloc]init];
                if ([[typeDict objectForKey:@"result"] count] != 0) {
                    for (NSDictionary *listDict in [typeDict objectForKey:@"result"]) {
                        TopKVideoListModel *listModel = [[TopKVideoListModel alloc]init];
                        [listModel setTVideoName:[listDict objectForKey:@"tVideoName"]];
                        [listModel setTVideoCCId:[listDict objectForKey:@"tVideoCCId"]];
                        [listModel setTVideoCoverUrl:[listDict objectForKey:@"tVideoCoverUrl"]];
                        [listModel setTVideoUrl:[listDict objectForKey:@"tVideoUrl"]];
                        [questionModel.resultArray addObject:listModel];
                    }
                }
                [infoResult setExtraObj:questionModel];
            }
        }else if ([infoResult.code isEqualToString:@"30001"]){
            [aCommon iToast:@"该账号已在其他设备登陆！"];
            [self performSelector:@selector(againLogin) withObject:self afterDelay:0.2];
        }else {
            [aCommon iToast:infoResult.desc];
        }
        success(infoResult);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failed(error);
    }];
}

/**
 *  1.5.1 用户注册
 *
 *  @param tel      手机号码
 *  @param password 密码
 *  @param nickName 昵称
 *  @param pId      省份id
 *  @param cId      城市id
 *  @param dId      区id
 *  @param email    邮箱
 *  @param success  回调函数成功
 *  @param failed   回调函数失败
 */
- (void)userUserRegistWithTel:(NSString *)tel andPassword:(NSString *)password andNickName:(NSString *)nickName andPId:(NSString *)pId andCId:(NSString *)cId andDId:(NSString *)dId email:(NSString *)email success:(SuccessBlock)success failed:(FailedBlock)failed
{
    RTHttpClient *client = [RTHttpClient defaultClient];
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:tel,@"tel",password,@"password",nickName,@"nickName",pId,@"pId",cId,@"cId",dId,@"dId",email,@"email",nil];
    [client requestWithPath:[BaseHandler requestUrlWithPath:@"/UserRegist"] method:RTHttpRequestGet parameters:dict prepareExecute:^{
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        InfoResult *infoResult = [[InfoResult alloc] init];
        infoResult.code = [infoResult objectOrNilForKey:@"code" fromDictionary:responseObject];
        infoResult.desc = [infoResult objectOrNilForKey:@"desc" fromDictionary:responseObject];
        if ([infoResult.code isEqualToString:@"0"]) {
            if ([responseObject objectForKey:@"data"] != [NSNull null]) {
                NSDictionary *userDic = [responseObject objectForKey:@"data"];
                UserLoginModel *userLogin = [[UserLoginModel alloc]init];
                [userLogin initWithJson:userDic];
                [infoResult setExtraObj:userLogin];
            }
        }
        success(infoResult);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failed(error);
    }];
}

/**
 *  1.5.2 查询省市区
 *
 *  @param success 回调函数成功
 *  @param failed  回调函数失败
 */
- (void)userRequestWithLocationSuccess:(SuccessBlock)success failed:(FailedBlock)failed
{
    RTHttpClient *client = [RTHttpClient defaultClient];
    NSDictionary *dict = nil;
    [client requestWithPath:[BaseHandler requestUrlWithPath:@"/PCD"] method:RTHttpRequestGet parameters:dict prepareExecute:^{
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        InfoResult *infoResult = [[InfoResult alloc] init];
        infoResult.code = [infoResult objectOrNilForKey:@"code" fromDictionary:responseObject];
        infoResult.desc = [infoResult objectOrNilForKey:@"desc" fromDictionary:responseObject];
        if ([infoResult.code isEqualToString:@"0"]) {
            if ([responseObject objectForKey:@"data"] != [NSNull null]) {
                NSDictionary *provineListDic = [responseObject objectForKey:@"data"];
                ProvinceListModel *provineList = [[ProvinceListModel alloc]init];
                if ([[provineListDic objectForKey:@"provinceList"] count] != 0) {
                    for (NSDictionary *dic in [provineListDic objectForKey:@"provinceList"]) {
                        ProvinceDataModel *provineData = [[ProvinceDataModel alloc] init];
                        [provineData setPId:[dic objectForKey:@"pId"]];
                        [provineData setProvince:[dic objectForKey:@"province"]];
                        if ([[dic objectForKey:@"cityList"] count] != 0) {
                            for (NSDictionary *cityDic in [dic objectForKey:@"cityList"]) {
                                CityDataModel *cityData = [[CityDataModel alloc] init];
                                [cityData setCId:[cityDic objectForKey:@"cId"]];
                                [cityData setCity:[cityDic objectForKey:@"city"]];
                                if ([[cityDic objectForKey:@"districtList"] count] != 0 ) {
                                    for (NSDictionary *disDic in [cityDic objectForKey:@"districtList"]) {
                                        DistrictDataModel *districtData = [[DistrictDataModel alloc]init];
                                        [districtData setDId:[disDic objectForKey:@"dId"]];
                                        [districtData setDistrict:[disDic objectForKey:@"district"]];
                                        [cityData.districtList addObject:districtData];
                                    }
                                }
                                [provineData.cityList addObject:cityData];
                            }
                        }
                        [provineList.provinceList addObject:provineData];
                    }
                }
                [infoResult setExtraObj:provineList];
            }
            success(infoResult);
        }else{
            [aCommon iToast:infoResult.desc];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failed(error);
    }];
}

/**
 *  1.5.3 更改学习计划
 *
 *  @param level   学习计划
 *  @param success 回调函数成功
 *  @param failed  回调函数失败
 */
- (void)userRequestChangePlanWithlevel:(NSString *)level success:(SuccessBlock)success failed:(FailedBlock)failed
{
    RTHttpClient *client = [RTHttpClient defaultClient];
    PLog(@"$%@",[UserDefaultsUtils valueWithKey:USER_TOKEN]);
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:[UserDefaultsUtils valueWithKey:USER_TOKEN],@"token",level,@"level",nil];
    [client requestWithPath:[BaseHandler requestUrlWithPath:@"/ChangePlan"] method:RTHttpRequestGet parameters:dict prepareExecute:^{
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        InfoResult *infoResult = [[InfoResult alloc] init];
        infoResult.code = [infoResult objectOrNilForKey:@"code" fromDictionary:responseObject];
        infoResult.desc = [infoResult objectOrNilForKey:@"desc" fromDictionary:responseObject];
        if ([infoResult.code isEqualToString:@"0"]) {
            if ([responseObject objectForKey:@"data"] != [NSNull null]) {
                
            }
        }else{
            [aCommon iToast:infoResult.desc];
        }
        success(infoResult);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failed(error);
    }];
}

/**
 *  1.4.39 重置密码
 *
 *  @param level   学习计划
 *  @param success 回调函数成功
 *  @param failed  回调函数失败
 */
- (void)userRequestupdatePassWordWithAccount:(NSString *)account andTel:(NSString *)tel success:(SuccessBlock)success failed:(FailedBlock)failed
{
    RTHttpClient *client = [RTHttpClient defaultClient];
    PLog(@"$%@",[UserDefaultsUtils valueWithKey:USER_TOKEN]);
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:account,@"account",tel,@"tel",[self fromType],@"fromType",nil];
    [client requestWithPath:[BaseHandler requestUrlWithPath:@"/UpdatePassWord"] method:RTHttpRequestGet parameters:dict prepareExecute:^{
    } success:^(NSURLSessionDataTask *task, id responseObject) {
//        InfoResult *infoResult = [[InfoResult alloc] init];
//        infoResult.code = [infoResult objectOrNilForKey:@"code" fromDictionary:responseObject];
//        infoResult.desc = [infoResult objectOrNilForKey:@"desc" fromDictionary:responseObject];
//        if ([infoResult.code isEqualToString:@"0"]) {
//            if ([responseObject objectForKey:@"data"] != [NSNull null]) {
//        
//            }
//        }else{
//            [aCommon iToast:infoResult.desc];
//        }
        success(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failed(error);
    }];
}

- (void)againLogin
{
    [[NSNotificationCenter defaultCenter] postNotificationName:k_NOTI_AGAIN_LOGIN object:nil];
}
@end
