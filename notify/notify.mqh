//+------------------------------------------------------------------+
//|                                  Lia Williams Signals System.mq4 |
//|                                   Copyright © 2019 Leiha Sellier |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2019, Leiha Sellier"
//----

class Notify
{
   static bool mail( string subject , string body ) {
      return SendMail( subject , body );   
   }
   
   static bool phone( string body ) {
      return SendNotification( body );
   }
   
   static void alert( string body ) {
      Alert( body );
   }
};