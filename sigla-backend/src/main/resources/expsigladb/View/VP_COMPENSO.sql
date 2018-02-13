--------------------------------------------------------
--  DDL for View VP_COMPENSO
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "VP_COMPENSO" ("CD_CDS", "CD_UNITA_ORGANIZZATIVA", "ESERCIZIO", "PG_COMPENSO", "DS_COMPENSO", "DT_REGISTRAZIONE", "DT_DA_COMPETENZA_COGE", "DT_A_COMPETENZA_COGE", "FL_COMPENSO_CONGUAGLIO", "FL_SENZA_CALCOLI", "IM_LORDO_PERCIPIENTE", "IM_NETTO_PERCIPIENTE", "DETRAZIONE_ALTRI_NETTO", "DETRAZIONE_CONIUGE_NETTO", "DETRAZIONE_FIGLI_NETTO", "DETRAZIONI_LA_NETTO", "DETRAZIONI_PERSONALI_NETTO", "IM_DEDUZIONE_IRPEF", "CD_TERZO", "NOME", "COGNOME", "RAGIONE_SOCIALE", "CODICE_FISCALE", "PARTITA_IVA", "ESERCIZIO_ORI_OBBLIGAZIONE", "PG_OBBLIGAZIONE", "CD_TRATTAMENTO", "DS_TI_TRATTAMENTO", "CD_ANAG", "TI_ITALIANO_ESTERO", "TI_ENTITA", "TI_ENTITA_FISICA", "TI_ENTITA_GIURIDICA", "DENOMINAZIONE_SEDE", "VIA_SEDE", "NUMERO_CIVICO_SEDE", "PG_COMUNE_SEDE", "DS_COMUNE_SEDE", "CD_PROVINCIA_SEDE", "DS_PROVINCIA_SEDE", "CAP_COMUNE_SEDE", "FRAZIONE_SEDE", "VIA_FISCALE", "NUM_CIVICO_FISCALE", "PG_COMUNE_FISCALE", "DS_COMUNE_FISCALE", "CD_PROVINCIA_FISCALE", "DS_PROVINCIA_FISCALE", "CAP_COMUNE_FISCALE", "FRAZIONE_FISCALE", "PG_NAZIONE_FISCALE", "DT_NASCITA", "PG_COMUNE_NASCITA", "DS_COMUNE_NASCITA", "CD_PROVINCIA_NASCITA", "DS_PROVINCIA_NASCITA", "CD_CONTRIBUTO_RITENUTA", "TI_ENTE_PERCIPIENTE", "PG_RIGA", "IMPONIBILE", "ALIQUOTA", "AMMONTARE_LORDO", "IMPONIBILE_LORDO", "CLASSIFICAZIONE", "ORDINAMENTO", "IM_DEDUZIONE_FAMILY", "PG_MINICARRIERA", "ALIQUOTA_FISCALE", "FL_CARICHI_FAMILIARI", "FL_NOTAXAREA", "FL_NOFAMILYAREA", "IM_TOTALE_COMPENSO", "DS_CONTRIBUTO_RITENUTA", "FL_CERVELLONE") AS 
  SELECT
--==============================================================================
--
-- Date: 18/07/2006
-- Version: 1.4
--
-- Vista estrazione CONTRIBUTI RITENUTE per prospetto stampa compenso
--
-- History:
-- Date: 09/12/2002
-- Version: 1.0
-- Creazione
--
-- Date: 07/03/2003
-- Version: 1.1
-- Estrazione informazioni di SEDE del terzo
--
-- Date: 25/03/2003
-- Version: 1.2
-- Riorganizzazione vista per adeguamento
--
-- Date: 26/03/2003
-- Version: 1.3
-- Corretta outer join sui dettagli di contributo ritenuta
--
-- Date: 18/07/2006
-- Version: 1.4
-- Gestione Impegni/Accertamenti Residui:
-- gestito il nuovo campo ESERCIZIO_ORIGINALE
--
--==============================================================================
COMPENSO.CD_CDS,
COMPENSO.CD_UNITA_ORGANIZZATIVA,
COMPENSO.ESERCIZIO,
COMPENSO.PG_COMPENSO,
COMPENSO.DS_COMPENSO,
COMPENSO.DT_REGISTRAZIONE,
COMPENSO.DT_DA_COMPETENZA_COGE,
COMPENSO.DT_A_COMPETENZA_COGE,
COMPENSO.FL_COMPENSO_CONGUAGLIO,
COMPENSO.FL_SENZA_CALCOLI,
COMPENSO.IM_LORDO_PERCIPIENTE,
COMPENSO.IM_NETTO_PERCIPIENTE,
COMPENSO.DETRAZIONE_ALTRI_NETTO,
COMPENSO.DETRAZIONE_CONIUGE_NETTO,
COMPENSO.DETRAZIONE_FIGLI_NETTO,
COMPENSO.DETRAZIONI_LA_NETTO,
COMPENSO.DETRAZIONI_PERSONALI_NETTO,
COMPENSO.IM_DEDUZIONE_IRPEF,
COMPENSO.CD_TERZO,
COMPENSO.NOME,
COMPENSO.COGNOME,
COMPENSO.RAGIONE_SOCIALE,
COMPENSO.CODICE_FISCALE,
COMPENSO.PARTITA_IVA,
COMPENSO.ESERCIZIO_ORI_OBBLIGAZIONE,
COMPENSO.PG_OBBLIGAZIONE,
COMPENSO.CD_TRATTAMENTO,
ti_trat.DS_TI_TRATTAMENTO,
V_ANAGRAFICO_TERZO.CD_ANAG,
V_ANAGRAFICO_TERZO.TI_ITALIANO_ESTERO,
V_ANAGRAFICO_TERZO.TI_ENTITA,
V_ANAGRAFICO_TERZO.TI_ENTITA_FISICA,
V_ANAGRAFICO_TERZO.TI_ENTITA_GIURIDICA,
V_ANAGRAFICO_TERZO.DENOMINAZIONE_SEDE,
V_ANAGRAFICO_TERZO.VIA_SEDE,
V_ANAGRAFICO_TERZO.NUMERO_CIVICO_SEDE,
V_ANAGRAFICO_TERZO.PG_COMUNE_SEDE,
V_ANAGRAFICO_TERZO.DS_COMUNE_SEDE,
V_ANAGRAFICO_TERZO.CD_PROVINCIA_SEDE,
V_ANAGRAFICO_TERZO.DS_PROVINCIA_SEDE,
V_ANAGRAFICO_TERZO.CAP_COMUNE_SEDE,
V_ANAGRAFICO_TERZO.FRAZIONE_SEDE,
V_ANAGRAFICO_TERZO.VIA_FISCALE,
V_ANAGRAFICO_TERZO.NUM_CIVICO_FISCALE,
V_ANAGRAFICO_TERZO.PG_COMUNE_FISCALE,
V_ANAGRAFICO_TERZO.DS_COMUNE_FISCALE,
V_ANAGRAFICO_TERZO.CD_PROVINCIA_FISCALE,
V_ANAGRAFICO_TERZO.DS_PROVINCIA_FISCALE,
V_ANAGRAFICO_TERZO.CAP_COMUNE_FISCALE,
V_ANAGRAFICO_TERZO.FRAZIONE_FISCALE,
V_ANAGRAFICO_TERZO.PG_NAZIONE_FISCALE,
V_ANAGRAFICO_TERZO.DT_NASCITA,
V_ANAGRAFICO_TERZO.PG_COMUNE_NASCITA,
V_ANAGRAFICO_TERZO.DS_COMUNE_NASCITA,
V_ANAGRAFICO_TERZO.CD_PROVINCIA_NASCITA,
V_ANAGRAFICO_TERZO.DS_PROVINCIA_NASCITA,
CONTRIBUTO_RITENUTA.CD_CONTRIBUTO_RITENUTA,
CONTRIBUTO_RITENUTA.TI_ENTE_PERCIPIENTE,
1,
CONTRIBUTO_RITENUTA.IMPONIBILE,
CONTRIBUTO_RITENUTA.ALIQUOTA,
CONTRIBUTO_RITENUTA.AMMONTARE_LORDO,
CONTRIBUTO_RITENUTA.IMPONIBILE_LORDO,
CLASSIFICAZIONE_CORI.CD_CLASSIFICAZIONE_CORI,
10, --Campo per ordinamento Stampa
CONTRIBUTO_RITENUTA.IM_DEDUZIONE_FAMILY,
(Select Distinct PG_MINICARRIERA From Minicarriera_rata M
 Where M.CD_CDS_COMPENSO = COMPENSO.CD_CDS
   And M.CD_UO_COMPENSO = COMPENSO.CD_UNITA_ORGANIZZATIVA
   And M.ESERCIZIO_COMPENSO = COMPENSO.ESERCIZIO
   And M.PG_COMPENSO = COMPENSO.PG_COMPENSO),
