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
      dow( );      
   }
   
   static void dow ( )
   {
      Script::add < TrendDowSignal > ( new TrendDowSignal( ) )
         .plotArrow( SIGNAL_LONG  , 233 , Blue , 1 )
         .plotArrow( SIGNAL_SHORT , 234 , Red  , 1 )         
         ;
   }
};
