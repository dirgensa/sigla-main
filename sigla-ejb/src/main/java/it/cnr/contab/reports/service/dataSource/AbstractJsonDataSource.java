package it.cnr.contab.reports.service.dataSource;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import it.cnr.contab.reports.bulk.Print_spoolerBulk;
import it.cnr.contab.reports.bulk.Print_spooler_paramBulk;
import it.cnr.contab.reports.bulk.Print_spooler_paramKey;
import it.cnr.jada.bulk.BulkList;
import it.cnr.jada.comp.ComponentException;
import org.apache.commons.lang.StringUtils;

import java.util.HashSet;
import java.util.Optional;
import java.util.Set;
import java.util.stream.Collectors;

public abstract class AbstractJsonDataSource implements JsonDataSource{

    protected  String getJson( Object o){
        return new GsonBuilder().create().toJson(o );
    }


    @Override
    public Print_spoolerBulk getPrintSpooler(Print_spoolerBulk printSpooler) throws ComponentException {
        if (Optional.of(printSpooler).isPresent()){
            String jsonDs =getJsonDataSource(printSpooler);
            //String jsonDs ="ciao";
            Print_spooler_paramBulk pDs = new Print_spooler_paramBulk(REPORT_DATA_SOURCE,printSpooler.getPgStampa());
            pDs.setParamType( String.class.getCanonicalName());
            int posDs=printSpooler.getParams().indexOfByPrimaryKey(pDs);
            if ( posDs>=0){
                Print_spooler_paramBulk paramList = (Print_spooler_paramBulk)printSpooler.getParams().get( posDs);
                paramList.setParamType( String.class.getCanonicalName());
                paramList.setValoreParam( jsonDs);
            }else{
                pDs.setValoreParam( jsonDs);
                printSpooler.addParam( pDs );
            }
        }

        printSpooler.setDacr(null);
        printSpooler.setDuva(null);
        return printSpooler;
    }
}
