//+------------------------------------------------------------------+
//|                                                       Lia System |
//|                                   Copyright © 2019 Leiha Sellier |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2019, Leiha Sellier"
//----
#include "./library.mqh"

class Script
{
   public:
   
   static iIndicator * _indicators[];
   
   static int onInit( ) 
   {
      Main::onInit( );
      int total = ArraySize( _indicators );
      for( int i=0;i < total;i++ ) { 
         _indicators[i].onInit( );
      }
      return 0;      
   }
   
   static int onCalculate( ) 
   {
      int total = ArraySize( _indicators );
      for( int i=0;i < total;i++ ) { 
         _indicators[i].onCalculate( );
      } 
      return 0;
   }
   
   // -----
   
   static iIndicator * add( iIndicator * oIndicator )
   {
      return Script::add < iIndicator > ( oIndicator );
   }
   
   template < typename TIndicator >
   static TIndicator * add( TIndicator * oIndicator )
   {
      int size = ArraySize ( _indicators );      
      ArrayResize( _indicators , size + 1 );      
      _indicators[ size ] = oIndicator;      
      return oIndicator;
   }
};

iIndicator * Script::_indicators[];

int init ( ) 
{
   return Script::onInit( );
};

int start( )
{   
   return Script::onCalculate( );
};