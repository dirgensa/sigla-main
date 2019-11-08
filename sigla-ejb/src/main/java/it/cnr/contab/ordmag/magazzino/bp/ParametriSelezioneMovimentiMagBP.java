package it.cnr.contab.ordmag.magazzino.bp;

import it.cnr.contab.ordmag.magazzino.bulk.ParametriSelezioneMovimentiBulk;
import it.cnr.contab.ordmag.magazzino.ejb.MovimentiMagComponentSession;
import it.cnr.jada.action.ActionContext;
import it.cnr.jada.action.BusinessProcessException;
import it.cnr.jada.bulk.OggettoBulk;
import it.cnr.jada.persistency.sql.CompoundFindClause;
import it.cnr.jada.util.RemoteIterator;
import it.cnr.jada.util.action.BulkBP;
import it.cnr.jada.util.ejb.EJBCommonServices;

/**
 * Insert the type's description here.
 * Creation date: (6/17/2002 12:39:16 PM)
 * @author: Roberto Peli
 */
public class ParametriSelezioneMovimentiMagBP extends BulkBP {
/**
 * DocumentiAmministrativiProtocollabiliBP constructor comment.
 */

public ParametriSelezioneMovimentiMagBP() {
	this("");
}
/**
 * DocumentiAmministrativiProtocollabiliBP constructor comment.
 * @param function java.lang.String
 */
public ParametriSelezioneMovimentiMagBP(String function) {
	super(function+"Tn");
}

public ParametriSelezioneMovimentiBulk createEmptyModelForSearch(ActionContext context) throws BusinessProcessException {

	try {
		return createNewBulk(context).initializeForSearch(this,context);
	} catch(Exception e) {
		throw handleException(e);
	}
}
protected void init(it.cnr.jada.action.Config config,it.cnr.jada.action.ActionContext context) throws it.cnr.jada.action.BusinessProcessException {
	super.init(config,context);
	try {
		ParametriSelezioneMovimentiBulk bulk = createEmptyModelForSearch(context);
		bulk = (ParametriSelezioneMovimentiBulk)((MovimentiMagComponentSession)createComponentSession(context)).initializeAbilitazioneMovimentiMagazzino(context.getUserContext(), bulk);
		setModel(context,bulk);
		setDirty(false);
		resetChildren(context);
	} catch(Throwable e) {
		throw new it.cnr.jada.action.BusinessProcessException(e);
	}
}

//protected final BulkHome getHome(UserContext usercontext, Class class1) throws ComponentException{
//    return (BulkHome)getHomeCache(usercontext).getHome(class1);
//}
/**
 * Crea un OggettoBulk vuoto della classe compatibile con la CRUDComponentSession del ricevente
 */
public ParametriSelezioneMovimentiBulk createNewBulk(ActionContext context) throws BusinessProcessException {
	try {
		ParametriSelezioneMovimentiBulk bulk = new ParametriSelezioneMovimentiBulk();
		bulk.setUser(context.getUserInfo().getUserid());
		return bulk;
	} catch(Exception e) {
		throw handleException(e);
	}
}
@Override
public RemoteIterator find(ActionContext actioncontext, CompoundFindClause clauses, OggettoBulk bulk,
		OggettoBulk oggettobulk1, String property) throws BusinessProcessException {
	try {
		it.cnr.jada.ejb.CRUDComponentSession cs = createComponentSession(actioncontext);
		if (cs == null) return null;
		return EJBCommonServices.openRemoteIterator(
				actioncontext,
				cs.cerca(
						actioncontext.getUserContext(),
						clauses,
						bulk, 
						getModel(),
						//(OggettoBulk)((Filtro_ricerca_doc_ammVBulk)getModel()).getInstance(),
						property));
	} catch (it.cnr.jada.comp.ComponentException e) {
		throw handleException(e);
	} catch (java.rmi.RemoteException e) {
		throw handleException(e);
	}

}

public RemoteIterator ricercaMovimenti(ActionContext actioncontext) throws BusinessProcessException {
	try {
		MovimentiMagComponentSession cs = (MovimentiMagComponentSession)createComponentSession(actioncontext);
		if (cs == null) return null;
		ParametriSelezioneMovimentiBulk parametriSelezioneMovimentiBulk = (ParametriSelezioneMovimentiBulk)getModel();
		return cs.ricercaMovimenti(actioncontext.getUserContext(), parametriSelezioneMovimentiBulk);
	} catch (it.cnr.jada.comp.ComponentException e) {
		throw handleException(e);
	} catch (java.rmi.RemoteException e) {
		throw handleException(e);
	}

}

public it.cnr.jada.ejb.CRUDComponentSession createComponentSession(ActionContext actionContext) throws BusinessProcessException {

	return (MovimentiMagComponentSession) createComponentSession(
			"CNRORDMAG00_EJB_MovimentiMagComponentSession",
			MovimentiMagComponentSession.class);

}

protected it.cnr.jada.util.jsp.Button[] createToolbar() {
	it.cnr.jada.util.jsp.Button[] toolbar = new it.cnr.jada.util.jsp.Button[1];
	int i = 0;
	toolbar[i++] = new it.cnr.jada.util.jsp.Button(it.cnr.jada.util.Config.getHandler().getProperties(getClass()),"CRUDToolbar.startSearch");
	return toolbar;
}
}
