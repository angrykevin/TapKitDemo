//
//  TKMacro.h
//  TapKit
//
//  Created by Wu Kevin on 4/26/13.
//  Copyright (c) 2013 Telligenty. All rights reserved.
//

#ifdef __cplusplus
extern "C" {
#endif


///-------------------------------
/// Degree and radian
///-------------------------------

#define TKDegreesToRadians(__degrees) ( M_PI * __degrees / 180.0 )
#define TKRadiansToDegrees(__radians) ( __radians * 180.0 / M_PI )


///-------------------------------
/// TimeInterval
///-------------------------------

#define TKTimeIntervalMinute()  (60.0)
#define TKTimeIntervalHour()    (60.0*60)
#define TKTimeIntervalDay()     (60.0*60*24)
#define TKTimeIntervalWeek()    (60.0*60*24*7)


///-------------------------------
/// Variable argument lists
///-------------------------------

#define TKValistToArray(__container, __start, __count) \
if ( __count>0 ) { \
  va_list __list; \
  va_start(__list, __start); \
  for ( int i=0; i<__count; ++i ) { \
    id __object = va_arg(__list, id); \
    [__container addObject:( (__object) ? __object : [NSNull null] )]; \
  } \
  va_end(__list); \
} else if ( __count<0 ) { \
  va_list __list; \
  va_start(__list, __start); \
  id __object = nil; \
  while ( (__object=va_arg(__list, id)) ) { \
    [__container addObject:__object]; \
  } \
  va_end(__list); \
}


#ifdef __cplusplus
}
#endif
