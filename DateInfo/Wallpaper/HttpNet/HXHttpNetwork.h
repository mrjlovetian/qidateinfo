//
//  AFNetwork.h
//  MRJ
//
//  Created by MRJ on 16/3/18.
//
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

@class AFHTTPSessionManager;
@protocol AFMultipartFormData;

@interface HXHttpNetwork : NSObject

//AFHTTPSessionManager
// 返回JSON数据 responseObject 是字典或者 数组
+ (NSURLSessionDataTask *)httpRequestDataByGet:(NSString *)urlString
                                        params:(NSDictionary *)params
                                       success:(void(^)(id responseObject))completionBlock
                                       failure:(void(^)(NSError *error))errorBlock;

// 返回JSON数据 responseObject 是字典或者 数组
+ (NSURLSessionDataTask *)httpRequestDataByPost:(NSString *)urlString
                                         params:(NSDictionary *)params
                                        success:(void(^)(id responseObject))completionBlock
                                        failure:(void(^)(NSError *error))errorBlock;

// 返回JSON数据 responseObject 是字典或者 数组 head
+ (void)httpRequestDataByPost:(NSString *)urlString
                       params:(NSDictionary *)params
                        head:(void (^)(AFHTTPSessionManager *manager))headBlock
                 construction:(void (^)(id <AFMultipartFormData> formData))construction
                      success:(void(^)(id responseObject))completionBlock
                      failure:(void(^)(NSError *error))errorBlock;

// 返回JSON数据 responseObject 是字典或者 数组
+ (NSURLSessionDataTask *)httpRequestDataByPost:(NSString *)urlString
                       params:(NSDictionary *)params
                 construction:(void (^)(id <AFMultipartFormData> formData))construction
                      success:(void (^)(id responseObject))completionBlock
                      failure:(void (^)(NSError *error))errorBlock;

// 返回一个JSON数据的 DataTask
+ (NSURLSessionDataTask *)httpDataTaskByRequest:(NSURLRequest *)request
                    success:(void(^)(NSURLResponse *response, id responseObject))completionBlock
                    failure:(void(^)(NSError *error))errorBlock;

// 返回JSON数据 responseObject 是字典或者 数组
+ (void)httpRequestDataByRequest:(NSURLRequest *)request
                      success:(void(^)(id responseObject))completionBlock
                      failure:(void(^)(NSError *error))errorBlock;

// 返回JSON数据 responseObject 是字典或者 数组
// 回调带有Response
+ (void)httpRequestDataByRequest:(NSURLRequest *)request
                         successBlock:(void(^)(NSURLResponse *response, id responseObject))completionBlock
                         failure:(void(^)(NSError *error))errorBlock;


// 返回原始数据(图片等)  responseObject 是 NSData
// 回调带有Response
+ (void)urlRequestDataByRequest:(NSURLRequest *)request
                   successBlock:(void(^)(NSURLResponse *response, id responseObject))completionBlock
                        failure:(void(^)(NSError *error))errorBlock;

// 返回原始数据(图片等)  responseObject 是 NSData
+ (void)urlRequestDataByRequest:(NSURLRequest *)request
                    success:(void(^)(id responseObject))completionBlock
                    failure:(void(^)(NSError *error))errorBlock;

// 返回原始数据  responseObject 是 NSData
// 回调带有Response
+ (void)urlRequestDataByGet:(NSString *)requestUrl
                     params:(NSDictionary *)params
                   successBlock:(void(^)(NSURLResponse *response, id responseObject))completionBlock
                        failure:(void(^)(NSError *error))errorBlock;

// 返回原始数据  responseObject 是 NSData
// 回调带有Response
+ (void)urlRequestDataByPost:(NSString *)requestUrl
                     params:(NSDictionary *)params
               successBlock:(void(^)(NSURLResponse *response, id responseObject))completionBlock
                    failure:(void(^)(NSError *error))errorBlock;


// 返回Request(上传图片Request等)  Body中写入数据了的模型
+ (NSURLRequest *)multipartFormRequestWithMethod:(NSString *)method
                                       URLString:(NSString *)urlString
                                      parameters:(NSDictionary *)params
                       constructingBodyWithBlock:(void (^)(id<AFMultipartFormData> formData))block;

// 返回一个JSON数据的 DataTask
+ (NSURLSessionDataTask *)urlDataTaskByRequest:(NSURLRequest *)request
                                        success:(void(^)(NSURLResponse *response, id responseObject))completionBlock
                                        failure:(void(^)(NSError *error))errorBlock;
// 设置下载文件存放的url
// 回调可以监控上传和下载的过程
// 返回NSURLSessionDownloadTask
+ (NSURLSessionDownloadTask *)urlDownloadDataByRequest:(NSURLRequest *)request
                                              progress:(void(^)(NSProgress *downloadProgress))downloadProgressBlock
                                           destination:(NSURL *(^)(NSURL * targetPath, NSURLResponse * response))destinationBlock
                                          successBlock:(void(^)(NSURLResponse *response, id responseObject))completionBlock
                                               failure:(void(^)(NSError *error))errorBlock;

// 设置下载文件存放的url，以及之前下载好的数据，实现断电续传的功能
// 回调可以监控上传和下载的过程
// 返回NSURLSessionDownloadTask
+ (NSURLSessionDownloadTask *)urlDownloadDataByResumeData:(NSData *)resumeData
                                                 progress:(void(^)(NSProgress *downloadProgress))downloadProgressBlock
                                              destination:(NSURL *(^)(NSURL * targetPath, NSURLResponse * response))destinationBlock
                                             successBlock:(void(^)(NSURLResponse *response, id responseObject))completionBlock
                                                  failure:(void(^)(NSError *error))errorBlock;


//AFURLSessionManager 传入url和params
//+ (NSURLSessionDataTask *)urlRequestDataByGet:(NSString *)urlString
//                     params:(NSDictionary *)params
//                    success:(void(^)(id responseObject))completionBlock
//                    failure:(void(^)(NSError *error))errorBlock;

//+ (NSURLSessionDataTask *)urlRequestDataByPost:(NSString *)urlString
//                     params:(NSDictionary *)params
//                    success:(void(^)(id responseObject))completionBlock
//                    failure:(void(^)(NSError *error))errorBlock;

//AFURLSessionManager 传入request
//+ (NSURLSessionDataTask *)urlRequestDataByRequest:(NSMutableURLRequest *)request
//                    success:(void(^)(id responseObject))completionBlock
//                    failure:(void(^)(NSError *error))errorBlock;

//图片下载
//+ (NSURLSessionDataTask *)downloadImageByRequest:(NSMutableURLRequest *)request
//                                         success:(void(^)(id responseObject))completionBlock
//                                         failure:(void(^)(NSError *error))errorBlock;

@end