V_ANAGRAFICO_TERZO.ALIQUOTA_FISCALE,
(Select Decode(Count(1),0,'N','Y')
 From CARICO_FAMILIARE_ANAG
 Where CARICO_FAMILIARE_ANAG.CD_ANAG = V_ANAGRAFICO_TERZO.CD_ANAG),
Nvl((Select FL_NOTAXAREA
 From ANAGRAFICO_ESERCIZIO
 Where ANAGRAFICO_ESERCIZIO.CD_ANAG = V_ANAGRAFICO_TERZO.CD_ANAG
   And ANAGRAFICO_ESERCIZIO.ESERCIZIO = COMPENSO.ESERCIZIO),'N'),
Nvl((Select FL_NOFAMILYAREA
 From ANAGRAFICO_ESERCIZIO
 Where ANAGRAFICO_ESERCIZIO.CD_ANAG = V_ANAGRAFICO_TERZO.CD_ANAG
   And ANAGRAFICO_ESERCIZIO.ESERCIZIO = COMPENSO.ESERCIZIO),'N'),
COMPENSO.IM_TOTALE_COMPENSO,
TIPO_CONTRIBUTO_RITENUTA.DS_CONTRIBUTO_RITENUTA,
V_ANAGRAFICO_TERZO.FL_CERVELLONE
FROM
COMPENSO,
TIPO_TRATTAMENTO ti_trat,
TIPO_RAPPORTO,
V_ANAGRAFICO_TERZO,
CONTRIBUTO_RITENUTA,
TIPO_CONTRIBUTO_RITENUTA,
CLASSIFICAZIONE_CORI
Where
COMPENSO.FL_COMPENSO_CONGUAGLIO   = 'N' AND
ti_trat.CD_TRATTAMENTO 			  = COMPENSO.CD_TRATTAMENTO AND
ti_trat.DT_INI_VALIDITA			  <= COMPENSO.DT_DA_COMPETENZA_COGE AND
ti_trat.DT_FIN_VALIDITA			  >= COMPENSO.DT_DA_COMPETENZA_COGE AND
COMPENSO.CD_TERZO 				  = V_ANAGRAFICO_TERZO.CD_TERZO AND
COMPENSO.CD_TIPO_RAPPORTO 		  = TIPO_RAPPORTO.CD_TIPO_RAPPORTO AND
TIPO_RAPPORTO.TI_DIPENDENTE_ALTRO = 'A' AND
CONTRIBUTO_RITENUTA.CD_CDS 		  		   = COMPENSO.CD_CDS AND
CONTRIBUTO_RITENUTA.CD_UNITA_ORGANIZZATIVA = COMPENSO.CD_UNITA_ORGANIZZATIVA AND
CONTRIBUTO_RITENUTA.ESERCIZIO 			   = COMPENSO.ESERCIZIO AND
CONTRIBUTO_RITENUTA.PG_COMPENSO 		   = COMPENSO.PG_COMPENSO AND
--CONTRIBUTO_RITENUTA.ALIQUOTA != 0 AND CONTRIBUTO_RITENUTA.ALIQUOTA IS NOT NULL AND
CONTRIBUTO_RITENUTA.TI_ENTE_PERCIPIENTE    = 'P' AND
CONTRIBUTO_RITENUTA.CD_CONTRIBUTO_RITENUTA = TIPO_CONTRIBUTO_RITENUTA.CD_CONTRIBUTO_RITENUTA AND
CONTRIBUTO_RITENUTA.DT_INI_VALIDITA 	   = TIPO_CONTRIBUTO_RITENUTA.DT_INI_VALIDITA AND
TIPO_CONTRIBUTO_RITENUTA.CD_CLASSIFICAZIONE_CORI = CLASSIFICAZIONE_CORI.CD_CLASSIFICAZIONE_CORI AND
CLASSIFICAZIONE_CORI.CD_CLASSIFICAZIONE_CORI 	 = 'FI'--IN ('IL', 'PR', 'FI')
Union ALL
SELECT
COMPENSO.CD_CDS,
COMPENSO.CD_UNITA_ORGANIZZATIVA,
COMPENSO.ESERCIZIO,
COMPENSO.PG_COMPENSO,
COMPENSO.DS_COMPENSO,
COMPENSO.DT_REGISTRAZIONE,
COMPENSO.DT_DA_COMPETENZA_COGE,
COMPENSO.DT_A_COMPETENZA_COGE,
COMPENSO.FL_COMPENSO_CONGUAGLIO,
COMPENSO.FL_SENZA_CALCOLI,
COMPENSO.IM_LORDO_PERCIPIENTE,
COMPENSO.IM_NETTO_PERCIPIENTE,
COMPENSO.DETRAZIONE_ALTRI_NETTO,
COMPENSO.DETRAZIONE_CONIUGE_NETTO,
COMPENSO.DETRAZIONE_FIGLI_NETTO,
COMPENSO.DETRAZIONI_LA_NETTO,
COMPENSO.DETRAZIONI_PERSONALI_NETTO,
COMPENSO.IM_DEDUZIONE_IRPEF,
COMPENSO.CD_TERZO,
COMPENSO.NOME,
COMPENSO.COGNOME,
COMPENSO.RAGIONE_SOCIALE,
COMPENSO.CODICE_FISCALE,
COMPENSO.PARTITA_IVA,
COMPENSO.ESERCIZIO_ORI_OBBLIGAZIONE,
COMPENSO.PG_OBBLIGAZIONE,
COMPENSO.CD_TRATTAMENTO,
ti_trat.DS_TI_TRATTAMENTO,
V_ANAGRAFICO_TERZO.CD_ANAG,
V_ANAGRAFICO_TERZO.TI_ITALIANO_ESTERO,
V_ANAGRAFICO_TERZO.TI_ENTITA,
V_ANAGRAFICO_TERZO.TI_ENTITA_FISICA,
V_ANAGRAFICO_TERZO.TI_ENTITA_GIURIDICA,
V_ANAGRAFICO_TERZO.DENOMINAZIONE_SEDE,
V_ANAGRAFICO_TERZO.VIA_SEDE,
V_ANAGRAFICO_TERZO.NUMERO_CIVICO_SEDE,
V_ANAGRAFICO_TERZO.PG_COMUNE_SEDE,
V_ANAGRAFICO_TERZO.DS_COMUNE_SEDE,
V_ANAGRAFICO_TERZO.CD_PROVINCIA_SEDE,
V_ANAGRAFICO_TERZO.DS_PROVINCIA_SEDE,
V_ANAGRAFICO_TERZO.CAP_COMUNE_SEDE,
V_ANAGRAFICO_TERZO.FRAZIONE_SEDE,
V_ANAGRAFICO_TERZO.VIA_FISCALE,
V_ANAGRAFICO_TERZO.NUM_CIVICO_FISCALE,
V_ANAGRAFICO_TERZO.PG_COMUNE_FISCALE,
V_ANAGRAFICO_TERZO.DS_COMUNE_FISCALE,
V_ANAGRAFICO_TERZO.CD_PROVINCIA_FISCALE,
V_ANAGRAFICO_TERZO.DS_PROVINCIA_FISCALE,
V_ANAGRAFICO_TERZO.CAP_COMUNE_FISCALE,
V_ANAGRAFICO_TERZO.FRAZIONE_FISCALE,
V_ANAGRAFICO_TERZO.PG_NAZIONE_FISCALE,
V_ANAGRAFICO_TERZO.DT_NASCITA,
V_ANAGRAFICO_TERZO.PG_COMUNE_NASCITA,
V_ANAGRAFICO_TERZO.DS_COMUNE_NASCITA,
V_ANAGRAFICO_TERZO.CD_PROVINCIA_NASCITA,
V_ANAGRAFICO_TERZO.DS_PROVINCIA_NASCITA,
CONTRIBUTO_RITENUTA.CD_CONTRIBUTO_RITENUTA,
CONTRIBUTO_RITENUTA.TI_ENTE_PERCIPIENTE,
1,
CONTRIBUTO_RITENUTA.IMPONIBILE,
CONTRIBUTO_RITENUTA.ALIQUOTA,
CONTRIBUTO_RITENUTA.AMMONTARE_LORDO,
CONTRIBUTO_RITENUTA.IMPONIBILE_LORDO,
CLASSIFICAZIONE_CORI.CD_CLASSIFICAZIONE_CORI,
5, --Campo per ordinamento Stampa
CONTRIBUTO_RITENUTA.IM_DEDUZIONE_FAMILY,
(Select Distinct PG_MINICARRIERA From Minicarriera_rata M
 Where M.CD_CDS_COMPENSO = COMPENSO.CD_CDS
   And M.CD_UO_COMPENSO = COMPENSO.CD_UNITA_ORGANIZZATIVA
   And M.ESERCIZIO_COMPENSO = COMPENSO.ESERCIZIO
   And M.PG_COMPENSO = COMPENSO.PG_COMPENSO),
