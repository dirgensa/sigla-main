--------------------------------------------------------
--  DDL for View V_CONS_OBBL_ACC_CONTRATTI
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "V_CONS_OBBL_ACC_CONTRATTI" ("TIPO", "ESERCIZIO_COMPETENZA", "CD_UNITA_ORGANIZZATIVA", "ESERCIZIO_ORIGINALE", "PG_DOC", "DT_REGISTRAZIONE", "DS_DOC", "CD_TERZO", "CD_ELEMENTO_VOCE", "CD_COMMESSA", "DS_COMMESSA", "ESERCIZIO_CONTRATTO_PADRE", "STATO_CONTRATTO_PADRE", "PG_CONTRATTO_PADRE", "ESERCIZIO_CONTRATTO", "STATO_CONTRATTO", "PG_CONTRATTO", "OGGETTO_CONTRATTO", "IM_ACCERTAMENTO", "IM_OBBLIGAZIONE") AS 
  SELECT
--
-- Date: 09/11/2006
-- Version: 1.2
--
-- Vista per la consultazione dei Documenti Contabili associati a un contratto
--
-- History:
--
-- Date: 19/04/2005
-- Version: 1.0
-- Creazione
--
-- Date: 18/07/2006
-- Version: 1.1
-- Gestione Impegni/Accertamenti Residui:
-- gestito il nuovo campo ESERCIZIO_ORIGINALE
--
-- Date: 09/11/2006
-- Version: 1.2
-- Aggiunta la selezione del progetto/commessa/modulo per anno
--
-- Body:
--
'ETR' TIPO,
ACCERTAMENTO.ESERCIZIO_COMPETENZA,
ACCERTAMENTO.CD_UNITA_ORGANIZZATIVA,
ACCERTAMENTO.ESERCIZIO_ORIGINALE,
ACCERTAMENTO.PG_ACCERTAMENTO,
ACCERTAMENTO.DT_REGISTRAZIONE,
ACCERTAMENTO.DS_ACCERTAMENTO,
ACCERTAMENTO.CD_TERZO,
ACCERTAMENTO.CD_ELEMENTO_VOCE,
COMMESSA.CD_PROGETTO,
COMMESSA.DS_PROGETTO,
CONTRATTO_PADRE.ESERCIZIO,
CONTRATTO_PADRE.STATO,
CONTRATTO_PADRE.PG_CONTRATTO,
CONTRATTO.ESERCIZIO,
CONTRATTO.STATO,
CONTRATTO.PG_CONTRATTO,
CONTRATTO.OGGETTO,
Sum(ACCERTAMENTO_SCAD_VOCE.IM_VOCE) TOTALE_ENTRATE,
0 TOTALE_SPESE
From PROGETTO_GEST COMMESSA, PROGETTO_GEST MODULO, CONTRATTO, CONTRATTO CONTRATTO_PADRE,
     ACCERTAMENTO, ACCERTAMENTO_SCADENZARIO, ACCERTAMENTO_SCAD_VOCE, v_LINEA_ATTIVITA_valida
