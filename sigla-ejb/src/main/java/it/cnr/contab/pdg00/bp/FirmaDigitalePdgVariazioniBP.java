package it.cnr.contab.pdg00.bp;

import it.cnr.contab.cmis.CMISAspect;
import it.cnr.contab.cmis.CMISRelationship;
import it.cnr.contab.cmis.MimeTypes;
import it.cnr.contab.cmis.service.CMISPath;
import it.cnr.contab.cmis.service.SiglaCMISService;
import it.cnr.contab.config00.bulk.Parametri_cdsBulk;
import it.cnr.contab.config00.bulk.Parametri_enteBulk;
import it.cnr.contab.config00.bulk.ServizioPecBulk;
import it.cnr.contab.config00.sto.bulk.CdrBulk;
import it.cnr.contab.config00.sto.bulk.CdsBulk;
import it.cnr.contab.config00.sto.bulk.Tipo_unita_organizzativaHome;
import it.cnr.contab.config00.sto.bulk.UnitaOrganizzativaPecBulk;
import it.cnr.contab.config00.sto.bulk.Unita_organizzativaBulk;
import it.cnr.contab.firma.bulk.FirmaOTPBulk;
import it.cnr.contab.pdg00.bulk.ArchiviaStampaPdgVariazioneBulk;
import it.cnr.contab.pdg00.bulk.Pdg_variazioneBulk;
import it.cnr.contab.pdg00.bulk.cmis.AllegatoPdGVariazioneSignedDocument;
import it.cnr.contab.pdg00.bulk.cmis.PdgVariazioneDocument;
import it.cnr.contab.pdg00.ejb.PdGVariazioniComponentSession;
import it.cnr.contab.pdg00.service.PdgVariazioniService;
import it.cnr.contab.service.SpringUtil;
import it.cnr.contab.utenze00.bp.CNRUserContext;
import it.cnr.contab.util.Utility;
import it.cnr.jada.DetailedException;
import it.cnr.jada.action.ActionContext;
import it.cnr.jada.action.BusinessProcessException;
import it.cnr.jada.action.Config;
import it.cnr.jada.action.HttpActionContext;
import it.cnr.jada.bulk.BulkInfo;
import it.cnr.jada.bulk.BulkList;
import it.cnr.jada.bulk.OggettoBulk;
import it.cnr.jada.bulk.ValidationException;
import it.cnr.jada.comp.ApplicationException;
import it.cnr.jada.comp.ComponentException;
import it.cnr.jada.firma.DatiPEC;
import it.cnr.jada.firma.FirmaInfos;
import it.cnr.jada.firma.NotSignedEnvelopeException;
import it.cnr.jada.firma.Verifica;
import it.cnr.jada.firma.bp.SendPecMail;
import it.cnr.jada.util.ListRemoteIterator;
import it.cnr.jada.util.ejb.EJBCommonServices;
import it.cnr.jada.util.jsp.Button;
import it.cnr.jada.util.jsp.JSPUtils;
import it.cnr.jada.util.upload.UploadedFile;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.StringReader;
import java.rmi.RemoteException;
import java.util.List;

import javax.ejb.EJBException;
import javax.servlet.ServletException;

import org.apache.chemistry.opencmis.client.api.CmisObject;
import org.apache.chemistry.opencmis.client.api.Document;
import org.apache.chemistry.opencmis.client.bindings.spi.http.Response;
import org.apache.chemistry.opencmis.commons.impl.UrlBuilder;
import org.apache.commons.httpclient.HttpException;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.util.URIUtil;
import org.apache.commons.io.IOUtils;
import org.json.JSONObject;
import org.json.JSONTokener;

/**
 * Insert the type's description here. Creation date: (11/04/2002 17:28:04)
 * 
 * @author: CNRADM
 */
