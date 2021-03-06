//+------------------------------------------------------------------+
//|                                  Lia Williams Signals System.mq4 |
//|                                   Copyright © 2019 Leiha Sellier |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2019, Leiha Sellier"
//----
#property indicator_separate_window
#property indicator_buffers 50

#include "./script.mqh"

class Main
{
   public:
   
   static void onInit( ) 
   {   
      ichimoku  ( );
      ichimokuH1( );
      
   }
   
   static void ichimoku( )
   {
      IIchimoku * indic = Indicators::ichimoku( );
      
      indic
         .plot    ( ICHIMOKU_KIJUNSEN   , Blue )
         .plot    ( ICHIMOKU_TENKANSEN  , Red )
         //.plot    ( ICHIMOKU_CHIKOUSPAN , Green )
         .plot    ( ICHIMOKU_SENKOUSPANA , Purple )
         //.plot    ( ICHIMOKU_SENKOUSPANB , Orange )
         .settings( )
            //.kijunSen   (  3 )
            //.tenkanSen  (  1 )
            //.senkouSpanB(  3 )
            ;   
   }
   
   static void ichimokuH1 ( )
   {
      /*
      IIchimoku * indic = Indicators::ichimoku( );
      indic
         .plot    ( MODE_SENKOUSPANA , Green )
         .settings( )
            .timeframe( PERIOD_M15 )
            ;*/
      
      /*
      BufferMA * ma = indic.ma( MODE_SENKOUSPANA );
      ma.plot( Purple )
         .settings( )
            .period( 8 )
            .method( MODE_EMA )
            ;*/
   
      /*
      TrendSignal * t = Signals::trend( ma );
      t.plot( SIGNAL_LONG  , Blue , 5 )
       .plot( SIGNAL_SHORT , Red  , 5 )
       .settings( )
         .position( 10 )
         ;*/
   }
   
   
};