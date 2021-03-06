//+------------------------------------------------------------------+
//|                                                       Lia System |
//|                                   Copyright © 2019 Leiha Sellier |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2019, Leiha Sellier"
//----

#include "./order.mqh"
#include "./orderCreate.mqh"

class Orders
{
   protected:
   
   virtual void _order( Order * order ) = NULL;

   public:
   
   Order * _orders[];
   
   TRADE_MODE _mode;
   
   Orders( TRADE_MODE mode = TRADE_MODE_TRADES ) {
      _mode = mode;
   }
   
   int total( ) {
      return ArraySize( _orders );   
   }
   
   void add( Order * order ) {
      int size = total( );
      ArrayResize( _orders , size + 1 );
      _orders[ size ] = order;
   }
   
   void iterate(  ) 
   {      
      int i , total;
      switch( _mode ) {
         case TRADE_MODE_TRADES  : total = OrdersTotal( )       ;break;
         case TRADE_MODE_HISTORY : total = OrdersHistoryTotal( );break;
      }   
   
      for( i=0; i < total; i++ ) {       
         if( OrderSelect( i, SELECT_BY_POS , _mode ) == false ) { 
            Print( "Access to history failed with error (", GetLastError() ,")" ); 
            break; 
         }         
         _order( new Order( OrderTicket( ) , _mode ) );
      }
   }
};

class OrdersByComment : public Orders
{
   protected:
   
   string _comment;
   
   void orderByComment( string comment , Order * order ) {
      if( order.comment( ) == comment ) {
         add( order );
      }
   }
   
   void _order( Order * order ) {
      orderByComment( _comment , order );
   }

   public:
   
   OrdersByComment( string comment )
   {
      _comment = comment;
   }
};