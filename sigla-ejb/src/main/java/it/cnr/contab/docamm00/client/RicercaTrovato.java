package it.cnr.contab.docamm00.client;

import it.cnr.brevetti.*;
import it.cnr.contab.docamm00.docs.bulk.TrovatoBulk;
import it.cnr.contab.service.SpringUtil;
import it.cnr.jada.comp.ApplicationException;
import org.apache.axis2.context.ConfigurationContext;
import org.apache.axis2.context.ConfigurationContextFactory;
import org.springframework.core.io.ClassPathResource;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.net.URL;
import java.lang.Exception;

public class RicercaTrovato {

	private static String targetEndpoint; //="http://siglaas4.cedrc.cnr.it:8480/";
	private static URL axis2Home;

	private static URL axis2TrovatoConf;

	private static String siglaWSClientPassword;
	public RicercaTrovato() throws FileNotFoundException, IOException {
		super();
//		recuperoTrovatoProperties();
		// carica le proprietÓ solo alla prima occorrenza della classe
//		if (getTargetEndpoint()==null)
			loadProperties();
	}

	private TrovatoProperties recuperoTrovatoProperties() {
		TrovatoProperties trovatoProperties = SpringUtil.getBean("trovatoProperties",TrovatoProperties.class);
		return trovatoProperties;
	}

//	public static String getTargetEndpoint() {
//		return targetEndpoint;
//	}
//
//	public static void setTargetEndpoint(String targetEndpoint) {
//		RicercaTrovato.targetEndpoint = targetEndpoint;
//	}
//
	private static ConfigurationContext axis2ConfContext() throws Exception   {

		return ConfigurationContextFactory.createConfigurationContextFromURIs(getAxis2TrovatoConf(), getAxis2Home());
	}

	public TrovatoBulk ricercaDatiTrovato(it.cnr.jada.UserContext userContext,Long trovato, Boolean soloValidi) throws Exception {
		TrovatoBulk trovatoBulk = new TrovatoBulk();
		ConfigurationContext ctx = axis2ConfContext();
		if (trovato == null){
			throw new ApplicationException("Identificativo del trovato non indicato.");
		} else {
			trovatoBulk = cerca(ctx, trovato, soloValidi);
		}
		return trovatoBulk;
	}

	public TrovatoBulk ricercaDatiTrovato(it.cnr.jada.UserContext userContext,Long trovato) throws Exception {
		return ricercaDatiTrovato(userContext, trovato, false);
	}

	private TrovatoBulk cerca(ConfigurationContext ctx, Long pgTrovato, Boolean soloValidi) throws Exception {
        TrovatiWebServiceBeanServiceStub stub = new TrovatiWebServiceBeanServiceStub(ctx,getTargetEndpoint()+"/brevetti/ws/TrovatiWebServiceBean");

        TrovatoBulk trovatoBulk = new TrovatoBulk();

        if (soloValidi){
            FindTrovatoValidoE trovatoE = new FindTrovatoValidoE();
            FindTrovatoValido trovato = new FindTrovatoValido();
            trovato.setNsrif(pgTrovato.intValue());
            trovatoE.setFindTrovatoValido(trovato);

    		FindTrovatoValidoResponseE respE = stub.findTrovatoValido(trovatoE);

    		if (respE.getFindTrovatoValidoResponse().getResult()!=null) {
    			TrovatoBean trovatoBean = respE.getFindTrovatoValidoResponse().getResult();
    			valorizzaTrovato(trovatoBulk, trovatoBean);
    		} else {
    			throw new ApplicationException("Identificativo del trovato indicato non esiste.");
    		}
        } else {
            FindTrovatoE trovatoE = new FindTrovatoE();
            FindTrovato trovato = new FindTrovato();
            trovato.setNsrif(pgTrovato.intValue());
            trovatoE.setFindTrovato(trovato);

    		FindTrovatoResponseE respE = stub.findTrovato(trovatoE);

    		if (respE.getFindTrovatoResponse().getResult()!=null) {
    			TrovatoBean trovatoBean = respE.getFindTrovatoResponse().getResult();
    			valorizzaTrovato(trovatoBulk, trovatoBean);
    		} else {
    			throw new ApplicationException("Identificativo del trovato indicato non esiste.");
    		}
        }
	    return trovatoBulk;
	}

	private void valorizzaTrovato(TrovatoBulk trovatoBulk,
			TrovatoBean trovatoBean) {
		trovatoBulk.setPg_trovato(new Long(trovatoBean.getNsrif()));
		trovatoBulk.setInventore(trovatoBean.getInventore());
		trovatoBulk.setTitolo(trovatoBean.getTitolo());
	}

	public synchronized void loadProperties() throws FileNotFoundException, IOException {
		TrovatoProperties trovatoProperties = recuperoTrovatoProperties();
		setTargetEndpoint(trovatoProperties.getTrovatoTargetEndpoint());
		PWCBHandler.setSiglaClientWSPassword(trovatoProperties.getTrovatoSiglaWSClientPassword());

		URL urlAxis2 = new ClassPathResource("axis2/").getURL();

		if (urlAxis2 != null){
			setAxis2Home(urlAxis2);
//			if (getAxis2Home().startsWith("file:")){
//				String axis2Home = getAxis2Home().substring(5);
//				if (axis2Home != null){
//					setAxis2Home(axis2Home.replace("!", "-contents"));
//				}
//			}
			setAxis2TrovatoConf(new URL(getAxis2Home()+"axis2-brevetti.xml"));
		} else {

		}
//		setAxis2TrovatoConf(getAxis2Home()+"axis2-brevetti.xml");

	}

	public static String getTargetEndpoint() {
		return targetEndpoint;
	}


	public static void setTargetEndpoint(String targetEndpoint) {
		RicercaTrovato.targetEndpoint = targetEndpoint;
	}

	public static String getSiglaWSClientPassword() {
		return siglaWSClientPassword;
	}

	public static void setSiglaWSClientPassword(String siglaWSClientPassword) {
		RicercaTrovato.siglaWSClientPassword = siglaWSClientPassword;
	}

	public static URL getAxis2Home() {
		return axis2Home;
	}

	public static void setAxis2Home(URL axis2Home) {
		RicercaTrovato.axis2Home = axis2Home;
	}

	public static URL getAxis2TrovatoConf() {
		return axis2TrovatoConf;
	}

	public static void setAxis2TrovatoConf(URL axis2TrovatoConf) {
		RicercaTrovato.axis2TrovatoConf = axis2TrovatoConf;
	}
}
