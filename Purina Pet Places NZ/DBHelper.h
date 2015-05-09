//
//  DBHelper.h
//  PurinaPetPlaces
//
//  Created by 菁优数学 on 15/5/9.
//
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "ImageItem.h"
@interface DBHelper : NSObject
@property(nonatomic,strong)ImageItem *iimm;
@property(nonatomic,copy)NSString *dbPath;
@property(nonatomic,strong)FMDatabase *db;
+(DBHelper *)sharedInstance;

-(BOOL)insertImageItem:(ImageItem *)item;
-(BOOL)updateImageItem:(ImageItem *)item;
-(NSMutableArray *)browseImageItem;

@end
