//+------------------------------------------------------------------+
//|                                                       Lia System |
//|                                   Copyright © 2019 Leiha Sellier |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2019, Leiha Sellier"
//----

ENUM_TIMEFRAMES tfNext ( ENUM_TIMEFRAMES tf ) 
{
   switch( tf ) {
      case PERIOD_M1  : return PERIOD_M5  ; break;
      case PERIOD_M5  : return PERIOD_M15 ; break;
      case PERIOD_M15 : return PERIOD_M30 ; break;
      case PERIOD_M30 : return PERIOD_H1  ; break;
      case PERIOD_H1  : return PERIOD_H4  ; break;
      case PERIOD_H4  : return PERIOD_D1  ; break;
      case PERIOD_D1  : return PERIOD_W1  ; break;
      case PERIOD_W1  : return PERIOD_MN1 ; break;
      case PERIOD_MN1 : 
      default         : 
         return NULL;
         break;
   }
};

ENUM_TIMEFRAMES intToTf ( int tf ) 
{
   switch( tf ) {
      case 1     : return PERIOD_M1  ; break;
      case 5     : return PERIOD_M5  ; break;
      case 15    : return PERIOD_M15 ; break;
      case 30    : return PERIOD_M30 ; break;
      case 60    : return PERIOD_H1  ; break;
      case 240   : return PERIOD_H4  ; break;
      case 1440  : return PERIOD_D1  ; break;
      case 10080 : return PERIOD_W1  ; break;
      case 43200 : return PERIOD_MN1 ; break;
      default    : 
         return NULL;
         break;
   }
};

string tfToStr ( ENUM_TIMEFRAMES tf ) 
{
   switch( tf ) {
      case PERIOD_M1  : return "M1"  ; break;
      case PERIOD_M5  : return "M5"  ; break;
      case PERIOD_M15 : return "M15" ; break;
      case PERIOD_M30 : return "M30" ; break;
      case PERIOD_H1  : return "H1"  ; break;
      case PERIOD_H4  : return "H4"  ; break;
      case PERIOD_D1  : return "D1"  ; break;
      case PERIOD_W1  : return "W1"  ; break;
      case PERIOD_MN1 : return "MN1" ; break;
      default    : 
         return NULL;
         break;
   }
};


// - Commons
// --------------------------------------
#include "./error/error.mqh"
#include "./notify/notify.mqh"

// - Indicators
// --------------------------------------
#include "./indicator/rsi.mqh"
#include "./indicator/williams.mqh"
#include "./indicator/ichimoku.mqh"
#include "./indicator/movingAverage.mqh"
#include "./indicator/stochastic.mqh"

// - Signals
// --------------------------------------
#include "./signal/base/trend/trendLine.mqh"
#include "./signal/base/trend/trendUpDown.mqh"
#include "./signal/base/trend/trendDow.mqh"
#include "./signal/base/cross/crossLevel.mqh"
#include "./signal/base/cross/crossLine.mqh"

// - Collections
// --------------------------------------
#include "./collection/rsi.mqh"


// - Orders
// --------------------------------------
/*
#include "./order/orders.mqh"
#include "./order/order.mqh"
#include "./order/orderCreate.mqh"
*/