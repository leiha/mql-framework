//+------------------------------------------------------------------+
//|                                                       Lia System |
//|                                   Copyright © 2019 Leiha Sellier |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2019, Leiha Sellier"
//----
#include "./buffer/bufferMA.mqh"

class IndicatorSettings
{
   public:
   
   IndicatorSettings ( )
   {}  
   
};

interface iIndicator{
   
   public:

   virtual int onInit     ( ) = 0;
   virtual int onCalculate( ) = 0;     
};

template < typename TIndicator , typename TSettings >
class IndicatorTemplate : public iIndicator
{
   protected:

   public:
      
   Calculator   < TSettings  > * _buffers  [];
   
   Settings     < TSettings  > * settings;

   IndicatorTemplate( )      
   {
      settings = new Settings < TSettings >( );
   }
     
   TIndicator * plot( 
      int   plot ,
      color c0lor , 
      int        width = 1 , 
      PLOT_TYPE  type  = PLOT_TYPE_LINE , 
      PLOT_STYLE style = PLOT_STYLE_SOLID 
   ) {
      _buffers[ plot ].plot( c0lor , width , type , style );         
      return GetPointer( this );
   }
   
   TIndicator * plotArrow( 
      int   plot ,
      int   arrow ,
      color c0lor , 
      int   width = 1 , 
      PLOT_STYLE style = PLOT_STYLE_SOLID 
   ) {
      return plotArrow( plot , arrow )
         .plot( plot , c0lor , width , DRAW_ARROW , style )
         ;     
   }
   
   TIndicator * plotArrow( 
      int   plot ,
      int   arrow      
   ) {
      _buffers[ plot ].arrow( arrow );
      return GetPointer( this );
   }
   
   Calculator < TSettings > * add( Calculator < TSettings > * oBuffer )
   {
      int size = ArraySize ( _buffers );
      ArrayResize( _buffers , size + 1 );      
      _buffers[ size ] = oBuffer;      
      return oBuffer.setSettings( settings );
   }
   
   
};

template < typename TIndicator , typename TSettings >
class Indicator : public IndicatorTemplate < TIndicator , TSettings >
{
   protected:

   public:
      
   CalculatorMA * _buffersMA[];
   
   Indicator( )
      : IndicatorTemplate( )
   {
      
   }
     
   CalculatorMA * ma( int bufferId=0 )
   {
      int size = ArraySize ( _buffersMA );
      ArrayResize( _buffersMA , size + 1 );      
      return ( _buffersMA[ size ] = new CalculatorMA( _buffers[ bufferId ] ) );
   }
   
   int onInit( )
   {
      int total = ArraySize( _buffers );
      for( int i=0;i < total;i++ ) {          
         _buffers[i].plot( ).onInit( );
      }      
      onInitMa( );
      return 0;
   }
   
   void onInitMa( )
   {
      int total = ArraySize( _buffersMA );
      for( int i=0;i < total;i++ ) {          
         _buffersMA[i].plot( ).onInit( );
      }      
   }
   
   int onCalculate( )
   {
      datetime TimeArray[];
      int counted_bars = IndicatorCounted( );
      int limit        = Bars - counted_bars;      
      
      ArrayCopySeries( TimeArray , MODE_TIME , settings._symbol , settings._timeframe );
   
      for( int w=0 , total=ArraySize( _buffers ) ; w < total ; w++ ) {
         for( int x=0, y=0; x < limit; x++ ) {
            if ( Time[ x ] < TimeArray[ y ] ) 
               y++;
            
            onCalculateCandle( _buffers[ w ] , x , y );
         }
      }
      onCalculateMa( limit );
      return 0;
   }
   
   virtual void onCalculateCandle( Calculator < TSettings > * buffer , int x , int y ) {
      buffer.onCalculateCandle( x , y );
   } 
   
   virtual void onCalculateMa( int limit ) {
      int total = ArraySize( _buffersMA );
      for( int i=0;i < total;i++ ) {
         for( int x=0; x < limit; x++ ) {
            _buffersMA[ i ].onCalculateCandle( x , x );
         }      
      }
   }
   
};