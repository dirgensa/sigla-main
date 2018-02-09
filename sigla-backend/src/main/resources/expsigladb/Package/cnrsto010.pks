CREATE OR REPLACE package         CNRSTO010 as
--
-- CNRSTO010 - Package per la gestione dello storico contratto
-- Date: 28/07/2017
-- Version: 1.0
--
 procedure scaricaSuStorico( aPgStorico number, aDsStorico varchar2, aOld contratto%rowtype);
End;
/


CREATE OR REPLACE package body  CNRSTO010 is
procedure scaricaSuStorico (aPgStorico number, aDsStorico varchar2, aOld contratto%rowtype) is
  begin
Insert into CONTRATTO_S
   (ESERCIZIO              		 ,
		STATO                  		 ,
		PG_CONTRATTO           		 ,
		ESERCIZIO_PADRE        		 ,
		STATO_PADRE            		 ,
		PG_CONTRATTO_PADRE     		 ,
		CD_UNITA_ORGANIZZATIVA 		 ,
		DT_REGISTRAZIONE       		 ,
		FIG_GIUR_INT           		 ,
		CD_TERZO_RESP          		 ,
		CD_TERZO_FIRMATARIO    		 ,
		FIG_GIUR_EST           		 ,
		RESP_ESTERNO           		 ,
		NATURA_CONTABILE       		 ,
		CD_TIPO_CONTRATTO      		 ,
		CD_PROC_AMM            		 ,
		OGGETTO                		 ,
		CD_PROTOCOLLO          		 ,
		DT_STIPULA             		 ,
		DT_INIZIO_VALIDITA     		 ,
		DT_FINE_VALIDITA       		 ,
		DT_PROROGA             		 ,
		IM_CONTRATTO_ATTIVO    		 ,
		IM_CONTRATTO_PASSIVO   		 ,
		CD_TIPO_ATTO           		 ,
		DS_ATTO_NON_DEFINITO   		 ,
		DS_ATTO                		 ,
		CD_ORGANO              		 ,
		DS_ORGANO_NON_DEFINITO 		 ,
		DT_ANNULLAMENTO        		 ,
		DS_ANNULLAMENTO        		 ,
		CD_TIPO_ATTO_ANN       		 ,
		DS_ATTO_ANN_NON_DEFINITO 	 ,
		DS_ATTO_ANN            		 ,
		CD_ORGANO_ANN          		 ,
		DS_ORGANO_ANN_NON_DEFINITO ,
		ESERCIZIO_PROTOCOLLO  		 ,
		CD_PROTOCOLLO_GENERALE		 ,
		FL_ART82              		 ,
		DACR                  		 ,
		UTCR                  		 ,
		DUVA                  		 ,
		UTUV                  		 ,
		PG_VER_REC            		 ,
		CD_TIPO_NORMA_PERLA   		 ,
		DIRETTORE             		 ,
		FL_MEPA               		 ,
		FL_PUBBLICA_CONTRATTO 		 ,
		CD_CIG                		 ,
		CD_CUP                		 ,
		CD_CIG_FATTURA_ATTIVA 		 ,
		PG_STORICO_,
		DS_STORICO_)
 Values
   (aOld.ESERCIZIO             ,
		aOld.STATO                 ,
		aOld.PG_CONTRATTO          ,
		aOld.ESERCIZIO_PADRE       ,
		aOld.STATO_PADRE           ,
		aOld.PG_CONTRATTO_PADRE    ,
		aOld.CD_UNITA_ORGANIZZATIVA,
		aOld.DT_REGISTRAZIONE      ,
		aOld.FIG_GIUR_INT          ,
		aOld.CD_TERZO_RESP         ,
		aOld.CD_TERZO_FIRMATARIO   ,
		aOld.FIG_GIUR_EST          ,
		aOld.RESP_ESTERNO          ,
		aOld.NATURA_CONTABILE      ,
		aOld.CD_TIPO_CONTRATTO     ,
		aOld.CD_PROC_AMM           ,
		aOld.OGGETTO               ,
		aOld.CD_PROTOCOLLO         ,
		aOld.DT_STIPULA            ,
		aOld.DT_INIZIO_VALIDITA    ,
		aOld.DT_FINE_VALIDITA      ,
		aOld.DT_PROROGA            ,
		aOld.IM_CONTRATTO_ATTIVO   ,
		aOld.IM_CONTRATTO_PASSIVO  ,
		aOld.CD_TIPO_ATTO          ,
		aOld.DS_ATTO_NON_DEFINITO  ,
		aOld.DS_ATTO               ,
		aOld.CD_ORGANO             ,
		aOld.DS_ORGANO_NON_DEFINITO,
		aOld.DT_ANNULLAMENTO       ,
		aOld.DS_ANNULLAMENTO       ,
		aOld.CD_TIPO_ATTO_ANN      ,
		aOld.DS_ATTO_ANN_NON_DEFINITO,
		aOld.DS_ATTO_ANN           ,
		aOld.CD_ORGANO_ANN         ,
		aOld.DS_ORGANO_ANN_NON_DEFINITO,
		aOld.ESERCIZIO_PROTOCOLLO  ,
		aOld.CD_PROTOCOLLO_GENERALE,
		aOld.FL_ART82              ,
		aOld.DACR                  ,
		aOld.UTCR                  ,
		aOld.DUVA                  ,
		aOld.UTUV                  ,
		aOld.PG_VER_REC            ,
		aOld.CD_TIPO_NORMA_PERLA   ,
		aOld.DIRETTORE             ,
		aOld.FL_MEPA               ,
		aOld.FL_PUBBLICA_CONTRATTO ,
		aOld.CD_CIG                ,
		aOld.CD_CUP                ,
		aOld.CD_CIG_FATTURA_ATTIVA ,
		aPgStorico,
		aDsStorico);
 end;
end;
/


