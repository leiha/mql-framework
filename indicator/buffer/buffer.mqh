//+------------------------------------------------------------------+
//|                                                       Lia System |
//|                                   Copyright © 2019 Leiha Sellier |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2019, Leiha Sellier"
//----
#include "./plot/plot.mqh"

int BUFFERCOUNTER = 0;

class Buffer
{
   protected:

   int bufferId;
   
   Plot * _plot;  
   
   public:

   double buffer[];
   
   
   Buffer( ) {
      bufferId        = BUFFERCOUNTER++;
      SetIndexBuffer( bufferId , buffer );      
   }
   
   Plot * plot( ) {
      if( ! _plot )
         _plot = new Plot( bufferId );
         
      return _plot;
   }
   
   Buffer * plot( 
      color c0lor , 
      int        width = 1 , 
      PLOT_TYPE  type  = PLOT_TYPE_LINE , 
      PLOT_STYLE style = PLOT_STYLE_SOLID 
   ) {
      plot( )
         .type ( type  )
         .style( style )
         .width( width )
         .c0lor( c0lor )
         ;
      
      return GetPointer( this );
   }
   
   Buffer * arrow( 
      int arrow ,
      color c0lor , 
      int   width = 1 , 
      PLOT_STYLE style = PLOT_STYLE_SOLID 
   ) {
      plot( )
         .type ( DRAW_ARROW )
         .style( style )
         .width( width )
         .c0lor( c0lor )
         ;
      return arrow( arrow );
   }
   
   Buffer * arrow( int arrow ) {
      plot( )
         .arrow( arrow )
         ;
         
      return GetPointer( this );
   }
};

//----
template < typename TSettings >
class Settings : public TSettings
{
   public:
   
   string          _symbol;
   ENUM_TIMEFRAMES _timeframe;
      
   Settings ( )
      : TSettings( )
   {      
      _symbol    = Symbol();
      _timeframe = PERIOD_CURRENT;
   }
   
   Settings < TSettings > * symbol( string symbol )
   {
      _symbol = symbol;
      return GetPointer( this );
   }
   
   Settings < TSettings > * timeframe( ENUM_TIMEFRAMES timeframe ) 
   {
      _timeframe = timeframe;
      return GetPointer( this );
   }  
   
};

template < typename TSettings >
class Calculator : public Buffer
{
   public:
   
   Settings < TSettings > * settings;

   Calculator( )
      : Buffer( )
      {}
   
   virtual int onCalculateCandle( int shift , int shiftMTF ) = 0;
   
   Calculator < TSettings > * plot( 
      color c0lor , 
      int        width = 1 , 
      PLOT_TYPE  type  = PLOT_TYPE_LINE , 
      PLOT_STYLE style = PLOT_STYLE_SOLID 
   ) {
      Buffer::plot( c0lor , width , type , style );         
      return GetPointer( this );
   }
   
   Calculator < TSettings > * setSettings( Settings < TSettings > * _settings ) {
      settings = _settings;         
      return GetPointer( this );
   }
   
   Calculator < TSettings > * setSettings( ) {
      return setSettings( new Settings < TSettings >( ) );
   }
   
   
};