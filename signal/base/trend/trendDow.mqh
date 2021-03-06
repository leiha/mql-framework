//+------------------------------------------------------------------+
//|                                                       Lia System |
//|                                   Copyright © 2019 Leiha Sellier |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2019, Leiha Sellier"
//----
#include "./trend.mqh"

class TrendDowSignal : public TrendSignal < TrendDowSignal , TrendSettings >
{
   protected:
   
   public:
      
   TrendDowSignal( )
      : TrendSignal( )   
   {
      
      
   }
   
   void onCalculateCandle( int x )
   {
      SIGNAL_TYPE signal;
   
      signal = SIGNAL_SHORT;
      _buffers[ signal ].buffer[ x ] = 1;
      
      signal = SIGNAL_LONG;
      _buffers[ signal ].buffer[ x ] = 5;
         
   }
};