V_ANAGRAFICO_TERZO.ALIQUOTA_FISCALE,
(Select Decode(Count(1),0,'N','Y')
 From CARICO_FAMILIARE_ANAG
 Where CARICO_FAMILIARE_ANAG.CD_ANAG = V_ANAGRAFICO_TERZO.CD_ANAG),
Nvl((Select FL_NOTAXAREA
 From ANAGRAFICO_ESERCIZIO
 Where ANAGRAFICO_ESERCIZIO.CD_ANAG = V_ANAGRAFICO_TERZO.CD_ANAG
   And ANAGRAFICO_ESERCIZIO.ESERCIZIO = COMPENSO.ESERCIZIO),'N'),
Nvl((Select FL_NOFAMILYAREA
 From ANAGRAFICO_ESERCIZIO
 Where ANAGRAFICO_ESERCIZIO.CD_ANAG = V_ANAGRAFICO_TERZO.CD_ANAG
   And ANAGRAFICO_ESERCIZIO.ESERCIZIO = COMPENSO.ESERCIZIO),'N'),
COMPENSO.IM_TOTALE_COMPENSO,
TIPO_CONTRIBUTO_RITENUTA.DS_CONTRIBUTO_RITENUTA,
V_ANAGRAFICO_TERZO.FL_CERVELLONE
FROM
COMPENSO,
TIPO_TRATTAMENTO ti_trat,
TIPO_RAPPORTO,
V_ANAGRAFICO_TERZO,
CONTRIBUTO_RITENUTA,
TIPO_CONTRIBUTO_RITENUTA,
CLASSIFICAZIONE_CORI
WHERE
COMPENSO.FL_COMPENSO_CONGUAGLIO   = 'N' AND
ti_trat.CD_TRATTAMENTO 			  = COMPENSO.CD_TRATTAMENTO AND
ti_trat.DT_INI_VALIDITA			  <= COMPENSO.DT_DA_COMPETENZA_COGE AND
ti_trat.DT_FIN_VALIDITA			  >= COMPENSO.DT_DA_COMPETENZA_COGE AND
COMPENSO.CD_TERZO 				  = V_ANAGRAFICO_TERZO.CD_TERZO AND
COMPENSO.CD_TIPO_RAPPORTO 		  = TIPO_RAPPORTO.CD_TIPO_RAPPORTO AND
TIPO_RAPPORTO.TI_DIPENDENTE_ALTRO = 'A' AND
CONTRIBUTO_RITENUTA.CD_CDS 		  		   = COMPENSO.CD_CDS AND
CONTRIBUTO_RITENUTA.CD_UNITA_ORGANIZZATIVA = COMPENSO.CD_UNITA_ORGANIZZATIVA AND
CONTRIBUTO_RITENUTA.ESERCIZIO 			   = COMPENSO.ESERCIZIO AND
CONTRIBUTO_RITENUTA.PG_COMPENSO 		   = COMPENSO.PG_COMPENSO AND
--CONTRIBUTO_RITENUTA.ALIQUOTA != 0 AND CONTRIBUTO_RITENUTA.ALIQUOTA IS NOT NULL AND
CONTRIBUTO_RITENUTA.TI_ENTE_PERCIPIENTE    = 'P' AND
CONTRIBUTO_RITENUTA.CD_CONTRIBUTO_RITENUTA = TIPO_CONTRIBUTO_RITENUTA.CD_CONTRIBUTO_RITENUTA AND
CONTRIBUTO_RITENUTA.DT_INI_VALIDITA 	   = TIPO_CONTRIBUTO_RITENUTA.DT_INI_VALIDITA AND
TIPO_CONTRIBUTO_RITENUTA.CD_CLASSIFICAZIONE_CORI = CLASSIFICAZIONE_CORI.CD_CLASSIFICAZIONE_CORI AND
CLASSIFICAZIONE_CORI.CD_CLASSIFICAZIONE_CORI 	 IN ('IL', 'PR') --IN ('IL', 'PR', 'FI')
AND NOT EXISTS (SELECT 1 FROM CONTRIBUTO_RITENUTA_DET CORID
			    WHERE CORID.CD_CDS = CONTRIBUTO_RITENUTA.CD_CDS
				  AND CORID.CD_UNITA_ORGANIZZATIVA = CONTRIBUTO_RITENUTA.CD_UNITA_ORGANIZZATIVA
				  AND CORID.ESERCIZIO 			   = CONTRIBUTO_RITENUTA.ESERCIZIO
				  AND CORID.PG_COMPENSO			   = CONTRIBUTO_RITENUTA.PG_COMPENSO
				  AND CORID.CD_CONTRIBUTO_RITENUTA = CONTRIBUTO_RITENUTA.CD_CONTRIBUTO_RITENUTA
				  AND CORID.TI_ENTE_PERCIPIENTE	   = CONTRIBUTO_RITENUTA.TI_ENTE_PERCIPIENTE)
