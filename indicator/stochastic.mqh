//+------------------------------------------------------------------+
//|                                                       Lia System |
//|                                   Copyright © 2019 Leiha Sellier |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2019, Leiha Sellier"
//----
#include "./indicator.mqh"

enum STOCHASTIC_LINES
{
   STOCHASTIC_MAIN   = MODE_MAIN,
   STOCHASTIC_SIGNAL = MODE_SIGNAL
};

class StochasticSettings
{
   public:
   
   int _periodK;
   int _periodD;
   int _slowing;
   ENUM_MA_METHOD _method;
   int _priceField;
   
   
   StochasticSettings ( )      
   {      
      _periodK    = 5;
      _periodD    = 3;
      _slowing    = 3;
      _method     = MODE_SMA;
      _priceField = 0;
   }
     
   StochasticSettings * periodK( int periodK )
   {
      _periodK = periodK;
      return GetPointer( this );
   }
   
   StochasticSettings * periodD( int periodD )
   {
      _periodD = periodD;
      return GetPointer( this );
   }
   
   StochasticSettings * slowing( int slowing )
   {
      _slowing = slowing;
      return GetPointer( this );
   }
   
   StochasticSettings * method( ENUM_MA_METHOD method )
   {
      _method = method;
      return GetPointer( this );
   }
   
   StochasticSettings * priceField( int priceField )
   {
      _priceField = priceField;
      return GetPointer( this );
   }  
};

class IStochastic : public Indicator < IStochastic , StochasticSettings >
{
   public:

   IStochastic( ) 
      : Indicator( ) 
   {
      add( new StochasticSerie( STOCHASTIC_MAIN   ) );
      add( new StochasticSerie( STOCHASTIC_SIGNAL ) );
   }
};

class StochasticSerie : public Calculator < StochasticSettings >
{
   protected:
   
   STOCHASTIC_LINES _mode;

   public:
   
   StochasticSerie( STOCHASTIC_LINES mode )
      : Calculator( ) 
   {
     _mode = mode;
   }
   
   int onCalculateCandle( int shift , int shiftMTF )
   {
      buffer[ shift ] = iStochastic( 
         settings._symbol , 
         settings._timeframe , 
         settings._periodK , 
         settings._periodD ,
         settings._slowing ,
         settings._method  ,
         settings._priceField ,
         _mode ,
         shiftMTF 
      );
      return 0;
   }
};