Where CONTRATTO.ESERCIZIO = ACCERTAMENTO.ESERCIZIO_CONTRATTO
  And CONTRATTO.STATO = ACCERTAMENTO.STATO_CONTRATTO
  And CONTRATTO.PG_CONTRATTO = ACCERTAMENTO.PG_CONTRATTO
  And ACCERTAMENTO.CD_CDS = ACCERTAMENTO_SCADENZARIO.CD_CDS
  And ACCERTAMENTO.ESERCIZIO = ACCERTAMENTO_SCADENZARIO.ESERCIZIO
  And ACCERTAMENTO.ESERCIZIO_ORIGINALE = ACCERTAMENTO_SCADENZARIO.ESERCIZIO_ORIGINALE
  And ACCERTAMENTO.PG_ACCERTAMENTO = ACCERTAMENTO_SCADENZARIO.PG_ACCERTAMENTO
  	AND (accertamento.esercizio_originale =accertamento.esercizio
                       or (accertamento.cd_tipo_documento_cont ='ACC_RES' and
                       not exists (select 1 from accertamento acc where
                		accertamento.CD_CDS = acc.CD_CDS
             			And accertamento.ESERCIZIO > acc.ESERCIZIO
             			And accertamento.ESERCIZIO_ORIGINALE = acc.ESERCIZIO_ORIGINALE
             			And accertamento.PG_accertamento = acc.PG_accertamento
             			and accertamento.ESERCIZIO_contratto = acc.ESERCIZIO_CONTRATTO
             			And accertamento.STATO_CONTRATTO = acc.STATO_CONTRATTO
             			And accertamento.PG_CONTRATTO = acc.PG_CONTRATTO)))
  And ACCERTAMENTO_SCADENZARIO.CD_CDS = ACCERTAMENTO_SCAD_VOCE.CD_CDS
  And ACCERTAMENTO_SCADENZARIO.ESERCIZIO = ACCERTAMENTO_SCAD_VOCE.ESERCIZIO
  And ACCERTAMENTO_SCADENZARIO.ESERCIZIO_ORIGINALE = ACCERTAMENTO_SCAD_VOCE.ESERCIZIO_ORIGINALE
  And ACCERTAMENTO_SCADENZARIO.PG_ACCERTAMENTO = ACCERTAMENTO_SCAD_VOCE.PG_ACCERTAMENTO
  And ACCERTAMENTO_SCADENZARIO.PG_ACCERTAMENTO_SCADENZARIO = ACCERTAMENTO_SCAD_VOCE.PG_ACCERTAMENTO_SCADENZARIO
  And ACCERTAMENTO_SCAD_VOCE.CD_CENTRO_RESPONSABILITA = v_LINEA_ATTIVITA_valida.CD_CENTRO_RESPONSABILITA
  And ACCERTAMENTO_SCAD_VOCE.CD_LINEA_ATTIVITA = v_LINEA_ATTIVITA_valida.CD_LINEA_ATTIVITA
  and v_LINEA_ATTIVITA_valida.esercizio =  ACCERTAMENTO.ESERCIZIO
  And v_LINEA_ATTIVITA_valida.PG_PROGETTO = MODULO.PG_PROGETTO(+)
  And (MODULO.ESERCIZIO Is Null Or MODULO.ESERCIZIO = ACCERTAMENTO.ESERCIZIO)
  And MODULO.ESERCIZIO_PROGETTO_PADRE = COMMESSA.ESERCIZIO(+)
  And MODULO.PG_PROGETTO_PADRE = COMMESSA.PG_PROGETTO(+)
  And CONTRATTO.ESERCIZIO_PADRE = CONTRATTO_PADRE.ESERCIZIO(+)
  And CONTRATTO.PG_CONTRATTO_PADRE = CONTRATTO_PADRE.PG_CONTRATTO(+)
Group By
'ETR',
ACCERTAMENTO.ESERCIZIO_COMPETENZA,
ACCERTAMENTO.CD_UNITA_ORGANIZZATIVA,
ACCERTAMENTO.ESERCIZIO_ORIGINALE,
ACCERTAMENTO.PG_ACCERTAMENTO,
ACCERTAMENTO.DT_REGISTRAZIONE,
ACCERTAMENTO.DS_ACCERTAMENTO,
ACCERTAMENTO.CD_TERZO,
ACCERTAMENTO.CD_ELEMENTO_VOCE,
COMMESSA.CD_PROGETTO,
COMMESSA.DS_PROGETTO,
CONTRATTO_PADRE.ESERCIZIO,
CONTRATTO_PADRE.STATO,
CONTRATTO_PADRE.PG_CONTRATTO,
CONTRATTO.ESERCIZIO,
CONTRATTO.STATO,
CONTRATTO.PG_CONTRATTO,
CONTRATTO.OGGETTO
union ALL
select
'ETR' TIPO,
ACCERTAMENTO.ESERCIZIO_COMPETENZA,
ACCERTAMENTO.CD_UNITA_ORGANIZZATIVA,
ACCERTAMENTO.ESERCIZIO_ORIGINALE,
ACCERTAMENTO.PG_ACCERTAMENTO,
ACCERTAMENTO.DT_REGISTRAZIONE,
ACCERTAMENTO.DS_ACCERTAMENTO,
ACCERTAMENTO.CD_TERZO,
ACCERTAMENTO.CD_ELEMENTO_VOCE,
COMMESSA.CD_PROGETTO,
COMMESSA.DS_PROGETTO,
CONTRATTO_PADRE.ESERCIZIO,
CONTRATTO_PADRE.STATO,
CONTRATTO_PADRE.PG_CONTRATTO,
CONTRATTO.ESERCIZIO,
CONTRATTO.STATO,
CONTRATTO.PG_CONTRATTO,
CONTRATTO.OGGETTO,
Sum(ACCERTAMENTO_MOD_VOCE.im_modifica) TOTALE_ENTRATE,
0 TOTALE_SPESE
From PROGETTO_GEST COMMESSA, PROGETTO_GEST MODULO, CONTRATTO, CONTRATTO CONTRATTO_PADRE,
     ACCERTAMENTO, accertamento_modifica, ACCERTAMENTO_MOD_VOCE, v_LINEA_ATTIVITA_valida
