package it.cnr.contab.incarichi00.bulk.cmis;

import it.cnr.cmisdl.model.Node;
import it.cnr.contab.cmis.annotation.CMISPolicy;
import it.cnr.contab.cmis.annotation.CMISProperty;
import it.cnr.contab.cmis.annotation.CMISType;
import it.cnr.contab.cmis.converter.Converter;
import it.cnr.contab.cmis.service.CMISPath;
import it.cnr.contab.cmis.service.CMISService;
import it.cnr.contab.incarichi00.bulk.Incarichi_proceduraBulk;
import it.cnr.contab.incarichi00.cmis.CMISContrattiProperty;
import it.cnr.contab.service.SpringUtil;
import it.cnr.contab.util.Utility;
import it.cnr.jada.bulk.OggettoBulk;

import java.util.GregorianCalendar;
import java.util.List;

@CMISType(name="F:sigla_contratti:procedura")
public class CMISFolderProcedura extends OggettoBulk {
	private static final long serialVersionUID = 4110702628275029148L;

	private Incarichi_proceduraBulk incaricoProcedura;

	public CMISFolderProcedura(Incarichi_proceduraBulk incaricoProcedura) {
    	super();
    	setIncaricoProcedura(incaricoProcedura);
    }

	private void setIncaricoProcedura(Incarichi_proceduraBulk incaricoProcedura) {
		this.incaricoProcedura = incaricoProcedura;
	}
	
	public Incarichi_proceduraBulk getIncaricoProcedura() {
		return incaricoProcedura;
	}

	@CMISPolicy(name="P:sigla_contratti_aspect:procedura", property=@CMISProperty(name="sigla_contratti_aspect_procedura:esercizio"))
	public Integer getEsercizio() {
		if (this.getIncaricoProcedura()==null)
			return null;
		return this.getIncaricoProcedura().getEsercizio();
	}
	
	@CMISPolicy(name="P:sigla_contratti_aspect:procedura", property=@CMISProperty(name="sigla_contratti_aspect_procedura:progressivo", converterBeanName="cmis.converter.longToIntegerConverter"))
	public Long getPg_procedura() {
		if (this.getIncaricoProcedura()==null)
			return null;
		return this.getIncaricoProcedura().getPg_procedura();
	}
	
	@CMISProperty(name="sigla_contratti:oggetto")
	public String getOggetto() {
		if (this.getIncaricoProcedura()==null)
			return null;
		return this.getIncaricoProcedura().getOggetto();
	}
	
	@CMISProperty(name="sigla_contratti:procedura_amministrativa")
	public String getDescrizioneProceduraAmministrativa(){
		if (this.getIncaricoProcedura()==null ||
			this.getIncaricoProcedura().getProcedura_amministrativa()==null)
			return null;
		return this.getIncaricoProcedura().getProcedura_amministrativa().getDs_proc_amm();
	}
	
	@CMISPolicy(name="P:sigla_contratti_aspect:tipo_norma", property=@CMISProperty(name="sigla_contratti_aspect_tipo_norma:descrizione"))
	public String getTipoNormaDescrizione() {
		if (this.getIncaricoProcedura()==null || this.getIncaricoProcedura().getTipo_norma_perla()==null)
			return null;
		if (this.getIncaricoProcedura().getCd_tipo_norma_perla()!=null && this.getIncaricoProcedura().getCd_tipo_norma_perla().equals("999")) 
			return (this.getIncaricoProcedura().getDs_libera_norma_perla());
		return this.getIncaricoProcedura().getTipo_norma_perla().getDs_tipo_norma();
	}

	@CMISPolicy(name="P:sigla_contratti_aspect:tipo_norma", property=@CMISProperty(name="sigla_contratti_aspect_tipo_norma:numero"))
	public String getTipoNormaNumero() {
		if (this.getIncaricoProcedura()==null || this.getIncaricoProcedura().getTipo_norma_perla()==null)
			return null;
		if (this.getIncaricoProcedura().getCd_tipo_norma_perla()!=null && this.getIncaricoProcedura().getCd_tipo_norma_perla().equals("999")) 
			return null;
		return this.getIncaricoProcedura().getTipo_norma_perla().getNumero_tipo_norma();
	}

