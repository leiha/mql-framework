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
#property indicator_level1 30
#property indicator_level2 50
#property indicator_level3 70

#include "./script.mqh"

class Main
{
   public:
   
   static void onInit( ) 
   {  
      string title ="";
    
      ENUM_TIMEFRAMES period = intToTf(Period());
      rsi  (  period);      
      title += tfToStr( period );
            
      period = tfNext( period );
      rsiM30( period );
      title += " / "+ tfToStr( period );
      
      period = tfNext( period );      
      rsiH1( period );
      title += " / "+ tfToStr( period );
      
      period = tfNext( period );
      rsiH4( period );
      title += " / "+ tfToStr( period );
      
      //rsiD1();
      //stochastic( );
      //williams( );
      
      /*Signals::trendUpDown(rsi( ),rsiH1( ))
         .plot( SIGNAL_LONG  , Blue  , 2 )
         .plot( SIGNAL_SHORT , Red   , 2 )
         .plot( SIGNAL_NULL  , Black , 2 )
         .settings( )
            .position( 95 )
            ;*/
      
      IndicatorShortName( title );
   }
   
   static Buffer * rsi ( ENUM_TIMEFRAMES period )
   {
      IRsi * indic = Indicators::rsi( );
      indic.plot( 0 , Blue , 1 , PLOT_TYPE_LINE , PLOT_STYLE_DOT )
         .settings( )
            //.timeframe( period )
            .period( 3 )
            ;
         
      BufferMA * ma = indic.ma( );
      ma.plot( Green , 1 )
         .settings( )
            
            .method( MODE_EMA )
            .period( 13 )
            ;
                        
      return indic._buffers[0];
   }

   static Buffer * rsiM30 ( ENUM_TIMEFRAMES period )
   {
      IRsi * indic = Indicators::rsi( );
      indic/*.plot( 0 , Green , 1 , PLOT_TYPE_LINE , PLOT_STYLE_DOT )*/
         .settings( )
            .timeframe( period )
            .period( 5 )
            ;
         
      BufferMA * ma = indic.ma( );
      ma/*.plot( Orange , 2 )*/
         .settings( )
            
            .method( MODE_EMA )
            .period( 24 )
            ;
            
      return ma;
   }
   
   static Buffer * rsiH1 (ENUM_TIMEFRAMES period  )
   {
      IRsi * indic = Indicators::rsi( );
      indic.plot( 0 , Red , 1 , PLOT_TYPE_LINE , PLOT_STYLE_SOLID )
         .settings( )
            .timeframe( period )
            .period   ( 5 )
            ;
      
      /*
      BufferMA * ma = indic.ma( );
      ma.plot( Purple , 1 , PLOT_TYPE_LINE , PLOT_STYLE_SOLID )
         .settings( )
            .method( MODE_EMA )
            .period( 21 )
            ;*/
      
      /*
      Signals::trend( ma )
         .plot( SIGNAL_LONG  , Blue  , 2 )
         .plot( SIGNAL_SHORT , Red   , 2 )
         .plot( SIGNAL_NULL  , Black , 2 )
         .settings( )
            .position( 93 )
            ;*/
      
      return indic._buffers[0];
   }
   
   static Buffer * rsiH4 (ENUM_TIMEFRAMES period  )
   {
      IRsi * indic = Indicators::rsi( );
      indic/*.plot( 0 , Purple , 1 , PLOT_TYPE_LINE , PLOT_STYLE_SOLID )*/
         .settings( )
            .timeframe( period )
            .period   ( 5 )
            ;
      
      BufferMA * ma = indic.ma( );
      ma/*.plot( Blue )*/
         .settings( )
            .method( MODE_EMA )
            .period( 12 )            
            ;
      /*
      Signals::trend( ma )
         .plot( SIGNAL_LONG  , Blue  , 2 )
         .plot( SIGNAL_SHORT , Red   , 2 )
         .plot( SIGNAL_NULL  , Black , 2 )
         .settings( )
            .position( 93 )
            ;*/
      
      return indic._buffers[0];
   }
   
   static void rsiD1 ( )
   {
      IRsi * indic = Indicators::rsi( );
      indic/*.plot( 0 , Blue )*/
         .settings( )
            .timeframe( PERIOD_D1 )
            .period   ( 8 )
            ;
      
      BufferMA * ma = indic.ma( );
      ma/*.plot( DeepPink )*/
         .settings( )
            .method( MODE_EMA )
            .period( 72 )            
            ;
            
      Signals::trend( ma )
         .plot( SIGNAL_LONG  , Blue  , 2 )
         .plot( SIGNAL_SHORT , Red   , 2 )
         .plot( SIGNAL_NULL  , Black , 2 )
         .settings( )
            .position( 90 )
            ;
     
   }
   
   static void williams ( )
   {
      /*
      IWilliams * indic = Indicators::williams( );      
      indic
         .plot( 0 , Red , 1 , PLOT_TYPE_LINE , PLOT_STYLE_DOT )
         .settings( )
            .timeframe( PERIOD_M15 )
            .period( 13 )
            ;*/
      
      /*
      BufferMA * ma = indic.ma( );
      ma.plot( DeepPink , 2 )
         .settings( )
            .method( MODE_EMA )
            .period( 21 )            
            ;*/
      
      /*  
      Signals::trend( ma )
         .plot( SIGNAL_LONG  , Blue  , 2 )
         .plot( SIGNAL_SHORT , Red   , 2 )
         .plot( SIGNAL_NULL  , Black , 2 )
         .settings( )
            .position( 95 )
            ;*/
      
      /*
      Signals::crossLevel( indic._buffers[0] )
         .plot     ( SIGNAL_NULL  , Black , 2 )
         .plot     ( SIGNAL_LONG  , Blue  , 1 , DRAW_ARROW )
         .plotArrow( SIGNAL_LONG  , 233 )
         .plot     ( SIGNAL_SHORT , Red   , 1 , DRAW_ARROW )
         .plotArrow( SIGNAL_SHORT , 234 )
         .settings( )
            .position( 20 , 80 )
            .limit   ( 20 , 80 )            
            ;*/
   }
   
   static void stochastic ( )
   {
      IStochastic * indic = Indicators::stochastic( );
      indic
         .plot( 0 , Purple , 1 , PLOT_TYPE_LINE , PLOT_STYLE_DOT )
         .plot( 1 , Orange , 1 , PLOT_TYPE_LINE , PLOT_STYLE_DOT )
         .settings( )
            .periodK( 5 )
            .periodD( 3 )
            .slowing( 5 )
            .method ( MODE_EMA )
         ;
       
      Signals::crossLevel( indic._buffers[1] )
         .plot     ( SIGNAL_NULL  , Black , 2 )
         .plot     ( SIGNAL_LONG  , Blue  , 1 , DRAW_ARROW )
         .plotArrow( SIGNAL_LONG  , 233 )
         .plot     ( SIGNAL_SHORT , Red   , 1 , DRAW_ARROW )
         .plotArrow( SIGNAL_SHORT , 234 )
         .settings( )
            .position( 20 , 80 )
            .limit   ( 20 , 80 )            
            ;
   }
      
};
