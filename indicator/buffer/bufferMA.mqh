//+------------------------------------------------------------------+
//|                                                       Lia System |
//|                                   Copyright © 2019 Leiha Sellier |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2019, Leiha Sellier"
//----
#include "./buffer.mqh"

//----
class SettingsMA
{
   public:
   
   int            _period;
   ENUM_MA_METHOD _method;
   int            _maShift;
      
   SettingsMA ( )       
   {      
      _period  = 13;
      _method  = MODE_SMA;
      _maShift = 0;
   }
   
   SettingsMA * period( int period ) 
   {
      _period = period;
      return GetPointer( this );
   }
   
   SettingsMA * maShift( int maShift ) 
   {
      _maShift = maShift;
      return GetPointer( this );
   }
   
   SettingsMA * method( ENUM_MA_METHOD method ) 
   {
      _method = method;
      return GetPointer( this );
   }
};

class CalculatorMA : public Calculator < SettingsMA >
{
   Buffer * _bufferParent;   

   public:
   
   CalculatorMA( Buffer * oBuffer ) 
      : Calculator( ) 
   {
      _bufferParent = oBuffer;
      setSettings( new Settings < SettingsMA > ( ) );
   }
      
   int onCalculateCandle( int shift , int shiftMTF )
   {   
      buffer[ shift ] = iMAOnArray(
         _bufferParent.buffer , 
         0 , 
         settings._period ,
         settings._maShift ,
         settings._method , 
         shift 
      );
      return 1;
   }
};