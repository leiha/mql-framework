//+------------------------------------------------------------------+
//|                                                       Lia System |
//|                                   Copyright © 2019 Leiha Sellier |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2019, Leiha Sellier"
//----
#include "./indicator.mqh"

class WilliamsSettings 
{
   public:
   
   int _period;   
   
   WilliamsSettings ( ) 
   {      
      _period = 21;      
   }
   
   WilliamsSettings * period( int period )
   {
      _period = period;
      return GetPointer( this );
   }
};

class IWilliams : public Indicator < IWilliams , WilliamsSettings >
{
   public:

   IWilliams( ) 
      : Indicator( ) 
   {
      add( new WilliamsSerie( ) );
   }
};

class WilliamsSerie : public Calculator < WilliamsSettings >
{
   public:
   
   WilliamsSerie( ) 
      : Calculator( ) 
   {}
   
   int onCalculateCandle( int shift , int shiftMTF )
   {
      buffer[ shift ] = iWPR( 
         settings._symbol , 
         settings._timeframe , 
         settings._period , 
         shiftMTF 
      );
      return 0;
   }
};