//+------------------------------------------------------------------+
//|                                  Lia Williams Signals System.mq4 |
//|                                   Copyright © 2019 Leiha Sellier |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2019, Leiha Sellier"

#include "./collection.mqh"
#include "../indicator/rsi.mqh"
#include "../signal/base/cross/crossLine.mqh"
#include "../signal/base/cross/crossLevel.mqh"
#include "../signal/base/trend/trendLine.mqh"
#include "../signal/base/trend/trendUpDown.mqh"

enum RSICOLLECTION {

};

class Rsi : public Collection < RSICOLLECTION > 
{
   public:
   
   Rsi( )
      : Collection()
   {  
      IRsi * indic = add < IRsi >( new IRsi( ) );
      
      indic.plot( 0 , Blue , 1 , PLOT_TYPE_LINE , PLOT_STYLE_SOLID )
         .settings
            .timeframe( tfNext( intToTf( Period() ) ) )
            .period( 5  )
            ;
            
      indic.ma()
         .plot( Blue , 1 , PLOT_TYPE_LINE , PLOT_STYLE_SOLID )
         .settings
            .period( 55 )
            .method( MODE_EMA )
            ;
      
      add < TrendLineSignal > ( new TrendLineSignal( indic._buffersMA[0] ) )
         .plot( SIGNAL_LONG  , Blue , 2 )
         .plot( SIGNAL_SHORT , Red  , 2 )         
         ;
      
      add < CrossLevelSignal > ( new CrossLevelSignal( indic._buffers[0] ) )
         .plotArrow( SIGNAL_LONG  , 233 , Blue , 1 )
         .plotArrow( SIGNAL_SHORT , 234 , Red  , 1 )
         .settings
            .position( 90 , 10 )
            .limit   ( 70 , 30 )            
            ;
   }   
};
