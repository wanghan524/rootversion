//
//  DBHelper.m
//  PurinaPetPlaces
//
//  Created by 菁优数学 on 15/5/9.
//
//

#import "DBHelper.h"
static DBHelper *single = nil;
@implementation DBHelper

+(DBHelper *)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        single = [[self alloc]init];
    });
    return single;
}

+(id)allocWithZone:(struct _NSZone *)zone
{
    if(single == nil)
    {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            single = [super allocWithZone:zone];
        });
        
    }
    return single;
}

+(id)copyWithZone:(struct _NSZone *)zone
{
    return single;
}
+(id)mutableCopyWithZone:(struct _NSZone *)zone
{
    return single;
}
-(instancetype)init
{
    if(self = [super init])
    {
        self.dbPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]stringByAppendingPathComponent:@"image.db"];
        [self createDB];
    }
    return self;
}

-(void)createDB
{
    self.db = [FMDatabase databaseWithPath:self.dbPath];
    [self createTable];
}

-(void)createTable
{
    if([self.db open])
    {
        NSString *sqlCreateTable = @"create table if not exists imageTable (uid INTEGER PRIMARY KEY AUTOINCREMENT, path TEXT,dateTimes TEXT)";
        BOOL res = [self.db executeUpdate:sqlCreateTable];
        if(!res)
        {
            DLog(@"create table error;");
        }
        else
        {
            DLog(@"create table ok");
        }
    }
    [self.db close];
}

-(NSMutableArray *)browseImageItem
{
    
    if([self.db open])
    {
        NSMutableArray *arr = [[NSMutableArray alloc]initWithCapacity:0];
        NSString *sql = @"select * from imageTable order by dateTimes desc";
        FMResultSet *rs = [self.db executeQuery:sql];
        while ([rs next]) {
            ImageItem *model = [[ImageItem alloc]init];
            model.uid = [rs intForColumn:@"uid"];
            model.path = [rs stringForColumn:@"path"];
            model.dateTimes = [rs stringForColumn:@"dateTimes"];
            [arr addObject:model];
        }
        return arr;
    }
    return nil;
}
-(BOOL)updateImageItem:(ImageItem *)item
{
    if(item == nil)return NO;
    if([self.db open])
    {
        NSString *updateSQL = [NSString stringWithFormat:@"update imageTable set path = '%@',dateTimes = '%@' where uid = '%lu'",item.path,item.dateTimes,(unsigned long)item.uid];
        if([self.db executeUpdate:updateSQL])
        {
            [self.db close];
            return YES;
        }
        else
        {
            [self.db close];
            return NO;
        }
    }
    [self.db close];
    return NO;
}

-(BOOL)insertImageItem:(ImageItem *)item
{
    if(item == nil)
        return NO;
    if([self.db open])
    {
        NSString *insertSQL = [NSString stringWithFormat:@"insert into imageTable (path,dateTimes) values ('%@','%@')",item.path,item.dateTimes];
        if([self.db executeUpdate:insertSQL])
        {
            [self.db close];
            return YES;
        }
        else
        {
            [self.db close];
            return NO;
        }
        
    }
    [self.db close];
    return NO;
}

@end
