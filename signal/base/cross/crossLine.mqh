//+------------------------------------------------------------------+
//|                                                       Lia System |
//|                                   Copyright © 2019 Leiha Sellier |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2019, Leiha Sellier"
//----
#include "./cross.mqh"

class CrossLineSettings : public SignalSettings < CrossLineSettings >
{
   public:
   
   CrossLineSettings( )
      : SignalSettings ( )
      {}  
};

class CrossLineSignal : public CrossSignal < CrossLineSignal , CrossLineSettings >
{
   protected:
   
   Buffer * _pBuffer1;
   Buffer * _pBuffer2;
   
   public:
      
   CrossLineSignal( Buffer * oBuffer1 , Buffer * oBuffer2 )
      : CrossSignal( )   
   {
      _pBuffer1 = oBuffer1;
      _pBuffer2 = oBuffer2;     
   }
   
   void onCalculateCandle( int x )
   {
      SIGNAL_TYPE signal;
      
      if( _pBuffer1.buffer[ x + 1 ] > _pBuffer2.buffer[ x + 1 ] 
       && _pBuffer1.buffer[ x     ] < _pBuffer2.buffer[ x ] )
      {
         signal = SIGNAL_SHORT;         
      } 
      else if( _pBuffer1.buffer[ x + 1 ] < _pBuffer2.buffer[ x + 1 ] 
            && _pBuffer1.buffer[ x     ] > _pBuffer2.buffer[ x ] )
      {
         signal = SIGNAL_LONG;
      }
       
      if( signal ) {
         _buffers[ signal ].buffer[ x ] = settings.position( signal );
      }
   }   
};