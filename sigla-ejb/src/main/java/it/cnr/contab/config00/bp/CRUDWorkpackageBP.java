package it.cnr.contab.config00.bp;


import it.cnr.contab.config00.blob.bulk.*;
import it.cnr.contab.config00.latt.bulk.*;
import it.cnr.contab.progettiric00.ejb.ProgettoRicercaPadreComponentSession;
import it.cnr.contab.utenze00.bp.CNRUserContext;
import it.cnr.jada.UserContext;
import it.cnr.jada.action.*;
import it.cnr.jada.bulk.*;
import it.cnr.jada.util.SendMail;
import it.cnr.jada.util.action.*;

public class CRUDWorkpackageBP extends SimpleCRUDBP {
	private final SimpleDetailCRUDController risultati = new SimpleDetailCRUDController("risultati",it.cnr.contab.config00.latt.bulk.RisultatoBulk.class,"risultati",this);
	private SimpleDetailCRUDController crudDettagliPostIt = new SimpleDetailCRUDController( "DettagliPostIt", PostItBulk.class, "dettagliPostIt", this);
public CRUDWorkpackageBP() {
	super();
}
public CRUDWorkpackageBP(String function) {
	super(function);
}
/**
 * Ritorna i risultati della linea di attivit�
 * 
 * @return it.cnr.jada.util.action.SimpleDetailCRUDController
 */
public final it.cnr.jada.util.action.SimpleDetailCRUDController getRisultati() {
	return risultati;
}
/*Angelo 18/11/2004 Aggiunta gestione PostIt*/
public final it.cnr.jada.util.action.SimpleDetailCRUDController getCrudDettagliPostIt() {
	return crudDettagliPostIt;
}
public boolean isDeleteButtonEnabled() {
	it.cnr.contab.config00.latt.bulk.WorkpackageBulk tipo_la = (it.cnr.contab.config00.latt.bulk.WorkpackageBulk)getModel();
	return
		super.isDeleteButtonEnabled() &&
		tipo_la != null &&
	    (tipo_la.getTipo_linea_attivita() != null) &&
        (tipo_la.getTipo_linea_attivita().getTi_tipo_la().equals(it.cnr.contab.config00.latt.bulk.Tipo_linea_attivitaBulk.PROPRIA));
}
public void reset(ActionContext context) throws BusinessProcessException {
	super.reset(context);
	resetTabs();
}
public void resetForSearch(ActionContext context) throws BusinessProcessException {
	super.resetForSearch(context);
	resetTabs();
}
private void resetTabs() {
	setTab("tab","tabTestata");
}

/* 
 * Necessario per la creazione di una form con enctype di tipo "multipart/form-data"
 * Sovrascrive quello presente nelle superclassi
 * 
*/

public void openForm(javax.servlet.jsp.PageContext context,String action,String target) throws java.io.IOException,javax.servlet.ServletException {

		openForm(context,action,target,"multipart/form-data");
	
}
public static ProgettoRicercaPadreComponentSession getProgettoRicercaPadreComponentSession() throws javax.ejb.EJBException, java.rmi.RemoteException {
	return (ProgettoRicercaPadreComponentSession)it.cnr.jada.util.ejb.EJBCommonServices.createEJB("CNRPROGETTIRIC00_EJB_ProgettoRicercaPadreComponentSession",ProgettoRicercaPadreComponentSession.class);
}	
private void aggiornaGECO(UserContext userContext) {
	try {
		getProgettoRicercaPadreComponentSession().aggiornaGECO(userContext);
	} catch (Exception e) {
		String text = "Errore interno del Server Utente:"+CNRUserContext.getUser(userContext);
		SendMail.getInstance().sendErrorMail(text,e.toString());
	}
}

@Override
protected void initialize(ActionContext actioncontext) throws BusinessProcessException {
	aggiornaGECO(actioncontext.getUserContext());
	super.initialize(actioncontext);
}
/*
 * Utilizzato per la gestione del bottone di attivazione del PostIt
 * Sovrascrive il metodo di SimpleCRUDBP
 * */
public boolean isActive(OggettoBulk bulk,int sel) {
  if (bulk instanceof WorkpackageBulk)	
	try
	{
		return ((PostItBulk) ((WorkpackageBulk)bulk).getDettagliPostIt().get(sel)).isROpostit();
	}
	catch (RuntimeException e)
	{
		if (sel==0)
		return false;
		else
		e.printStackTrace();
	}
	return false;
}

}
