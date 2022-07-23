//
//  SchoolClass.m
//  ByteDanceCampusDemo
//
//  Created by SSR on 2022/7/23.
//

#import "SchoolClass.h"

#import "objc/runtime.h"

static SchoolClass *_shareClass;

static NSString *SchoolClassSavePath;

#pragma mark - SchoolClassDatasourceFlags

typedef struct {
    
    /// schoolClass:locateAtIndexPath:
    BOOL schoolClass_locateAtIndexPath;
    
    /// savePathOfSchoolClass:
    BOOL savePathOfSchoolClass;
    
} SchoolClassDatasourceFlags;

#pragma mark - SchoolClass ()

@interface SchoolClass ()

@property (nonatomic, copy) NSIndexPath *currentIndexPath;

@property (nonatomic) NSInteger range_begin;

@property (nonatomic) NSInteger range_lenth;

@property (nonatomic) SchoolClassDatasourceFlags datasourceFlags;

@end

#pragma mark - SchoolClass

@implementation SchoolClass

#pragma mark - Method

- (instancetype)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        self.teacher = [dic[@"teacher"] stringValue];
        self.sourse = [dic[@"sourse"] stringValue];
    }
    return self;
}

- (void)reloadData:(void (^)(SchoolClass * _Nonnull))complition {
    if (self.dataSource) {
        NSInteger section = [self.dataSource numberOfSectionOfSchoolClass:self];
        for (NSInteger i = 0; i < section; i++) {
            NSInteger row = [self.dataSource schoolClass:self numberOfClassesOfSection:i];
            self.currentIndexPath = [NSIndexPath indexPathWithIndex:section * 7 + row];
            if (self.datasourceFlags.schoolClass_locateAtIndexPath) {
                NSRange range = [self.dataSource schoolClass:self locateAtIndexPath:self.currentIndexPath];
                self.range_begin = range.location;
                self.range_lenth = range.length;
            }
            if (self.datasourceFlags.savePathOfSchoolClass) {
                SchoolClassSavePath = [(id<SchoolClassDatasource>)self.dataSource.class savePathOfSchoolClass:self];
            }
        }
    }
}

#pragma mark - Setter

- (void)setDataSource:(id<SchoolClassDatasource>)dataSource {
    _dataSource = dataSource;
    
    _datasourceFlags.savePathOfSchoolClass = class_respondsToSelector(dataSource.class, @selector(savePathOfSchoolClass:));
    
    _datasourceFlags.schoolClass_locateAtIndexPath = [dataSource respondsToSelector:@selector(schoolClass:locateAtIndexPath:)];
}

#pragma mark - Getter

+ (SchoolClass *)shareClass {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareClass = [[SchoolClass alloc] init];
    });
    return _shareClass;
}

@end
