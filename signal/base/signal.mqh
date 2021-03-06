//+------------------------------------------------------------------+
//|                                                       Lia System |
//|                                   Copyright © 2019 Leiha Sellier |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2019, Leiha Sellier"
//----
#include "../../indicator/indicator.mqh"

enum SIGNAL_TYPE {
   SIGNAL_NULL  = 0,
   SIGNAL_SHORT = 1,
   SIGNAL_LONG  = 2,
};

template < typename TSettings >
class SignalSettings
{
   int _positionS;
   int _positionL;

   public:
   
   SignalSettings( )
      {}  
      
   TSettings * position( int sshort , int slong )
   {
      _positionS = sshort;
      _positionL = slong;
      return GetPointer( this );
   }
   
   int position( SIGNAL_TYPE signal )
   {
      return signal == SIGNAL_LONG
         ? _positionL
         : _positionS
         ;
   }
};

template < typename TSignal , typename TSettings >
class Signal : public IndicatorTemplate < TSignal , TSettings >
{
   protected:
   
   public:
      
   Signal( )
      : IndicatorTemplate( )        
   {      
      
   }
   
   int onInit( )
   {
      int total = ArraySize( _buffers );
      for( int i=0;i < total;i++ ) {          
         _buffers[i].plot( ).onInit( );
      }      
      return 0;
   }
   
   virtual void onCalculateCandle( int x ) = NULL;
   
   int onCalculate( )
   {
      datetime TimeArray[];
      int counted_bars = IndicatorCounted( );
      int limit        = 150;//Bars - counted_bars;      
      
      for( int x=limit; x >= 1 ; x-- ) {      
         onCalculateCandle( x );
      }      
      return 0;
   }
};