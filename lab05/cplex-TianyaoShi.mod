/*********************************************
 * OPL 12.9.0.0 Model
 * Author: StHowling
 * Creation Date: 2019年4月1日 at 上午2:02:26
 *********************************************/

 {string} Machine=...;
 {string} Product=...;
 {int} Month=...;
 
 float Profit[Product]=...;
 float Timeconsumption[Product][Machine]=...;
 int Number[Machine]=...;
 float Workhour=...;
 float Marketlimit[Product][Month]=...;
 float Maxstorage[Product]=...;
 float Storecost[Product]=...;
 float Initialstorage[Product]=...;
 float Finalstorage[Product]=...;
 
 int minMonth = min(i in Month) i; 
 int maxMonth = max(i in Month) i; 
 
 dvar float+ produce[Product][Month];
 dvar float+ sell[Product][Month];
 dvar int+ Downnumber[Machine][Month];
 dvar float+ Storage[Product][Month];
 
 
 maximize
 	sum(p in Product, m in Month)
 	  (Profit[p] * sell[p][m] - Storage[p][m] * Storecost[p] );
 	  
 subject to {
 	forall(ma in Machine)
 	  ctNumber:
 	  	sum( m in minMonth+1..maxMonth) 
 	  		Downnumber[ma][m]==Number[ma];
 	forall(ma in Machine, m in Month)
 	  ctWorkhour:
 	  	sum(p in Product)
 	  		produce[p][m]*Timeconsumption[p][ma]<=Workhour*(Number[ma]-Downnumber[ma][m]);
 	forall(p in Product, m in Month)
 	  ctMarketlimit:
 	  	sell[p][m]<=Marketlimit[p][m];
 	forall(p in Product, m in Month)  	
 	  ctMaxstorage:
 	  	Storage[p][m]<=Maxstorage[p];	
 	forall(p in Product, m in minMonth+1..maxMonth)
 	  	Storage[p][m]==Storage[p][m-1]+produce[p][m]-sell[p][m];
 	forall(p in Product)
 	  Storage[p][minMonth]==Initialstorage[p];
 	forall(p in Product)
 	  Storage[p][maxMonth]==Finalstorage[p];
 }