/*
 * Created by BulkGenerator 2.0 [07/12/2009]
 * Date 12/09/2016
 */
package it.cnr.contab.docamm00.consultazioni.bulk;
import java.sql.Connection;
import it.cnr.jada.bulk.BulkHome;
import it.cnr.jada.persistency.PersistentCache;
public class VDocAmmAttiviBrevettiHome extends BulkHome {
	public VDocAmmAttiviBrevettiHome(Connection conn) {
		super(VDocAmmAttiviBrevettiBulk.class, conn);
	}
	public VDocAmmAttiviBrevettiHome(Connection conn, PersistentCache persistentCache) {
		super(VDocAmmAttiviBrevettiBulk.class, conn, persistentCache);
	}
}