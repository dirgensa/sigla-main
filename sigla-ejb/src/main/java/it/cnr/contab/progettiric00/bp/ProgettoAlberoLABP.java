package it.cnr.contab.progettiric00.bp;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;

import it.cnr.contab.progettiric00.core.bulk.ProgettoBulk;
import it.cnr.contab.progettiric00.core.bulk.Progetto_sipBulk;
import it.cnr.jada.bulk.OggettoBulk;
import it.cnr.jada.util.action.SelezionatoreListaAlberoBP;

/**
 * BusinessProcess che presenta i Progetti sotto forma di Albero
 */
public class ProgettoAlberoLABP extends SelezionatoreListaAlberoBP {
	private Integer livelloMax = ProgettoBulk.LIVELLO_PROGETTO_TERZO;
	
	public ProgettoAlberoLABP() {
		super();
	}

	public ProgettoAlberoLABP(Integer livelloMax) {
		super();
		setLivelloMax(livelloMax);
	}

	public void writeHistoryLabel(PageContext pagecontext)
		throws IOException, ServletException
	{
		JspWriter jspwriter = pagecontext.getOut();
		jspwriter.println("<span class=\"FormLabel\">Struttura del progetto: </span>");
	}

	public boolean isBringBackButtonEnabled()
	{
		if (getFocusedElement()!=null) {
			Progetto_sipBulk rec = (Progetto_sipBulk) getFocusedElement();
			Integer livello = rec.getLivello();
			if (livello.compareTo(livelloMax)==0)
				return true;
		}
		return false;
	}

	public boolean isExpandButtonEnabled()
	{
		if (!super.isExpandButtonEnabled())
			return false;

		if (getFocusedElement()!=null) {
			Progetto_sipBulk rec = (Progetto_sipBulk) getFocusedElement();
			Integer livello = rec.getLivello();
			if (livello.compareTo(livelloMax)<0)
				return true;
		}
		return false;
	}
	public void setParentElement(OggettoBulk oggettobulk) {
		Progetto_sipBulk progetto = (Progetto_sipBulk)oggettobulk;
		if (ProgettoBulk.LIVELLO_PROGETTO_SECONDO.equals(livelloMax)) {
			if (progetto != null && progetto.getLivello() != null){
				if (progetto.getLivello().equals(ProgettoBulk.LIVELLO_PROGETTO_PRIMO))
				  setColumns( getBulkInfo().getColumnFieldPropertyDictionary("progetto_liv2"));
				else if (progetto.getLivello().equals(ProgettoBulk.LIVELLO_PROGETTO_SECONDO))
				  setColumns( getBulkInfo().getColumnFieldPropertyDictionary("moduli_sip")); 
			}else
			  setColumns( getBulkInfo().getColumnFieldPropertyDictionary("progetto_liv1"));
		} else {
			if (progetto != null && progetto.getLivello() != null){
				if (progetto.getLivello().equals(ProgettoBulk.LIVELLO_PROGETTO_PRIMO))
				  setColumns( getBulkInfo().getColumnFieldPropertyDictionary("commesse_sip"));
				else if (progetto.getLivello().equals(ProgettoBulk.LIVELLO_PROGETTO_SECONDO))
				  setColumns( getBulkInfo().getColumnFieldPropertyDictionary("moduli_sip")); 
			}else
			  setColumns( getBulkInfo().getColumnFieldPropertyDictionary("progetti_sip"));
		} 
		super.setParentElement(oggettobulk);
	}

	public void setLivelloMax(Integer livelloMax) {
		this.livelloMax = livelloMax;
	}
	
	public Integer getLivelloMax() {
		return livelloMax;
	}
}
