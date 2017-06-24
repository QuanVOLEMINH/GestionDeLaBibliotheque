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
	<h1>Mini application bibliothèque<h1>
	<hr/>
	<h2>Emprunter</h2>
	<form name="form-modifier" id="form-modifier" action="Emprunter.jsp" method="POST">
	<table border=0>
	<tr><td>ID exemplaire</td><td><input type="text" name="id_exemplaire" size="40" /></td></tr>
	<tr><td>ID usager</td><td><input type="text" name="id_usager" size="40" value=""/></td></tr>
	<tr><td>&nbsp;</td><td><input type="submit" name="submit-creer" id="submit" value="Enregistrer"></td></tr>
	</table>
	</form>
		
	<% if (request.getParameter("submit-creer")!=null){
		String idExemplaire = 	request.getParameter("id_exemplaire");
		String idUsager =	request.getParameter("id_usager");
		try {	
			compBD.emprunter(idUsager,idExemplaire);		
	%>
		<p style="font-weight:bold; color:green">L'emprunt a été enregistré.</p>
	<% }
		catch(java.sql.SQLException e) {
	%> <p style="font-weight:bold; color:red">L'emprunt est impossible, vérifiez le n° d'exemplaire ou le n° d'usager !</p>
	<%
		}
	 }
	%>
	
	<p align="center"><a href="/bibliotheque/">Retour...</a></p>

</body>
</html>