	@SuppressWarnings("unchecked")
	@CMISPolicy(name="P:sigla_contratti_aspect:tipo_norma", property=@CMISProperty(name="sigla_contratti_aspect_tipo_norma:data"))
	public GregorianCalendar getTipoNormaData() {
		if (this.getIncaricoProcedura()==null || this.getIncaricoProcedura().getTipo_norma_perla()==null)
			return null;
		if (this.getIncaricoProcedura().getCd_tipo_norma_perla()!=null && this.getIncaricoProcedura().getCd_tipo_norma_perla().equals("999")) 
			return null;
		return (GregorianCalendar)SpringUtil.getBean("cmis.converter.timestampToCalendarConverter", Converter.class).convert(this.getIncaricoProcedura().getTipo_norma_perla().getDt_tipo_norma());
	}

	@CMISPolicy(name="P:sigla_contratti_aspect:tipo_norma", property=@CMISProperty(name="sigla_contratti_aspect_tipo_norma:articolo"))
	public String getTipoNormaArticolo() {
		if (this.getIncaricoProcedura()==null || this.getIncaricoProcedura().getTipo_norma_perla()==null)
			return null;
		if (this.getIncaricoProcedura().getCd_tipo_norma_perla()!=null && this.getIncaricoProcedura().getCd_tipo_norma_perla().equals("999")) 
			return null;
		return this.getIncaricoProcedura().getTipo_norma_perla().getArticolo_tipo_norma();
	}

	@CMISPolicy(name="P:sigla_contratti_aspect:tipo_norma", property=@CMISProperty(name="sigla_contratti_aspect_tipo_norma:comma"))
	public String getTipoNormaComma() {
		if (this.getIncaricoProcedura()==null || this.getIncaricoProcedura().getTipo_norma_perla()==null)
			return null;
		if (this.getIncaricoProcedura().getCd_tipo_norma_perla()!=null && this.getIncaricoProcedura().getCd_tipo_norma_perla().equals("999")) 
			return null;
		return this.getIncaricoProcedura().getTipo_norma_perla().getComma_tipo_norma();
	}

	public CMISPath getCMISPrincipalPath(CMISService cmisService){
		CMISPath cmisPath = SpringUtil.getBean("cmisPathContratti",CMISPath.class);
		cmisPath = cmisService.createFolderIfNotPresent(cmisPath, this.getIncaricoProcedura().getCd_unita_organizzativa(), this.getIncaricoProcedura().getUnita_organizzativa().getDs_unita_organizzativa(), this.getIncaricoProcedura().getUnita_organizzativa().getDs_unita_organizzativa());
		if (this.getIncaricoProcedura().isProceduraForIncarichi())
			cmisPath = cmisService.createFolderIfNotPresent(cmisPath, "Incarichi di Collaborazione", "Incarichi", "Incarichi di Collaborazione");
		else if (this.getIncaricoProcedura().isProceduraForBorseStudio())
			cmisPath = cmisService.createFolderIfNotPresent(cmisPath, "Borse di Studio", "Borse di Studio", "Borse di Studio");
		else if (this.getIncaricoProcedura().isProceduraForAssegniRicerca())
			cmisPath = cmisService.createFolderIfNotPresent(cmisPath, "Assegni di Ricerca", "Assegni di Ricerca", "Assegni di Ricerca");
		return cmisPath;
	}

	public CMISPath getCMISPath(CMISService cmisService){
		CMISPath cmisPath = this.getCMISPrincipalPath(cmisService);
		if (cmisPath!=null) {
			cmisPath = cmisService.createFolderIfNotPresent(cmisPath, this.getEsercizio().toString(), "Esercizio "+this.getEsercizio().toString(), "Esercizio "+this.getEsercizio().toString());
			cmisPath = cmisService.createFolderIfNotPresent(cmisPath, "Procedura "+this.getEsercizio().toString()+Utility.lpad(this.getPg_procedura().toString(),10,'0'), "Procedura "+this.getEsercizio().toString()+"/"+this.getPg_procedura().toString(), "Procedura "+this.getEsercizio().toString()+"/"+this.getPg_procedura().toString(), this);
			cmisService.setInheritedPermission(cmisPath, Boolean.FALSE);
		}
		return cmisPath;
	}
	