Where CONTRATTO.ESERCIZIO = ACCERTAMENTO.ESERCIZIO_CONTRATTO
  And CONTRATTO.STATO = ACCERTAMENTO.STATO_CONTRATTO
  And CONTRATTO.PG_CONTRATTO = ACCERTAMENTO.PG_CONTRATTO
  and accertamento.cd_cds = accertamento_modifica.cd_cds
  AND accertamento.esercizio = accertamento_modifica.esercizio
  AND accertamento.esercizio_originale = accertamento_modifica.esercizio_originale
	AND accertamento.pg_accertamento =  accertamento_modifica.pg_accertamento
  AND accertamento_modifica.cd_cds = accertamento_mod_voce.cd_cds
  AND accertamento_modifica.esercizio = accertamento_mod_voce.esercizio
  AND accertamento_modifica.pg_modifica = accertamento_mod_voce.pg_modifica
  And accertamento_mod_voce.CD_CENTRO_RESPONSABILITA = v_LINEA_ATTIVITA_valida.CD_CENTRO_RESPONSABILITA
  And accertamento_mod_voce.CD_LINEA_ATTIVITA = v_LINEA_ATTIVITA_valida.CD_LINEA_ATTIVITA
  AND exists(select 1 from ACCERTAMENTO acc where
                ACCERTAMENTO.CD_CDS = acc.CD_CDS
             --And ACCERTAMENTO.ESERCIZIO = acc.ESERCIZIO
             And ACCERTAMENTO.ESERCIZIO_ORIGINALE = acc.ESERCIZIO_ORIGINALE
             And ACCERTAMENTO.pg_accertamento = acc.pg_accertamento
             and ACCERTAMENTO.ESERCIZIO_contratto = acc.ESERCIZIO_CONTRATTO
             And ACCERTAMENTO.STATO_contratto = acc.STATO_CONTRATTO
             And ACCERTAMENTO.PG_CONTRATTO = acc.PG_CONTRATTO
             and acc.ESERCIZIO = acc.ESERCIZIO_ORIGINALE )
  And v_LINEA_ATTIVITA_valida.PG_PROGETTO = MODULO.PG_PROGETTO(+)
  and v_LINEA_ATTIVITA_valida.esercizio = ACCERTAMENTO.esercizio
  And (MODULO.ESERCIZIO Is Null Or MODULO.ESERCIZIO = ACCERTAMENTO.ESERCIZIO)
  And MODULO.ESERCIZIO_PROGETTO_PADRE = COMMESSA.ESERCIZIO(+)
  And MODULO.PG_PROGETTO_PADRE = COMMESSA.PG_PROGETTO(+)
  And CONTRATTO.ESERCIZIO_PADRE = CONTRATTO_PADRE.ESERCIZIO(+)
  And CONTRATTO.PG_CONTRATTO_PADRE = CONTRATTO_PADRE.PG_CONTRATTO(+)
