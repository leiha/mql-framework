//+------------------------------------------------------------------+
//|                                                       Lia System |
//|                                   Copyright © 2019 Leiha Sellier |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2019, Leiha Sellier"
//----
#include "./indicator.mqh"

enum ICHIMOKU_LINES
{
   ICHIMOKU_TENKANSEN   = MODE_TENKANSEN,
   ICHIMOKU_KIJUNSEN    = MODE_KIJUNSEN,
   ICHIMOKU_SENKOUSPANA = MODE_SENKOUSPANA,
   ICHIMOKU_SENKOUSPANB = MODE_SENKOUSPANB,
   ICHIMOKU_CHIKOUSPAN  = MODE_CHIKOUSPAN
};

class IchimokuSettings 
{
   public:
   
   int _kijunSen;
   int _tenkanSen;
   int _senkouSpanB;
   
   IchimokuSettings ( ) 
   {      
      _kijunSen    =  9;
      _tenkanSen   = 26;
      _senkouSpanB = 52;
   }
   
   IchimokuSettings * tenkanSen( int tenkanSen )
   {
      _tenkanSen = tenkanSen;
      return GetPointer( this );
   }
   
   IchimokuSettings * kijunSen( int kijunSen )
   {
      _kijunSen = kijunSen;
      return GetPointer( this );
   }
   
   IchimokuSettings * senkouSpanB ( int senkouSpanB )
   {
      _senkouSpanB = senkouSpanB;
      return GetPointer( this );
   }  
};

class IIchimoku : public Indicator < IIchimoku , IchimokuSettings >
{
   public:

   IIchimoku( ) 
      : Indicator( ) 
   {
      add( new IchimokuSerie( ICHIMOKU_TENKANSEN   ) );
      add( new IchimokuSerie( ICHIMOKU_KIJUNSEN    ) );
      add( new IchimokuSerie( ICHIMOKU_SENKOUSPANA ) );
      add( new IchimokuSerie( ICHIMOKU_SENKOUSPANB ) );
      add( new IchimokuSerie( ICHIMOKU_CHIKOUSPAN  ) );
   }  
};

class IchimokuSerie : public Calculator < IchimokuSettings >
{
   protected:
   
   ICHIMOKU_LINES _mode;

   public:
   
   IchimokuSerie( ICHIMOKU_LINES mode )
      : Calculator(  ) 
   {
     _mode = mode;
   }
   
   int onCalculateCandle( int shift , int shiftMTF )
   {
      buffer[ shift ] = iIchimoku( 
         settings._symbol , 
         settings._timeframe , 
         settings._tenkanSen , 
         settings._kijunSen ,
         settings._senkouSpanB ,
         _mode ,
         shiftMTF 
      );
      return 0;
   }
};