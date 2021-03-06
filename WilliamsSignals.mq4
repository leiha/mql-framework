//+------------------------------------------------------------------+
//|                                  Lia Williams Signals System.mq4 |
//|                                   Copyright © 2019 Leiha Sellier |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2019, Leiha Sellier"
//----
#property indicator_separate_window
#property indicator_buffers 50
#property indicator_minimum 0
#property indicator_maximum 100
#property indicator_level1 20
#property indicator_level2 50
#property indicator_level3 80

#include "./script.mqh"

class Main
{
   public:
   
   static void onInit( ) 
   {   
      williams  ( );
      //williamsH1( );
      
      /*Signals::trendUpDown(williamsH1( ),williams( ))
         .plot( SIGNAL_LONG  , Blue  , 2 )
         .plot( SIGNAL_SHORT , Red   , 2 )
         .plot( SIGNAL_NULL  , Black , 2 )
         .settings( )
            .position( 95 )
            ;*/
   }
   
   static Buffer * williams( )
   {
      IWilliams * indic = Indicators::williams( );
   
      indic
         .plot    ( 0 , Green , 1 , PLOT_TYPE_LINE , PLOT_STYLE_DOT )
         .settings( )
            //.timeframe( PERIOD_H1 )
            .period( 34 )
            ;      
         
      BufferMA * ma = indic.ma( );
      ma.plot( Orange )
         .settings( )
            .period( 13 )
            .method( MODE_SMMA )
            ;
            
      Signals::trendUpDown(indic._buffers[0] , ma)
         .plot( SIGNAL_LONG  , Blue  , 2 )
         .plot( SIGNAL_SHORT , Red   , 2 )
         .plot( SIGNAL_NULL  , Black , 2 )
         .settings( )
            .position( 95 )
            ;
            
      return indic._buffers[0]; 
   }
   
   static Buffer * williamsH1( )
   {
      IWilliams * indic = Indicators::williams( );
   
      indic
         .plot    ( 0 , Red)
         .settings( )
            .timeframe( PERIOD_H1 )            
            ;      
         
      BufferMA * ma = indic.ma( );
      ma.plot( Blue )
         .settings( )
            .period( 21 )
            ;
      
      Signals::crossLine( indic._buffers[0] , ma )
         .plot     ( SIGNAL_NULL  , Black , 2 )
         .plot     ( SIGNAL_LONG  , Blue  , 1 , DRAW_ARROW )
         .plotArrow( SIGNAL_LONG  , 233 )
         .plot     ( SIGNAL_SHORT , Red   , 1 , DRAW_ARROW )
         .plotArrow( SIGNAL_SHORT , 234 )
         .settings( )
            .position( 20 , 80 );
            ;
            
       return indic._buffers[0];
   }
   
};