Group By
'ETR',
ACCERTAMENTO.ESERCIZIO_COMPETENZA,
ACCERTAMENTO.CD_UNITA_ORGANIZZATIVA,
ACCERTAMENTO.ESERCIZIO_ORIGINALE,
ACCERTAMENTO.PG_ACCERTAMENTO,
ACCERTAMENTO.DT_REGISTRAZIONE,
ACCERTAMENTO.DS_ACCERTAMENTO,
ACCERTAMENTO.CD_TERZO,
ACCERTAMENTO.CD_ELEMENTO_VOCE,
COMMESSA.CD_PROGETTO,
COMMESSA.DS_PROGETTO,
CONTRATTO_PADRE.ESERCIZIO,
CONTRATTO_PADRE.STATO,
CONTRATTO_PADRE.PG_CONTRATTO,
CONTRATTO.ESERCIZIO,
CONTRATTO.STATO,
CONTRATTO.PG_CONTRATTO,
CONTRATTO.OGGETTO
Union All
Select
'SPE' TIPO,
OBBLIGAZIONE.ESERCIZIO_COMPETENZA,
OBBLIGAZIONE.CD_UNITA_ORGANIZZATIVA,
OBBLIGAZIONE.ESERCIZIO_ORIGINALE,
OBBLIGAZIONE.PG_OBBLIGAZIONE,
OBBLIGAZIONE.DT_REGISTRAZIONE,
OBBLIGAZIONE.DS_OBBLIGAZIONE,
OBBLIGAZIONE.CD_TERZO,
OBBLIGAZIONE.CD_ELEMENTO_VOCE,
COMMESSA.CD_PROGETTO,
COMMESSA.DS_PROGETTO,
CONTRATTO_PADRE.ESERCIZIO,
CONTRATTO_PADRE.STATO,
CONTRATTO_PADRE.PG_CONTRATTO,
CONTRATTO.ESERCIZIO,
CONTRATTO.STATO,
CONTRATTO.PG_CONTRATTO,
CONTRATTO.OGGETTO,
0 TOTALE_ENTRATE,
Sum(OBBLIGAZIONE_SCAD_VOCE.IM_VOCE) TOTALE_SPESE
From PROGETTO_GEST COMMESSA, PROGETTO_GEST MODULO, CONTRATTO, CONTRATTO CONTRATTO_PADRE,
     OBBLIGAZIONE, OBBLIGAZIONE_SCADENZARIO, OBBLIGAZIONE_SCAD_VOCE, v_LINEA_ATTIVITA_valida
Where CONTRATTO.ESERCIZIO = OBBLIGAZIONE.ESERCIZIO_CONTRATTO
  And CONTRATTO.STATO = OBBLIGAZIONE.STATO_CONTRATTO
  And CONTRATTO.PG_CONTRATTO = OBBLIGAZIONE.PG_CONTRATTO
  And OBBLIGAZIONE.CD_CDS = OBBLIGAZIONE_SCADENZARIO.CD_CDS
  And OBBLIGAZIONE.ESERCIZIO = OBBLIGAZIONE_SCADENZARIO.ESERCIZIO
  And OBBLIGAZIONE.ESERCIZIO_ORIGINALE = OBBLIGAZIONE_SCADENZARIO.ESERCIZIO_ORIGINALE
  And OBBLIGAZIONE.PG_OBBLIGAZIONE = OBBLIGAZIONE_SCADENZARIO.PG_OBBLIGAZIONE
  AND (obbligazione.esercizio_originale =obbligazione.esercizio
                       or obbligazione.cd_tipo_documento_cont ='OBB_RESIM'
                       or (obbligazione.cd_tipo_documento_cont ='OBB_RES' and
                       not exists (select 1 from obbligazione obb where
                		OBBLIGAZIONE.CD_CDS = obb.CD_CDS
             			And OBBLIGAZIONE.ESERCIZIO > obb.ESERCIZIO
             			And OBBLIGAZIONE.ESERCIZIO_ORIGINALE = obb.ESERCIZIO_ORIGINALE
             			And OBBLIGAZIONE.PG_OBBLIGAZIONE = obb.PG_OBBLIGAZIONE
             			and OBBLIGAZIONE.ESERCIZIO_contratto = obb.ESERCIZIO_CONTRATTO
             			And OBBLIGAZIONE.STATO_CONTRATTO = obb.STATO_CONTRATTO
             			And OBBLIGAZIONE.PG_CONTRATTO = obb.PG_CONTRATTO)))
  And OBBLIGAZIONE_SCADENZARIO.CD_CDS = OBBLIGAZIONE_SCAD_VOCE.CD_CDS
  And OBBLIGAZIONE_SCADENZARIO.ESERCIZIO = OBBLIGAZIONE_SCAD_VOCE.ESERCIZIO
  And OBBLIGAZIONE_SCADENZARIO.ESERCIZIO_ORIGINALE = OBBLIGAZIONE_SCAD_VOCE.ESERCIZIO_ORIGINALE
  And OBBLIGAZIONE_SCADENZARIO.PG_OBBLIGAZIONE = OBBLIGAZIONE_SCAD_VOCE.PG_OBBLIGAZIONE
  And OBBLIGAZIONE_SCADENZARIO.PG_OBBLIGAZIONE_SCADENZARIO = OBBLIGAZIONE_SCAD_VOCE.PG_OBBLIGAZIONE_SCADENZARIO
  And OBBLIGAZIONE_SCAD_VOCE.CD_CENTRO_RESPONSABILITA = v_LINEA_ATTIVITA_valida.CD_CENTRO_RESPONSABILITA
  And OBBLIGAZIONE_SCAD_VOCE.CD_LINEA_ATTIVITA = v_LINEA_ATTIVITA_valida.CD_LINEA_ATTIVITA
  And v_LINEA_ATTIVITA_valida.PG_PROGETTO = MODULO.PG_PROGETTO(+)
  and v_LINEA_ATTIVITA_valida.esercizio = OBBLIGAZIONE.ESERCIZIO
  And (MODULO.ESERCIZIO Is Null Or MODULO.ESERCIZIO = OBBLIGAZIONE.ESERCIZIO)
  And MODULO.ESERCIZIO_PROGETTO_PADRE = COMMESSA.ESERCIZIO(+)
  And MODULO.PG_PROGETTO_PADRE = COMMESSA.PG_PROGETTO(+)
  And CONTRATTO.ESERCIZIO_PADRE = CONTRATTO_PADRE.ESERCIZIO(+)
  And CONTRATTO.PG_CONTRATTO_PADRE = CONTRATTO_PADRE.PG_CONTRATTO(+)
