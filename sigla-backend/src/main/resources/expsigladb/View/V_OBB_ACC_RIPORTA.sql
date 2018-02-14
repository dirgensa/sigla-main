--------------------------------------------------------
--  DDL for View V_OBB_ACC_RIPORTA
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "V_OBB_ACC_RIPORTA" ("CD_CDS", "ESERCIZIO", "ESERCIZIO_ORI_ACC_OBB", "PG_ACC_OBB", "TI_GESTIONE", "CD_TIPO_DOCUMENTO_CONT", "CD_CDS_ORIGINE", "CD_UO_ORIGINE", "TI_APPARTENENZA", "CD_ELEMENTO_VOCE", "CD_VOCE", "CD_TERZO", "IM_ACC_OBB", "FL_PGIRO", "ESERCIZIO_COMPETENZA", "CD_CDS_ORI_RIPORTO", "ESERCIZIO_ORI_RIPORTO", "ESERCIZIO_ORI_ORI_RIPORTO", "PG_ACC_OBB_ORI_RIPORTO", "RIPORTATO", "PG_VER_REC") AS 
  SELECT
--
-- Date: 18/07/2006
-- Version: 1.3
--
-- Vista per l'estrazione dei documenti obb/acc riportabili
--
-- Per motivi di performance è stato usato il cd_cds dell'ente 999
-- in forma statica, senza andare in join con l'unità organizzativa
--
-- History:
--
-- Date: 26/06/2003
-- Version: 1.0
-- Creazione
--
-- Date: 08/01/2004
-- Version: 1.1
-- Estrazione capitolo voce_f per ricerca impegni/impegni residui
--
-- Date: 09/01/2004
-- Version: 1.2
-- Analisi di performance
--
-- Date: 18/07/2006
-- Version: 1.3
-- Gestione Impegni/Accertamenti Residui:
-- gestito il nuovo campo ESERCIZIO_ORIGINALE
--
-- Body:
--
 acc.CD_CDS,
 acc.ESERCIZIO,
 acc.ESERCIZIO_ORIGINALE,
 acc.PG_ACCERTAMENTO,
 acc.TI_GESTIONE,
 acc.CD_TIPO_DOCUMENTO_CONT,
 acc.CD_CDS_ORIGINE,
 acc.CD_UO_ORIGINE,
 acc.TI_APPARTENENZA,
 acc.CD_ELEMENTO_VOCE,
 acc.CD_VOCE,
 acc.CD_TERZO,
 acc.IM_ACCERTAMENTO,
 acc.FL_PGIRO,
 acc.ESERCIZIO_COMPETENZA,
 acc.CD_CDS_ORI_RIPORTO,
 acc.ESERCIZIO_ORI_RIPORTO,
 acc.ESERCIZIO_ORI_ORI_RIPORTO,
 acc.PG_ACCERTAMENTO_ORI_RIPORTO,
 acc.RIPORTATO,
 acc.PG_VER_REC
from accertamento acc
where ACC.PG_ACCERTAMENTO > 0 AND
     isEligibileRibalt_elenco('E',acc.cd_cds,acc.esercizio,acc.esercizio_originale,acc.pg_accertamento) = 'Y' And
-- CONTROLLA SE E' POSSIBILE PER IL CDS PORTARE AVANTI
(Select FL_RIPORTA_AVANTI From PARAMETRI_CDS PAR Where PAR.CD_CDS = acc.CD_CDS And PAR.ESERCIZIO = acc.ESERCIZIO) = 'Y'
union all
select
obb.CD_CDS,
obb.ESERCIZIO,
obb.ESERCIZIO_ORIGINALE,
obb.PG_OBBLIGAZIONE,
obb.TI_GESTIONE,
obb.CD_TIPO_DOCUMENTO_CONT,
obb.CD_CDS_ORIGINE,
obb.CD_UO_ORIGINE,
obb.TI_APPARTENENZA,
obb.CD_ELEMENTO_VOCE,
null,
obb.CD_TERZO,
obb.IM_OBBLIGAZIONE,
obb.FL_PGIRO,
obb.ESERCIZIO_COMPETENZA,
obb.CD_CDS_ORI_RIPORTO,
obb.ESERCIZIO_ORI_RIPORTO,
obb.ESERCIZIO_ORI_ORI_RIPORTO,
obb.PG_OBBLIGAZIONE_ORI_RIPORTO,
obb.RIPORTATO,
obb.PG_VER_REC
from obbligazione obb
where obb.PG_OBBLIGAZIONE > 0 AND
 cd_cds <> cnrctb020.getCdCdsEnte(obb.esercizio) and
 isEligibileRibalt_elenco('S',obb.cd_cds,obb.esercizio,obb.esercizio_originale,obb.pg_obbligazione) = 'Y' And
-- CONTROLLA SE E' POSSIBILE PER IL CDS PORTARE AVANTI
(Select FL_RIPORTA_AVANTI From PARAMETRI_CDS PAR Where PAR.CD_CDS = OBB.CD_CDS And PAR.ESERCIZIO = OBB.ESERCIZIO) = 'Y'
union all
select
obb.CD_CDS,
obb.ESERCIZIO,
obb.ESERCIZIO_ORIGINALE,
obb.PG_OBBLIGAZIONE,
obb.TI_GESTIONE,
obb.CD_TIPO_DOCUMENTO_CONT,
obb.CD_CDS_ORIGINE,
obb.CD_UO_ORIGINE,
obb.TI_APPARTENENZA,
obb.CD_ELEMENTO_VOCE,
obbsv.cd_voce,
obb.CD_TERZO,
obb.IM_OBBLIGAZIONE,
obb.FL_PGIRO,
obb.ESERCIZIO_COMPETENZA,
obb.CD_CDS_ORI_RIPORTO,
obb.ESERCIZIO_ORI_RIPORTO,
obb.ESERCIZIO_ORI_ORI_RIPORTO,
obb.PG_OBBLIGAZIONE_ORI_RIPORTO,
obb.RIPORTATO,
obb.PG_VER_REC
from obbligazione obb,
	 obbligazione_scad_voce obbsv
where
 obb.cd_cds = cnrctb020.getCdCdsEnte(obb.esercizio) and
 obb.PG_OBBLIGAZIONE > 0 AND
 isEligibileRibalt_elenco('S',obb.cd_cds,obb.esercizio,obb.esercizio_originale,obb.pg_obbligazione) = 'Y' And
-- CONTROLLA SE E' POSSIBILE PER IL CDS PORTARE AVANTI
(Select FL_RIPORTA_AVANTI From PARAMETRI_CDS PAR Where PAR.CD_CDS = OBB.CD_CDS And PAR.ESERCIZIO = OBB.ESERCIZIO) = 'Y' And
 obbsv.cd_cds = obb.cd_cds and
 obbsv.esercizio = obb.ESERCIZIO and
 obbsv.esercizio_originale = obb.esercizio_originale and
 obbsv.pg_obbligazione = obb.pg_obbligazione;