UNION ALL
SELECT
COMPENSO.CD_CDS,
COMPENSO.CD_UNITA_ORGANIZZATIVA,
COMPENSO.ESERCIZIO,
COMPENSO.PG_COMPENSO,
COMPENSO.DS_COMPENSO,
COMPENSO.DT_REGISTRAZIONE,
COMPENSO.DT_DA_COMPETENZA_COGE,
COMPENSO.DT_A_COMPETENZA_COGE,
COMPENSO.FL_COMPENSO_CONGUAGLIO,
COMPENSO.FL_SENZA_CALCOLI,
COMPENSO.IM_LORDO_PERCIPIENTE,
COMPENSO.IM_NETTO_PERCIPIENTE,
COMPENSO.DETRAZIONE_ALTRI_NETTO,
COMPENSO.DETRAZIONE_CONIUGE_NETTO,
COMPENSO.DETRAZIONE_FIGLI_NETTO,
COMPENSO.DETRAZIONI_LA_NETTO,
COMPENSO.DETRAZIONI_PERSONALI_NETTO,
COMPENSO.IM_DEDUZIONE_IRPEF,
COMPENSO.CD_TERZO,
COMPENSO.NOME,
COMPENSO.COGNOME,
COMPENSO.RAGIONE_SOCIALE,
COMPENSO.CODICE_FISCALE,
COMPENSO.PARTITA_IVA,
COMPENSO.ESERCIZIO_ORI_OBBLIGAZIONE,
COMPENSO.PG_OBBLIGAZIONE,
COMPENSO.CD_TRATTAMENTO,
ti_trat.DS_TI_TRATTAMENTO,
V_ANAGRAFICO_TERZO.CD_ANAG,
V_ANAGRAFICO_TERZO.TI_ITALIANO_ESTERO,
V_ANAGRAFICO_TERZO.TI_ENTITA,
V_ANAGRAFICO_TERZO.TI_ENTITA_FISICA,
V_ANAGRAFICO_TERZO.TI_ENTITA_GIURIDICA,
V_ANAGRAFICO_TERZO.DENOMINAZIONE_SEDE,
V_ANAGRAFICO_TERZO.VIA_SEDE,
V_ANAGRAFICO_TERZO.NUMERO_CIVICO_SEDE,
V_ANAGRAFICO_TERZO.PG_COMUNE_SEDE,
V_ANAGRAFICO_TERZO.DS_COMUNE_SEDE,
V_ANAGRAFICO_TERZO.CD_PROVINCIA_SEDE,
V_ANAGRAFICO_TERZO.DS_PROVINCIA_SEDE,
V_ANAGRAFICO_TERZO.CAP_COMUNE_SEDE,
V_ANAGRAFICO_TERZO.FRAZIONE_SEDE,
V_ANAGRAFICO_TERZO.VIA_FISCALE,
V_ANAGRAFICO_TERZO.NUM_CIVICO_FISCALE,
V_ANAGRAFICO_TERZO.PG_COMUNE_FISCALE,
V_ANAGRAFICO_TERZO.DS_COMUNE_FISCALE,
V_ANAGRAFICO_TERZO.CD_PROVINCIA_FISCALE,
V_ANAGRAFICO_TERZO.DS_PROVINCIA_FISCALE,
V_ANAGRAFICO_TERZO.CAP_COMUNE_FISCALE,
V_ANAGRAFICO_TERZO.FRAZIONE_FISCALE,
V_ANAGRAFICO_TERZO.PG_NAZIONE_FISCALE,
V_ANAGRAFICO_TERZO.DT_NASCITA,
V_ANAGRAFICO_TERZO.PG_COMUNE_NASCITA,
V_ANAGRAFICO_TERZO.DS_COMUNE_NASCITA,
V_ANAGRAFICO_TERZO.CD_PROVINCIA_NASCITA,
V_ANAGRAFICO_TERZO.DS_PROVINCIA_NASCITA,
CONTRIBUTO_RITENUTA.CD_CONTRIBUTO_RITENUTA,
CONTRIBUTO_RITENUTA.TI_ENTE_PERCIPIENTE,
1,
CONTRIBUTO_RITENUTA.IMPONIBILE,
CONTRIBUTO_RITENUTA.ALIQUOTA,
CONTRIBUTO_RITENUTA.AMMONTARE_LORDO,
CONTRIBUTO_RITENUTA.IMPONIBILE_LORDO,
CLASSIFICAZIONE_CORI.CD_CLASSIFICAZIONE_CORI,
20, --Campo per ordinamento Stampa
CONTRIBUTO_RITENUTA.IM_DEDUZIONE_FAMILY,
(Select Distinct PG_MINICARRIERA From Minicarriera_rata M
 Where M.CD_CDS_COMPENSO = COMPENSO.CD_CDS
   And M.CD_UO_COMPENSO = COMPENSO.CD_UNITA_ORGANIZZATIVA
   And M.ESERCIZIO_COMPENSO = COMPENSO.ESERCIZIO
   And M.PG_COMPENSO = COMPENSO.PG_COMPENSO),