	public boolean isEqualsTo(Node node, List<String> listError){
		String initTesto = "Procedura "+this.getEsercizio().toString()+"/"+this.getPg_procedura().toString()+" - Disallineamento dato ";
		boolean isEquals = true;
		String valueDB=null, valueCMIS=null; 

		valueDB=String.valueOf(this.getEsercizio());
		valueCMIS=String.valueOf(node.getPropertyValue(CMISContrattiProperty.SIGLA_CONTRATTI_PROCEDURA_ESERCIZIO.value()));
		if (!valueCMIS.equals(valueDB)) {
			listError.add(initTesto+" - Esercizio - DB:"+valueDB+" - CMIS:"+valueCMIS);
			isEquals = false;
		}

		valueDB=String.valueOf(this.getPg_procedura());
		valueCMIS=String.valueOf(node.getPropertyValue(CMISContrattiProperty.SIGLA_CONTRATTI_PROCEDURA_PROGRESSIVO.value()));
		if (!valueCMIS.equals(valueDB)) {
			listError.add(initTesto+" - Pg_procedura - DB:"+valueDB+" - CMIS:"+valueCMIS);
			isEquals = false;
		}

		valueDB=String.valueOf(this.getOggetto()).replaceAll("  ", " ").replaceAll("\r\n", "\n");
		valueCMIS=String.valueOf(node.getPropertyValue("sigla_contratti:oggetto"));
		if (!valueCMIS.equals(valueDB)) {
			listError.add(initTesto+" - Oggetto - DB:"+valueDB+" - CMIS:"+valueCMIS);
			isEquals = false;
		}

		valueDB=String.valueOf(this.getDescrizioneProceduraAmministrativa()).replaceAll("  ", " ").replaceAll("\r\n", "\n");
		valueCMIS=String.valueOf(node.getPropertyValue("sigla_contratti:procedura_amministrativa"));
		if (!valueCMIS.equals(valueDB)) {
			listError.add(initTesto+" - Procedura Amministrativa - DB:"+valueDB+" - CMIS:"+valueCMIS);
			isEquals = false;
		}

		valueDB=String.valueOf(this.getTipoNormaDescrizione()).replaceAll("  ", " ").replaceAll("\r\n", "\n");
		valueCMIS=String.valueOf(node.getPropertyValue(CMISContrattiProperty.SIGLA_CONTRATTI_TIPO_NORMA_DESCRIZIONE.value()));
		if (!valueCMIS.equals(valueDB)) {
			listError.add(initTesto+" - Descrizione Tipo Norma - DB:"+valueDB+" - CMIS:"+valueCMIS);
			isEquals = false;
		}
		
		valueDB=String.valueOf(this.getTipoNormaNumero());
		valueCMIS=String.valueOf(node.getPropertyValue(CMISContrattiProperty.SIGLA_CONTRATTI_TIPO_NORMA_NUMERO.value()));
		if (!valueCMIS.equals(valueDB)) {
			listError.add(initTesto+" - Numero Tipo Norma - DB:"+valueDB+" - CMIS:"+valueCMIS);
			isEquals = false;
		}

		valueDB=String.valueOf(this.getTipoNormaArticolo());
		valueCMIS=String.valueOf(node.getPropertyValue(CMISContrattiProperty.SIGLA_CONTRATTI_TIPO_NORMA_ARTICOLO.value()));
		if (!valueCMIS.equals(valueDB)) {
			listError.add(initTesto+" - Articolo Tipo Norma - DB:"+valueDB+" - CMIS:"+valueCMIS);
			isEquals = false;
		}

		valueDB=String.valueOf(this.getTipoNormaComma());
		valueCMIS=String.valueOf(node.getPropertyValue(CMISContrattiProperty.SIGLA_CONTRATTI_TIPO_NORMA_COMMA.value()));
		if (!valueCMIS.equals(valueDB)) {
			listError.add(initTesto+" - Comma Tipo Norma - DB:"+valueDB+" - CMIS:"+valueCMIS);
			isEquals = false;
		}

		valueDB=this.getTipoNormaData()==null?"":Integer.toString(this.getTipoNormaData().get(GregorianCalendar.DAY_OF_MONTH)) + "/" + 
												 Integer.toString(this.getTipoNormaData().get(GregorianCalendar.MONTH)) + "/" + 
												 Integer.toString(this.getTipoNormaData().get(GregorianCalendar.YEAR));
		GregorianCalendar gcCMIS = (GregorianCalendar)node.getPropertyValue(CMISContrattiProperty.SIGLA_CONTRATTI_TIPO_NORMA_DATA.value());
		valueCMIS=gcCMIS==null?"":Integer.toString(gcCMIS.get(GregorianCalendar.DAY_OF_MONTH)) + "/" + 
				  				  Integer.toString(gcCMIS.get(GregorianCalendar.MONTH)) + "/" + 
				  				  Integer.toString(gcCMIS.get(GregorianCalendar.YEAR));

		if (!valueCMIS.equals(valueDB)) {
			listError.add(initTesto+" - Data Tipo Norma - DB:"+valueDB+" - CMIS:"+valueCMIS);
			isEquals = false;
		}
		return isEquals;
	}
}