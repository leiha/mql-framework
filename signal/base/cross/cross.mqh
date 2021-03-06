//+------------------------------------------------------------------+
//|                                                       Lia System |
//|                                   Copyright © 2019 Leiha Sellier |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2019, Leiha Sellier"
//----
#include "../signal.mqh"

template < typename TSignal , typename TSettings >
class CrossSignal : public Signal < TSignal , TSettings >
{
   protected:
   
   public:
      
   CrossSignal( )
      : Signal( )   
   {
      add( new CrossSerie < TSettings >( ) );
      add( new CrossSerie < TSettings >( ) );
      add( new CrossSerie < TSettings >( ) );
   }
};

template < typename TSettings >
class CrossSerie : public Calculator < TSettings >
{
   protected:
   
   public:
   
   CrossSerie( )
      : Calculator( )
      {}
   
   int onCalculateCandle( int shift , int shiftMTF ){ return 0;}
};