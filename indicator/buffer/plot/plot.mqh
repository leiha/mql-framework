//+------------------------------------------------------------------+
//|                                                       Lia System |
//|                                   Copyright © 2019 Leiha Sellier |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2019, Leiha Sellier"
//----
enum PLOT_TYPE {
   PLOT_TYPE_LINE      = DRAW_LINE,
   PLOT_TYPE_SECTION   = DRAW_SECTION,
   PLOT_TYPE_HISTOGRAM = DRAW_HISTOGRAM,
   PLOT_TYPE_ARROW     = DRAW_ARROW,
   PLOT_TYPE_ZIGZAG    = DRAW_ZIGZAG,
   PLOT_TYPE_NONE      = DRAW_NONE
};

enum PLOT_STYLE {
   PLOT_STYLE_SOLID      = STYLE_SOLID,
   PLOT_STYLE_DASH       = STYLE_DASH,
   PLOT_STYLE_DOT        = STYLE_DOT,
   PLOT_STYLE_DASHDOT    = STYLE_DASHDOT,
   PLOT_STYLE_DASHDOTDOT = STYLE_DASHDOTDOT   
};

class Plot
{
   int plotCount;

   public:
   
   PLOT_TYPE  plotType ;
   PLOT_STYLE plotStyle;
   int        plotWidth;
   color      plotColor;
   
   int        plotArrow;
   
   Plot ( int counter ) 
   {
      plotCount = counter;
      // ---      
      plotType  = PLOT_TYPE_NONE;
      plotStyle = PLOT_STYLE_SOLID;
      plotColor = Black;
      plotWidth = 1;
   }
   
   Plot * type ( PLOT_TYPE type ) {
      plotType = type;
      return GetPointer( this );
   }
   
   Plot * style ( PLOT_STYLE style ) {
      plotStyle = style;
      return GetPointer( this );
   }
   
   Plot * width ( int width ) {
      plotWidth = width;
      return GetPointer( this );
   }
   
   Plot * c0lor ( color c0lor ) {
      plotColor = c0lor;
      return GetPointer( this );
   }
   
   Plot * arrow ( int arrow ) {
      plotArrow = arrow;
      return GetPointer( this );
   }
   
   void onInit() {
      SetIndexStyle ( plotCount , plotType , plotStyle , plotWidth , plotColor );
      if( plotArrow )
         SetIndexArrow ( plotCount , plotArrow );
   }
};