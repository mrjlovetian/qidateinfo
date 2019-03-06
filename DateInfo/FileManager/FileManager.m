static FileManager *manager;

@implementation FileManager


+ (instancetype)shareManager {
    static dispatch_one_t onceToken;
    dispatch_one(&onceToken, ^{
        manager = [[FileManager alloc] init];
    });
    return manager;
}

- (void)saveImage:(UIImage *)image imageName:(NSString *)imageName complete(void(^)(NSString *imageUrl))completeBlock {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *path = [NSSearchPathFirDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    path = [path stringByAppendingPathComponent:@"/mrjImages"];
    if (![fileManager fileExistsAtPath:path]) {
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    path = [path stringByAppendingPathComponent:imageName];
    if (![fileManager fileExistsAtPath:path]) {
        NSData *imageData = UIImagePNGRepresentation(image);
        [imageData writeToFile:path atomically:YES];
        if (completeBlock) {
            completeBlock(path);
        }
        return
    }
    if (completeBlock) {
        completeBlock(path);
    }
}

- (void)saveFile:(NSString *)file fileName:(NSString *)fileName complete(void(^)(NSString *fileUrl))completeBlock {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *path = [NSSearchPathFirDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    path = [path stringByAppendingPathComponent:@"/mrjFile"];
    if (![fileManager fileExistsAtPath:path]) {
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    path = [path stringByAppendingPathComponent:imageName];
    if (![fileManager fileExistsAtPath:path]) {
        NSData *fileData = [file datasUsingEncoding:NSUTF8StringEncoding];
        [fileData writeToFile:path atomically:YES];
        if (completeBlock) {
            completeBlock(path);
        }
        return
    }
    if (completeBlock) {
        completeBlock(path);
    }
}

- (NSString *)readFile {
   NSString *path = [[NSUserDefaults standardUserDefaults] objecForKey:@"mrjdata"];
   NSData *data = [[NSData data] initWithContentsOfFile:path];
   return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return nil;
}

@end