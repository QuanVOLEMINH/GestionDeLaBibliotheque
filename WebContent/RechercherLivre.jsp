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
	<script type="text/javascript" src="autocomplete.js"></script>
	<script type="text/javascript">
		// Variable indiquant l'adresse de la page générant en XML la liste des champs possibles à afficher
		var _adresseRecherche = "options_livres.jsp";
		window.onload = function(){initAutoComplete(document.getElementById('form-test'),
		document.getElementById('champ-texte'),document.getElementById('bouton-submit'))};
	</script>
</head>

<body>
	<h1>Mini application bibliothèque<h1>
	<hr/>

	<h2>Recherche d'un livre :</h2>

	<form name="form-test" id="form-test" action="ListeLivres.jsp" style="margin-left: 50px; margin-top:20px" method="POST">
		Titre : <input type="text" name="titre-rechercher" id="champ-texte" size="40" autocomplete="off" />
		<input type="submit" name="submit-rechercher" id="bouton-submit">
	</form>
	
	<p align="center"><a href="/bibliotheque/">Retour...</a></p>
</body>
</html>