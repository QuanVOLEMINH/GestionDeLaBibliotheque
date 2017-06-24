<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page language="java" contentType="text/html; charset=iso-8859-1" %>

<%-- Import de la classe ArrayList --%>
<%@ page import="java.util.ArrayList"%>

<%-- Instantiation du Bean permettant l'accès à la base de données --%>
<jsp:useBean id="compBD" class="biblio.ComposantBDLivre" />

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
	<title>Projet Bibliothèque</title>
	<link href="styles/styles.css" media="all" rel="stylesheet" type="text/css">
</head>

<body>
	<h1>Mini application bibliothèque<h1>
	<hr/>
	<h2>Création d'un livre</h2>
	<form name="form-creer" id="form-creer" action="CreerLivre.jsp" method="POST">
	<table border=0>
	<tr><td>ISBN-10</td><td><input type="text" name="isbn10" size="40"/></td></tr>
	<tr><td>ISBN-13</td><td><input type="text" name="isbn13" size="40"/></td></tr>
	<tr><td>Titre</td><td><input type="text" name="titre" size="40"/></td></tr>
	<tr><td>Auteur</td><td><input type="text" name="auteur" size="40"/></td></tr>
	<tr><td>&nbsp;</td></tr>
	<tr><td>&nbsp;</td><td><input type="submit" name="submit-creer" id="submit" value="Créer"></td></tr>
	</table>
	</form>
		
	<% if (request.getParameter("submit-creer")!=null){
		String isbn10 = request.getParameter("isbn10");
		String isbn13 =	request.getParameter("isbn13");
		String titre =	request.getParameter("titre");
		String auteur =	request.getParameter("auteur");
			
		int id = compBD.creerLivre(isbn10, isbn13, titre, auteur);
		if (id!=0) {
	%>
		<p style="font-weight:bold; color:green">Le livre "<%=titre%>" (n°<%=id%>) a été créé. Vous pouvez consulter sa <a href="ModifierLivre.jsp?id=<%=id%>">fiche</a>.</p>
	<% 
		}
		else {
	%>
		<p style="font-weight:bold; color:red">La création du livre a échouée</p>
	<% }} %>
	
	<p align="center"><a href="/bibliotheque/">Retour...</a></p>

</body>
</html>

