--------------------------------------------------------
--  DDL for View V_CONS_MODULI_CONTRATTI
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "V_CONS_MODULI_CONTRATTI" ("CD_MODULO", "DS_MODULO", "CD_COMMESSA", "DS_COMMESSA", "CD_PROGETTO", "DS_PROGETTO", "ESERCIZIO_CONTRATTO_PADRE", "STATO_CONTRATTO_PADRE", "PG_CONTRATTO_PADRE", "ESERCIZIO_CONTRATTO", "STATO_CONTRATTO", "PG_CONTRATTO", "OGGETTO_CONTRATTO", "TOTALE_ENTRATE", "TOTALE_SPESE") AS 
  SELECT CD_MODULO, DS_MODULO, CD_COMMESSA, DS_COMMESSA, CD_PROGETTO, DS_PROGETTO, ESERCIZIO_CONTRATTO_PADRE,
 STATO_CONTRATTO_PADRE, PG_CONTRATTO_PADRE, ESERCIZIO_CONTRATTO, STATO_CONTRATTO, PG_CONTRATTO,
 OGGETTO_CONTRATTO, sum(TOTALE_ENTRATE), sum(TOTALE_SPESE)
FROM (select
--
-- Date: 09/11/2006
-- Version: 1.1
--
-- Vista per la consultazione del totale dei documenti contabili
-- per Commessa e Contratto
--
-- History:
--
-- Date: 18/04/2005
-- Version: 1.0
-- Creazione
--
-- Date: 09/11/2006
-- Version: 1.1
-- Aggiunta la selezione del progetto/commessa/modulo per anno
--
-- Body:
--
MODULO.CD_PROGETTO cd_MODULO,
MODULO.DS_PROGETTO ds_MODULO,
COMMESSA.CD_PROGETTO cd_commessa,
COMMESSA.DS_PROGETTO ds_commessa,
PROGETTO.CD_PROGETTO  CD_PROGETTO,
PROGETTO.DS_PROGETTO ds_progetto,
CONTRATTO_PADRE.ESERCIZIO ESERCIZIO_CONTRATTO_PADRE,
CONTRATTO_PADRE.STATO STATO_CONTRATTO_PADRE,
CONTRATTO_PADRE.PG_CONTRATTO pg_contratto_padre,
CONTRATTO.ESERCIZIO ESERCIZIO_CONTRATTO,
CONTRATTO.STATO STATO_CONTRATTO,
CONTRATTO.PG_CONTRATTO pg_contratto,
CONTRATTO.OGGETTO oggetto_contratto,
Sum(ACCERTAMENTO_SCAD_VOCE.IM_VOCE) TOTALE_ENTRATE,
0 TOTALE_SPESE
From PROGETTO_GEST PROGETTO, PROGETTO_GEST COMMESSA, PROGETTO_GEST MODULO, CONTRATTO, CONTRATTO CONTRATTO_PADRE,
     ACCERTAMENTO, ACCERTAMENTO_SCADENZARIO, ACCERTAMENTO_SCAD_VOCE, v_LINEA_ATTIVITA_valida
Where CONTRATTO.ESERCIZIO = ACCERTAMENTO.ESERCIZIO_CONTRATTO
  And CONTRATTO.PG_CONTRATTO = ACCERTAMENTO.PG_CONTRATTO
  And CONTRATTO.STATO = ACCERTAMENTO.STATO_CONTRATTO
  And ACCERTAMENTO.CD_CDS = ACCERTAMENTO_SCADENZARIO.CD_CDS
  And ACCERTAMENTO.ESERCIZIO = ACCERTAMENTO_SCADENZARIO.ESERCIZIO
	and Accertamento.ESERCIZIO_ORIGINALE = ACCERTAMENTO_SCADENZARIO.ESERCIZIO_ORIGINALE
	and Accertamento.ESERCIZIO = ACCERTAMENTO.ESERCIZIO_ORIGINALE
  And ACCERTAMENTO.PG_ACCERTAMENTO = ACCERTAMENTO_SCADENZARIO.PG_ACCERTAMENTO
  And ACCERTAMENTO_SCADENZARIO.CD_CDS = ACCERTAMENTO_SCAD_VOCE.CD_CDS
  And ACCERTAMENTO_SCADENZARIO.ESERCIZIO = ACCERTAMENTO_SCAD_VOCE.ESERCIZIO
  and ACCERTAMENTO_SCADENZARIO.ESERCIZIO_ORIGINALE = ACCERTAMENTO_SCAD_VOCE.ESERCIZIO_ORIGINALE
  And ACCERTAMENTO_SCADENZARIO.PG_ACCERTAMENTO = ACCERTAMENTO_SCAD_VOCE.PG_ACCERTAMENTO
  And ACCERTAMENTO_SCADENZARIO.PG_ACCERTAMENTO_SCADENZARIO = ACCERTAMENTO_SCAD_VOCE.PG_ACCERTAMENTO_SCADENZARIO
  And ACCERTAMENTO_SCAD_VOCE.CD_CENTRO_RESPONSABILITA = v_LINEA_ATTIVITA_valida.CD_CENTRO_RESPONSABILITA
  And ACCERTAMENTO_SCAD_VOCE.CD_LINEA_ATTIVITA = v_LINEA_ATTIVITA_valida.CD_LINEA_ATTIVITA
  And v_LINEA_ATTIVITA_valida.PG_PROGETTO = MODULO.PG_PROGETTO
  and v_LINEA_ATTIVITA_valida.esercizio = accertamento.esercizio
  And MODULO.ESERCIZIO = CONTRATTO.ESERCIZIO
  And MODULO.ESERCIZIO_PROGETTO_PADRE = COMMESSA.ESERCIZIO
  And MODULO.PG_PROGETTO_PADRE = COMMESSA.PG_PROGETTO
  And COMMESSA.ESERCIZIO_PROGETTO_PADRE = PROGETTO.ESERCIZIO
  And COMMESSA.PG_PROGETTO_PADRE = PROGETTO.PG_PROGETTO
  And CONTRATTO.ESERCIZIO_PADRE = CONTRATTO_PADRE.ESERCIZIO(+)
  And CONTRATTO.PG_CONTRATTO_PADRE = CONTRATTO_PADRE.PG_CONTRATTO(+)
Group By
MODULO.CD_PROGETTO,
MODULO.DS_PROGETTO,
COMMESSA.CD_PROGETTO,
COMMESSA.DS_PROGETTO,
PROGETTO.CD_PROGETTO,
PROGETTO.DS_PROGETTO,
CONTRATTO_PADRE.ESERCIZIO,
CONTRATTO_PADRE.STATO,
CONTRATTO_PADRE.PG_CONTRATTO,
CONTRATTO.ESERCIZIO,
CONTRATTO.STATO,
CONTRATTO.PG_CONTRATTO,
CONTRATTO.OGGETTO
Union All
Select
MODULO.CD_PROGETTO,
MODULO.DS_PROGETTO,
COMMESSA.CD_PROGETTO,
COMMESSA.DS_PROGETTO,
PROGETTO.CD_PROGETTO,
PROGETTO.DS_PROGETTO,
CONTRATTO_PADRE.ESERCIZIO,
CONTRATTO_PADRE.STATO,
CONTRATTO_PADRE.PG_CONTRATTO,
CONTRATTO.ESERCIZIO,
CONTRATTO.STATO,
CONTRATTO.PG_CONTRATTO,
CONTRATTO.OGGETTO,
0 TOTALE_ENTRATE,
Sum(OBBLIGAZIONE_SCAD_VOCE.IM_VOCE) TOTALE_SPESE
From PROGETTO_GEST PROGETTO, PROGETTO_GEST COMMESSA, PROGETTO_GEST MODULO, CONTRATTO, CONTRATTO CONTRATTO_PADRE,
     OBBLIGAZIONE, OBBLIGAZIONE_SCADENZARIO, OBBLIGAZIONE_SCAD_VOCE, v_LINEA_ATTIVITA_valida
Where CONTRATTO.ESERCIZIO = OBBLIGAZIONE.ESERCIZIO_CONTRATTO
  And CONTRATTO.PG_CONTRATTO = OBBLIGAZIONE.PG_CONTRATTO
  And CONTRATTO.STATO = OBBLIGAZIONE.STATO_CONTRATTO
  And OBBLIGAZIONE.CD_CDS = OBBLIGAZIONE_SCADENZARIO.CD_CDS
  And OBBLIGAZIONE.ESERCIZIO = OBBLIGAZIONE_SCADENZARIO.ESERCIZIO
  And OBBLIGAZIONE.PG_OBBLIGAZIONE = OBBLIGAZIONE_SCADENZARIO.PG_OBBLIGAZIONE
  and OBBLIGAZIONE.ESERCIZIO_ORIGINALE = OBBLIGAZIONE_SCADENZARIO.ESERCIZIO_ORIGINALE
	and (OBBLIGAZIONE.ESERCIZIO = OBBLIGAZIONE.ESERCIZIO_ORIGINALE  or
			obbligazione.cd_tipo_documento_cont ='OBB_RESIM')
  And OBBLIGAZIONE_SCADENZARIO.CD_CDS = OBBLIGAZIONE_SCAD_VOCE.CD_CDS
  And OBBLIGAZIONE_SCADENZARIO.ESERCIZIO = OBBLIGAZIONE_SCAD_VOCE.ESERCIZIO
  and OBBLIGAZIONE_SCADENZARIO.ESERCIZIO_ORIGINALE = OBBLIGAZIONE_SCAD_VOCE.ESERCIZIO_ORIGINALE
  And OBBLIGAZIONE_SCADENZARIO.PG_OBBLIGAZIONE = OBBLIGAZIONE_SCAD_VOCE.PG_OBBLIGAZIONE
  And OBBLIGAZIONE_SCADENZARIO.PG_OBBLIGAZIONE_SCADENZARIO = OBBLIGAZIONE_SCAD_VOCE.PG_OBBLIGAZIONE_SCADENZARIO
  And OBBLIGAZIONE_SCAD_VOCE.CD_CENTRO_RESPONSABILITA = v_LINEA_ATTIVITA_valida.CD_CENTRO_RESPONSABILITA
  And OBBLIGAZIONE_SCAD_VOCE.CD_LINEA_ATTIVITA = v_LINEA_ATTIVITA_valida.CD_LINEA_ATTIVITA
  And v_LINEA_ATTIVITA_valida.PG_PROGETTO = MODULO.PG_PROGETTO
  and v_LINEA_ATTIVITA_valida.esercizio = obbligazione.esercizio
  And MODULO.ESERCIZIO = CONTRATTO.ESERCIZIO
  And MODULO.ESERCIZIO_PROGETTO_PADRE = COMMESSA.ESERCIZIO
  And MODULO.PG_PROGETTO_PADRE = COMMESSA.PG_PROGETTO
  And COMMESSA.ESERCIZIO_PROGETTO_PADRE = PROGETTO.ESERCIZIO
  And COMMESSA.PG_PROGETTO_PADRE = PROGETTO.PG_PROGETTO
  And CONTRATTO.ESERCIZIO_PADRE = CONTRATTO_PADRE.ESERCIZIO(+)
  And CONTRATTO.PG_CONTRATTO_PADRE = CONTRATTO_PADRE.PG_CONTRATTO(+)
Group By
MODULO.CD_PROGETTO,
MODULO.DS_PROGETTO,
COMMESSA.CD_PROGETTO,
COMMESSA.DS_PROGETTO,
PROGETTO.CD_PROGETTO,
PROGETTO.DS_PROGETTO,
CONTRATTO_PADRE.ESERCIZIO,
CONTRATTO_PADRE.STATO,
CONTRATTO_PADRE.PG_CONTRATTO,
CONTRATTO.ESERCIZIO,
CONTRATTO.STATO,
CONTRATTO.PG_CONTRATTO,
CONTRATTO.OGGETTO)
group by CD_MODULO, DS_MODULO, CD_COMMESSA, DS_COMMESSA, CD_PROGETTO, DS_PROGETTO, ESERCIZIO_CONTRATTO_PADRE,
 STATO_CONTRATTO_PADRE, PG_CONTRATTO_PADRE, ESERCIZIO_CONTRATTO, STATO_CONTRATTO, PG_CONTRATTO,
 OGGETTO_CONTRATTO;
