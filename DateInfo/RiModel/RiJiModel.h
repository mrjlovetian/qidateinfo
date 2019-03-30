
#import <Foundation/Foundation.h>

@class RiJiModel;
@class RiJiMonth;
@class RiJiDay;


@interface RiJiYear : NSObject

@property (nonatomic, copy)NSString *year;
@property (nonatomic, copy)NSArray<RiJiModel *> *datas;

@end

@interface RiJiMonth : NSObject

@property (nonatomic, copy)NSString *month;
@property (nonatomic, copy)NSArray<RiJiModel *> *datas;

@end

@interface RiJiDay : NSObject

@property (nonatomic, copy)NSString *date;
@property (nonatomic, copy)NSArray<RiJiModel *> *datas;

@end

@interface RiJiModel : NSObject

@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *content;
@property (nonatomic, copy)NSString *dateTime;
@property (nonatomic, copy)NSString *dateStr;
@property (nonatomic, copy)NSString *index;
@property (nonatomic, copy)NSArray *images;
@property (nonatomic, copy)NSArray *videos;
@property (nonatomic, copy)NSArray *voices;

@property (nonatomic, assign)CGFloat height;

@end
