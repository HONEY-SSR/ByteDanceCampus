//
//  SchoolClass.h
//  ByteDanceCampusDemo
//
//  Created by SSR on 2022/7/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class SchoolClass;

#pragma mark - SchoolClassDatasourse

@protocol SchoolClassDatasource <NSObject>

@required

/// 有几周
/// @param schoolClass 当前对象
- (NSInteger)numberOfSectionOfSchoolClass:(SchoolClass *)schoolClass;

/// 每周有几节
/// @param schoolClass 当前对象
/// @param section 第几周
- (NSInteger)schoolClass:(SchoolClass *)schoolClass numberOfClassesOfSection:(NSInteger)section;

@optional

/// 第几节开始，有几节，默认0，2
/// @param schoolClass 当前对象
/// @param indexPath 所在周，第几个
- (NSRange)schoolClass:(SchoolClass *)schoolClass locateAtIndexPath:(NSIndexPath *)indexPath;

/// 存储位置
/// @param schoolClass 当前对象
+ (NSString *)savePathOfSchoolClass:(SchoolClass *)schoolClass;

@end

#pragma mark - SchoolClass

@interface SchoolClass : NSObject

/// 星期，存储属性
@property (nonatomic) NSInteger week;

/// 在第几周，计算属性
@property (nonatomic, readonly) NSInteger weekOfSeson;

/// 资源，强引用
@property (nonatomic, strong) NSString *sourse;

/// 老师，copy属性
@property (nonatomic, copy) NSString *teacher;

/// 单例课程，用于添加课程
@property(nonatomic, readonly, class) SchoolClass *shareClass;

/// 代理
@property (nonatomic, weak) id <SchoolClassDatasource> dataSource;

- (instancetype)init NS_UNAVAILABLE;

+ (instancetype)new NS_UNAVAILABLE;

/// 根据字典创建
/// @param dic 字典
- (instancetype)initWithDic:(NSDictionary *)dic;

/// 重写加载数据savePathOfSchoolClass
- (void)reloadData:(void (^ _Nullable)(SchoolClass *schoolClass))complition;

@end

NS_ASSUME_NONNULL_END