V_ANAGRAFICO_TERZO.ALIQUOTA_FISCALE,
(Select Decode(Count(1),0,'N','Y')
 From CARICO_FAMILIARE_ANAG
 Where CARICO_FAMILIARE_ANAG.CD_ANAG = V_ANAGRAFICO_TERZO.CD_ANAG),
Nvl((Select FL_NOTAXAREA
 From ANAGRAFICO_ESERCIZIO
 Where ANAGRAFICO_ESERCIZIO.CD_ANAG = V_ANAGRAFICO_TERZO.CD_ANAG
   And ANAGRAFICO_ESERCIZIO.ESERCIZIO = COMPENSO.ESERCIZIO),'N'),
Nvl((Select FL_NOFAMILYAREA
 From ANAGRAFICO_ESERCIZIO
 Where ANAGRAFICO_ESERCIZIO.CD_ANAG = V_ANAGRAFICO_TERZO.CD_ANAG
   And ANAGRAFICO_ESERCIZIO.ESERCIZIO = COMPENSO.ESERCIZIO),'N'),
COMPENSO.IM_TOTALE_COMPENSO,
TIPO_CONTRIBUTO_RITENUTA.DS_CONTRIBUTO_RITENUTA,
V_ANAGRAFICO_TERZO.FL_CERVELLONE
FROM
COMPENSO,
TIPO_TRATTAMENTO ti_trat,
TIPO_RAPPORTO,
V_ANAGRAFICO_TERZO,
CONTRIBUTO_RITENUTA,
TIPO_CONTRIBUTO_RITENUTA,
CLASSIFICAZIONE_CORI
WHERE
COMPENSO.FL_COMPENSO_CONGUAGLIO   = 'N' AND
ti_trat.CD_TRATTAMENTO 			  = COMPENSO.CD_TRATTAMENTO AND
ti_trat.DT_INI_VALIDITA			  <= COMPENSO.DT_DA_COMPETENZA_COGE AND
ti_trat.DT_FIN_VALIDITA			  >= COMPENSO.DT_DA_COMPETENZA_COGE AND
COMPENSO.CD_TERZO 				  = V_ANAGRAFICO_TERZO.CD_TERZO AND
COMPENSO.CD_TIPO_RAPPORTO 		  = TIPO_RAPPORTO.CD_TIPO_RAPPORTO AND
TIPO_RAPPORTO.TI_DIPENDENTE_ALTRO = 'A' AND
CONTRIBUTO_RITENUTA.CD_CDS 		  		   = COMPENSO.CD_CDS AND
CONTRIBUTO_RITENUTA.CD_UNITA_ORGANIZZATIVA = COMPENSO.CD_UNITA_ORGANIZZATIVA AND
CONTRIBUTO_RITENUTA.ESERCIZIO 			   = COMPENSO.ESERCIZIO AND
CONTRIBUTO_RITENUTA.PG_COMPENSO 		   = COMPENSO.PG_COMPENSO AND
--CONTRIBUTO_RITENUTA.ALIQUOTA != 0 AND CONTRIBUTO_RITENUTA.ALIQUOTA IS NOT NULL AND
CONTRIBUTO_RITENUTA.TI_ENTE_PERCIPIENTE    = 'P' AND
CONTRIBUTO_RITENUTA.CD_CONTRIBUTO_RITENUTA = TIPO_CONTRIBUTO_RITENUTA.CD_CONTRIBUTO_RITENUTA AND
CONTRIBUTO_RITENUTA.DT_INI_VALIDITA 	   = TIPO_CONTRIBUTO_RITENUTA.DT_INI_VALIDITA AND
TIPO_CONTRIBUTO_RITENUTA.CD_CLASSIFICAZIONE_CORI = CLASSIFICAZIONE_CORI.CD_CLASSIFICAZIONE_CORI AND
CLASSIFICAZIONE_CORI.CD_CLASSIFICAZIONE_CORI 	 IN ('P9','C9','R9') --IN ('IL', 'PR', 'FI')
AND NOT EXISTS (SELECT 1 FROM CONTRIBUTO_RITENUTA_DET CORID
			    WHERE CORID.CD_CDS = CONTRIBUTO_RITENUTA.CD_CDS
				  AND CORID.CD_UNITA_ORGANIZZATIVA = CONTRIBUTO_RITENUTA.CD_UNITA_ORGANIZZATIVA
				  AND CORID.ESERCIZIO 			   = CONTRIBUTO_RITENUTA.ESERCIZIO
				  AND CORID.PG_COMPENSO			   = CONTRIBUTO_RITENUTA.PG_COMPENSO
				  AND CORID.CD_CONTRIBUTO_RITENUTA = CONTRIBUTO_RITENUTA.CD_CONTRIBUTO_RITENUTA
				  AND CORID.TI_ENTE_PERCIPIENTE	   = CONTRIBUTO_RITENUTA.TI_ENTE_PERCIPIENTE)
