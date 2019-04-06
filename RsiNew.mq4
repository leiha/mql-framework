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
      rsi( );      
   }
   
   static void rsi ( )
   {
      Script::add < Rsi > ( new Rsi( ) );         
   }
};
