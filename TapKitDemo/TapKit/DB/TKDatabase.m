//
//  TKDatabase.m
//  TapKitDemo
//
//  Created by Wu Kevin on 4/29/13.
//  Copyright (c) 2013 Telligenty. All rights reserved.
//

#import "TKDatabase.h"

@interface TKDatabase (Private)

- (BOOL)bindStatement:(sqlite3_stmt *)statement toParameters:(NSArray *)parameters;
- (void)bindObject:(id)object toColumn:(int)index inStatement:(sqlite3_stmt *)statement;

@end

@implementation TKDatabase (Private)

- (BOOL)bindStatement:(sqlite3_stmt *)statement toParameters:(NSArray *)parameters
{
	int count = sqlite3_bind_parameter_count(statement);
  for ( int i=0; i<[parameters count]; ++i ) {
    id object = [parameters objectAtIndex:i];
    [self bindObject:object toColumn:(i+1) inStatement:statement];
  }
	return ( [parameters count] == count );
}

- (void)bindObject:(id)object toColumn:(int)index inStatement:(sqlite3_stmt *)statement
{
  if ( (object == nil) || ((NSNull *)object == [NSNull null]) ) {
		sqlite3_bind_null(statement, index);
	} else if ( [object isKindOfClass:[NSNumber class]] ) {
    if ( strcmp([object objCType], @encode(BOOL)) == 0 ) {
			sqlite3_bind_int64(statement, index, ([object boolValue] ? 1 : 0));
		} else if ( strcmp([object objCType], @encode(int)) == 0 ) {
			sqlite3_bind_int64(statement, index, [object intValue]);
		} else if ( strcmp([object objCType], @encode(long long)) == 0 ) {
			sqlite3_bind_int64(statement, index, [object longLongValue]);
		} else if ( strcmp([object objCType], @encode(double)) == 0 ) {
			sqlite3_bind_double(statement, index, [object doubleValue]);
		} else {
			sqlite3_bind_text(statement, index, [[object description] UTF8String], -1, SQLITE_STATIC);
		}
  } else if ( [object isKindOfClass:[NSDate class]] ) {
    sqlite3_bind_text(statement, index, [TKInternetDateStringFromDate(object) UTF8String], -1, SQLITE_STATIC);
  } else if ( [object isKindOfClass:[NSString class]] ) {
    sqlite3_bind_text(statement, index, [object UTF8String], -1, SQLITE_STATIC);
  } else if ( [object isKindOfClass:[NSData class]] ) {
    sqlite3_bind_blob(statement, index, [object bytes], [object length], SQLITE_STATIC);
	} else {
    sqlite3_bind_text(statement, index, [[object description] UTF8String], -1, SQLITE_STATIC);
  }
}

@end



@implementation TKDatabase


#pragma mark - NSObject

- (id)init
{
  self = [super init];
  if ( self ) {
    _path = nil;
    
    _handle = NULL;
    _opened = NO;
    
    _lock = [[NSLock alloc] init];
  }
  return self;
}



#pragma mark - Singleton

static TKDatabase *database = nil;

+ (TKDatabase *)sharedObject
{
  return database;
}

+ (void)setSharedObject:(TKDatabase *)object
{
  database = object;
}



#pragma mark - Sqlite connection

- (BOOL)open
{
	if ( _opened ) {
    return YES;
  }
	
	int code = sqlite3_open([_path fileSystemRepresentation], &_handle);
	if ( code != SQLITE_OK ) {
    return NO;
  }
	
	_opened = YES;
	return YES;
}

- (void)close
{
	if ( _handle ) {
    sqlite3_close(_handle);
    _opened = NO;
  }
}

- (BOOL)goodConnection
{
  if ( _handle ) {
    // TODO: Check
    NSString *sql = @"SELECT * FROM sqlite_master WHERE type='table';";
    return ( [self executeQuery:sql] != nil );
  }
  return NO;
}



#pragma mark - Database routines

- (BOOL)executeUpdate:(NSString *)sql, ...
{
  int count = 0;
  for ( int i=0; i<[sql length]; ++i ) {
    unichar c = [sql characterAtIndex:i];
    if ( c == '?' ) {
      count++;
    }
  }
  
  if ( count == 0 ) {
    count = -1;
  }
  
  NSMutableArray *parameters = [[NSMutableArray alloc] init];
  TKValistToArray(parameters, sql, count);
  return [self executeUpdate:sql parameters:parameters];
}

- (BOOL)executeUpdate:(NSString *)sql parameters:(NSArray *)parameters
{
  [_lock lock];
  
	if ( ![self open] ) {
    [_lock unlock];
    return NO;
	}
  
  int code = 0;
  sqlite3_stmt *statement = NULL;
  
  code = sqlite3_prepare(_handle, [sql UTF8String], -1, &statement, 0);
  if ( code != SQLITE_OK ) {
    sqlite3_finalize(statement);
    [_lock unlock];
    return NO;
  }
  
  if ( ![self bindStatement:statement toParameters:parameters] ) {
    sqlite3_finalize(statement);
    [_lock unlock];
    return NO;
  }
  
  code = sqlite3_step(statement);
  
  code = sqlite3_finalize(statement);
  
  [_lock unlock];
  
  return ( code == SQLITE_OK );
}

