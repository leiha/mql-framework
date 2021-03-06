//+------------------------------------------------------------------+
//|                                                       Lia System |
//|                                   Copyright © 2019 Leiha Sellier |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2019, Leiha Sellier"
//----
#include "../indicator/indicator.mqh"
#include "../library.mqh"

template < typename TEnumLines >
class Collection : public iIndicator
{
   public:
   
   iIndicator * _indicators[];
   
   Collection( )
      {}
   
   int onInit( ) 
   {  
      int total = ArraySize( _indicators );
      for( int i=0;i < total;i++ ) { 
         _indicators[i].onInit( );
      }
      return 0;      
   }
   
   int onCalculate( ) 
   {
      int total = ArraySize( _indicators );
      for( int i=0;i < total;i++ ) { 
         _indicators[i].onCalculate( );
      } 
      return 0;
   }
   
   // -----
   
   iIndicator * add( iIndicator * oIndicator )
   {
      return add < iIndicator > ( oIndicator );
   }
   
   template < typename TIndicator >
   TIndicator * add( TIndicator * oIndicator )
   {
      int size = ArraySize ( _indicators );      
      ArrayResize( _indicators , size + 1 );      
      _indicators[ size ] = oIndicator;      
      return oIndicator;
   }
   
   template < typename TIndicator >
   TIndicator * get( TEnumLines line )
   {
      return _indicators[ line ];
   }
};
