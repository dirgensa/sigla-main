/*
 * Copyright (C) 2019  Consiglio Nazionale delle Ricerche
 *
 *     This program is free software: you can redistribute it and/or modify
 *     it under the terms of the GNU Affero General Public License as
 *     published by the Free Software Foundation, either version 3 of the
 *     License, or (at your option) any later version.
 *
 *     This program is distributed in the hope that it will be useful,
 *     but WITHOUT ANY WARRANTY; without even the implied warranty of
 *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *     GNU Affero General Public License for more details.
 *
 *     You should have received a copy of the GNU Affero General Public License
 *     along with this program.  If not, see <https://www.gnu.org/licenses/>.
 */

package it.cnr.contab.doccont00.core.bulk;

import java.sql.*;
import it.cnr.contab.doccont00.intcass.bulk.*;
import it.cnr.contab.util.Utility;
import it.cnr.jada.bulk.*;
import it.cnr.jada.persistency.*;
import it.cnr.jada.persistency.beans.*;
import it.cnr.jada.persistency.sql.*;

import java.math.*;
import java.util.Collection;

public class Sospeso_det_uscHome extends BulkHome {
/**
 * <!-- @TODO: da completare -->
 * Costruisce un Sospeso_det_uscHome
 *
 * @param conn	La java.sql.Connection su cui vengono effettuate le operazione di persistenza
 */
public Sospeso_det_uscHome(java.sql.Connection conn) {
	super(Sospeso_det_uscBulk.class,conn);
}
/**
 * <!-- @TODO: da completare -->
 * Costruisce un Sospeso_det_uscHome
 *
 * @param conn	La java.sql.Connection su cui vengono effettuate le operazione di persistenza
 * @param persistentCache	La PersistentCache in cui vengono cachati gli oggetti persistenti caricati da questo Home
 */
public Sospeso_det_uscHome(java.sql.Connection conn,PersistentCache persistentCache) {
	super(Sospeso_det_uscBulk.class,conn,persistentCache);
}
/*
 * Calcola la somma degli importi dei dettagli del mandato associati al riscontro.
*/
public BigDecimal calcolaTotDettagli( V_mandato_reversaleBulk man_rev ) throws it.cnr.jada.persistency.PersistencyException 
{

		BigDecimal impTotale = Utility.ZERO;
		SQLBuilder sql = createSQLBuilder();
		sql.addSQLClause("AND", "ESERCIZIO", sql.EQUALS, man_rev.getEsercizio());
		sql.addSQLClause("AND", "CD_CDS", SQLBuilder.EQUALS, man_rev.getCd_cds());
		sql.addSQLClause("AND", "PG_MANDATO", sql.EQUALS, man_rev.getPg_documento_cont());
		sql.addSQLClause("AND", "STATO", sql.EQUALS, Sospeso_det_uscBulk.STATO_DEFAULT);
		sql.addSQLClause("AND", "TI_SOSPESO_RISCONTRO", sql.EQUALS, SospesoBulk.TI_RISCONTRO);
		Collection coll = fetchAll(sql);
		for (java.util.Iterator i = coll.iterator(); i.hasNext();)
		{
			Sospeso_det_uscBulk sospDet = (Sospeso_det_uscBulk) i.next();
			impTotale = impTotale.add(Utility.nvl(sospDet.getIm_associato()));
		}
		return impTotale;
}
}
