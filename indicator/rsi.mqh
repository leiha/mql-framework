//+------------------------------------------------------------------+
//|                                                       Lia System |
//|                                   Copyright © 2019 Leiha Sellier |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2019, Leiha Sellier"
//----
#include "./indicator.mqh"

class RsiSettings
{
   public:
   
   int                _period;   
   ENUM_APPLIED_PRICE _appliedPrice;
   
   RsiSettings ( )      
   {      
      _period       = 8;
      _appliedPrice = PRICE_CLOSE;
   }
   
   RsiSettings * period( int period )
   {
      _period = period;
      return GetPointer( this );
   }
   
   RsiSettings * appliedPrice( ENUM_APPLIED_PRICE appliedPrice )
   {
      _appliedPrice = appliedPrice;
      return GetPointer( this );
   }      
};

class IRsi : public Indicator < IRsi , RsiSettings >
{
   public:

   IRsi( ) 
      : Indicator( ) 
   {
      add( new RsiSerie( ) );
   }
};

class RsiSerie : public Calculator < RsiSettings >
{
   public:
   
   RsiSerie(  ) 
      : Calculator( ) 
      {}
   
   int onCalculateCandle( int shift , int shiftMTF )
   {
      buffer[ shift ] = iRSI( 
         settings._symbol , 
         settings._timeframe , 
         settings._period , 
         settings._appliedPrice , 
         shiftMTF 
      );
      return 0;
   }
};