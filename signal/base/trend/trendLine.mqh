//+------------------------------------------------------------------+
//|                                                       Lia System |
//|                                   Copyright © 2019 Leiha Sellier |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2019, Leiha Sellier"
//----
#include "./trend.mqh"

class TrendLineSignal : public TrendSignal < TrendLineSignal , TrendSettings >
{
   protected:
   
   Buffer * _pBuffer;

   public:
      
   TrendLineSignal( Buffer * oBuffer )
      : TrendSignal( )   
   {
      _pBuffer = oBuffer;
      
   }
   
   void onCalculateCandle( int x )
   {
      SIGNAL_TYPE signal;
      if( _pBuffer.buffer[ x + 1 ] > _pBuffer.buffer[ x ] ) 
      {
         signal = SIGNAL_SHORT;
      } 
      else if( _pBuffer.buffer[ x + 1 ] < _pBuffer.buffer[ x ] ) 
      {
         signal = SIGNAL_LONG;
      }      
      
      if( signal ) {
         double pos = settings.position( signal );
         _buffers[ signal ].buffer[ x ] = pos ? pos : _pBuffer.buffer[ x ];
      }
         
   }
};