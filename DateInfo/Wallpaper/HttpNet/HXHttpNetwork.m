//
//  AFNetwork.m
//  MRJ
//
//  Created by MRJ on 16/3/18.
//
//

#import "HXHttpNetwork.h"

static const CGFloat kNetworkTimeoutInterval = 15.f;

@interface HXHttpNetwork()

@end

@implementation HXHttpNetwork


#pragma mark Public
/*
 * http Get 请求
 * */
+ (NSURLSessionDataTask *)httpRequestDataByGet:(NSString *)urlString params:(NSDictionary *)params success:(void (^)(id))completionBlock failure:(void (^)(NSError *))errorBlock {
    AFHTTPSessionManager *manager = [self creatHTTPSessionManager];
    
    NSURLSessionDataTask *task = [manager GET:urlString parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (completionBlock){
            completionBlock(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (errorBlock) {
            errorBlock(error);
        }
    }];
    return task;
}
/*
 * http Post 请求
 * */
+ (NSURLSessionDataTask *)httpRequestDataByPost:(NSString *)urlString params:(NSDictionary *)params success:(void (^)(id))completionBlock failure:(void (^)(NSError *))errorBlock {
    AFHTTPSessionManager *manager = [self creatHTTPSessionManager];
    
    return [manager POST:urlString parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (completionBlock){
            completionBlock(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (errorBlock) {
            errorBlock(error);
        }
    }];
}

+ (void)httpRequestDataByPost:(NSString *)urlString params:(NSDictionary *)params head:(void (^)(AFHTTPSessionManager *))headBlock construction:(void (^)(id <AFMultipartFormData> formData))construction success:(void (^)(id))completionBlock failure:(void (^)(NSError *))errorBlock {
    AFHTTPSessionManager *manager = [self creatHTTPSessionManager];
    
    if (headBlock) {
        headBlock(manager);
    }
    
    [manager POST:urlString parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (construction) {
            construction(formData);
        }
    } progress:nil
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
              if (completionBlock){
                  completionBlock(responseObject);
              }
          } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              if (errorBlock) {
                  errorBlock(error);
              }
          }];
}

+ (NSURLSessionDataTask *)httpRequestDataByPost:(NSString *)urlString params:(NSDictionary *)params construction:(void (^)(id <AFMultipartFormData> formData))construction success:(void (^)(id))completionBlock failure:(void (^)(NSError *))errorBlock {
    AFHTTPSessionManager *manager = [self creatHTTPSessionManager];
    
    NSURLSessionDataTask *task = [manager POST:urlString parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (construction) {
            construction(formData);
        }
    } progress:nil
       success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (completionBlock){
            completionBlock(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (errorBlock) {
            errorBlock(error);
        }
    }];
    return task;
}


+ (NSURLSessionDataTask *)httpDataTaskByRequest:(NSURLRequest *)request success:(void (^)(NSURLResponse *response, id responseObject))completionBlock failure:(void (^)(NSError *error))errorBlock {
    AFHTTPSessionManager *manager = [self creatHTTPSessionManager];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (!error){
            if (completionBlock) {
                completionBlock(response, responseObject);
            }
        }else {
            if (errorBlock) {
                errorBlock(error);
            }
        }
    }];
    return dataTask;
}

+ (void)httpRequestDataByRequest:(NSURLRequest *)request success:(void (^)(id))completionBlock failure:(void (^)(NSError *))errorBlock {
    AFHTTPSessionManager *manager = [self creatHTTPSessionManager];
    
    NSURLSessionTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (!error){
            if (completionBlock) {
                completionBlock(responseObject);
            }
        }else {
            if (errorBlock) {
                errorBlock(error);
            }
        }
    }];
    if (dataTask) [dataTask resume];
}

