//+------------------------------------------------------------------+
//|                                                       Lia System |
//|                                   Copyright © 2019 Leiha Sellier |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2019, Leiha Sellier"
//----
#include "./cross.mqh"

class CrossLevelSettings : public SignalSettings < CrossLevelSettings >
{
   int _limitS;
   int _limitL;

   public:
   
   CrossLevelSettings( )
      : SignalSettings ( )
      {}  
      
   CrossLevelSettings * limit( int sshort , int slong )
   {
      _limitS = sshort;
      _limitL = slong;
      return GetPointer( this );
   }
   
   int limit( SIGNAL_TYPE signal )
   {
      return signal == SIGNAL_LONG
         ? _limitL
         : _limitS
         ;
   }
};

class CrossLevelSignal : public CrossSignal < CrossLevelSignal , CrossLevelSettings >
{
   protected:
   
   Buffer * _pBuffer;
   
   public:
      
   CrossLevelSignal( Buffer * oBuffer )
      : CrossSignal( )   
   {
      _pBuffer = oBuffer;      
   }
   
   void onCalculateCandle( int x )
   {
      SIGNAL_TYPE signal;
      double s = settings.limit( SIGNAL_SHORT );
      double l = settings.limit( SIGNAL_LONG );
      
      if( _pBuffer.buffer[ x + 1 ] > s && _pBuffer.buffer[ x ] < s )
      {
         signal = SIGNAL_SHORT;
      } 
      else if( _pBuffer.buffer[ x + 1 ] < l && _pBuffer.buffer[ x ] > l )
      {
         signal = SIGNAL_LONG;
      }
      
      if( signal ) {
         double pos = settings.position( signal );
         _buffers[ signal ].buffer[ x ] = pos ? pos : _pBuffer.buffer[ x ];
      }
   }
};