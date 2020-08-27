#import "RiJiModel.h"
#import <WCDB/WCDB.h>
#import "XMDataManager.h"
#import "NSDate+Extension.h"

@interface RiJiModel ()<WCTTableCoding>

@end

@implementation RiJiModel

WCDB_IMPLEMENTATION(RiJiModel)
WCDB_SYNTHESIZE(RiJiModel, localID)
WCDB_SYNTHESIZE(RiJiModel, year)
WCDB_SYNTHESIZE(RiJiModel, month)
WCDB_SYNTHESIZE(RiJiModel, day)
WCDB_SYNTHESIZE(RiJiModel, title)
WCDB_SYNTHESIZE(RiJiModel, content)
WCDB_SYNTHESIZE(RiJiModel, imageUrls)
WCDB_PRIMARY_ASC_AUTO_INCREMENT(RiJiModel, localID)

WCDB_INDEX(RiJiModel, "_index", day)

- (CGFloat)height {
    return 0;
}

+ (BOOL)insertData:(RiJiModel *)model {
    model.isAutoIncrement = YES;
    NSLog(@"..........%@", [XMDataManager shareDBManager].database);
    BOOL result = [[XMDataManager shareDBManager].database insertObject:model
    into:@"RiJiModel"];
    return result;
}

+ (BOOL)deleteModel:(RiJiModel *)model {
    return [[XMDataManager shareDBManager].database deleteObjectsFromTable:@"RiJiModel"
                                             where:RiJiModel.localID == model.localID];
}

+ (NSArray *)selectDataByDay:(NSString *)day {

    
    NSArray<RiJiModel *> *datas = [[XMDataManager shareDBManager].database getObjectsOfClass:RiJiModel.class
                                                                                   fromTable:@"RiJiModel" where:RiJiModel.day == day];
    
    
    return datas;
}

+ (NSArray *)selectDataByYear:(NSString *)year {

    
    NSArray<RiJiModel *> *datas = [[XMDataManager shareDBManager].database getObjectsOfClass:RiJiModel.class
                                                                                   fromTable:@"RiJiModel" where:RiJiModel.year == year];
    
    
    return datas;
}

+ (NSArray *)selectDataByYearMonth:(NSString *)month {

    
    NSArray<RiJiModel *> *datas = [[XMDataManager shareDBManager].database getObjectsOfClass:RiJiModel.class
                                                                                   fromTable:@"RiJiModel" where:RiJiModel.month == month];
    
    
    return datas;
}

@end

@implementation RiJiDay

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"datas" : [RiJiModel class]};
}

@end

@implementation RiJiMonth

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"datas" : [RiJiDay class]};
}

@end

@implementation RiJiYear
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"datas" : [RiJiMonth class]};
}

@end
