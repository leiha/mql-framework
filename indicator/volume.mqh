//+------------------------------------------------------------------+
//|                                                       Lia System |
//|                                   Copyright © 2019 Leiha Sellier |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2019, Leiha Sellier"
//----
#include "./indicator.mqh"

class VolumeSettings
{
   public:
   
   VolumeSettings( ) 
   {}
};

class IVolume : public Indicator < IVolume , VolumeSettings >
{
   public:

   IVolume( ) 
      : Indicator( ) 
   {
      add( new VolumeSerie( ) );
   }
};

class VolumeSerie : public Calculator < VolumeSettings >
{
   public:
   
   VolumeSerie( ) 
      : Calculator( ) 
   {}
   
   int onCalculateCandle( int shift , int shiftMTF )
   {
      buffer[ shift ] = iVolume( 
         settings._symbol , 
         settings._timeframe ,
         shiftMTF 
      );
      return 0;
   }
};