- (NSArray *)executeQuery:(NSString *)sql, ...
{
  int count = 0;
  for ( int i=0; i<[sql length]; ++i ) {
    unichar c = [sql characterAtIndex:i];
    if ( c == '?' ) {
      count++;
    }
  }
  
  if ( count == 0 ) {
    count = -1;
  }
  
  NSMutableArray *parameters = [[NSMutableArray alloc] init];
  TKValistToArray(parameters, sql, count);
  return [self executeQuery:sql parameters:parameters];
}

- (NSArray *)executeQuery:(NSString *)sql parameters:(NSArray *)parameters
{
  [_lock lock];
  
	if ( ![self open] ) {
    [_lock unlock];
    return nil;
	}
  
  int code = 0;
  sqlite3_stmt *statement = NULL;
  
  code = sqlite3_prepare(_handle, [sql UTF8String], -1, &statement, 0);
  if ( code != SQLITE_OK ) {
    sqlite3_finalize(statement);
    [_lock unlock];
    return nil;
  }
  
  if ( ![self bindStatement:statement toParameters:parameters] ) {
    sqlite3_finalize(statement);
    [_lock unlock];
    return nil;
  }
  
  NSMutableArray *names = [[NSMutableArray alloc] init];
  NSMutableArray *types = [[NSMutableArray alloc] init];
  
  int count = sqlite3_column_count(statement);
  for ( int i=0; i<count; ++i ) {
    
    NSString *name = [[NSString alloc] initWithUTF8String:sqlite3_column_name(statement, i)];
    [names addObject:name];
    
    NSString *type = [[NSString alloc] initWithUTF8String:sqlite3_column_decltype(statement, i)];
    [types addObject:type];
    
  }
  
  NSMutableArray *rows = [[NSMutableArray alloc] init];
  while ( sqlite3_step(statement) == SQLITE_ROW ) {
    TKDatabaseRow *row = [[TKDatabaseRow alloc] init];
    [rows addObject:row];
    
    row.names = names;
    row.types = types;
    
    NSMutableArray *columns = [[NSMutableArray alloc] init];
    row.columns = columns;
    
    for ( int i=0; i<count; ++i ) {
      
      NSString *type = [types objectAtIndex:i];
      
      if ( [type isEqualToString:@"INTEGER"] ) {
        id object = [NSNull null];
        if ( sqlite3_column_blob(statement, i) ) {
          sqlite3_int64 value = sqlite3_column_int64(statement, i);
          object = [[NSNumber alloc] initWithLongLong:value];
        }
        [columns addObject:object];
      } else if ( [type isEqualToString:@"REAL"] ) {
        id object = [NSNull null];
        if ( sqlite3_column_blob(statement, i) ) {
          double value = sqlite3_column_double(statement, i);
          object = [[NSNumber alloc] initWithDouble:value];
        }
        [columns addObject:object];
      } else if ( [type isEqualToString:@"TEXT"] ) {
        id object = [NSNull null];
        const unsigned char *value = sqlite3_column_text(statement, i);
        if ( value ) {
          object = [[NSString alloc] initWithFormat:@"%s", value];
        }
        [columns addObject:object];
      } else if ( [type isEqualToString:@"BLOB"] ) {
        id object = [NSNull null];
        const void *value = sqlite3_column_blob(statement, i);
        if ( value ) {
          int size = sqlite3_column_bytes(statement, i);
          object = [[NSMutableData alloc] initWithLength:size];
          memcpy([object mutableBytes], value, size);
        }
        [columns addObject:object];
      } else {
        id object = [NSNull null];
        const unsigned char *value = sqlite3_column_text(statement, i);
        if ( value ) {
          object = [[NSString alloc] initWithFormat:@"%s", value];
        }
        [columns addObject:object];
      }
      
    }
  }
  
  [_lock unlock];
  
  if ( [rows count] > 0 ) {
    return rows;
  }
  
  return nil;
}



#pragma mark - Error infomation

- (NSString *)lastErrorMessage
{
  return [[NSString alloc] initWithUTF8String:sqlite3_errmsg(_handle)];
}

- (int)lastErrorCode
{
  return sqlite3_errcode(_handle);
}

- (BOOL)hadError
{
  int lastErrorCode = [self lastErrorCode];
  return ((lastErrorCode > SQLITE_OK)
          && (lastErrorCode < SQLITE_ROW)
          );
}



#pragma mark - Database status

+ (BOOL)isSQLiteThreadSafe
{
  return sqlite3_threadsafe();
}

+ (NSString *)sqliteLibVersion
{
  return [[NSString alloc] initWithFormat:@"%s", sqlite3_libversion()];
}

- (BOOL)hasTableNamed:(NSString *)tableName
{
  // TODO: Update
  if ( _handle && tableName ) {
    NSString *sql = @"SELECT COUNT(*) AS count FROM sqlite_master WHERE type='table' AND name=?;";
    NSArray *result = [self executeQuery:sql, tableName];
    
    TKDatabaseRow *row = [result objectOrNilAtIndex:0];
    return ( [row intForName:@"count"] > 0 );
  }
  return NO;
}

- (unsigned long long)databaseFileSize
{
  NSFileManager *manager = [NSFileManager defaultManager];
  NSDictionary *attributes = [manager attributesOfItemAtPath:_path error:NULL];
  return [attributes fileSize];
}

@end
