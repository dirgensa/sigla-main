/*
 * Created by BulkGenerator 2.0 [07/12/2009]
 * Date 15/12/2010
 */
package it.cnr.contab.config00.pdcfin.bulk;
import it.cnr.jada.bulk.OggettoBulk;
import it.cnr.jada.persistency.KeyedPersistent;
public class LimiteSpesaKey extends OggettoBulk implements KeyedPersistent {
	private java.lang.Integer esercizio;
	private java.lang.String ti_appartenenza;
	private java.lang.String ti_gestione;
	private java.lang.String cd_elemento_voce;
	private java.lang.String fonte;
	/**
	 * Created by BulkGenerator 2.0 [07/12/2009]
	 * Table name: LIMITE_SPESA
	 **/
	public LimiteSpesaKey() {
		super();
	}
	public LimiteSpesaKey(java.lang.Integer esercizio, java.lang.String tiAppartenenza, java.lang.String tiGestione, java.lang.String cdElementoVoce, java.lang.String fonte) {
		super();
		this.esercizio=esercizio;
		this.ti_appartenenza=tiAppartenenza;
		this.ti_gestione=tiGestione;
		this.cd_elemento_voce=cdElementoVoce;
		this.fonte=fonte;
	}
	public boolean equalsByPrimaryKey(Object o) {
		if (this== o) return true;
		if (!(o instanceof LimiteSpesaKey)) return false;
		LimiteSpesaKey k = (LimiteSpesaKey) o;
		if (!compareKey(getEsercizio(), k.getEsercizio())) return false;
		if (!compareKey(getTi_appartenenza(), k.getTi_appartenenza())) return false;
		if (!compareKey(getTi_gestione(), k.getTi_gestione())) return false;
		if (!compareKey(getCd_elemento_voce(), k.getCd_elemento_voce())) return false;
		if (!compareKey(getFonte(), k.getFonte())) return false;
		return true;
	}
	public int primaryKeyHashCode() {
		int i = 0;
		i = i + calculateKeyHashCode(getEsercizio());
		i = i + calculateKeyHashCode(getTi_appartenenza());
		i = i + calculateKeyHashCode(getTi_gestione());
		i = i + calculateKeyHashCode(getCd_elemento_voce());
		i = i + calculateKeyHashCode(getFonte());
		return i;
	}
	/**
	 * Created by BulkGenerator 2.0 [07/12/2009]
	 * Restituisce il valore di: [esercizio]
	 **/
	public void setEsercizio(java.lang.Integer esercizio)  {
		this.esercizio=esercizio;
	}
	/**
	 * Created by BulkGenerator 2.0 [07/12/2009]
	 * Setta il valore di: [esercizio]
	 **/
	public java.lang.Integer getEsercizio() {
		return esercizio;
	}
	
	/**
	 * Created by BulkGenerator 2.0 [07/12/2009]
	 * Restituisce il valore di: [fonte]
	 **/
	public void setFonte(java.lang.String fonte)  {
		this.fonte=fonte;
	}
	/**
	 * Created by BulkGenerator 2.0 [07/12/2009]
	 * Setta il valore di: [fonte]
	 **/
	public java.lang.String getFonte() {
		return fonte;
	}
	public java.lang.String getTi_appartenenza() {
		return ti_appartenenza;
	}
	public void setTi_appartenenza(java.lang.String ti_appartenenza) {
		this.ti_appartenenza = ti_appartenenza;
	}
	public java.lang.String getTi_gestione() {
		return ti_gestione;
	}
	public void setTi_gestione(java.lang.String ti_gestione) {
		this.ti_gestione = ti_gestione;
	}
	public java.lang.String getCd_elemento_voce() {
		return cd_elemento_voce;
	}
	public void setCd_elemento_voce(java.lang.String cd_elemento_voce) {
		this.cd_elemento_voce = cd_elemento_voce;
	}
}