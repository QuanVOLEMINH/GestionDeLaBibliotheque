<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page language="java" contentType="text/html; charset=iso-8859-1" %>

<%-- Import de la classe ArrayList --%>
<%@ page import="java.util.ArrayList"%>

<%-- Instantiation du Bean permettant l'accès à la base de données --%>
<jsp:useBean id="compBD" class="biblio.ComposantBDEmprunt" />

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
	<title>Projet Bibliothèque</title>
	<link href="styles/styles.css" media="all" rel="stylesheet" type="text/css">
</head>

<body>

	<% 
		String idExemplaire = request.getParameter("id"); 
	%>
	<h1>Mini application bibliothèque<h1>
	<hr/>
	<h2>Retourner un livre</h2>
	<form name="form-modifier" id="form-modifier" action="Rendre.jsp" method="POST">
	<table border=0>
	<tr><td>ID exemplaire</td><td><input type="text" name="id_exemplaire" size="40" value="<%=idExemplaire!=null ? idExemplaire : ""%>"/></td><td><input type="submit" name="submit-retourner" id="submit" value="Retourner le livre"></td></tr>
	</table>
	</form>
		
	<% if (request.getParameter("submit-retourner")!=null){
		try {	
			idExemplaire = request.getParameter("id_exemplaire");
			compBD.rendre(idExemplaire);		
	%>
		<p style="font-weight:bold; color:green">Le livre est de nouveau disponible pour l'emprunt.</p>
	<% }
		catch(java.sql.SQLException e) {
	%> <p style="font-weight:bold; color:red">Impossible de retourner le livre, vérifiez le n° de l'exemplaire !</p>
	<%
		}
	 }
	%>
	
	<p align="center"><a href="/bibliotheque/">Retour...</a></p>

</body>
</html>

