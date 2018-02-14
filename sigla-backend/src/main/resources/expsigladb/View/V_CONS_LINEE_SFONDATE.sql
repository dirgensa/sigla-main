--------------------------------------------------------
--  DDL for View V_CONS_LINEE_SFONDATE
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "V_CONS_LINEE_SFONDATE" ("ESERCIZIO", "ESERCIZIO_RES", "CD_CENTRO_RESPONSABILITA", "CD_LINEA_ATTIVITA", "TI_APPARTENENZA", "TI_GESTIONE", "CD_ELEMENTO_VOCE", "CD_VOCE", "DISP_COMPETENZA", "DISP_RESIDUI", "IM_STANZ_INIZIALE_A1", "VARIAZIONI_PIU", "VARIAZIONI_MENO", "IM_OBBL_ACC_COMP", "IM_STANZ_RES_IMPROPRIO", "VAR_PIU_STANZ_RES_IMP", "VAR_MENO_STANZ_RES_IMP", "IM_OBBL_RES_IMP", "IM_OBBL_RES_PRO", "VAR_PIU_OBBL_RES_PRO", "VAR_MENO_OBBL_RES_PRO", "IM_MANDATI_REVERSALI_PRO", "IM_MANDATI_REVERSALI_IMP") AS 
  SELECT voce_f_saldi_cdr_linea.ESERCIZIO,
       ESERCIZIO_RES,
       voce_f_saldi_cdr_linea.CD_CENTRO_RESPONSABILITA,
       voce_f_saldi_cdr_linea.CD_LINEA_ATTIVITA,
       voce_f_saldi_cdr_linea.TI_APPARTENENZA,
       voce_f_saldi_cdr_linea.TI_GESTIONE     ,
       voce_f_saldi_cdr_linea.CD_ELEMENTO_VOCE,
       CD_VOCE,
       IM_STANZ_INIZIALE_A1+VARIAZIONI_PIU-VARIAZIONI_MENO-IM_OBBL_ACC_COMP     DISP_COMPETENZA,
       IM_STANZ_RES_IMPROPRIO+VAR_PIU_STANZ_RES_IMP-VAR_MENO_STANZ_RES_IMP-VAR_PIU_OBBL_RES_PRO+VAR_MENO_OBBL_RES_PRO-IM_OBBL_RES_IMP DISP_RESIDUI,
       IM_STANZ_INIZIALE_A1,
       VARIAZIONI_PIU,
       VARIAZIONI_MENO,
       IM_OBBL_ACC_COMP,
       IM_STANZ_RES_IMPROPRIO,
       VAR_PIU_STANZ_RES_IMP  ,
       VAR_MENO_STANZ_RES_IMP,
       IM_OBBL_RES_IMP        ,
       IM_OBBL_RES_PRO,
       VAR_PIU_OBBL_RES_PRO,
       VAR_MENO_OBBL_RES_PRO,
       IM_MANDATI_REVERSALI_PRO,
       IM_MANDATI_REVERSALI_IMP
FROM   voce_f_saldi_cdr_linea, LINEA_ATTIVITA, ELEMENTO_VOCE
WHERE  ((IM_STANZ_INIZIALE_A1+VARIAZIONI_PIU-VARIAZIONI_MENO-IM_OBBL_ACC_COMP < 0) OR
        (voce_f_saldi_cdr_linea.CD_CENTRO_RESPONSABILITA != '999.000.000' And
                IM_STANZ_RES_IMPROPRIO+VAR_PIU_STANZ_RES_IMP-VAR_MENO_STANZ_RES_IMP-VAR_PIU_OBBL_RES_PRO+VAR_MENO_OBBL_RES_PRO-IM_OBBL_RES_IMP < 0)) And
       voce_f_saldi_cdr_linea.CD_CENTRO_RESPONSABILITA = LINEA_ATTIVITA.CD_CENTRO_RESPONSABILITA And
       voce_f_saldi_cdr_linea.CD_LINEA_ATTIVITA        = LINEA_ATTIVITA.CD_LINEA_ATTIVITA       And
       LINEA_ATTIVITA.FL_LIMITE_ASS_OBBLIG = 'Y' And
       ELEMENTO_VOCE.FL_LIMITE_ASS_OBBLIG = 'Y' And
       ELEMENTO_VOCE.ESERCIZIO =        VOCE_F_SALDI_CDR_LINEA.ESERCIZIO And
       ELEMENTO_VOCE.TI_APPARTENENZA =  VOCE_F_SALDI_CDR_LINEA.TI_APPARTENENZA And
       ELEMENTO_VOCE.TI_GESTIONE =      VOCE_F_SALDI_CDR_LINEA.TI_GESTIONE And
       ELEMENTO_VOCE.CD_ELEMENTO_VOCE = VOCE_F_SALDI_CDR_LINEA.CD_ELEMENTO_VOCE;
