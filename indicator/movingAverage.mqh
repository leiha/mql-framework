//+------------------------------------------------------------------+
//|                                                       Lia System |
//|                                   Copyright © 2019 Leiha Sellier |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2019, Leiha Sellier"
//----
#include "./indicator.mqh"

class MaSettings
{
   public:
   
   int                _period;   
   int                _maShift;
   ENUM_MA_METHOD     _method;
   ENUM_APPLIED_PRICE _appliedPrice;
   
   MaSettings ( ) 
   {      
      _period       = 5;
      _maShift      = 0;
      _method       = MODE_SMA;
      _appliedPrice = PRICE_CLOSE;
   }
   
   MaSettings * period( int period )
   {
      _period = period;
      return GetPointer( this );
   }
   
   MaSettings * maShift( int maShift )
   {
      _maShift = maShift;
      return GetPointer( this );
   }
   
   MaSettings * method( ENUM_MA_METHOD method )
   {
      _method = method;
      return GetPointer( this );
   }
   
   MaSettings * appliedPrice( ENUM_APPLIED_PRICE appliedPrice )
   {
      _appliedPrice = appliedPrice;
      return GetPointer( this );
   }      
};

class IMa : public Indicator < IMa , MaSettings >
{
   public:

   IMa( ) 
      : Indicator( ) 
   {
      add( new MaSerie( ) );
   }
};

class MaSerie : public Calculator < MaSettings >
{
   public:
   
   MaSerie( ) 
      : Calculator( ) 
      {}
   
   int onCalculateCandle( int shift , int shiftMTF )
   {
      buffer[ shift ] = iMA( 
         settings._symbol , 
         settings._timeframe , 
         settings._period , 
         settings._maShift , 
         settings._method ,          
         settings._appliedPrice , 
         shiftMTF 
      );
      return 0;
   }
};