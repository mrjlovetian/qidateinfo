#import "FileManager.h"

static FileManager *manager;

@implementation FileManager


+ (instancetype)shareManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[FileManager alloc] init];
    });
    return manager;
}

- (void)saveImages:(NSArray<UIImage *> *)images imageName:(NSArray *)imageNames complete:(void(^)(NSArray<NSString *>* imageUrls))completeBlock {
    NSMutableArray *imagesFilePath = [NSMutableArray arrayWithCapacity:1];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *path = [self getMianPath];
    NSString *imagePath = @"/mrjImages";
    path = [path stringByAppendingPathComponent:imagePath];
    if (![fileManager fileExistsAtPath:path]) {
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    for (int i = 0; i < images.count; i++) {
        NSString *imageName = imageNames[i];
        UIImage *image = images[i];
        NSString *newImagePath = [imagePath stringByAppendingPathComponent:imageName];
        NSString *writeImagePath = [path stringByAppendingPathComponent:imageName];
        if (![fileManager fileExistsAtPath:newImagePath]) {
            NSData *imageData = UIImagePNGRepresentation(image);
            [imageData writeToFile:writeImagePath atomically:YES];
        }
        [imagesFilePath addObject:newImagePath];
    }
    completeBlock(imagesFilePath);
}

- (void)saveImage:(UIImage *)image imageName:(NSString *)imageName complete:(void(^)(NSString *imageUrl))completeBlock {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *path = [self getMianPath];
    NSString *imagePath = @"/mrjImages";
    path = [path stringByAppendingPathComponent:imagePath];
    if (![fileManager fileExistsAtPath:path]) {
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    imagePath = [imagePath stringByAppendingPathComponent:imageName];
    path = [path stringByAppendingPathComponent:imagePath];
    if (![fileManager fileExistsAtPath:path]) {
        NSData *imageData = UIImagePNGRepresentation(image);
        [imageData writeToFile:path atomically:YES];
        if (completeBlock) {
            completeBlock(imagePath);
        }
        return;
    }
    if (completeBlock) {
        completeBlock(imagePath);
    }
}

- (void)saveFile:(NSString *)file fileName:(NSString *)fileName complete:(void(^)(NSString *fileUrl))completeBlock {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *path = [self getMianPath];
    NSString *filePath = @"/mrjFile";
    path = [path stringByAppendingPathComponent:filePath];
    if (![fileManager fileExistsAtPath:path]) {
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    filePath = [filePath stringByAppendingPathComponent:fileName];
    path = [path stringByAppendingPathComponent:fileName];
    NSData *fileData = [file dataUsingEncoding:NSUTF8StringEncoding];
    [fileData writeToFile:path atomically:YES];
    if (completeBlock) {
        completeBlock(filePath);
        return;
    }
}

- (NSString *)readFileNameForKey:(NSString *)keyName {
    NSString *path = [[NSUserDefaults standardUserDefaults] objectForKey:keyName];
    NSString *filePath = [self getMianPath];
    filePath = [filePath stringByAppendingPathComponent:path];
    NSData *data = [[NSData data] initWithContentsOfFile:filePath];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

- (void)saveFileName:(NSString *)fileName ForKey:(NSString *)keyName {
    [[NSUserDefaults standardUserDefaults] setObject:fileName forKey:keyName];
}

- (NSString *)getMianPath {
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    return path;
}

@end
