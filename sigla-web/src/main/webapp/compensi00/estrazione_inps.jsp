<%@ page pageEncoding="UTF-8"
	import="it.cnr.jada.util.jsp.*,
	it.cnr.jada.action.*,
	java.util.*,
	it.cnr.jada.util.action.*,
	it.cnr.contab.compensi00.bp.*"
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
<% JSPUtils.printBaseUrl(pageContext);%>
<script language="JavaScript" src="scripts/util.js"></script>
<script language="javascript" src="scripts/css.js"></script>
<title> Elaborazione INPS </title>
</head>
<body class="Form"> 

<%	EstrazioneINPSBP bp = (EstrazioneINPSBP)BusinessProcess.getBusinessProcess(request);
	bp.openFormWindow(pageContext); %>

<table>
  <tr>
	<td><% bp.getController().writeFormLabel(out,"esercizio"); %></td>
	<td><% bp.getController().writeFormInput(out,"esercizio"); %></td>
	<td><% bp.getController().writeFormLabel(out,"cd_uo"); %></td>
	<td><% bp.getController().writeFormInput(out,"cd_uo"); %></td>
  </tr>
</table>

<% bp.closeFormWindow(pageContext); %>

</body>
</html>