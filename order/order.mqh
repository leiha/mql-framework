//+------------------------------------------------------------------+
//|                                                       Lia System |
//|                                   Copyright © 2019 Leiha Sellier |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2019, Leiha Sellier"
//----

enum TRADE
{   
   TRADE_BUY       = OP_BUY       , // Buy operation
   TRADE_SELL      = OP_SELL      , // Sell operation
   TRADE_BUYLIMIT  = OP_BUYLIMIT  , // Buy limit pending order
   TRADE_SELLLIMIT = OP_SELLLIMIT , // Sell limit pending order
   TRADE_BUYSTOP   = OP_BUYSTOP   , // Buy stop pending order
   TRADE_SELLSTOP  = OP_SELLSTOP    // Sell stop pending order
};

enum TRADE_MODE
{
   TRADE_MODE_TRADES  = MODE_TRADES , // Order selected from trading pool(opened and pending orders)
   TRADE_MODE_HISTORY = MODE_HISTORY  // Order selected from history pool(closed and canceled order)
};

class Order
{
   public:

   int _ticket;
   
   int _slippage;
   
   TRADE_MODE _mode;
   
   Order( int ticket , TRADE_MODE mode = TRADE_MODE_TRADES ) 
   {
      _mode   = mode;
      _ticket = ticket;      
   }
   
   int ticket( ) 
   {
      return _ticket;
   }
   
   bool select( ) 
   {
      return OrderSelect( _ticket , SELECT_BY_TICKET , _mode );
   }
   
   bool modify( double stopLoss = 0 , double takeProfit = 0 ) 
   {
      double sl = stopLoss( );
      if( stopLoss )
         sl = NormalizeDouble( Bid - ( stopLoss   * Point ) , Digits );
      
      double tp = takeProfit( );
      if( takeProfit )
         tp = NormalizeDouble( Ask + ( takeProfit * Point ) , Digits );
   
      return OrderModify( ticket( ) , openPrice( ) , sl , tp , expiration( ) , clrNONE );
   }
   
   bool close( double volume , double price )
   {   
      bool closed = OrderClose( ticket( ) , volume , price , _slippage , clrNONE );      
      if( closed ) {
         _mode = TRADE_MODE_HISTORY;
      }      
      return closed;
   }
   
   string comment( ) 
   {
      return OrderComment( );
   }
   
   double expiration( ) 
   {
      return OrderExpiration( );
   }
   
   double stopLoss( ) 
   {
      return OrderStopLoss( );
   }
   
   double symbol( ) 
   {
      return OrderSymbol( );
   }
   
   double takeProfit( ) 
   {
      return OrderTakeProfit( );
   }
   
   TRADE type( ) 
   {
      return ( TRADE ) OrderType( );
   }
   
   double lots( ) 
   {
      return OrderLots( );
   }
   
   int magic( ) 
   {
      return OrderMagicNumber( );
   }
   
   double openPrice( ) 
   {
      return OrderOpenPrice( );
   }
   
   double openTime( ) 
   {
      return OrderOpenPrice( );
   }
   
   double closePrice( ) 
   {
      return OrderClosePrice( );
   }
   
   double closeTime( ) 
   {
      return OrderCloseTime( );
   }
   
   double profit( ) 
   {
      return OrderProfit( );
   }
   
    double commission( ) 
   {
      return OrderCommission( );
   }
   
   double swap( ) 
   {
      return OrderSwap( );
   }
   
   void print( ) 
   {
      OrderPrint( );
   }
};