Group By
'SPE',
OBBLIGAZIONE.ESERCIZIO_COMPETENZA,
OBBLIGAZIONE.CD_UNITA_ORGANIZZATIVA,
OBBLIGAZIONE.ESERCIZIO_ORIGINALE,
OBBLIGAZIONE.PG_OBBLIGAZIONE,
OBBLIGAZIONE.DT_REGISTRAZIONE,
OBBLIGAZIONE.DS_OBBLIGAZIONE,
OBBLIGAZIONE.CD_TERZO,
OBBLIGAZIONE.CD_ELEMENTO_VOCE,
COMMESSA.CD_PROGETTO,
COMMESSA.DS_PROGETTO,
CONTRATTO_PADRE.ESERCIZIO,
CONTRATTO_PADRE.STATO,
CONTRATTO_PADRE.PG_CONTRATTO,
CONTRATTO.ESERCIZIO,
CONTRATTO.STATO,
CONTRATTO.PG_CONTRATTO,
CONTRATTO.OGGETTO
union all
Select
'SPE' TIPO,
OBBLIGAZIONE.ESERCIZIO_COMPETENZA,
OBBLIGAZIONE.CD_UNITA_ORGANIZZATIVA,
OBBLIGAZIONE.ESERCIZIO_ORIGINALE,
OBBLIGAZIONE.PG_OBBLIGAZIONE,
OBBLIGAZIONE.DT_REGISTRAZIONE,
OBBLIGAZIONE.DS_OBBLIGAZIONE,
OBBLIGAZIONE.CD_TERZO,
OBBLIGAZIONE.CD_ELEMENTO_VOCE,
COMMESSA.CD_PROGETTO,
COMMESSA.DS_PROGETTO,
CONTRATTO_PADRE.ESERCIZIO,
CONTRATTO_PADRE.STATO,
CONTRATTO_PADRE.PG_CONTRATTO,
CONTRATTO.ESERCIZIO,
CONTRATTO.STATO,
CONTRATTO.PG_CONTRATTO,
CONTRATTO.OGGETTO,
0 TOTALE_ENTRATE,
Sum(OBBLIGAZIONE_MOD_VOCE.im_modifica) TOTALE_SPESE
From PROGETTO_GEST COMMESSA, PROGETTO_GEST MODULO, CONTRATTO, CONTRATTO CONTRATTO_PADRE,
     OBBLIGAZIONE, OBBLIGAZIONE_modifica, OBBLIGAZIONE_mod_VOCE, v_LINEA_ATTIVITA_valida
