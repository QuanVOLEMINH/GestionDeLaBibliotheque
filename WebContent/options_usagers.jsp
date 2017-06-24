<%@ page language="java" contentType="text/xml;charset=utf-8" %>

<%-- Import de la classe ArrayList --%>
<%@ page import="java.util.ArrayList"%>

<%-- Instantiation du Bean permettant l'accès à la base de données --%>
<jsp:useBean id="compBD" class="biblio.ComposantBDUsager" />

	<options>
<%
	// Récupération de la variable GET
	String debut = request.getParameter("debut");
%>
	
<%
	// Appel de la méthode "debutUsager"
	ArrayList<String> usagers = compBD.debutUsager(debut);
	for (String usager : usagers){
%>
	<option><%=usager%></option>
<%
	}
%>	
	</options>