UNION ALL
SELECT
COMPENSO.CD_CDS,
COMPENSO.CD_UNITA_ORGANIZZATIVA,
COMPENSO.ESERCIZIO,
COMPENSO.PG_COMPENSO,
COMPENSO.DS_COMPENSO,
COMPENSO.DT_REGISTRAZIONE,
COMPENSO.DT_DA_COMPETENZA_COGE,
COMPENSO.DT_A_COMPETENZA_COGE,
COMPENSO.FL_COMPENSO_CONGUAGLIO,
COMPENSO.FL_SENZA_CALCOLI,
COMPENSO.IM_LORDO_PERCIPIENTE,
COMPENSO.IM_NETTO_PERCIPIENTE,
COMPENSO.DETRAZIONE_ALTRI_NETTO,
COMPENSO.DETRAZIONE_CONIUGE_NETTO,
COMPENSO.DETRAZIONE_FIGLI_NETTO,
COMPENSO.DETRAZIONI_LA_NETTO,
COMPENSO.DETRAZIONI_PERSONALI_NETTO,
COMPENSO.IM_DEDUZIONE_IRPEF,
COMPENSO.CD_TERZO,
COMPENSO.NOME,
COMPENSO.COGNOME,
COMPENSO.RAGIONE_SOCIALE,
COMPENSO.CODICE_FISCALE,
COMPENSO.PARTITA_IVA,
COMPENSO.ESERCIZIO_ORI_OBBLIGAZIONE,
COMPENSO.PG_OBBLIGAZIONE,
COMPENSO.CD_TRATTAMENTO,
ti_trat.DS_TI_TRATTAMENTO,
V_ANAGRAFICO_TERZO.CD_ANAG,
V_ANAGRAFICO_TERZO.TI_ITALIANO_ESTERO,
V_ANAGRAFICO_TERZO.TI_ENTITA,
V_ANAGRAFICO_TERZO.TI_ENTITA_FISICA,
V_ANAGRAFICO_TERZO.TI_ENTITA_GIURIDICA,
V_ANAGRAFICO_TERZO.DENOMINAZIONE_SEDE,
V_ANAGRAFICO_TERZO.VIA_SEDE,
V_ANAGRAFICO_TERZO.NUMERO_CIVICO_SEDE,
V_ANAGRAFICO_TERZO.PG_COMUNE_SEDE,
V_ANAGRAFICO_TERZO.DS_COMUNE_SEDE,
V_ANAGRAFICO_TERZO.CD_PROVINCIA_SEDE,
V_ANAGRAFICO_TERZO.DS_PROVINCIA_SEDE,
V_ANAGRAFICO_TERZO.CAP_COMUNE_SEDE,
V_ANAGRAFICO_TERZO.FRAZIONE_SEDE,
V_ANAGRAFICO_TERZO.VIA_FISCALE,
V_ANAGRAFICO_TERZO.NUM_CIVICO_FISCALE,
V_ANAGRAFICO_TERZO.PG_COMUNE_FISCALE,
V_ANAGRAFICO_TERZO.DS_COMUNE_FISCALE,
V_ANAGRAFICO_TERZO.CD_PROVINCIA_FISCALE,
V_ANAGRAFICO_TERZO.DS_PROVINCIA_FISCALE,
V_ANAGRAFICO_TERZO.CAP_COMUNE_FISCALE,
V_ANAGRAFICO_TERZO.FRAZIONE_FISCALE,
V_ANAGRAFICO_TERZO.PG_NAZIONE_FISCALE,
V_ANAGRAFICO_TERZO.DT_NASCITA,
V_ANAGRAFICO_TERZO.PG_COMUNE_NASCITA,
V_ANAGRAFICO_TERZO.DS_COMUNE_NASCITA,
V_ANAGRAFICO_TERZO.CD_PROVINCIA_NASCITA,
V_ANAGRAFICO_TERZO.DS_PROVINCIA_NASCITA,
CONTRIBUTO_RITENUTA.CD_CONTRIBUTO_RITENUTA,
CONTRIBUTO_RITENUTA.TI_ENTE_PERCIPIENTE,
1,
CONTRIBUTO_RITENUTA.IMPONIBILE,
CONTRIBUTO_RITENUTA.ALIQUOTA,
CONTRIBUTO_RITENUTA.AMMONTARE_LORDO,
CONTRIBUTO_RITENUTA.IMPONIBILE_LORDO,
CLASSIFICAZIONE_CORI.CD_CLASSIFICAZIONE_CORI,
1, --Campo per ordinamento Stampa
CONTRIBUTO_RITENUTA.IM_DEDUZIONE_FAMILY,
(Select Distinct PG_MINICARRIERA From Minicarriera_rata M
 Where M.CD_CDS_COMPENSO = COMPENSO.CD_CDS
   And M.CD_UO_COMPENSO = COMPENSO.CD_UNITA_ORGANIZZATIVA
   And M.ESERCIZIO_COMPENSO = COMPENSO.ESERCIZIO
   And M.PG_COMPENSO = COMPENSO.PG_COMPENSO),
V_ANAGRAFICO_TERZO.ALIQUOTA_FISCALE,
(Select Decode(Count(1),0,'N','Y')
 From CARICO_FAMILIARE_ANAG
 Where CARICO_FAMILIARE_ANAG.CD_ANAG = V_ANAGRAFICO_TERZO.CD_ANAG),
Nvl((Select FL_NOTAXAREA
 From ANAGRAFICO_ESERCIZIO
 Where ANAGRAFICO_ESERCIZIO.CD_ANAG = V_ANAGRAFICO_TERZO.CD_ANAG
   And ANAGRAFICO_ESERCIZIO.ESERCIZIO = COMPENSO.ESERCIZIO),'N'),
Nvl((Select FL_NOFAMILYAREA
 From ANAGRAFICO_ESERCIZIO
 Where ANAGRAFICO_ESERCIZIO.CD_ANAG = V_ANAGRAFICO_TERZO.CD_ANAG
   And ANAGRAFICO_ESERCIZIO.ESERCIZIO = COMPENSO.ESERCIZIO),'N'),