Where CONTRATTO.ESERCIZIO = OBBLIGAZIONE.ESERCIZIO_CONTRATTO
  And CONTRATTO.STATO = OBBLIGAZIONE.STATO_CONTRATTO
  And CONTRATTO.PG_CONTRATTO = OBBLIGAZIONE.PG_CONTRATTO
  AND obbligazione.cd_cds = obbligazione_modifica.cd_cds
  AND obbligazione.esercizio = obbligazione_modifica.esercizio
  AND obbligazione.esercizio_originale =obbligazione_modifica.esercizio_originale
  AND obbligazione.pg_obbligazione = obbligazione_modifica.pg_obbligazione
  AND obbligazione_modifica.cd_cds = obbligazione_mod_voce.cd_cds
  AND obbligazione_modifica.esercizio = obbligazione_mod_voce.esercizio
  AND obbligazione_modifica.pg_modifica = obbligazione_mod_voce.pg_modifica
  -- per evitare che prende le variazioni su impegni già diminuiti nell'importo sull'obbligazione collegato al contratto
  AND exists(select 1 from obbligazione obb where
                OBBLIGAZIONE.CD_CDS = obb.CD_CDS
             --And OBBLIGAZIONE.ESERCIZIO = obb.ESERCIZIO
             And OBBLIGAZIONE.ESERCIZIO_ORIGINALE = obb.ESERCIZIO_ORIGINALE
             And OBBLIGAZIONE.PG_OBBLIGAZIONE = obb.PG_OBBLIGAZIONE
             and OBBLIGAZIONE.ESERCIZIO_contratto = obb.ESERCIZIO_CONTRATTO
             And OBBLIGAZIONE.STATO_CONTRATTO = obb.STATO_CONTRATTO
             And OBBLIGAZIONE.PG_CONTRATTO = obb.PG_CONTRATTO
             and (obb.ESERCIZIO = obb.ESERCIZIO_ORIGINALE or
								 obb.cd_tipo_documento_cont ='OBB_RESIM'))
  And OBBLIGAZIONE_mod_VOCE.CD_CENTRO_RESPONSABILITA = v_LINEA_ATTIVITA_valida.CD_CENTRO_RESPONSABILITA
  And OBBLIGAZIONE_mod_VOCE.CD_LINEA_ATTIVITA = v_LINEA_ATTIVITA_valida.CD_LINEA_ATTIVITA
  And v_LINEA_ATTIVITA_valida.PG_PROGETTO = MODULO.PG_PROGETTO(+)
  and v_LINEA_ATTIVITA_valida.esercizio =  OBBLIGAZIONE.ESERCIZIO
  And (MODULO.ESERCIZIO Is Null Or MODULO.ESERCIZIO = OBBLIGAZIONE.ESERCIZIO)
  And MODULO.ESERCIZIO_PROGETTO_PADRE = COMMESSA.ESERCIZIO(+)
  And MODULO.PG_PROGETTO_PADRE = COMMESSA.PG_PROGETTO(+)
  And CONTRATTO.ESERCIZIO_PADRE = CONTRATTO_PADRE.ESERCIZIO(+)
  And CONTRATTO.PG_CONTRATTO_PADRE = CONTRATTO_PADRE.PG_CONTRATTO(+)
Group By
'SPE',
OBBLIGAZIONE.ESERCIZIO_COMPETENZA,
OBBLIGAZIONE.CD_UNITA_ORGANIZZATIVA,
OBBLIGAZIONE.ESERCIZIO_ORIGINALE,
OBBLIGAZIONE.PG_OBBLIGAZIONE,
OBBLIGAZIONE.DT_REGISTRAZIONE,
OBBLIGAZIONE.DS_OBBLIGAZIONE,
OBBLIGAZIONE.CD_TERZO,
OBBLIGAZIONE.CD_ELEMENTO_VOCE,
COMMESSA.CD_PROGETTO,
COMMESSA.DS_PROGETTO,
CONTRATTO_PADRE.ESERCIZIO,
CONTRATTO_PADRE.STATO,
CONTRATTO_PADRE.PG_CONTRATTO,
CONTRATTO.ESERCIZIO,
CONTRATTO.STATO,
CONTRATTO.PG_CONTRATTO,
CONTRATTO.OGGETTO;
