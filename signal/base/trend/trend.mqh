//+------------------------------------------------------------------+
//|                                                       Lia System |
//|                                   Copyright © 2019 Leiha Sellier |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2019, Leiha Sellier"
//----
#include "../signal.mqh"

class TrendSettings : public SignalSettings < TrendSettings >
{
   public:
   
   TrendSettings( )
      : SignalSettings( )
      {}
};

template < typename TSignal , typename TSettings >
class TrendSignal : public Signal < TSignal , TSettings >
{
   protected:
   
   public:
      
   TrendSignal( )
      : Signal( )   
   {
      add( new TrendSerie < TSettings >( ) );
      add( new TrendSerie < TSettings >( ) );
      add( new TrendSerie < TSettings >( ) );
   }
};

template < typename TSettings >
class TrendSerie : public Calculator < TSettings >
{
   public:
   
   TrendSerie(  )
      : Calculator( ) 
      {}
      
   int onCalculateCandle( int shift , int shiftMTF )
   {
      return 0;
   };
};