public class FirmaDigitalePdgVariazioniBP extends
		it.cnr.jada.util.action.SelezionatoreListaBP implements FirmaInfos {
	private boolean signEnabled;
	private boolean signFile;
	private boolean uploadFile;
	private DatiPEC datiPEC = new DatiPEC();
	public static String PEC_PROTOCOLLO = "PROTOCOLLO";
	public static String PEC_BILANCIO = "BILANCIO";
	private PdgVariazioniService pdgVariazioniService;
	private boolean testSession=false; // sessione di test per la firma digitale, evita in qualunque modo la registrazione dati in ALFRESCO
	private String nomeFileTest="test-file.pdf";
	private String nomeFilePathTest=System.getProperty("tmp.dir.SIGLAWeb")+"applets/"+nomeFileTest;
	private String nomeFileTestFirmato;
	/**
	 * SpoolerStatusBP constructor comment.
	 * 
	 * @param function
	 *            java.lang.String
	 */
	public FirmaDigitalePdgVariazioniBP() {
		super();
		table.setMultiSelection(true);
		setBulkInfo(BulkInfo.getBulkInfo(ArchiviaStampaPdgVariazioneBulk.class));
	}

	public FirmaDigitalePdgVariazioniBP(String function) {
		this();
		if (function.equals("T"))
			testSession=true;
	}

	public PdGVariazioniComponentSession createComponentSession()
			throws BusinessProcessException {
		return (PdGVariazioniComponentSession) createComponentSession(
				"CNRPDG00_EJB_PdGVariazioniComponentSession",
				PdGVariazioniComponentSession.class);
	}

	@Override
	protected void setFocusedElement(ActionContext actioncontext, Object obj)
			throws BusinessProcessException {
		if (obj != null) {
			ArchiviaStampaPdgVariazioneBulk bulk = (ArchiviaStampaPdgVariazioneBulk) getModel();
			bulk.setPdg_variazioneForPrint((Pdg_variazioneBulk) obj);
			if (!isTestSession()) {
				try {
					bulk.setPdgVariazioneDocument(pdgVariazioniService
							.getPdgVariazioneDocument(bulk));
				} catch (DetailedException e) {
					throw handleException(e);
				}
			} else {
				PdgVariazioneDocument varDoc = new PdgVariazioneDocument(null);
				bulk.setPdgVariazioneDocument(varDoc);
			}
			super.setFocusedElement(actioncontext, bulk);
		} else
			super.setFocusedElement(actioncontext, obj);
	}

	public void openForm(javax.servlet.jsp.PageContext context,String action,String target) throws java.io.IOException,javax.servlet.ServletException {

		if (isUploadFile())
			openForm(context,action,target,"multipart/form-data");
		else
			super.openForm(context, action, target);
	}
	
	public it.cnr.jada.util.jsp.Button[] createToolbar() {
		Button[] toolbar = new Button[8];
		int i = 0;
		toolbar[i++] = new it.cnr.jada.util.jsp.Button(it.cnr.jada.util.Config
				.getHandler().getProperties(getClass()), "Toolbar.refresh");
		toolbar[i++] = new it.cnr.jada.util.jsp.Button(it.cnr.jada.util.Config
				.getHandler().getProperties(getClass()), "Toolbar.print");
		toolbar[i++] = new it.cnr.jada.util.jsp.Button(it.cnr.jada.util.Config
				.getHandler().getProperties(getClass()), "Toolbar.download");
		toolbar[i++] = new it.cnr.jada.util.jsp.Button(it.cnr.jada.util.Config
				.getHandler().getProperties(getClass()), "Toolbar.sign");
		toolbar[i++] = new it.cnr.jada.util.jsp.Button(it.cnr.jada.util.Config
				.getHandler().getProperties(getClass()), "Toolbar.signOTP");
		toolbar[i++] = new it.cnr.jada.util.jsp.Button(it.cnr.jada.util.Config
				.getHandler().getProperties(getClass()), "Toolbar.upload");
		toolbar[i++] = new it.cnr.jada.util.jsp.Button(it.cnr.jada.util.Config
				.getHandler().getProperties(getClass()), "Toolbar.printSigned");
		toolbar[i++] = new it.cnr.jada.util.jsp.Button(it.cnr.jada.util.Config
				.getHandler().getProperties(getClass()), "Toolbar.installa");
		toolbar[i-1].setSeparator(true);
		return toolbar;
	}

	public void writeToolbar(javax.servlet.jsp.PageContext pageContext)
			throws java.io.IOException, javax.servlet.ServletException {
		Button[] toolbar = getToolbar();
		ArchiviaStampaPdgVariazioneBulk bulk = (ArchiviaStampaPdgVariazioneBulk) getFocusedElement();
		if (bulk != null) {
			String nomeFileAllegato="";
			if (!isTestSession())
				nomeFileAllegato = bulk.getPdgVariazioneDocument().getDocument().getName();
			else
				nomeFileAllegato = nomeFileTest;

			toolbar[1]
					.setHref("doPrint('"
							+ JSPUtils
									.buildAbsoluteUrl(
											pageContext,
											null,
											"genericdownload/"
													+ nomeFileAllegato
													+ "?methodName=scaricaFile&it.cnr.jada.action.BusinessProcess="
													+ getPath()) + "')");
			toolbar[2]
					.setHref("doPrint('"
							+ JSPUtils
									.buildAbsoluteUrl(
											pageContext,
											null,
											"genericdownload/"
													+ nomeFileAllegato
													+ "?methodName=scaricaFileGenerico&it.cnr.jada.action.BusinessProcess="
													+ getPath()) + "')");
			Document nodeSignedFile = null;
			try {
				nodeSignedFile = getNodeFileFirmato(bulk
						.getPdgVariazioneDocument()
						.getDocument());
				String signedFileName = null;
				if (!isTestSession()) {
					if (nodeSignedFile!=null)
						signedFileName=getNodeFileFirmato(bulk
							.getPdgVariazioneDocument()
							.getDocument()).getName();
				} else {
					signedFileName = nomeFileTestFirmato;
					if (signedFileName!=null)
						signedFileName= signedFileName.replace("\\", "/");
				}
				if (signedFileName!=null)
					toolbar[6]
						.setHref("doPrint('"
								+ JSPUtils
										.buildAbsoluteUrl(
												pageContext,
												null,
												"genericdownload/"
														+ signedFileName
														+ "?methodName=scaricaFileFirmato&it.cnr.jada.action.BusinessProcess="
														+ getPath()) + "')");
			} catch (ApplicationException e) {
				throw new ServletException(e);
			}
		}
		else {
			toolbar[1].setHref(null);
			toolbar[2].setHref(null);
			toolbar[6].setHref(null);
		}
		writeToolbar(pageContext.getOut(), toolbar);
	}

	protected void init(Config config, ActionContext context)
			throws BusinessProcessException {
		super.init(config, context);
		setMultiSelection(false);
		if (!isTestSession())
			pdgVariazioniService = SpringUtil.getBean("pdgVariazioniService",
				PdgVariazioniService.class);
		ArchiviaStampaPdgVariazioneBulk bulk = new ArchiviaStampaPdgVariazioneBulk();
		bulk.setTiSigned(ArchiviaStampaPdgVariazioneBulk.VIEW_NOT_SIGNED);
		setModel(context, bulk);
		refresh(context);
	}

	public boolean isPrintButtonEnabled() {
		return getFocusedElement() != null;
	}

	public boolean isUploadButtonEnabled() {
		ArchiviaStampaPdgVariazioneBulk bulk = (ArchiviaStampaPdgVariazioneBulk) getFocusedElement();
		if (!isTestSession())
			return getFocusedElement() != null
				&& !isUploadFile()
				&& !pdgVariazioniService.hasAspect(bulk.getPdgVariazioneDocument().getDocument(),
						CMISAspect.CNR_SIGNEDDOCUMENT.value());
		else
			return getFocusedElement() != null;
	}

	public boolean isInviaButtonEnabled() {
		ArchiviaStampaPdgVariazioneBulk bulk = (ArchiviaStampaPdgVariazioneBulk) getFocusedElement();
		if (!isTestSession())
			return getFocusedElement() != null
				&& !pdgVariazioniService.hasAspect(bulk.getPdgVariazioneDocument().getDocument(),
						CMISAspect.CNR_SIGNEDDOCUMENT.value());
		else
			return getFocusedElement() != null;
	}

	public boolean isPrintSignedButtonEnabled() {
		ArchiviaStampaPdgVariazioneBulk bulk = (ArchiviaStampaPdgVariazioneBulk) getFocusedElement();
		if (!isTestSession())
			return getFocusedElement() != null && pdgVariazioniService.hasAspect(bulk.getPdgVariazioneDocument().getDocument(),
				CMISAspect.CNR_SIGNEDDOCUMENT.value());
		else
			return getFocusedElement() != null;
	}

	public boolean isSignButtonEnabled() {
		ArchiviaStampaPdgVariazioneBulk bulk = (ArchiviaStampaPdgVariazioneBulk) getFocusedElement();
		if (!isTestSession())
			return getFocusedElement() != null
				&& !pdgVariazioniService.hasAspect(bulk.getPdgVariazioneDocument().getDocument(),
						CMISAspect.CNR_SIGNEDDOCUMENT.value());
		else
			return getFocusedElement() != null;
	}

	public boolean isInstButtonEnabled() {
		return true;
	}

	public void refresh(ActionContext context) throws BusinessProcessException {
		try {
			EJBCommonServices.closeRemoteIterator(getIterator());
			if (!isTestSession())
					setIterator(context, EJBCommonServices.openRemoteIterator(context,
							createComponentSession().cercaVariazioniForDocumentale(
									context.getUserContext(),
									null,
									new Pdg_variazioneBulk(),
									((ArchiviaStampaPdgVariazioneBulk) getModel())
											.getTiSigned(), Boolean.TRUE)));
			else {
				Pdg_variazioneBulk bulk = new Pdg_variazioneBulk();
				CdsBulk cds = null;
				Unita_organizzativaBulk uo = null;
				CdrBulk cdr = null;
				try {
					cds = Utility.createParametriEnteComponentSession().getCds(
							context.getUserContext(),
							CNRUserContext.getCd_cds((CNRUserContext) context
									.getUserContext()));
					uo = Utility.createParametriEnteComponentSession().getUo(
							context.getUserContext(),
							CNRUserContext
									.getCd_unita_organizzativa((CNRUserContext) context
											.getUserContext()));
					cdr = Utility.createParametriEnteComponentSession().getCdr(
							context.getUserContext(),
							CNRUserContext.getCd_cdr((CNRUserContext) context
									.getUserContext()));
				} catch (ComponentException e) {
					throw handleException(e);
				} catch (EJBException e) {
					throw handleException(e);
				} catch (RemoteException e) {
					throw handleException(e);
				}
				bulk.setPg_variazione_pdg(new Long(0));
				bulk.setCentro_responsabilita(cdr);
				bulk.setCd_centro_responsabilita(CNRUserContext.getCd_cdr((CNRUserContext) context.getUserContext()));
				bulk.setDs_variazione("VARIAZIONE PER TEST DI FIRMA DIGITALE");
				BulkList<OggettoBulk> list = new BulkList<OggettoBulk>();
				list.add(bulk);
				ListRemoteIterator lri = new ListRemoteIterator(list);
				try {
					setIterator(context, lri);
				} catch (Throwable e) {
					throw new BusinessProcessException(e);
				}
			}
		} catch (Throwable e) {
			throw new BusinessProcessException(e);
		}
		super.refresh(context);
	}

	public void scaricaFile(ActionContext actioncontext) throws IOException,
			ServletException {
		ArchiviaStampaPdgVariazioneBulk archiviaStampaPdgVariazioneBulk = (ArchiviaStampaPdgVariazioneBulk) getFocusedElement();
		InputStream is = null;
		if (!isTestSession()) {
			is = pdgVariazioniService
					.getResource(archiviaStampaPdgVariazioneBulk
							.getPdgVariazioneDocument().getDocument());
			((HttpActionContext) actioncontext).getResponse().setContentType(
					archiviaStampaPdgVariazioneBulk.getPdgVariazioneDocument()
							.getDocument().getContentStreamMimeType());
			((HttpActionContext) actioncontext).getResponse().setContentLength(
					Long.valueOf(archiviaStampaPdgVariazioneBulk.getPdgVariazioneDocument()
							.getDocument().getContentStreamLength()).intValue());
		} else {
			is = new BufferedInputStream(new FileInputStream(nomeFilePathTest));
		}
		OutputStream os = ((HttpActionContext) actioncontext).getResponse()
				.getOutputStream();
		int nextChar;
		while ((nextChar = is.read()) != -1)
			os.write(nextChar);
		os.write('\n');
		os.flush();
	}

	public void scaricaFileGenerico(ActionContext actioncontext) throws IOException,
			ServletException {
		ArchiviaStampaPdgVariazioneBulk archiviaStampaPdgVariazioneBulk = (ArchiviaStampaPdgVariazioneBulk) getFocusedElement();
		InputStream is = null;
		if (!isTestSession()) {
			is = pdgVariazioniService
					.getResource(archiviaStampaPdgVariazioneBulk
							.getPdgVariazioneDocument().getDocument());
			((HttpActionContext) actioncontext).getResponse().setContentType(
					archiviaStampaPdgVariazioneBulk.getPdgVariazioneDocument()
							.getDocument().getContentStreamMimeType());
			((HttpActionContext) actioncontext).getResponse().setContentLength(
					Long.valueOf(archiviaStampaPdgVariazioneBulk.getPdgVariazioneDocument()
							.getDocument().getContentStreamLength()).intValue());
		} else {
			is = new BufferedInputStream(new FileInputStream(nomeFilePathTest));
		}
		OutputStream os = ((HttpActionContext) actioncontext).getResponse()
				.getOutputStream();
		int nextChar;
		while ((nextChar = is.read()) != -1)
			os.write(nextChar);
		os.write('\n');
		os.flush();
	}

	public File scaricaSuFile(ActionContext actioncontext, File filePath) throws IOException,
		ServletException {
		ArchiviaStampaPdgVariazioneBulk archiviaStampaPdgVariazioneBulk = (ArchiviaStampaPdgVariazioneBulk) getFocusedElement();
		InputStream is = null;
		File fout = null;
		if (!isTestSession()) {
			is = pdgVariazioniService
					.getResource(archiviaStampaPdgVariazioneBulk
							.getPdgVariazioneDocument().getDocument());
			((HttpActionContext) actioncontext).getResponse().setContentType(
					archiviaStampaPdgVariazioneBulk.getPdgVariazioneDocument()
							.getDocument().getContentStreamMimeType());
			((HttpActionContext) actioncontext).getResponse().setContentLength(
					Long.valueOf(archiviaStampaPdgVariazioneBulk.getPdgVariazioneDocument()
							.getDocument().getContentStreamLength()).intValue());
			fout = new File(filePath.getParent()+File.separator+
					archiviaStampaPdgVariazioneBulk.getPdgVariazioneDocument()
							.getDocument().getName());
		} else {
			is = new BufferedInputStream(new FileInputStream(nomeFilePathTest));
			fout = new File(filePath.getParent()+File.separator+nomeFileTest);
		}
		FileOutputStream os = new FileOutputStream(fout);
		int nextChar;
		while ((nextChar = is.read()) != -1)
			os.write(nextChar);
		os.flush();
		return fout;
	}

	public void scaricaFileFirmato(ActionContext actioncontext)
			throws IOException, ServletException, ApplicationException {
		ArchiviaStampaPdgVariazioneBulk archiviaStampaPdgVariazioneBulk = (ArchiviaStampaPdgVariazioneBulk) getFocusedElement();
		InputStream is = null;
		if (!isTestSession()) {
			Document firmato=getNodeFileFirmato(archiviaStampaPdgVariazioneBulk.getPdgVariazioneDocument().getDocument());
			is = pdgVariazioniService.getResource(firmato);
			((HttpActionContext) actioncontext).getResponse().setContentType(
					firmato.getContentStreamMimeType());
			((HttpActionContext) actioncontext).getResponse().setContentLength(
					Long.valueOf(firmato.getContentStreamLength()).intValue());
		} else {
			is = new BufferedInputStream(new FileInputStream(nomeFileTestFirmato));
		}
		OutputStream os = ((HttpActionContext) actioncontext).getResponse()
				.getOutputStream();
		int nextChar;
		while ((nextChar = is.read()) != -1)
			os.write(nextChar);
		os.write('\n');
		os.flush();
	}

	public Document getNodeFileFirmato(Document nodePdf) throws ApplicationException {

		if (isTestSession())
			return null;

		List<CmisObject> firmati = pdgVariazioniService
				.getRelationshipFromTarget(nodePdf.getId(),
						CMISRelationship.CNR_SIGNEDDOCUMENT);
		if (firmati.size()==1)
			return (Document) firmati.get(0);
		else
			return null;
		
	}
	
	public void sign(ActionContext context) throws BusinessProcessException {
		try {
			ArchiviaStampaPdgVariazioneBulk archiviaStampaPdgVariazioneBulk = (ArchiviaStampaPdgVariazioneBulk) getFocusedElement();
			Parametri_cdsBulk  parametriCds = Utility.createParametriCdsComponentSession().
				getParametriCds(context.getUserContext(), 
								CNRUserContext.getCd_cds(context.getUserContext()), 
								CNRUserContext.getEsercizio(context.getUserContext()));
			if (parametriCds.getFl_kit_firma_digitale() || isTestSession()){
				caricaDatiPEC(context);
				setSignEnabled(true);
				setSignFile(true);
			}else{
				pdgVariazioniService.addAspect(archiviaStampaPdgVariazioneBulk
						.getPdgVariazioneDocument().getDocument(),
						CMISAspect.CNR_SIGNEDDOCUMENT.value());
							//rp 21/01/2014 inserisco data firma sulla variazione
				createComponentSession().aggiornaDataFirma(context.getUserContext(),archiviaStampaPdgVariazioneBulk
				.getPdgVariazioneDocument().getEsercizio(),archiviaStampaPdgVariazioneBulk.getPdgVariazioneDocument().getNumeroVariazione());		
				setFocusedElement(context, null);
				refresh(context);
			}
		} catch (Throwable e) {
			throw new BusinessProcessException(e);
		}
	}

	public void installa(ActionContext context) throws BusinessProcessException {
		try {
			ArchiviaStampaPdgVariazioneBulk archiviaStampaPdgVariazioneBulk = (ArchiviaStampaPdgVariazioneBulk) getFocusedElement();
			setSignEnabled(true);
		} catch (Throwable e) {
			throw new BusinessProcessException(e);
		}
	}

	public boolean isSignEnabled() {
		return signEnabled;
	}

	public void setSignEnabled(boolean signEnabled) {
		this.signEnabled = signEnabled;
	}

	public boolean isSignFile() {
		return signFile;
	}

	public void setSignFile(boolean signFile) {
		this.signFile = signFile;
	}

	public String getFileName() {
		ArchiviaStampaPdgVariazioneBulk archiviaStampaPdgVariazioneBulk = (ArchiviaStampaPdgVariazioneBulk) getFocusedElement();
		if (archiviaStampaPdgVariazioneBulk != null)
			if (!isTestSession())
				return archiviaStampaPdgVariazioneBulk.getPdgVariazioneDocument().getDocument().getName().replace(" ", "_");
			else
				return nomeFileTest;
		else
			return (null);
	}

	public String getDownloadFile(javax.servlet.jsp.PageContext pageContext) throws BusinessProcessException {
		ArchiviaStampaPdgVariazioneBulk archiviaStampaPdgVariazioneBulk = (ArchiviaStampaPdgVariazioneBulk) getFocusedElement();
		File file = null;
		File fileDir = null;
		File fileTest = null;
		try {
			fileDir = File.createTempFile("var", "pdg", new File(System
					.getProperty("tmp.dir.SIGLAWeb")
					+ "/tmp/"));
			fileDir.delete();
			if (!fileDir.mkdir())
				throw new BusinessProcessException(
						"Directory gi� esistente, riprovare a generare la firma!");

			file = new File(fileDir, getFileName());
			InputStream is = null;
			if (!isTestSession()) {
				is = pdgVariazioniService
				.getResource(archiviaStampaPdgVariazioneBulk
						.getPdgVariazioneDocument().getDocument());
			} else {
				is = new BufferedInputStream(new FileInputStream(nomeFilePathTest));
			}
				
					
			OutputStream out = new FileOutputStream(file);
			int c;
			while ((c = is.read()) != -1) {
				out.write(c);
			}
			is.close();
			out.flush();
			out.close();
		} catch (IOException e) {
			throw handleException(e);
		} catch (BusinessProcessException e) {
			throw handleException(e);
		}
		String dirName = new File(fileDir.getName()).getName();
		// ripuliamo il path
		String fileName = new File(file.getName()).getName();
		return JSPUtils.buildAbsoluteUrl(pageContext, null, "tmp/" + dirName
				+ "/" + fileName);
	}

	public String getPgStampa() {
		ArchiviaStampaPdgVariazioneBulk archiviaStampaPdgVariazioneBulk = (ArchiviaStampaPdgVariazioneBulk) getFocusedElement();
		if (archiviaStampaPdgVariazioneBulk != null)
			return ""
					+ archiviaStampaPdgVariazioneBulk.getPg_variazione_pdg()
							.longValue();
		else
			return null;
	}

	public String getUploadFile(javax.servlet.jsp.PageContext pageContext) {
		String actionExtension = pageContext.getServletConfig()
				.getInitParameter("extension");
		if (actionExtension == null)
			actionExtension = ".do";
		String path = getDefaultAction() + actionExtension;
		return JSPUtils.buildAbsoluteUrl(pageContext, null, path);
	}

	public String descrizione() {
		return null;
	}

	public DatiPEC datiPEC() {
		return datiPEC;
	}

	public void caricaDatiPEC(ActionContext context) throws ValidationException, BusinessProcessException {
		ArchiviaStampaPdgVariazioneBulk pbulk = (ArchiviaStampaPdgVariazioneBulk) getFocusedElement();
		String cdServizioPEC = null;
		cdServizioPEC = PEC_BILANCIO;

		boolean testMode = true;
		Parametri_enteBulk parametriEnte = null;
		try {
			parametriEnte = Utility.createParametriEnteComponentSession()
					.getParametriEnte(context.getUserContext());
		} catch (ComponentException e) {
			throw handleException(e);
		} catch (EJBException e) {
			throw handleException(e);
		} catch (RemoteException e) {
			throw handleException(e);
		}
		// PEC del protocollo
		ServizioPecBulk servizioPecProtocollo = null;
		try {
			servizioPecProtocollo = Utility
					.createParametriEnteComponentSession().getServizioPec(
							context.getUserContext(), PEC_PROTOCOLLO);
		} catch (ComponentException e) {
			throw handleException(e);
		} catch (EJBException e) {
			throw handleException(e);
		} catch (RemoteException e) {
			throw handleException(e);
		}
		if (servizioPecProtocollo == null)
			throw new ValidationException(
					"Non � presente l'email per l'invio della posta certificata per l'ufficio del Protocollo. Impossibile procedere!");
		// PEC derivata dalla stampa specifica
		ServizioPecBulk servizioPec = null;
		try {
			servizioPec = Utility.createParametriEnteComponentSession()
					.getServizioPec(context.getUserContext(), cdServizioPEC);
		} catch (ComponentException e) {
			throw handleException(e);
		} catch (EJBException e) {
			throw handleException(e);
		} catch (RemoteException e) {
			throw handleException(e);
		}
		if (servizioPec == null)
			throw new ValidationException(
					"L'ufficio di competenza per l'invio della posta certificata non � definito. Impossibile procedere!");
		if (!parametriEnte.getTipo_db().equals(Parametri_enteBulk.DB_PRODUZIONE) || isTestSession()) 
			testMode = true;
		else
			testMode = false;
			
		CdsBulk cds = null;
		Unita_organizzativaBulk uo = null;
		CdrBulk cdr = null;
		try {
			cds = Utility.createParametriEnteComponentSession().getCds(
					context.getUserContext(),
					CNRUserContext.getCd_cds((CNRUserContext) context
							.getUserContext()));
			uo = Utility.createParametriEnteComponentSession().getUo(
					context.getUserContext(),
					CNRUserContext
							.getCd_unita_organizzativa((CNRUserContext) context
									.getUserContext()));
			cdr = Utility.createParametriEnteComponentSession().getCdr(
					context.getUserContext(),
					CNRUserContext.getCd_cdr((CNRUserContext) context
							.getUserContext()));
		} catch (ComponentException e) {
			throw handleException(e);
		} catch (EJBException e) {
			throw handleException(e);
		} catch (RemoteException e) {
			throw handleException(e);
		}

		String cdUoPec = null;
		UnitaOrganizzativaPecBulk uoPec = null;

		if (cds.getCd_tipo_unita().equals(
				Tipo_unita_organizzativaHome.TIPO_UO_SAC)) {
			datiPEC.setUo(CNRUserContext
					.getCd_unita_organizzativa((CNRUserContext) context
							.getUserContext()));
			datiPEC.setDsUo(uo.getDs_unita_organizzativa());
			cdUoPec = uo.getCd_unita_organizzativa();
			uoPec = getUoPec(context, cdUoPec);
			datiPEC.setCds("000000");
			datiPEC.setDsCds("Consiglio Nazionale delle Ricerche");
			datiPEC.setSiglaCds("CNR");
			datiPEC.setCdsDest("000000");
			datiPEC.setDsCdsDest("Consiglio Nazionale delle Ricerche");
			datiPEC.setSiglaCdsDest("CNR");

		} else {
			datiPEC.setUo(uo.getCd_cds());
			datiPEC.setDsUo(uo.getDs_unita_organizzativa());
			cdUoPec = cds.getCd_unita_organizzativa();
			uoPec = getUoPec(context, cdUoPec);
			datiPEC.setCds(cds.getCd_unita_organizzativa());
			datiPEC.setDsCds(cds.getDs_unita_organizzativa());
			datiPEC.setSiglaCds(uoPec.getSigla().toUpperCase());
			datiPEC.setCdsDest("000000");
			datiPEC.setDsCdsDest("Consiglio Nazionale delle Ricerche");
			datiPEC.setSiglaCdsDest("CNR");
		}

		if (!pbulk.getDs_variazione().equals(""))
			datiPEC.setOggetto("Variazione al PdG n. "+pbulk.getPg_variazione_pdg()+"-"+pbulk.getEsercizio()+" CdR proponente "+pbulk.getCd_centro_responsabilita()+", "+pbulk.getDs_variazione());
		else
			datiPEC.setOggetto("Variazione al PdG n. "+pbulk.getPg_variazione_pdg()+"-"+pbulk.getEsercizio()+" CdR proponente "+pbulk.getCd_centro_responsabilita()+", "+descrizione());

		datiPEC.setOggetto(datiPEC.getOggetto().replace("\"","'").replaceAll("[^a-zA-Z0-9\\\\/. ,'_^-]"," "));
		datiPEC.setDenominazioneServizio(servizioPec.getDsServizio());
		datiPEC.setNumeroRegistrazione(pbulk.getPg_variazione_pdg()+"-"+pbulk.getEsercizio());
		
		if (testMode) {
			datiPEC.setEmailProtocollo(servizioPecProtocollo.getEmailTest());
			datiPEC.setEmailServizio(servizioPec.getEmailTest());
		} else {
			datiPEC.setEmailProtocollo(servizioPecProtocollo.getEmail());
			datiPEC.setEmailProtocollo2(servizioPecProtocollo.getEmail2());
			datiPEC.setEmailProtocollo3(servizioPecProtocollo.getEmail3());
			datiPEC.setEmailServizio(servizioPec.getEmail());
			datiPEC.setEmailServizio2(servizioPec.getEmail2());
			datiPEC.setEmailServizio3(servizioPec.getEmail3());
			datiPEC.setEmailIstituto(uoPec.getEmailPec());
			datiPEC.setEmailIstituto2(uoPec.getEmailPecDirettore());
		}
	}

	private UnitaOrganizzativaPecBulk getUoPec(ActionContext context, String cdUoPec) throws ValidationException, BusinessProcessException {
		UnitaOrganizzativaPecBulk uoPec = null;
		try {
			uoPec = Utility
					.createParametriEnteComponentSession()
					.getUnitaOrganizzativaPec(context.getUserContext(), cdUoPec);
		} catch (ComponentException e) {
			throw handleException(e);
		} catch (EJBException e) {
			throw handleException(e);
		} catch (RemoteException e) {
			throw handleException(e);
		}
		if (uoPec == null || (uoPec.getEmailPec()==null && uoPec.getEmailPecDirettore()==null))
			throw new ValidationException("L'indirizzo email di posta certificata per la unit� organizzativa "+cdUoPec+" non � definito. Impossibile procedere!");
		return uoPec;
	}
	
	public void persist(ActionContext context, String signFileRicevuto)
			throws Exception {
		ArchiviaStampaPdgVariazioneBulk archiviaStampaPdgVariazioneBulk = (ArchiviaStampaPdgVariazioneBulk) getFocusedElement();
		File file = new File(signFileRicevuto);
		Verifica.verificaBustaFirmata(file);

		AllegatoPdGVariazioneSignedDocument allegato=null;
		Document node = null;
		Document pdgVariazioneDocumentNode = null;
		if (!isTestSession()) {
			allegato = new AllegatoPdGVariazioneSignedDocument();
			allegato.setFile(file);
			// allegato.setTitolo(titolo);
			allegato.setDescrizione("Busta firmata: "
					+ archiviaStampaPdgVariazioneBulk.getDs_variazione());
			allegato.setNome(file.getName());
			allegato.setContentType("application/p7m");
			CMISPath cmisPath = getCMISPath(archiviaStampaPdgVariazioneBulk);
			node = pdgVariazioniService.storeSimpleDocument(allegato,
					new FileInputStream(allegato.getFile()), allegato
							.getContentType(), allegato.getNome(), cmisPath);
			pdgVariazioneDocumentNode = archiviaStampaPdgVariazioneBulk
					.getPdgVariazioneDocument().getDocument();
			pdgVariazioniService.createRelationship(pdgVariazioneDocumentNode
					.getId(), node.getId(),
					CMISRelationship.VARPIANOGEST_ALLEGATIVARBILANCIO);

			pdgVariazioniService.addAspect(archiviaStampaPdgVariazioneBulk
					.getPdgVariazioneDocument().getDocument(),
					CMISAspect.CNR_SIGNEDDOCUMENT.value());
		} else {
			nomeFileTestFirmato = signFileRicevuto;
			if (nomeFileTestFirmato!=null)
				nomeFileTestFirmato= nomeFileTestFirmato.replace("\\", "/");

		}

		try {
			List<String> lista = datiPEC.emailListTotale();
			SendPecMail.sendMail(datiPEC.getOggetto(), datiPEC.getOggetto(), file,
					lista, datiPEC);
		} catch (Exception ex) {
			if (!isTestSession()) {
				pdgVariazioniService.removeAspect(archiviaStampaPdgVariazioneBulk
						.getPdgVariazioneDocument().getDocument(),
						CMISAspect.CNR_SIGNEDDOCUMENT.value());
				pdgVariazioniService.deleteNode(node);
			}
			throw new ApplicationException("Errore nell'invio della mail PEC al protocollo informatico. Ripetere l'operazione di firma!");
		}

		if (!isTestSession()) {
			pdgVariazioniService.createRelationship(node.getId(),
					pdgVariazioneDocumentNode.getId(),
					CMISRelationship.CNR_SIGNEDDOCUMENT);
		}

		//rp 21/01/2014 inserisco data firma sulla variazione
		createComponentSession().aggiornaDataFirma(context.getUserContext(),archiviaStampaPdgVariazioneBulk
				.getPdgVariazioneDocument().getEsercizio(),archiviaStampaPdgVariazioneBulk.getPdgVariazioneDocument().getNumeroVariazione());
		setFocusedElement(context, null);
		refresh(context);
	}
	
	public void firmaOTP(ActionContext context, FirmaOTPBulk firmaOTPBulk) throws Exception {
		ArchiviaStampaPdgVariazioneBulk archiviaStampaPdgVariazioneBulk = (ArchiviaStampaPdgVariazioneBulk) getFocusedElement();
		Document pdgVariazioneDocumentNode = archiviaStampaPdgVariazioneBulk.getPdgVariazioneDocument().getDocument();
		String webScriptURL = pdgVariazioniService.getRepositoyURL().concat("service/sigla/firma/variazioni");
		String json = "{" +
				"\"nodeRefSource\" : \"" + pdgVariazioneDocumentNode.getProperty(SiglaCMISService.ALFCMIS_NODEREF).getValueAsString() + "\"," +
				"\"username\" : \"" + firmaOTPBulk.getUserName() + "\"," +
				"\"password\" : \"" + firmaOTPBulk.getPassword() + "\"," +
				"\"otp\" : \"" + firmaOTPBulk.getOtp() + "\""
				+ "}";
		Document node = null;
		try {		
			UrlBuilder url = new UrlBuilder(URIUtil.encodePath(webScriptURL));
			Response response = pdgVariazioniService.invokePOST(url, MimeTypes.JSON, json.getBytes("UTF-8"));
			int status = response.getResponseCode();
			if (status == HttpStatus.SC_NOT_FOUND
					|| status == HttpStatus.SC_INTERNAL_SERVER_ERROR
					|| status == HttpStatus.SC_UNAUTHORIZED
					|| status == HttpStatus.SC_BAD_REQUEST) {
				JSONTokener tokenizer = new JSONTokener(new StringReader(response.getErrorContent()));
			    JSONObject jsonObject = new JSONObject(tokenizer);
			    String jsonMessage = jsonObject.getString("message");
				throw new ApplicationException(FirmaOTPBulk.errorMessage(jsonMessage));
			} else {
				JSONTokener tokenizer = new JSONTokener(new InputStreamReader(response.getStream()));
			    JSONObject jsonObject = new JSONObject(tokenizer);
			    node = (Document) pdgVariazioniService.getNodeByNodeRef(jsonObject.getString("nodeRef"));
			}
		} catch (HttpException e) {
			throw new BusinessProcessException(e);
		} catch (IOException e) {
			throw new BusinessProcessException(e);
		} catch (Exception e) {
			throw new BusinessProcessException(e);
		} 
	
		try {
			File fileNew = File.createTempFile("docFirmatoVariazioni", "p7m");
			OutputStream outputStream = new FileOutputStream(fileNew);
			IOUtils.copy(pdgVariazioniService.getResource(node), outputStream);
			outputStream.close();			
			List<String> lista = datiPEC.emailListTotale();
			if (!lista.isEmpty())
				SendPecMail.sendMail(datiPEC.getOggetto(), datiPEC.getOggetto(), fileNew,
						lista, datiPEC);
		} catch (Exception ex) {
			if (!isTestSession()) {
				pdgVariazioniService.removeAspect(archiviaStampaPdgVariazioneBulk
						.getPdgVariazioneDocument().getDocument(),
						CMISAspect.CNR_SIGNEDDOCUMENT.value());
				pdgVariazioniService.deleteNode(node);
			}
			throw new ApplicationException("Errore nell'invio della mail PEC al protocollo informatico. Ripetere l'operazione di firma!");
		}

		//rp 21/01/2014 inserisco data firma sulla variazione
		createComponentSession().aggiornaDataFirma(context.getUserContext(),archiviaStampaPdgVariazioneBulk
				.getPdgVariazioneDocument().getEsercizio(),archiviaStampaPdgVariazioneBulk.getPdgVariazioneDocument().getNumeroVariazione());
		setFocusedElement(context, null);
		refresh(context);	
	}

	public void persistUploadedFile(ActionContext context, UploadedFile ufile)
		throws Exception {
		ArchiviaStampaPdgVariazioneBulk archiviaStampaPdgVariazioneBulk = (ArchiviaStampaPdgVariazioneBulk) getFocusedElement();
		File file = ufile.getFile();
		File fOutput=null;
		try {
			fOutput = Verifica.estraiFile(file);
		} catch (NotSignedEnvelopeException ex) {
			throw new ValidationException(
					"Il file non ha il formato richiesto \"busta di firma digitale\" p7m");
		}
		Verifica.verificaBustaFirmata(file);
		File archivedFileOutput = scaricaSuFile(context, ufile.getFile());
		if (!Verifica.fileContentsEquals(fOutput, archivedFileOutput))
			throw new ValidationException(
				"Il file inviato non corrisponde alla variazione selezionata. Impossibile procedere!");		

		String nomeFileNew = null;
		if (!isTestSession()) {
			nomeFileNew=getFileName()+".p7m";
		} else {
			nomeFileNew=getFileName()+"-2.p7m";
		}

		File fileNew = new File(file.getParent(), nomeFileNew);
		Verifica.fileCopy(file, fileNew);
		Verifica.verificaBustaFirmata(fileNew);
		
		AllegatoPdGVariazioneSignedDocument allegato = null;
		Document node = null;
		Document pdgVariazioneDocumentNode = null;
		if (!isTestSession()) {
			allegato = new AllegatoPdGVariazioneSignedDocument();
			allegato.setFile(fileNew);
			// allegato.setTitolo(titolo);
			allegato.setDescrizione("Busta firmata: "
					+ archiviaStampaPdgVariazioneBulk.getDs_variazione());
			allegato.setNome(fileNew.getName());
			allegato.setContentType("application/p7m");
			CMISPath cmisPath = getCMISPath(archiviaStampaPdgVariazioneBulk);
			node = pdgVariazioniService.storeSimpleDocument(allegato,
					new FileInputStream(allegato.getFile()), allegato
							.getContentType(), allegato.getNome(), cmisPath);
			pdgVariazioneDocumentNode = archiviaStampaPdgVariazioneBulk
					.getPdgVariazioneDocument().getDocument();
			pdgVariazioniService.createRelationship(pdgVariazioneDocumentNode
					.getId(), node.getId(),
					CMISRelationship.VARPIANOGEST_ALLEGATIVARBILANCIO);
			
			pdgVariazioniService.addAspect(archiviaStampaPdgVariazioneBulk
					.getPdgVariazioneDocument().getDocument(),
					CMISAspect.CNR_SIGNEDDOCUMENT.value());
		} else {
			nomeFileTestFirmato = fileNew.getPath();
			if (nomeFileTestFirmato!=null)
				nomeFileTestFirmato= nomeFileTestFirmato.replace("\\", "/");
		}
		
		try {
			List<String> lista = datiPEC.emailListTotale();
			SendPecMail.sendMail(datiPEC.getOggetto(), datiPEC.getOggetto(), fileNew,
					lista, datiPEC);
		} catch (Exception ex) {
			if (!isTestSession()) {
				pdgVariazioniService.removeAspect(archiviaStampaPdgVariazioneBulk
						.getPdgVariazioneDocument().getDocument(),
						CMISAspect.CNR_SIGNEDDOCUMENT.value());
				pdgVariazioniService.deleteNode(node);
			}
			throw new ApplicationException("Errore nell'invio della mail PEC al protocollo informatico. Ripetere l'operazione di firma!");
		}

		if (!isTestSession()) {
			pdgVariazioniService.createRelationship(node.getId(),
					pdgVariazioneDocumentNode.getId(),
					CMISRelationship.CNR_SIGNEDDOCUMENT);
		}

		//rp 21/01/2014 inserisco data firma sulla variazione
		createComponentSession().aggiornaDataFirma(context.getUserContext(),archiviaStampaPdgVariazioneBulk
				.getPdgVariazioneDocument().getEsercizio(),archiviaStampaPdgVariazioneBulk.getPdgVariazioneDocument().getNumeroVariazione());
		setFocusedElement(context, null);
		refresh(context);
	}
	
	private CMISPath getCMISPath(
			ArchiviaStampaPdgVariazioneBulk archiviaStampaPdgVariazioneBulk) throws ApplicationException {
		CMISPath cmisPath = SpringUtil.getBean(
				"cmisPathVariazioniAlPianoDiGestione", CMISPath.class);
		cmisPath = pdgVariazioniService.createFolderIfNotPresent(cmisPath,
				archiviaStampaPdgVariazioneBulk.getEsercizio().toString(),
				"Esercizio :"
						+ archiviaStampaPdgVariazioneBulk.getEsercizio()
								.toString(), "Esercizio :"
						+ archiviaStampaPdgVariazioneBulk.getEsercizio()
								.toString());
		cmisPath = pdgVariazioniService.createFolderIfNotPresent(cmisPath,
				archiviaStampaPdgVariazioneBulk.getCd_cds() + " - "
						+ archiviaStampaPdgVariazioneBulk.getDs_cds(),
				archiviaStampaPdgVariazioneBulk.getDs_cds(),
				archiviaStampaPdgVariazioneBulk.getDs_cds());
		cmisPath = pdgVariazioniService.createFolderIfNotPresent(cmisPath,
				"CdR "
						+ archiviaStampaPdgVariazioneBulk
								.getCd_centro_responsabilita()
						+ " Variazione "
						+ lpad(archiviaStampaPdgVariazioneBulk
								.getPg_variazione_pdg(), 5, '0'), null, null);
		return cmisPath;
	}

	public static String lpad(double d, int size, char pad) {
		return lpad(Double.toString(d), size, pad);
	}

	public static String lpad(long l, int size, char pad) {
		return lpad(Long.toString(l), size, pad);
	}

	public static String lpad(String s, int size, char pad) {
		StringBuilder builder = new StringBuilder();
		while (builder.length() + s.length() < size) {
			builder.append(pad);
		}
		builder.append(s);
		return builder.toString();
	}

	public void rendiPersistente(String file) {
		// TODO Auto-generated method stub

	}

	public String tipoPersistenza() {
		return TIPO_PERSISTENZA_ESTERNA;
	}

	public void setUploadFile(boolean uploadFile) {
		this.uploadFile = uploadFile;
	}

	public boolean isUploadFile() {
		return uploadFile;
	}

	public boolean isTestSession() {
		return testSession;
	}

	public void setTestSession(boolean testSession) {
		this.testSession = testSession;
	}
}