+ (void)httpRequestDataByRequest:(NSURLRequest *)request successBlock:(void (^)(NSURLResponse *response, id responseObject))completionBlock failure:(void (^)(NSError *error))errorBlock {
    AFHTTPSessionManager *manager = [self creatHTTPSessionManager];
    
    NSURLSessionTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (!error){
            if (completionBlock) {
                completionBlock(response, responseObject);
            }
        }else {
            if (errorBlock) {
                errorBlock(error);
            }
        }
    }];
    if (dataTask) [dataTask resume];
}


+ (void)urlRequestDataByRequest:(NSURLRequest *)request
                        success:(void(^)(id responseObject))completionBlock
                        failure:(void(^)(NSError *error))errorBlock {
    AFURLSessionManager *manager = [self creatURLSessionManager];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            if (errorBlock){
                errorBlock(error);
            }
        } else {
            if (completionBlock){
                completionBlock(responseObject);
            }
        }
    }];

    if (dataTask) [dataTask resume];
}
// urlRequest Method Get 返回 NSData数据
+ (void)urlRequestDataByGet:(NSString *)requestUrl params:(NSDictionary *)params successBlock:(void (^)(NSURLResponse *response, id responseObject))completionBlock failure:(void (^)(NSError *error))errorBlock {
    [self urlRequestDataWithUrl:requestUrl method:@"GET" params:params success:^(NSURLResponse *response, id responseObject) {
        if (!completionBlock) return;
        completionBlock(response, responseObject);
    } failure:^(NSError *error) {
        if (!errorBlock) return;
        errorBlock(error);
    }];
}
// urlRequest Method Post 返回 NSData数据
+ (void)urlRequestDataByPost:(NSString *)requestUrl params:(NSDictionary *)params successBlock:(void (^)(NSURLResponse *response, id responseObject))completionBlock failure:(void (^)(NSError *error))errorBlock {
    [self urlRequestDataWithUrl:requestUrl method:@"POST" params:params success:^(NSURLResponse *response, id responseObject) {
        if (!completionBlock) return;
        completionBlock(response, responseObject);
    } failure:^(NSError *error) {
        if (!errorBlock) return;
        errorBlock(error);
    }];
}


+ (void)urlRequestDataByRequest:(NSURLRequest *)request
                        successBlock:(void(^)(NSURLResponse *response, id responseObject))completionBlock
                        failure:(void(^)(NSError *error))errorBlock {
    AFURLSessionManager *manager = [self creatURLSessionManager];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            if (errorBlock){
                errorBlock(error);
            }
        } else {
            if (completionBlock){
                completionBlock(response, responseObject);
            }
        }
    }];

    if (dataTask) [dataTask resume];
}


+ (NSURLRequest *)multipartFormRequestWithMethod:(NSString *)method URLString:(NSString *)urlString parameters:(NSDictionary *)params constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block {
    NSParameterAssert(block != nil);
    NSError *error = nil;
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST"
                                                                                              URLString:urlString
                                                                                             parameters:params
                                                                              constructingBodyWithBlock:block
                                                                                                  error:&error];

    request.timeoutInterval = kNetworkTimeoutInterval;
    if (!error) return request;
    else return nil;
}


+ (NSURLSessionDataTask *)urlDataTaskByRequest:(NSURLRequest *)request success:(void (^)(NSURLResponse *response, id responseObject))completionBlock failure:(void (^)(NSError *error))errorBlock {
    AFURLSessionManager *manager = [self creatURLSessionManager];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            if (errorBlock){
                errorBlock(error);
            }
        } else {
            if (completionBlock){
                completionBlock(response, responseObject);
            }
        }
    }];

    return dataTask;
}

+ (NSURLSessionDownloadTask *)urlDownloadDataByRequest:(NSURLRequest *)request
                                              progress:(void(^)(NSProgress *downloadProgress))downloadProgressBlock
                                           destination:(NSURL *(^)(NSURL * targetPath, NSURLResponse * response))destinationBlock
                                          successBlock:(void(^)(NSURLResponse *response, id responseObject))completionBlock
                                               failure:(void(^)(NSError *error))errorBlock {
    AFURLSessionManager *manager = [self creatURLSessionManager];
    
    NSURLSessionDownloadTask *dataTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        if (downloadProgress) {
            if (downloadProgressBlock) {
                downloadProgressBlock(downloadProgress);
            }
        }
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        if (targetPath && response) {
            if (destinationBlock) {
                return destinationBlock(targetPath,response);
            }
        }
        return destinationBlock(nil,nil);
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            if (errorBlock){
                errorBlock(error);
            }
        } else {
            if (completionBlock){
                completionBlock(response, responseObject);
            }
        }
    }];
    
    return dataTask;
}

