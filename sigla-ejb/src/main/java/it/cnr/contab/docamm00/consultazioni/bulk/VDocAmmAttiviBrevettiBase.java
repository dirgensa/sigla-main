/*
 * Created by BulkGenerator 2.0 [07/12/2009]
 * Date 12/09/2016
 */
package it.cnr.contab.docamm00.consultazioni.bulk;
import it.cnr.jada.persistency.Keyed;
public class VDocAmmAttiviBrevettiBase extends VDocAmmAttiviBrevettiKey implements Keyed {
//    DS_FATTURA_ATTIVA VARCHAR(1000)
	private java.lang.String dsFatturaAttiva;
 
//    CD_CDS_ORIGINE VARCHAR(30) NOT NULL
	private java.lang.String cdCdsOrigine;
 
//    CD_UO_ORIGINE VARCHAR(30) NOT NULL
	private java.lang.String cdUoOrigine;
 
//    DT_REGISTRAZIONE TIMESTAMP(7) NOT NULL
	private java.sql.Timestamp dtRegistrazione;
 
//    CD_TERZO DECIMAL(8,0) NOT NULL
	private java.lang.Integer cdTerzo;
 
//    COGNOME VARCHAR(50)
	private java.lang.String cognome;
 
//    NOME VARCHAR(50)
	private java.lang.String nome;
 
//    RAGIONE_SOCIALE VARCHAR(100)
	private java.lang.String ragioneSociale;
 
//    CAMBIO DECIMAL(15,4) NOT NULL
	private java.math.BigDecimal cambio;
 
//    CD_DIVISA VARCHAR(10) NOT NULL
	private java.lang.String cdDivisa;
 
	/**
	 * Created by BulkGenerator 2.0 [07/12/2009]
	 * Table name: V_DOC_AMM_ATTIVI_BREVETTI
	 **/
	public VDocAmmAttiviBrevettiBase() {
		super();
	}
	public VDocAmmAttiviBrevettiBase(java.lang.String cd_cds,java.lang.String cd_unita_organizzativa,java.lang.Integer esercizio,java.lang.Long pg_fattura_attiva,java.lang.String tipoFattura) {
		super(cd_cds,cd_unita_organizzativa,esercizio,pg_fattura_attiva,tipoFattura);
	}
	/**
	 * Created by BulkGenerator 2.0 [07/12/2009]
	 * Restituisce il valore di: [dsFatturaAttiva]
	 **/
	public java.lang.String getDsFatturaAttiva() {
		return dsFatturaAttiva;
	}
	/**
	 * Created by BulkGenerator 2.0 [07/12/2009]
	 * Setta il valore di: [dsFatturaAttiva]
	 **/
	public void setDsFatturaAttiva(java.lang.String dsFatturaAttiva)  {
		this.dsFatturaAttiva=dsFatturaAttiva;
	}
	/**
	 * Created by BulkGenerator 2.0 [07/12/2009]
	 * Restituisce il valore di: [cdCdsOrigine]
	 **/
	public java.lang.String getCdCdsOrigine() {
		return cdCdsOrigine;
	}
	/**
	 * Created by BulkGenerator 2.0 [07/12/2009]
	 * Setta il valore di: [cdCdsOrigine]
	 **/
	public void setCdCdsOrigine(java.lang.String cdCdsOrigine)  {
		this.cdCdsOrigine=cdCdsOrigine;
	}
	/**
	 * Created by BulkGenerator 2.0 [07/12/2009]
	 * Restituisce il valore di: [cdUoOrigine]
	 **/
	public java.lang.String getCdUoOrigine() {
		return cdUoOrigine;
	}
	/**
	 * Created by BulkGenerator 2.0 [07/12/2009]
	 * Setta il valore di: [cdUoOrigine]
	 **/
	public void setCdUoOrigine(java.lang.String cdUoOrigine)  {
		this.cdUoOrigine=cdUoOrigine;
	}
	/**
	 * Created by BulkGenerator 2.0 [07/12/2009]
	 * Restituisce il valore di: [dtRegistrazione]
	 **/
	public java.sql.Timestamp getDtRegistrazione() {
		return dtRegistrazione;
	}
	/**
	 * Created by BulkGenerator 2.0 [07/12/2009]
	 * Setta il valore di: [dtRegistrazione]
	 **/
	public void setDtRegistrazione(java.sql.Timestamp dtRegistrazione)  {
		this.dtRegistrazione=dtRegistrazione;
	}
	/**
	 * Created by BulkGenerator 2.0 [07/12/2009]
	 * Restituisce il valore di: [cdTerzo]
	 **/
	public java.lang.Integer getCdTerzo() {
		return cdTerzo;
	}
	/**
	 * Created by BulkGenerator 2.0 [07/12/2009]
	 * Setta il valore di: [cdTerzo]
	 **/
	public void setCdTerzo(java.lang.Integer cdTerzo)  {
		this.cdTerzo=cdTerzo;
	}
	/**
	 * Created by BulkGenerator 2.0 [07/12/2009]
	 * Restituisce il valore di: [cognome]
	 **/
	public java.lang.String getCognome() {
		return cognome;
	}
	/**
	 * Created by BulkGenerator 2.0 [07/12/2009]
	 * Setta il valore di: [cognome]
	 **/
	public void setCognome(java.lang.String cognome)  {
		this.cognome=cognome;
	}
	/**
	 * Created by BulkGenerator 2.0 [07/12/2009]
	 * Restituisce il valore di: [nome]
	 **/
	public java.lang.String getNome() {
		return nome;
	}
	/**
	 * Created by BulkGenerator 2.0 [07/12/2009]
	 * Setta il valore di: [nome]
	 **/
	public void setNome(java.lang.String nome)  {
		this.nome=nome;
	}
	/**
	 * Created by BulkGenerator 2.0 [07/12/2009]
	 * Restituisce il valore di: [ragioneSociale]
	 **/
	public java.lang.String getRagioneSociale() {
		return ragioneSociale;
	}
	/**
	 * Created by BulkGenerator 2.0 [07/12/2009]
	 * Setta il valore di: [ragioneSociale]
	 **/
	public void setRagioneSociale(java.lang.String ragioneSociale)  {
		this.ragioneSociale=ragioneSociale;
	}
	/**
	 * Created by BulkGenerator 2.0 [07/12/2009]
	 * Restituisce il valore di: [cambio]
	 **/
	public java.math.BigDecimal getCambio() {
		return cambio;
	}
	/**
	 * Created by BulkGenerator 2.0 [07/12/2009]
	 * Setta il valore di: [cambio]
	 **/
	public void setCambio(java.math.BigDecimal cambio)  {
		this.cambio=cambio;
	}
	/**
	 * Created by BulkGenerator 2.0 [07/12/2009]
	 * Restituisce il valore di: [cdDivisa]
	 **/
	public java.lang.String getCdDivisa() {
		return cdDivisa;
	}
	/**
	 * Created by BulkGenerator 2.0 [07/12/2009]
	 * Setta il valore di: [cdDivisa]
	 **/
	public void setCdDivisa(java.lang.String cdDivisa)  {
		this.cdDivisa=cdDivisa;
	}
}