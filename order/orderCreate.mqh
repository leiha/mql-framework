//+------------------------------------------------------------------+
//|                                                       Lia System |
//|                                   Copyright © 2019 Leiha Sellier |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2019, Leiha Sellier"
//----

#include "./order.mqh"

class OrderCreate
{
   public:

   string   _symbol;        // symbol 
   int      _slippage;      // slippage 
   string   _comment;       // comment 
   int      _magic;         // magic number 
   datetime _expiration;    // pending order expiration 
   color    _arrow_color;   // color 

   OrderCreate( string symbol = NULL )      
   {
      _symbol      = symbol == NULL ? Symbol( ) : symbol;
      _slippage    = 0;
      _comment     = NULL;
      _magic       = 0;
      _expiration  = 0;
      _arrow_color = clrNONE;
   }
   
   Order * openLong( 
      double volume     = 0.1 , 
      int    stopLoss   = 0   , 
      int    takeProfit = 0 
   ) {
      double sl = 0;
      if( stopLoss )
         sl = NormalizeDouble( Ask + ( stopLoss   * Point ) , Digits );
      
      double tp = 0;
      if( takeProfit )
         tp = NormalizeDouble( Bid - ( takeProfit * Point ) , Digits );
   
      return open( TRADE_BUY , volume , Bid , sl , tp );
   }
   
   Order * openShort( 
      double volume     = 0.1 , 
      int    stopLoss   = 0   , 
      int    takeProfit = 0 
   ) {   
      double sl = 0;
      if( stopLoss )
         sl = NormalizeDouble( Bid - ( stopLoss   * Point ) , Digits );
      
      double tp = 0;
      if( takeProfit )
         tp = NormalizeDouble( Ask + ( takeProfit * Point ) , Digits );
   
      return open( TRADE_SELL , volume , Ask , sl , tp );
   }
   
   Order * open( 
      TRADE  trade   , 
      double volume  , 
      double price   , 
      double stopLoss   = 0 , 
      double takeProfit = 0 
   ) {
      int ticket = OrderSend( 
         _symbol      , 
         trade        , 
         volume       , 
         price        , 
         _slippage    , 
         stopLoss     , 
         takeProfit   , 
         _comment     , 
         _magic       , 
         _expiration  , 
         _arrow_color
      );   
      
      if( ticket ) {
         return new Order( ticket );
      }
      return NULL;
   }
};