+ (NSURLSessionDownloadTask *)urlDownloadDataByResumeData:(NSData *)resumeData
                                                 progress:(void(^)(NSProgress *downloadProgress))downloadProgressBlock
                                              destination:(NSURL *(^)(NSURL * targetPath, NSURLResponse * response))destinationBlock
                                             successBlock:(void(^)(NSURLResponse *response, id responseObject))completionBlock
                                                  failure:(void(^)(NSError *error))errorBlock {
    AFURLSessionManager *manager = [self creatURLSessionManager];
    NSURLSessionDownloadTask *dataTask = [manager downloadTaskWithResumeData:resumeData progress:^(NSProgress * _Nonnull downloadProgress) {
        if (downloadProgress) {
            if (downloadProgressBlock) {
                downloadProgressBlock(downloadProgress);
            }
        }
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        if (targetPath && response) {
            if (destinationBlock) {
                return destinationBlock(targetPath,response);
            }
        }
        return destinationBlock(nil,nil);
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            if (errorBlock){
                errorBlock(error);
            }
        } else {
            if (completionBlock){
                completionBlock(response, responseObject);
            }
        }
    }];
    
    return dataTask;
}

#pragma mark Private
+ (AFHTTPSessionManager *)creatHTTPSessionManager {
   	static AFHTTPSessionManager *manager;
    if (!manager) {
	    // JIRA:10801使用自定义协议进行域名解析
	    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
		
        manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:config];
        manager.requestSerializer.timeoutInterval = kNetworkTimeoutInterval;
        // 过滤 非法response
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", @"text/plain", nil];
        //设置信任所有证书和域名 JIRA:8504
        manager.securityPolicy.validatesDomainName = NO;
        manager.securityPolicy.allowInvalidCertificates = YES;
    }
    return manager;
}

+ (AFURLSessionManager *)creatURLSessionManager {
	static AFURLSessionManager *manager;
    if (!manager) {
	    // JIRA:10801使用自定义协议进行域名解析
	    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    
	    manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:config];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        //设置信任所有证书和域名 JIRA:8504
        manager.securityPolicy.validatesDomainName = NO;
        manager.securityPolicy.allowInvalidCertificates = YES;
    }
    return manager;
}

+ (void)urlRequestDataWithUrl:(NSString *)urlString
                       method:(NSString *)method
                       params:(NSDictionary *)params
                      success:(void(^)(NSURLResponse *response, id responseObject))completionBlock
                      failure:(void(^)(NSError *error))errorBlock {
    NSError *error = nil;
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:method URLString:urlString parameters:params error:&error];
    request.timeoutInterval = kNetworkTimeoutInterval;
    if (!error && request) {
        AFURLSessionManager *manager = [self creatURLSessionManager];
        NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
            if (error) {
                errorBlock(error);
            } else {
                completionBlock(response, responseObject);
            }
        }];
        if (dataTask) {
            [dataTask resume];
        }
    } else {
        errorBlock(error);
    }
}

/*
 * 图片下载功能
 * */
+ (NSURLSessionDataTask *)downloadImageByRequest:(NSMutableURLRequest *)request
                                         success:(void(^)(id responseObject))completionBlock
                                         failure:(void(^)(NSError *error))errorBlock {
    AFURLSessionManager *manager = [self creatURLSessionManager];

    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            errorBlock(error);
        } else {
            completionBlock(responseObject);
        }
    }];

    if (dataTask) {
        return  dataTask;
    }
    return nil;
}
@end

