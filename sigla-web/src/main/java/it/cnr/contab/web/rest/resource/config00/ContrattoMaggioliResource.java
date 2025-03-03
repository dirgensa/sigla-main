package it.cnr.contab.web.rest.resource.config00;

import it.cnr.contab.config00.contratto.bulk.ContrattoBulk;
import it.cnr.contab.web.rest.exception.RestException;
import it.cnr.contab.web.rest.local.config00.ContrattoMaggioliLocal;
import it.cnr.contab.web.rest.model.AttachmentContratto;
import it.cnr.contab.web.rest.model.ContrattoDtoBulk;
import it.cnr.contab.web.rest.model.ContrattoMaggioliDTOBulk;
import it.cnr.contab.web.rest.model.EnumTypeAttachmentContratti;
import it.cnr.jada.DetailedRuntimeException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.CollectionUtils;

import javax.servlet.http.HttpServletRequest;

import javax.validation.Valid;
import javax.ws.rs.core.Response;
import java.util.Optional;

public class ContrattoMaggioliResource  extends AbstractContrattoResource implements ContrattoMaggioliLocal {
    private final Logger _log = LoggerFactory.getLogger(ContrattoMaggioliResource.class);

    @Override
    public void validateContratto(ContrattoDtoBulk contrattoBulk) {
        //Check valore tipoDettaglioContratto
        if (Optional.ofNullable(contrattoBulk.getTipo_dettaglio_contratto()).isPresent()){
            if ( !contrattoBulk.getTipo_dettaglio_contratto().equals(ContrattoBulk.DETTAGLIO_CONTRATTO_ARTICOLI) &&
                    contrattoBulk.getTipo_dettaglio_contratto().equals(ContrattoBulk.DETTAGLIO_CONTRATTO_CATGRP))
                throw new RestException(Response.Status.BAD_REQUEST, String.format("Per Il Tipo Dettaglio Contratto sono previsti i seguenti valori:{ vuoto,"
                        + ContrattoBulk.DETTAGLIO_CONTRATTO_ARTICOLI)+"}");
        }
        if (CollectionUtils.isEmpty(contrattoBulk.getAttachments()))
            throw new RestException(Response.Status.BAD_REQUEST,String.format("Deve essere presente tra gli allegati il documento del contratt0"));

        contrattoBulk.getAttachments().stream().filter(a->a.getTypeAttachment().equals(EnumTypeAttachmentContratti.CONTRATTO_FLUSSO)).findFirst().
                orElseThrow(
                        () -> new DetailedRuntimeException("Il file del contratto è obbligatorio"));
    }

    @Override
    public Response insertContratto(HttpServletRequest request, @Valid ContrattoDtoBulk contrattoDtoBulk) throws Exception {
        _log.info("insertContratto->Maggioli" );
        return Response.status(Response.Status.CREATED).entity(contrattoDtoBulk).build();
    }

    @Override
    public Response recuperoDatiContratto(HttpServletRequest request, String uo, Integer cdTerzo) throws Exception {
        _log.info("recuperoDatiContratto->Maggioli" );
        return Response.ok().entity(new ContrattoBulk()).build();
    }
}
