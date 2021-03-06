//+------------------------------------------------------------------+
//|                                  Lia Williams Signals System.mq4 |
//|                                   Copyright © 2019 Leiha Sellier |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2019, Leiha Sellier"
//----

void error( ) 
{
   int Error=GetLastError();                 // Failed :(
   switch(Error)                             // Overcomable errors
     {
      case  4: Alert("Trade server is busy. Retrying..");
         Sleep(3000);                        // Simple solution
         break;                              // At the next iteration
      case 137:Alert("Broker is busy. Retrying..");
         Sleep(3000);                        // Simple solution
         break;                              // At the next iteration
      case 146:Alert("Trading subsystem is busy. Retrying..");
         Sleep(500);                         // Simple solution
         break;                              // At the next iteration
     }
   switch(Error)                             // Critical errors
     {
      case 2 : Alert("Common error.");
         break;                              // Exit 'switch'
      case 64: Alert("Account is blocked.");
         break;                              // Exit 'switch'
      case 133:Alert("Trading is prohibited");
         break;                              // Exit 'switch'
      case 139:Alert("Order is blocked and is being processed");
         break;                              // Exit 'switch'
      case 145:Alert("Modification prohibited. ",
                           "Order is too close to the market");
         break;                              // Exit 'switch'
      default: Alert("Occurred error ",Error);//Other alternatives   
     }

}