COMPENSO.IM_TOTALE_COMPENSO,
TIPO_CONTRIBUTO_RITENUTA.DS_CONTRIBUTO_RITENUTA,
V_ANAGRAFICO_TERZO.FL_CERVELLONE
FROM
COMPENSO,
TIPO_TRATTAMENTO ti_trat,
TIPO_RAPPORTO,
V_ANAGRAFICO_TERZO,
CONTRIBUTO_RITENUTA,
TIPO_CONTRIBUTO_RITENUTA,
CLASSIFICAZIONE_CORI
WHERE
COMPENSO.FL_COMPENSO_CONGUAGLIO   = 'N' AND
ti_trat.CD_TRATTAMENTO 			  = COMPENSO.CD_TRATTAMENTO AND
ti_trat.DT_INI_VALIDITA			  <= COMPENSO.DT_DA_COMPETENZA_COGE AND
ti_trat.DT_FIN_VALIDITA			  >= COMPENSO.DT_DA_COMPETENZA_COGE AND
COMPENSO.CD_TERZO 				  = V_ANAGRAFICO_TERZO.CD_TERZO AND
COMPENSO.CD_TIPO_RAPPORTO 		  = TIPO_RAPPORTO.CD_TIPO_RAPPORTO AND
TIPO_RAPPORTO.TI_DIPENDENTE_ALTRO = 'A' AND
CONTRIBUTO_RITENUTA.CD_CDS 		  		   = COMPENSO.CD_CDS AND
CONTRIBUTO_RITENUTA.CD_UNITA_ORGANIZZATIVA = COMPENSO.CD_UNITA_ORGANIZZATIVA AND
CONTRIBUTO_RITENUTA.ESERCIZIO 			   = COMPENSO.ESERCIZIO AND
CONTRIBUTO_RITENUTA.PG_COMPENSO 		   = COMPENSO.PG_COMPENSO AND
--CONTRIBUTO_RITENUTA.ALIQUOTA != 0 AND CONTRIBUTO_RITENUTA.ALIQUOTA IS NOT NULL AND
CONTRIBUTO_RITENUTA.TI_ENTE_PERCIPIENTE    = 'E' AND
CONTRIBUTO_RITENUTA.CD_CONTRIBUTO_RITENUTA = TIPO_CONTRIBUTO_RITENUTA.CD_CONTRIBUTO_RITENUTA AND
CONTRIBUTO_RITENUTA.DT_INI_VALIDITA 	   = TIPO_CONTRIBUTO_RITENUTA.DT_INI_VALIDITA AND
TIPO_CONTRIBUTO_RITENUTA.CD_CLASSIFICAZIONE_CORI = CLASSIFICAZIONE_CORI.CD_CLASSIFICAZIONE_CORI AND
CLASSIFICAZIONE_CORI.CD_CLASSIFICAZIONE_CORI 	 IN ('RV') --IN ('IL', 'PR', 'FI')
AND NOT EXISTS (SELECT 1 FROM CONTRIBUTO_RITENUTA_DET CORID
			    WHERE CORID.CD_CDS = CONTRIBUTO_RITENUTA.CD_CDS
				  AND CORID.CD_UNITA_ORGANIZZATIVA = CONTRIBUTO_RITENUTA.CD_UNITA_ORGANIZZATIVA
				  AND CORID.ESERCIZIO 			   = CONTRIBUTO_RITENUTA.ESERCIZIO
				  AND CORID.PG_COMPENSO			   = CONTRIBUTO_RITENUTA.PG_COMPENSO
				  AND CORID.CD_CONTRIBUTO_RITENUTA = CONTRIBUTO_RITENUTA.CD_CONTRIBUTO_RITENUTA
				  AND CORID.TI_ENTE_PERCIPIENTE	   = CONTRIBUTO_RITENUTA.TI_ENTE_PERCIPIENTE)
UNION ALL
SELECT
COMPENSO.CD_CDS,
COMPENSO.CD_UNITA_ORGANIZZATIVA,
COMPENSO.ESERCIZIO,
COMPENSO.PG_COMPENSO,
COMPENSO.DS_COMPENSO,
COMPENSO.DT_REGISTRAZIONE,
COMPENSO.DT_DA_COMPETENZA_COGE,
COMPENSO.DT_A_COMPETENZA_COGE,
COMPENSO.FL_COMPENSO_CONGUAGLIO,
COMPENSO.FL_SENZA_CALCOLI,
COMPENSO.IM_LORDO_PERCIPIENTE,
COMPENSO.IM_NETTO_PERCIPIENTE,
COMPENSO.DETRAZIONE_ALTRI_NETTO,
COMPENSO.DETRAZIONE_CONIUGE_NETTO,
COMPENSO.DETRAZIONE_FIGLI_NETTO,
COMPENSO.DETRAZIONI_LA_NETTO,
COMPENSO.DETRAZIONI_PERSONALI_NETTO,
COMPENSO.IM_DEDUZIONE_IRPEF,
COMPENSO.CD_TERZO,
COMPENSO.NOME,
COMPENSO.COGNOME,
COMPENSO.RAGIONE_SOCIALE,
COMPENSO.CODICE_FISCALE,
COMPENSO.PARTITA_IVA,
COMPENSO.ESERCIZIO_ORI_OBBLIGAZIONE,
COMPENSO.PG_OBBLIGAZIONE,
COMPENSO.CD_TRATTAMENTO,
ti_trat.DS_TI_TRATTAMENTO,
V_ANAGRAFICO_TERZO.CD_ANAG,
V_ANAGRAFICO_TERZO.TI_ITALIANO_ESTERO,
V_ANAGRAFICO_TERZO.TI_ENTITA,
V_ANAGRAFICO_TERZO.TI_ENTITA_FISICA,
V_ANAGRAFICO_TERZO.TI_ENTITA_GIURIDICA,
V_ANAGRAFICO_TERZO.DENOMINAZIONE_SEDE,
V_ANAGRAFICO_TERZO.VIA_SEDE,
V_ANAGRAFICO_TERZO.NUMERO_CIVICO_SEDE,
V_ANAGRAFICO_TERZO.PG_COMUNE_SEDE,
V_ANAGRAFICO_TERZO.DS_COMUNE_SEDE,
V_ANAGRAFICO_TERZO.CD_PROVINCIA_SEDE,
V_ANAGRAFICO_TERZO.DS_PROVINCIA_SEDE,
V_ANAGRAFICO_TERZO.CAP_COMUNE_SEDE,
V_ANAGRAFICO_TERZO.FRAZIONE_SEDE,
V_ANAGRAFICO_TERZO.VIA_FISCALE,
V_ANAGRAFICO_TERZO.NUM_CIVICO_FISCALE,
V_ANAGRAFICO_TERZO.PG_COMUNE_FISCALE,
V_ANAGRAFICO_TERZO.DS_COMUNE_FISCALE,
V_ANAGRAFICO_TERZO.CD_PROVINCIA_FISCALE,
V_ANAGRAFICO_TERZO.DS_PROVINCIA_FISCALE,
V_ANAGRAFICO_TERZO.CAP_COMUNE_FISCALE,
V_ANAGRAFICO_TERZO.FRAZIONE_FISCALE,
V_ANAGRAFICO_TERZO.PG_NAZIONE_FISCALE,
V_ANAGRAFICO_TERZO.DT_NASCITA,
V_ANAGRAFICO_TERZO.PG_COMUNE_NASCITA,
V_ANAGRAFICO_TERZO.DS_COMUNE_NASCITA,
V_ANAGRAFICO_TERZO.CD_PROVINCIA_NASCITA,
V_ANAGRAFICO_TERZO.DS_PROVINCIA_NASCITA,
CONTRIBUTO_RITENUTA.CD_CONTRIBUTO_RITENUTA,
CONTRIBUTO_RITENUTA.TI_ENTE_PERCIPIENTE,
NVL(CONTRIBUTO_RITENUTA_DET.PG_RIGA,1),
NVL(CONTRIBUTO_RITENUTA_DET.IMPONIBILE,CONTRIBUTO_RITENUTA.IMPONIBILE),
NVL(CONTRIBUTO_RITENUTA_DET.ALIQUOTA,CONTRIBUTO_RITENUTA.ALIQUOTA),
NVL(CONTRIBUTO_RITENUTA_DET.AMMONTARE,CONTRIBUTO_RITENUTA.AMMONTARE_LORDO),
CONTRIBUTO_RITENUTA.IMPONIBILE_LORDO,
CLASSIFICAZIONE_CORI.CD_CLASSIFICAZIONE_CORI,
5, --Campo per ordinamento Stampa
CONTRIBUTO_RITENUTA.IM_DEDUZIONE_FAMILY,
(Select Distinct PG_MINICARRIERA From Minicarriera_rata M
 Where M.CD_CDS_COMPENSO = COMPENSO.CD_CDS
   And M.CD_UO_COMPENSO = COMPENSO.CD_UNITA_ORGANIZZATIVA
   And M.ESERCIZIO_COMPENSO = COMPENSO.ESERCIZIO
   And M.PG_COMPENSO = COMPENSO.PG_COMPENSO),
V_ANAGRAFICO_TERZO.ALIQUOTA_FISCALE,
(Select Decode(Count(1),0,'N','Y')
 From CARICO_FAMILIARE_ANAG
 Where CARICO_FAMILIARE_ANAG.CD_ANAG = V_ANAGRAFICO_TERZO.CD_ANAG),
Nvl((Select FL_NOTAXAREA
 From ANAGRAFICO_ESERCIZIO
 Where ANAGRAFICO_ESERCIZIO.CD_ANAG = V_ANAGRAFICO_TERZO.CD_ANAG
   And ANAGRAFICO_ESERCIZIO.ESERCIZIO = COMPENSO.ESERCIZIO),'N'),
Nvl((Select FL_NOFAMILYAREA
 From ANAGRAFICO_ESERCIZIO
 Where ANAGRAFICO_ESERCIZIO.CD_ANAG = V_ANAGRAFICO_TERZO.CD_ANAG
   And ANAGRAFICO_ESERCIZIO.ESERCIZIO = COMPENSO.ESERCIZIO),'N'),
COMPENSO.IM_TOTALE_COMPENSO,
TIPO_CONTRIBUTO_RITENUTA.DS_CONTRIBUTO_RITENUTA,
V_ANAGRAFICO_TERZO.FL_CERVELLONE
FROM
COMPENSO,
TIPO_TRATTAMENTO ti_trat,
TIPO_RAPPORTO,
V_ANAGRAFICO_TERZO,
CONTRIBUTO_RITENUTA,
CONTRIBUTO_RITENUTA_DET,
TIPO_CONTRIBUTO_RITENUTA,
CLASSIFICAZIONE_CORI
WHERE
COMPENSO.FL_COMPENSO_CONGUAGLIO = 'N' AND
ti_trat.CD_TRATTAMENTO 			= COMPENSO.CD_TRATTAMENTO AND
ti_trat.DT_INI_VALIDITA			<= COMPENSO.DT_DA_COMPETENZA_COGE AND
ti_trat.DT_FIN_VALIDITA			>= COMPENSO.DT_DA_COMPETENZA_COGE AND
COMPENSO.CD_TERZO 				= V_ANAGRAFICO_TERZO.CD_TERZO AND
COMPENSO.CD_TIPO_RAPPORTO 		= TIPO_RAPPORTO.CD_TIPO_RAPPORTO AND
TIPO_RAPPORTO.TI_DIPENDENTE_ALTRO = 'A' AND
CONTRIBUTO_RITENUTA.CD_CDS 		  			  = COMPENSO.CD_CDS AND
CONTRIBUTO_RITENUTA.CD_UNITA_ORGANIZZATIVA 	  = COMPENSO.CD_UNITA_ORGANIZZATIVA AND
CONTRIBUTO_RITENUTA.ESERCIZIO 				  = COMPENSO.ESERCIZIO AND
CONTRIBUTO_RITENUTA.PG_COMPENSO 			  = COMPENSO.PG_COMPENSO AND
(CONTRIBUTO_RITENUTA.ALIQUOTA = 0 OR CONTRIBUTO_RITENUTA.ALIQUOTA IS NULL) AND
CONTRIBUTO_RITENUTA.TI_ENTE_PERCIPIENTE = 'P' AND
CONTRIBUTO_RITENUTA_DET.CD_CDS 			  	  	   = CONTRIBUTO_RITENUTA.CD_CDS AND
CONTRIBUTO_RITENUTA_DET.CD_UNITA_ORGANIZZATIVA 	   = CONTRIBUTO_RITENUTA.CD_UNITA_ORGANIZZATIVA AND
CONTRIBUTO_RITENUTA_DET.ESERCIZIO 				   = CONTRIBUTO_RITENUTA.ESERCIZIO AND
CONTRIBUTO_RITENUTA_DET.PG_COMPENSO 			   = CONTRIBUTO_RITENUTA.PG_COMPENSO AND
CONTRIBUTO_RITENUTA_DET.CD_CONTRIBUTO_RITENUTA 	   = CONTRIBUTO_RITENUTA.CD_CONTRIBUTO_RITENUTA AND
CONTRIBUTO_RITENUTA_DET.TI_ENTE_PERCIPIENTE 	   = CONTRIBUTO_RITENUTA.TI_ENTE_PERCIPIENTE AND
CONTRIBUTO_RITENUTA.CD_CONTRIBUTO_RITENUTA 		   = TIPO_CONTRIBUTO_RITENUTA.CD_CONTRIBUTO_RITENUTA AND
CONTRIBUTO_RITENUTA.DT_INI_VALIDITA 			   = TIPO_CONTRIBUTO_RITENUTA.DT_INI_VALIDITA AND
TIPO_CONTRIBUTO_RITENUTA.CD_CLASSIFICAZIONE_CORI   = CLASSIFICAZIONE_CORI.CD_CLASSIFICAZIONE_CORI AND
CLASSIFICAZIONE_CORI.CD_CLASSIFICAZIONE_CORI IN ('IL', 'PR') -- 'FI';
